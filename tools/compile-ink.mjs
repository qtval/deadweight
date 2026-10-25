// Compile story/main.ink -> src/generated/story.json. Fails on any error; prints warnings.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { createRequire } from "node:module";
const inkjs = createRequire(import.meta.url)("inkjs/full");
const { Compiler, CompilerOptions } = inkjs;

const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const storyDir = join(root, "story");
const errors = [], warnings = [];
const fileHandler = {
  ResolveInkFilename: (name) => join(storyDir, name),
  LoadInkFileContents: (path) => readFileSync(path, "utf8"),
};
const opts = new CompilerOptions(join(storyDir, "main.ink"), [], true,
  (msg, type) => (type === 2 ? errors : warnings).push(msg), fileHandler);

let story;
try { story = new Compiler(readFileSync(join(storyDir, "main.ink"), "utf8"), opts).Compile(); }
catch (e) { /* errors collected below */ }
for (const w of warnings) console.warn("ink warning:", w);
if (errors.length || !story) {
  for (const e of errors) console.error("ink error:", e);
  process.exit(1);
}
writeFileSync(join(root, "src", "generated", "story.json"), story.ToJson());
console.log(`ink compiled OK -> src/generated/story.json${warnings.length ? ` (${warnings.length} warnings)` : ""}`);
