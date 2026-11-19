// Plain-text playthroughs of a chapter that is not yet linked into the main story, for the blind reader panel.
//   node tools/make-chapter-transcripts.mjs ch01_stint ch01
// Each entry in ENTRIES sets the variables a prologue route would have left, then plays the chapter with a choice plan.
// Stop-gap until the story test runs per chapter from seeded entry states (docs/TECH.md).
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { createRequire } from "node:module";
const inkjs = createRequire(import.meta.url)("inkjs/full");
const { Compiler, CompilerOptions } = inkjs;
const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const storyDir = join(root, "story");
const [file = "ch01_stint", knot = "ch01"] = process.argv.slice(2);

const ENTRIES = {
  "a-honest":      { vars: { AT_FORD: '"bridle"', WENT_IN: true, PURSE: false, LETTER: '"wren"', MARROW_KNOWS_LETTER: true, TOLD_MARROW: '"truth"', VERSION: '"truth"', ELBOW: '"hidden"', PLAN: '"objected"', SOLD: '"face"', SELF: '"him"', DEED: '"waiting"', RING: false, DEBT_MARROW: false }, plan: [1, 1, 1, 0, 0, 0, 1, 0, 2, 0] },
  "b-selfserving": { vars: { AT_FORD: '"silent"', DRANK: true, WENT_IN: false, PURSE: true, LETTER: '"hidden"', MARROW_KNOWS_LETTER: true, TOLD_MARROW: '"ambush"', VERSION: '"hero"', PLAN: '"bargained"', ISOLDE_OWES: true, SOLD: '"hand"', READ_BALLAD: true, SELF: '"wages"', DEED: '"signed"', RING: false, DEBT_MARROW: true }, plan: [0, 2, 0, 2, 1, 1, 2, 0, 1, 2] },
  "c-mixed":       { vars: { AT_FORD: '"called"', DRANK: true, WENT_IN: true, PURSE: false, LETTER: '"isolde"', MARROW_KNOWS_LETTER: true, TOLD_MARROW: '"wait"', VERSION: '"ambush"', PLAN: '"agreed"', SOLD: '"begged"', READ_BALLAD: true, SELF: '"peace"', DEED: '"signed"', RING: true, DEBT_MARROW: false }, plan: [1, 0, 2, 1, 2, 0, 0, 0, 1] },
};

const out = join(root, "reports/transcripts");
mkdirSync(out, { recursive: true });
for (const [name, { vars, plan }] of Object.entries(ENTRIES)) {
  const main = `INCLUDE systems.ink\nINCLUDE ${file}.ink\n${Object.entries(vars).map(([k, v]) => `~ ${k} = ${v}`).join("\n")}\n-> ${knot}\n`;
  const errors = [];
  const opts = new CompilerOptions(join(storyDir, "dev.ink"), [], true, (m, t) => { if (t === 2) errors.push(m); },
    { ResolveInkFilename: (n) => join(storyDir, n), LoadInkFileContents: (p) => readFileSync(p, "utf8") });
  let story;
  try { story = new Compiler(main, opts).Compile(); } catch { /* reported below */ }
  if (errors.length || !story) { for (const e of errors) console.error("ink error:", e); process.exit(1); }
  const md = [];
  let picks = 0;
  for (;;) {
    while (story.canContinue) {
      const line = story.Continue().trim();
      const after = [];
      for (const raw of story.currentTags ?? []) {
        const [key, ...rest] = raw.split(":");
        const val = rest.join(":").trim();
        if (key.trim() === "title") md.push(`# ${val.replace("::", "—")}`, "");
        if (key.trim() === "scene") md.push("", "* * *", "");
        if (key.trim() === "remember") after.push(`> *${val.split("::")[1].trim()}*`, "");
      }
      if (line) md.push(line, "");
      md.push(...after);
    }
    const choices = story.currentChoices;
    if (!choices.length) break;
    const want = plan[picks] ?? 0;
    const i = want === "last" ? choices.length - 1 : Math.min(want, choices.length - 1);
    md.push("**The game offers:**", ...choices.map((c, k) => `- ${k === i ? "**▶ " + c.text.trim() + "**  (chosen)" : c.text.trim()}`), "");
    story.ChooseChoiceIndex(i);
    picks++;
  }
  md.push("* * *", "", "*(The chapter continues. Only its first three scenes are written.)*", "");
  writeFileSync(join(out, `${knot}-${name}.md`), md.join("\n"));
  console.log(`transcript: reports/transcripts/${knot}-${name}.md (${picks} choices, ${md.join(" ").split(/\s+/).length} words)`);
}
