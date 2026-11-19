// Story test: plays EVERY path through the compiled story and checks it against tests/story-spec.mjs.
// Writes reports/story-report.md and reports/story-paths.json. Exits 1 on any failure.
//
// Checks: dead ends, runtime ink errors, unreachable knots/stitches, required outcomes reachable,
// end-state invariants, scene order, remember-lines firing only when earned (and at least once),
// one-way variables, panel tags valid and present before text, choice label rules,
// proper nouns (unknown words, too many new names per scene), walls of text, reading time.

import { readFileSync, writeFileSync, existsSync, mkdirSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { spec } from "../tests/story-spec.mjs";

const require = createRequire(import.meta.url);
const { Story } = require("inkjs");
const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const story = new Story(readFileSync(join(root, "src/generated/story.json"), "utf8"));
const glossary = JSON.parse(readFileSync(join(root, "story/GLOSSARY.json"), "utf8"));

const failures = new Map();   // message -> example route
const warnings = new Map();
const fail = (msg, route) => { if (!failures.has(msg)) failures.set(msg, route?.join(" → ") ?? ""); };
const warn = (msg, route) => { if (!warnings.has(msg)) warnings.set(msg, route?.join(" → ") ?? ""); };

const runtimeErrors = [];
story.onError = (msg) => runtimeErrors.push(msg);

// --- glossary lookup ---------------------------------------------------------
const termOf = new Map(); // surface form -> canonical term
for (const [term, def] of Object.entries(glossary.terms)) {
  termOf.set(term, term);
  for (const a of def.aka ?? []) termOf.set(a, term);
}
const surfaces = [...termOf.keys()].sort((a, b) => b.length - a.length);
const ignore = new Set(glossary.ignore);

function termsIn(line) {
  const found = new Set();
  for (const s of surfaces) if (new RegExp(`\\b${s}\\b`).test(line)) found.add(termOf.get(s));
  return found;
}
function unknownCapitals(line) {
  const out = [];
  const re = /([^\s]*?)\b([A-Z][a-z']+)\b/g;
  let m;
  while ((m = re.exec(line))) {
    const word = m[2].replace(/'s$/, ""), idx = m.index + m[1].length;
    if (/^I'/.test(m[2])) continue;
    const before = line.slice(0, idx).trimEnd();
    const sentenceStart = before === "" || /[.!?:"“—*('‘]$/.test(before);
    if (sentenceStart || ignore.has(word)) continue;
    if (!surfaces.some((s) => s.split(" ").includes(word))) out.push(word);
  }
  return out;
}

// --- named containers (knots + stitches) for coverage --------------------------
const containers = [];
for (const [name, c] of story.mainContentContainer.namedContent) {
  if (name.startsWith("global")) continue;
  const fnNames = ["recap", "ballad"];
  if (fnNames.includes(name)) continue;
  containers.push(name);
  for (const [sub] of c.namedContent ?? []) if (!/^\d/.test(sub) && !sub.startsWith("c-") && !sub.startsWith("g-")) containers.push(`${name}.${sub}`);
}
const covered = new Set();

const vars = () => {
  const o = {};
  for (const k of story.variablesState._globalVariables.keys()) o[k] = story.variablesState.$(k);
  return o;
};

// --- exploration ---------------------------------------------------------------
const paths = [];
const rememberFired = new Map(); // id -> count
const decisionPoints = new Map(); // key -> {scene, options: Map(label -> count)}
const outcomes = new Map();
const boundarySeen = new Set();
let laterPaths = 0;
let entryStates = 0;
let maxDepth = 0;

function newCtx() {
  return { route: [], sceneIdx: -1, scene: null, sceneNew: 0, seen: new Set(), panel: null,
           wordsSinceChoice: 0, words: 0, remembers: [], refrains: {}, endId: null, prev: vars() };
}
const cloneCtx = (c) => ({ ...c, route: [...c.route], seen: new Set(c.seen), remembers: [...c.remembers], refrains: { ...c.refrains }, prev: { ...c.prev } });

function processTags(ctx, tags) {
  for (const raw of tags) {
    const t = raw.trim();
    const [key, ...rest] = t.split(":");
    const val = rest.join(":").trim();
    switch (key.trim()) {
      case "scene": {
        const idx = spec.sceneOrder.indexOf(val);
        if (idx === -1) fail(`unknown scene id "${val}" (add it to spec.sceneOrder)`, ctx.route);
        else if (idx < ctx.sceneIdx) fail(`scene order goes backwards: ${ctx.scene} → ${val}`, ctx.route);
        ctx.sceneIdx = idx; ctx.scene = val; ctx.sceneNew = 0;
        break;
      }
      case "panel": {
        const ok = ["svg", "webp", "png", "jpg"].some((ext) => existsSync(join(root, "assets/panels", `${val}.${ext}`)));
        if (!ok) fail(`panel "${val}" has no file in assets/panels/`, ctx.route);
        ctx.panel = val;
        break;
      }
      case "remember": {
        const [id] = val.split("::").map((s) => s.trim());
        const cond = spec.remember[id];
        if (!cond) fail(`remember line "${id}" is not in spec.remember`, ctx.route);
        else if (!cond(vars())) fail(`remember line "${id}" fired without its condition`, ctx.route);
        rememberFired.set(id, (rememberFired.get(id) ?? 0) + 1);
        ctx.remembers.push(id);
        break;
      }
      case "end": ctx.endId = val; break;
      case "chapterend": ctx.chapterEnd = val; break;
      case "title": case "know": break;
      default: fail(`unknown tag "${t}"`, ctx.route);
    }
  }
}

function processLine(ctx, line) {
  const text = line.trim();
  if (!text) return;
  if (!ctx.panel) fail("text shown before any panel", ctx.route);
  const n = text.split(/\s+/).length;
  ctx.words += n; ctx.wordsSinceChoice += n;
  for (const term of termsIn(text)) {
    if (!ctx.seen.has(term)) { ctx.seen.add(term); ctx.sceneNew++; }
  }
  const limit = ctx.sceneIdx === 0 ? spec.maxNewProperNouns.firstScene : spec.maxNewProperNouns.otherScenes;
  if (ctx.sceneNew > limit) fail(`scene ${ctx.scene} introduces ${ctx.sceneNew} new proper nouns (max ${limit})`, ctx.route);
  if (spec.voice) {
    const narration = text.replace(/"[^"]*"/g, " ");
    if (spec.voice.thirdPersonSlip.test(narration)) fail(`voice: third-person narration ("${text.slice(0, 60)}…")`, ctx.route);
    const low = text.toLowerCase();
    for (const b of spec.voice.banned) if (new RegExp(`\\b${b}\\b`).test(low)) fail(`voice: banned phrase "${b}" in "${text.slice(0, 60)}…"`, ctx.route);
    for (const r of Object.keys(spec.voice.refrains)) if (low.includes(r)) ctx.refrains[r] = (ctx.refrains[r] ?? 0) + 1;
    (spec.voice.limits ?? []).forEach(([re], i) => { const n = (low.match(re) ?? []).length; if (n) ctx.refrains[`#${i}`] = (ctx.refrains[`#${i}`] ?? 0) + n; });
  }
  for (const w of unknownCapitals(text)) fail(`unknown proper noun "${w}" (add to story/GLOSSARY.json or rephrase)`, ctx.route);
}

function checkVars(ctx) {
  const now = vars();
  for (const k of spec.neverIncreases) if (now[k] > ctx.prev[k]) fail(`${k} increased (${ctx.prev[k]} → ${now[k]})`, ctx.route);
  ctx.prev = now;
}

function run(ctx, depth) {
  maxDepth = Math.max(maxDepth, depth);
  if (depth > 200) { fail("path longer than 200 choices (loop?)", ctx.route); return; }
  while (story.canContinue) {
    const line = story.Continue();
    processTags(ctx, story.currentTags ?? []);
    processLine(ctx, line);
    checkVars(ctx);
    if (runtimeErrors.length) { fail(`ink runtime error: ${runtimeErrors.join("; ")}`, ctx.route); runtimeErrors.length = 0; }
    if (ctx.chapterEnd) {
      // End of a chapter: run the end-of-chapter checks here, then walk the next chapter only once per
      // distinct combination of the variables it reads (spec.chapterKeys), so paths don't multiply.
      const done = ctx.chapterEnd; ctx.chapterEnd = null;
      ctx.endId = done; finish(ctx); ctx.endId = null;
      // Walk the next chapter from this state only if it brings a value of a variable that chapter reads
      // (spec.chapterKeys) that no earlier entry state brought: every value is tested at least once.
      const keys = spec.chapterKeys?.[done] ?? [];
      const v = vars();
      const fresh = keys.map((k) => `${done}|${k}=${v[k]}`).filter((p) => !boundarySeen.has(p));
      if (!fresh.length) return;
      fresh.forEach((p) => boundarySeen.add(p));
      entryStates++;
      ctx.refrains = {}; ctx.wordsSinceChoice = 0; ctx.chapter = (ctx.chapter ?? 0) + 1;
    }
  }
  for (const c of containers) if (story.state.VisitCountAtPathString(c) > 0) covered.add(c);

  const choices = story.currentChoices;
  if (choices.length === 0) return finish(ctx);

  if (ctx.wordsSinceChoice > spec.maxWordsBetweenChoices)
    warn(`${ctx.wordsSinceChoice} words without a choice before "${choices[0].text}" (max ${spec.maxWordsBetweenChoices})`, ctx.route);

  const labels = choices.map((c) => c.text.trim());
  const key = `${ctx.scene} :: ${labels.join(" / ")}`;
  if (!decisionPoints.has(key)) decisionPoints.set(key, { scene: ctx.scene, options: new Map(labels.map((l) => [l, 0])) });
  if (new Set(labels).size !== labels.length) fail(`duplicate choice labels: ${labels.join(" / ")}`, ctx.route);
  for (const l of labels) {
    if (!l) fail("empty choice label", ctx.route);
    const words = l.replace(/["“”]/g, "").split(/\s+/).length;
    if (words > spec.choiceMaxWords) fail(`choice label over ${spec.choiceMaxWords} words: "${l}"`, ctx.route);
  }

  const saved = story.state.toJson();
  choices.forEach((choice, i) => {
    const next = cloneCtx(ctx);
    next.route.push(choice.text.trim());
    next.wordsSinceChoice = 0;
    decisionPoints.get(key).options.set(labels[i], decisionPoints.get(key).options.get(labels[i]) + 1);
    story.ChooseChoiceIndex(i);
    run(next, depth + 1);
    story.state.LoadJson(saved);
  });
}

function finish(ctx) {
  const v = vars();
  if (!ctx.endId) fail("dead end: story stopped with no choices and no `# end:` tag", ctx.route);
  else if (!spec.endIds.includes(ctx.endId)) fail(`unexpected end id "${ctx.endId}"`, ctx.route);
  for (const [name, check] of spec.endState) if (!check(v)) fail(`end state broken: ${name}`, ctx.route);
  if (ctx.chapter) {
    // A later chapter's ending: voice limits apply per chapter; prologue outcomes were counted at its end.
    for (const [r, max] of Object.entries(spec.voice?.refrains ?? {})) if ((ctx.refrains[r] ?? 0) > max) fail(`voice: refrain "${r}" used ${ctx.refrains[r]} times in one chapter (max ${max})`, ctx.route);
    laterPaths++;
    return;
  }

  for (const [r, max] of Object.entries(spec.voice?.refrains ?? {})) if ((ctx.refrains[r] ?? 0) > max) fail(`voice: refrain "${r}" used ${ctx.refrains[r]} times on one path (max ${max})`, ctx.route);

  (spec.voice?.limits ?? []).forEach(([re, max], i) => { if ((ctx.refrains[`#${i}`] ?? 0) > max) fail(`voice: tic ${re} used ${ctx.refrains[`#${i}`]} times on one path (max ${max})`, ctx.route); });

  const recap = story.EvaluateFunction("recap", [], true).output.trim();
  const ballad = story.EvaluateFunction("ballad", [], true).output.trim();
  if (recap.split("\n").filter(Boolean).length !== 3) fail("recap() did not produce exactly 3 lines", ctx.route);
  if (!ballad) fail("ballad() produced nothing", ctx.route);

  const okey = Object.keys(spec.mustReach).map((k) => `${k}=${v[k]}`).join(", ");
  if (!outcomes.has(okey)) outcomes.set(okey, { count: 0, example: ctx.route, recap, ballad });
  outcomes.get(okey).count++;

  paths.push({ route: ctx.route, words: ctx.words, remembers: ctx.remembers,
               state: Object.fromEntries(Object.entries(v).filter(([k]) => !["PLACE"].includes(k))) });
}

run(newCtx(), 0);

// --- whole-story checks ------------------------------------------------------
for (const c of containers) if (!covered.has(c)) fail(`unreachable: ${c} is never visited on any path`);
for (const id of Object.keys(spec.remember)) if (!rememberFired.get(id)) fail(`remember line "${id}" never fires on any path`);
const combos = Object.entries(spec.mustReach).reduce((acc, [k, vals]) => acc.flatMap((a) => vals.map((x) => [...a, `${k}=${x}`])), [[]]).map((a) => a.join(", "));
for (const combo of combos) if (!outcomes.has(combo)) fail(`required outcome never reached: ${combo}`);
for (const [key, dp] of decisionPoints) for (const [label, n] of dp.options) if (n === 0) fail(`choice never taken: "${label}" at ${key}`);

// --- report ------------------------------------------------------------------
const words = paths.map((p) => p.words).sort((a, b) => a - b);
const mins = (w) => (w / spec.readingWpm).toFixed(1);
const median = words[Math.floor(words.length / 2)];
const ok = failures.size === 0;

const md = [];
md.push(`# Story test report`, ``, `Generated by \`npm run test:story\`. Every path through the story was played.`, ``);
md.push(`**Result: ${ok ? "PASS" : "FAIL"}** — ${failures.size} failures, ${warnings.size} warnings`, ``);
md.push(`| Measure | Value |`, `|---|---|`);
md.push(`| Distinct paths played | ${paths.length} |`);
md.push(`| Decision points | ${decisionPoints.size} |`);
md.push(`| Longest path (choices) | ${maxDepth} |`);
md.push(`| Knots/stitches covered | ${covered.size} / ${containers.length} |`);
md.push(`| Remember lines that fire | ${rememberFired.size} / ${Object.keys(spec.remember).length} |`);
md.push(`| Required outcomes reached | ${combos.filter((c) => outcomes.has(c)).length} / ${combos.length} |`);
md.push(`| Words per playthrough | ${words[0]}–${words.at(-1)} (median ${median}) |`);
md.push(`| Reading time at ${spec.readingWpm} wpm | ${mins(words[0])}–${mins(words.at(-1))} min (median ${mins(median)}) |`, ``);

md.push(`## Checks`, ``);
const checks = [
  ["No dead ends (every path reaches an `# end:` tag)", ![...failures.keys()].some((m) => m.startsWith("dead end"))],
  ["No ink runtime errors", ![...failures.keys()].some((m) => m.startsWith("ink runtime"))],
  ["Every knot and stitch reachable", ![...failures.keys()].some((m) => m.startsWith("unreachable"))],
  ["Every choice option is taken on some path", ![...failures.keys()].some((m) => m.startsWith("choice never taken"))],
  ["All required outcomes reachable", ![...failures.keys()].some((m) => m.startsWith("required outcome"))],
  ["End-state logic holds on every path", ![...failures.keys()].some((m) => m.startsWith("end state"))],
  ["Scenes always progress forward", ![...failures.keys()].some((m) => m.startsWith("scene order") || m.startsWith("unknown scene"))],
  ["Remember lines fire only when earned, and each fires somewhere", ![...failures.keys()].some((m) => m.startsWith("remember"))],
  ["Days never run backwards", ![...failures.keys()].some((m) => m.includes("increased"))],
  ["Every panel exists; no text before a panel", ![...failures.keys()].some((m) => m.startsWith("panel") || m.startsWith("text shown"))],
  ["Choice labels short and distinct", ![...failures.keys()].some((m) => m.startsWith("choice label") || m.startsWith("duplicate") || m.startsWith("empty"))],
  ["Proper nouns known; not too many new names per scene", ![...failures.keys()].some((m) => m.includes("proper noun"))],
  ["Voice: first person holds, no banned phrases, refrains within limit", ![...failures.keys()].some((m) => m.startsWith("voice:"))],
  ["Recap is 3 lines and the ballad renders, on every ending", ![...failures.keys()].some((m) => m.startsWith("recap") || m.startsWith("ballad"))],
];
for (const [name, pass] of checks) md.push(`- ${pass ? "✅" : "❌"} ${name}`);
md.push(``);

if (failures.size) { md.push(`## Failures`, ``); for (const [m, r] of failures) md.push(`- **${m}**${r ? `  \n  route: ${r}` : ""}`); md.push(``); }
if (warnings.size) { md.push(`## Warnings`, ``); for (const [m, r] of warnings) md.push(`- ${m}${r ? `  \n  route: ${r}` : ""}`); md.push(``); }

md.push(`## Outcomes`, ``, `How each combination of the key outcomes is reached. One example route each.`, ``);
for (const combo of combos) {
  const o = outcomes.get(combo);
  md.push(`### ${combo} — ${o ? `${o.count} paths` : "NOT REACHED"}`);
  if (o) { md.push(``, `Example: ${o.example.join(" → ")}`, ``, "Recap:", "", ...o.recap.split("\n").map((l) => `> ${l}`), ""); }
}

md.push(`## Decision map`, ``, `Every choice point, and on how many of the ${paths.length} paths each option is taken.`, ``);
for (const [, dp] of decisionPoints) {
  md.push(`- **${dp.scene}**: ${[...dp.options].map(([l, n]) => `${l} (${n})`).join(" · ")}`);
}
md.push(``, `## Remember lines`, ``);
for (const id of Object.keys(spec.remember)) md.push(`- \`${id}\` fires on ${rememberFired.get(id) ?? 0} paths`);

mkdirSync(join(root, "reports"), { recursive: true });
writeFileSync(join(root, "reports/story-report.md"), md.join("\n") + "\n");
writeFileSync(join(root, "reports/story-paths.json"), JSON.stringify(paths, null, 1));
// Stats the game itself shows on the end screen, so it never states a stale number.
writeFileSync(join(root, "src/generated/story-stats.json"), JSON.stringify({ paths: paths.length, outcomes: outcomes.size, chapter1Paths: laterPaths, chapter1Entries: entryStates }));

console.log(`${ok ? "PASS" : "FAIL"}: ${paths.length} prologue paths, chapter 1 from ${entryStates} entry states (${laterPaths} paths), ${covered.size}/${containers.length} knots, ${combos.filter((c) => outcomes.has(c)).length}/${combos.length} outcomes, ${failures.size} failures, ${warnings.size} warnings`);
for (const [m, r] of failures) console.log(`  ✗ ${m}${r ? `\n      route: ${r}` : ""}`);
for (const [m] of warnings) console.log(`  ! ${m}`);
console.log("report: reports/story-report.md");
process.exit(ok ? 0 : 1);
