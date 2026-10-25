// Builds the ChatGPT prompt pack page from art/prompts/STYLE.md + art/prompts/<chapter>.md
//   node tools/make-prompt-pack.mjs ch00 <out.html>
// The page is published as an artifact: copy buttons, done-ticks, and the save-to folder.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";

const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const [chapter = "ch00", out = "prompt-pack.html"] = process.argv.slice(2);
const style = readFileSync(join(root, "art/prompts/STYLE.md"), "utf8");
const md = readFileSync(join(root, `art/prompts/${chapter}.md`), "utf8");

const setup = style.match(/## Style setup message[\s\S]*?```\n([\s\S]*?)```/)[1].trim();
const title = md.match(/^# (.+)$/m)[1];
const arc = (md.match(/^Amber arc[^\n]*$/m) ?? [""])[0];
const panels = [...md.matchAll(/^## (\S+)\n(.+)\n```\n([\s\S]*?)```/gm)].map(([, id, scene, prompt]) => ({ id, scene, prompt: prompt.trim() }));
const esc = (s) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);

const html = `<title>Deadweight Prompt Pack</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Alegreya:ital,wght@0,400;0,500;1,400&family=Alegreya+Sans+SC:wght@500&family=Grenze:wght@500;700&display=swap">
<style>
/* Layout: one reading column of numbered steps; each prompt is a card you copy from.
   Single deliberate dark theme matching the game: ink, bone, amber. */
:root {
  --ink: #0e0d0b; --ink-2: #181713; --bone: #e9e4d8; --ash: #9a958a; --rule: #34322d; --amber: #e0a24a;
  --display: "Grenze", Georgia, serif; --read: "Alegreya", Georgia, serif; --label: "Alegreya Sans SC", "Trebuchet MS", sans-serif;
  --mono: ui-monospace, "Cascadia Mono", Consolas, monospace;
  color-scheme: dark;
}
body { background: var(--ink); color: var(--bone); font-family: var(--read); font-size: 17px; line-height: 1.55; }
main { max-width: 44rem; margin: 0 auto; padding-block: 40px 80px; padding-left: max(16px, env(safe-area-inset-left, 0px)); padding-right: max(16px, env(safe-area-inset-right, 0px)); display: flex; flex-direction: column; gap: 28px; }
.kicker { font-family: var(--label); letter-spacing: 0.2em; font-size: 0.8rem; color: var(--amber); }
h1 { font-family: var(--display); font-weight: 700; font-size: clamp(2.4rem, 9vw, 3.4rem); line-height: 0.95; margin: 6px 0 10px; text-wrap: balance; }
h2 { font-family: var(--display); font-weight: 500; font-size: 1.6rem; margin: 0; }
p { margin: 0; max-width: 38rem; }
.muted { color: var(--ash); }
.steps { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: 10px; counter-reset: s; }
.steps li { display: grid; grid-template-columns: 2rem 1fr; gap: 10px; counter-increment: s; }
.steps li::before { content: counter(s); font-family: var(--display); font-size: 1.4rem; color: var(--amber); line-height: 1.2; }
code.path { font-family: var(--mono); font-size: 0.9em; background: var(--ink-2); border: 1px solid var(--rule); padding: 1px 6px; word-break: break-all; }
.progress { font-family: var(--label); letter-spacing: 0.08em; color: var(--ash); }
.progress b { color: var(--bone); font-weight: 500; font-variant-numeric: tabular-nums; }
.card { border: 1px solid var(--rule); background: var(--ink-2); display: flex; flex-direction: column; }
.card.setup { border-color: #5a4a2c; }
.card.done { opacity: 0.55; }
.head { display: flex; align-items: baseline; gap: 12px; padding: 14px 16px 10px; flex-wrap: wrap; }
.num { font-family: var(--display); font-size: 1.5rem; color: var(--amber); min-width: 1.6rem; }
.head .meta { display: flex; flex-direction: column; gap: 2px; min-width: 0; flex: 1; }
.id { font-family: var(--mono); font-size: 0.85rem; color: var(--ash); word-break: break-all; }
.scene { font-size: 1.05rem; }
pre { margin: 0; padding: 14px 16px; border-top: 1px solid var(--rule); white-space: pre-wrap; word-wrap: break-word; font-family: var(--mono); font-size: 0.85rem; line-height: 1.5; color: #d9d3c4; max-height: 22rem; overflow: auto; }
.bar { display: flex; gap: 8px; padding: 10px 16px 14px; border-top: 1px solid var(--rule); flex-wrap: wrap; align-items: center; }
button { font: inherit; cursor: pointer; }
.copy { background: var(--bone); color: var(--ink); border: 1px solid var(--bone); padding: 9px 18px; font-family: var(--label); letter-spacing: 0.12em; font-size: 0.85rem; min-height: 44px; }
.copy.ok { background: var(--amber); border-color: var(--amber); }
.tick { background: none; border: 1px solid var(--rule); color: var(--bone); padding: 9px 14px; font-family: var(--label); letter-spacing: 0.1em; font-size: 0.85rem; min-height: 44px; }
.tick[aria-pressed="true"] { border-color: var(--amber); color: var(--amber); }
.tips { border-left: 2px solid var(--amber); padding-left: 16px; display: flex; flex-direction: column; gap: 8px; }
.tips h3 { font-family: var(--label); letter-spacing: 0.16em; font-size: 0.8rem; color: var(--amber); margin: 0; font-weight: 500; }
.tips ul { margin: 0; padding-left: 1.1em; display: flex; flex-direction: column; gap: 6px; }
:focus-visible { outline: 2px solid var(--amber); outline-offset: 3px; }
</style>
<main>
  <header>
    <span class="kicker">Deadweight · art · ${esc(title)}</span>
    <h1>ChatGPT prompt pack</h1>
    <p class="muted">${panels.length} panels for the prologue. Black and white ink with one colour: amber, only for real light.</p>
  </header>

  <ol class="steps">
    <li><p>Open a <b>new chat</b> in the ChatGPT app and paste the <b>style setup</b> below. Wait for "Ready".</p></li>
    <li><p>Paste each panel prompt as its own message. One image per message.</p></li>
    <li><p>Download each image and save it in <code class="path">Pictures\\Deadweight</code>. File names don't matter; I recognise each panel.</p></li>
    <li><p>Come back and tell me "panels saved". I'll process, test, and push them to the game.</p></li>
  </ol>

  <p class="progress" id="progress"></p>

  <section class="card setup" data-key="setup">
    <div class="head"><span class="num">0</span><div class="meta"><span class="scene">Style setup: paste this first</span><span class="id">once per chat</span></div></div>
    <pre>${esc(setup)}</pre>
    <div class="bar"><button class="copy" type="button">Copy</button><button class="tick" type="button" aria-pressed="false">Mark done</button></div>
  </section>

  ${panels.map((p, i) => `
  <section class="card" data-key="${p.id}">
    <div class="head"><span class="num">${i + 1}</span><div class="meta"><span class="scene">${esc(p.scene)}</span><span class="id">${p.id}</span></div></div>
    <pre>${esc(p.prompt)}</pre>
    <div class="bar"><button class="copy" type="button">Copy</button><button class="tick" type="button" aria-pressed="false">Mark done</button></div>
  </section>`).join("")}

  <aside class="tips">
    <h3>If an image comes out wrong</h3>
    <ul>
      <li>Text, letters or a visible face crept in: reply "Same image, but remove the text" (or "hide the face in shadow").</li>
      <li>Colour other than amber: don't worry, my processing step turns everything grey except amber light.</li>
      <li>Not sure which of two versions is better? Save both. I'll pick and tell you why.</li>
      <li>Style drifting after many images: start a new chat and paste the style setup again.</li>
    </ul>
    <p class="muted">${esc(arc)}</p>
  </aside>
</main>
<script>
(() => {
  const KEY = "deadweight.promptpack.${chapter}";
  let done = {};
  try { done = JSON.parse(localStorage.getItem(KEY) || "{}"); } catch {}
  const save = () => { try { localStorage.setItem(KEY, JSON.stringify(done)); } catch {} };
  const cards = [...document.querySelectorAll(".card")];
  const progress = document.getElementById("progress");
  const render = () => {
    let n = 0;
    cards.forEach((c) => {
      const d = !!done[c.dataset.key];
      if (d && c.dataset.key !== "setup") n++;
      c.classList.toggle("done", d);
      const t = c.querySelector(".tick");
      t.setAttribute("aria-pressed", String(d));
      t.textContent = d ? "Done" : "Mark done";
    });
    progress.innerHTML = "<b>" + n + "</b> of ${panels.length} panels done";
  };
  cards.forEach((c) => {
    const pre = c.querySelector("pre");
    const copy = c.querySelector(".copy");
    copy.addEventListener("click", async () => {
      try { await navigator.clipboard.writeText(pre.textContent); copy.textContent = "Copied"; }
      catch { const r = document.createRange(); r.selectNodeContents(pre); const s = getSelection(); s.removeAllRanges(); s.addRange(r); copy.textContent = "Selected: press Ctrl+C"; }
      copy.classList.add("ok");
      setTimeout(() => { copy.textContent = "Copy"; copy.classList.remove("ok"); }, 2200);
    });
    c.querySelector(".tick").addEventListener("click", () => { done[c.dataset.key] = !done[c.dataset.key]; save(); render(); });
  });
  render();
})();
</script>
`;
writeFileSync(out, html);
console.log(`prompt pack: ${panels.length} panels -> ${out}`);
