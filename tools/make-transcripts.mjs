// Writes plain-text playthroughs for the blind reader panel (docs/TESTING.md, layer 3).
// A reader gets ONE of these files and nothing else: no docs, no source, no other route.
//   node tools/make-transcripts.mjs      → reports/transcripts/<route>.md
// Routes are in tests/story-spec.mjs (readerRoutes): a list of choice indexes, "last" = last option.
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { spec } from "../tests/story-spec.mjs";

const require = createRequire(import.meta.url);
const { Story } = require("inkjs");
const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const json = readFileSync(join(root, "src/generated/story.json"), "utf8");
const out = join(root, "reports/transcripts");
mkdirSync(out, { recursive: true });

for (const [name, plan] of Object.entries(spec.readerRoutes)) {
  const story = new Story(json);
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
  const recap = story.EvaluateFunction("recap", [], true).output.trim();
  const ballad = story.EvaluateFunction("ballad", [], true).output.trim();
  md.push("* * *", "", "## End screen", "", "**What you did**", "", ...recap.split("\n").filter(Boolean).map((l) => `- ${l}`), "", "**Isolde's ballad, as it stands**", "", ...ballad.split("\n").map((l) => `> ${l}`), "");
  writeFileSync(join(out, `${name}.md`), md.join("\n"));
  console.log(`transcript: reports/transcripts/${name}.md (${picks} choices)`);
}
