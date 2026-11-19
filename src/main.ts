import { Story } from "inkjs";
import storyJson from "./generated/story.json";
import stats from "./generated/story-stats.json";
import "./style.css";

// ---------------------------------------------------------------------------
// Assets
const panelFiles = import.meta.glob("../assets/panels/*.{svg,webp,png,jpg}", { eager: true, query: "?url", import: "default" }) as Record<string, string>;
const panels: Record<string, string> = {};
// A real panel (webp/png/jpg) always wins over its SVG placeholder.
for (const [path, url] of Object.entries(panelFiles)) {
  const id = path.split("/").pop()!.replace(/\.\w+$/, "");
  if (!panels[id] || !path.endsWith(".svg")) panels[id] = url;
}

const WHO: Record<string, { name: string }> = {
  aubric: { name: "Sir Aubric Dane" },
  marrow: { name: "Marrow" },
  isolde: { name: "Isolde Ferrant" },
  letter: { name: "The surrender" },
  sayle: { name: "Marshal Sayle" },
  stint: { name: "Stint" },
};
const ROAD = [
  { place: "The Greywater", note: "The ford where it happened" },
  { place: "The road to Stint", note: "A day south" },
  { place: "Stint", note: "Toll town · Chapter 1" },
  { place: "The Hanging Wood", note: "Last year's battlefield · Chapter 2" },
  { place: "Barrow Hill", note: "The Marshal's camp · Chapter 3" },
  { place: "Saint Weir", note: "A pilgrim chapel · Chapter 4" },
  { place: "Vellmouth", note: "The capital · Chapter 5" },
];
const OUTCOME_WORDS: Record<string, Record<string, string>> = {
  VERSION: { truth: "you told the truth", ambush: "you told Marrow's lie", hero: "you made him a hero" },
  LETTER: { isolde: "Isolde holds the surrender", wren: "you hold the surrender", hidden: "you hold the surrender and deny it" },
};

type Vars = Record<string, any>;
type Beat = { kind: "text" | "remember"; text: string } | { kind: "title"; kicker: string; title: string };

// ---------------------------------------------------------------------------
// Storage (per-viewer convenience only; the game works without it)
const SAVE_KEY = "deadweight.save.v1";
const PREF_KEY = "deadweight.prefs.v1";
const store = {
  get<T>(k: string): T | null { try { const s = localStorage.getItem(k); return s ? (JSON.parse(s) as T) : null; } catch { return null; } },
  set(k: string, v: unknown) { try { localStorage.setItem(k, JSON.stringify(v)); } catch { /* private mode etc. */ } },
  del(k: string) { try { localStorage.removeItem(k); } catch { /* ignore */ } },
};
type Save = { ink: string; panel: string | null; knows: [string, string][]; route: string[]; unseen: boolean; v: 1 };

// ---------------------------------------------------------------------------
// State
let story: Story;
let queue: Beat[] = [];
let panel: string | null = null;
let knows = new Map<string, string>();
let route: string[] = [];
let chapterStart = 0; // index in route where the current chapter began (for the demo end card)
let ended = false;
let endId = "";
// Set by `# chapterend:`; the reader stops pulling, shows the chapter's end card, and Continue resumes.
let chapterBreak = false;
let unseenJournal = false;
let current: Beat | null = null;

const app = document.getElementById("app")!;
app.innerHTML = `
  <div class="panel" aria-hidden="true"><img alt=""><img alt=""></div>
  <div class="bar" hidden>
    <span class="days" data-testid="days"></span>
    <button class="journal-btn" data-testid="journal" aria-label="Open journal">Journal</button>
  </div>
  <div class="stage" data-testid="stage" hidden>
    <div class="box" aria-live="polite"></div>
  </div>
  <div class="layer"></div>`;
const imgs = [...app.querySelectorAll<HTMLImageElement>(".panel img")];
const bar = app.querySelector<HTMLElement>(".bar")!;
const stage = app.querySelector<HTMLElement>(".stage")!;
const box = app.querySelector<HTMLElement>(".box")!;
const layer = app.querySelector<HTMLElement>(".layer")!;
const daysEl = app.querySelector<HTMLElement>(".days")!;
const journalBtn = app.querySelector<HTMLButtonElement>(".journal-btn")!;

const prefs = store.get<{ size?: string }>(PREF_KEY) ?? {};
if (prefs.size) document.documentElement.dataset.size = prefs.size;

const vars = (): Vars => {
  const o: Vars = {};
  // @ts-ignore — inkjs keeps globals in a Map
  for (const k of story.variablesState._globalVariables.keys()) o[k] = story.variablesState.$(k);
  return o;
};
const esc = (s: string) => s.replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]!);
const fmt = (s: string) => esc(s).replace(/\*([^*]+)\*/g, "<em>$1</em>");

// ---------------------------------------------------------------------------
// Panel crossfade
let front = 0;
function showPanel(id: string | null) {
  if (!id || id === panel && imgs[front].classList.contains("on")) return;
  panel = id;
  const url = panels[id];
  const next = imgs[1 - front];
  next.onload = () => { next.classList.add("on"); imgs[front].classList.remove("on"); front = 1 - front; };
  next.src = url ?? "";
  if (!url) console.warn("missing panel", id);
}

function updateBar() {
  const v = vars();
  daysEl.innerHTML = `<b>${v.DAYS_LEFT}</b> days to Vellmouth · ${esc(v.PLACE)}`;
  journalBtn.innerHTML = `Journal${unseenJournal ? '<span class="dot" aria-label="new entries"></span>' : ""}`;
}

// One toast at a time; names learned in quick succession are merged into it.
let toastEl: HTMLElement | null = null, toastNames: string[] = [], toastTimer = 0;
function toastJournal(name: string) {
  toastNames.push(name);
  if (!toastEl) { toastEl = document.createElement("div"); toastEl.className = "toast"; toastEl.dataset.testid = "toast"; app.appendChild(toastEl); }
  toastEl.textContent = `Journal · ${toastNames.join(", ")}`;
  clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => { toastEl?.remove(); toastEl = null; toastNames = []; }, 2700);
}

// ---------------------------------------------------------------------------
// Story flow
function pull(): boolean {
  // Pull lines from ink until at least one beat is queued. Returns false if nothing more.
  while (queue.length === 0 && story.canContinue && !chapterBreak) {
    const line = story.Continue()!.trim();
    const after: Beat[] = [];
    for (const raw of story.currentTags ?? []) {
      const [key, ...rest] = raw.split(":");
      const val = rest.join(":").trim();
      const [a, b] = val.split("::").map((s) => s.trim());
      switch (key.trim()) {
        case "panel": showPanel(val); break;
        case "title": queue.push({ kind: "title", kicker: a, title: b }); break;
        case "know": {
          const isNew = !knows.has(a);
          knows.set(a, b); unseenJournal = true;
          if (isNew && WHO[a]) toastJournal(WHO[a].name);
          break;
        }
        case "remember": after.push({ kind: "remember", text: b }); break;
        case "end": ended = true; endId = val; break;
        case "chapterend": chapterBreak = true; break;
      }
    }
    if (line) queue.push({ kind: "text", text: line });
    queue.push(...after);
    updateBar();
  }
  return queue.length > 0;
}

function advance() {
  if (layer.querySelector(".chapter-card")) return;
  if (!pull()) {
    if (story.currentChoices.length) return renderChoices();
    if (chapterBreak) return showEnd(true);
    if (ended || !story.canContinue) return showEnd(false);
    return;
  }
  current = queue.shift()!;
  if (current.kind === "title") return showChapterCard(current.kicker, current.title);
  renderBeat(current);
  // If ink has nothing more before a choice, show the choices with this line.
  if (!queue.length && !story.canContinue && story.currentChoices.length) renderChoices(true);
}

function renderBeat(b: Beat) {
  if (b.kind === "title") return;
  const cls = b.kind === "remember" ? "remember" : "line";
  box.innerHTML = `<p class="${cls}">${fmt(b.text)}</p><span class="tap" aria-hidden="true">tap to continue</span>`;
}

function renderChoices(keepLine = false) {
  if (!keepLine && current && current.kind !== "title") renderBeat(current);
  box.querySelector(".tap")?.remove();
  const wrap = document.createElement("div");
  wrap.className = "choices";
  story.currentChoices.forEach((c, i) => {
    const btn = document.createElement("button");
    btn.className = "choice";
    btn.dataset.testid = `choice-${i}`;
    btn.innerHTML = `<span class="k">${i + 1}</span>${esc(c.text.trim())}`;
    btn.addEventListener("click", (e) => { e.stopPropagation(); choose(i); });
    wrap.appendChild(btn);
  });
  box.appendChild(wrap);
}

function choose(i: number) {
  route.push(story.currentChoices[i].text.trim());
  story.ChooseChoiceIndex(i);
  save();
  advance();
}

function save() {
  store.set(SAVE_KEY, { ink: story.state.toJson(), panel, knows: [...knows], route, unseen: unseenJournal, v: 1 } satisfies Save);
}

// ---------------------------------------------------------------------------
// Cards
function showChapterCard(kicker: string, title: string) {
  layer.innerHTML = `
    <div class="card chapter-card" data-testid="chapter-card" role="button" tabindex="0">
      <span class="kicker">${esc(kicker)}</span>
      <h2>${esc(title)}</h2>
      <span class="tap">tap to begin</span>
    </div>`;
  const card = layer.querySelector<HTMLElement>(".chapter-card")!;
  const go = () => { layer.innerHTML = ""; advance(); };
  card.addEventListener("click", go);
  card.addEventListener("keydown", (e) => { if (e.key === "Enter" || e.key === " ") { e.preventDefault(); go(); } });
  card.focus();
}

function showTitle() {
  const saved = store.get<Save>(SAVE_KEY);
  bar.hidden = true; stage.hidden = true;
  showPanel("greywater_ford_night");
  layer.innerHTML = `
    <div class="card title-card" data-testid="title-card">
      <span class="kicker">A story in six chapters · Prologue demo</span>
      <h1>Dead&shy;weight</h1>
      <div class="rule"></div>
      <p>The realm's one true hero dies stupidly, a day's ride from the end of his famous quest. You are his squire. Carry the body, the letter that ends the war, and the lie, home.</p>
      <div class="actions">
        ${saved ? '<button class="btn" data-testid="continue">Continue</button><button class="btn ghost" data-testid="begin">Start over</button>'
                : '<button class="btn" data-testid="begin">Begin</button>'}
      </div>
      <p class="quiet">About 10 minutes. Placeholder art; final panels will be illustrated. Contains war, death and coarse language.</p>
    </div>`;
  layer.querySelector('[data-testid="begin"]')!.addEventListener("click", () => start(null));
  layer.querySelector('[data-testid="continue"]')?.addEventListener("click", () => start(saved));
}

function start(saved: Save | null) {
  story = new Story(storyJson as any);
  queue = []; knows = new Map(); route = []; chapterStart = 0; ended = false; endId = ""; chapterBreak = false; unseenJournal = false; current = null;
  if (saved) {
    try {
      story.state.LoadJson(saved.ink);
      knows = new Map(saved.knows); route = saved.route; unseenJournal = saved.unseen;
      if (saved.panel) showPanel(saved.panel);
    } catch { store.del(SAVE_KEY); story = new Story(storyJson as any); }
  } else store.del(SAVE_KEY);
  layer.innerHTML = "";
  bar.hidden = false; stage.hidden = false;
  updateBar();
  advance();
}

function inkText(fn: string) {
  try { return (story.EvaluateFunction(fn, [], true) as any).output.trim() as string; } catch { return ""; }
}

function showEnd(chapterDone: boolean) {
  bar.hidden = true; stage.hidden = true;
  if (!chapterDone && endId === "ch01_preview") {
    store.del(SAVE_KEY);
    layer.innerHTML = `
      <div class="card end-card" data-testid="demo-end">
        <span class="kicker">End of the demo</span>
        <h2>Stint, the first evening</h2>
        <section><p>Chapter 1 goes on from here: the night, the surgeon's bowl at first light, and the Marshal, who is coming to pay his respects.</p></section>
        <section><h3>Your choices in Stint</h3><ol class="route">${route.slice(chapterStart).map((r) => `<li><span>${esc(r)}</span></li>`).join("")}</ol></section>
        <div class="actions">
          <button class="btn" data-testid="again">Play again</button>
          <button class="btn ghost" data-testid="end-journal">Open the journal</button>
        </div>
      </div>`;
  } else {
    if (!chapterDone) store.del(SAVE_KEY);
    const v = vars();
    const recap = inkText("recap").split("\n").filter(Boolean);
    const ballad = inkText("ballad");
    layer.innerHTML = `
      <div class="card end-card" data-testid="end-card">
        <span class="kicker">End of the prologue</span>
        <h2>Eight days to Vellmouth</h2>
        <section><h3>What you did</h3>${recap.map((l) => `<p>${esc(l)}</p>`).join("")}</section>
        <section><h3>Isolde's ballad, as it stands</h3><p class="ballad" data-testid="ballad">${esc(ballad)}</p></section>
        <section><h3>Your choices</h3><ol class="route">${route.map((r) => `<li><span>${esc(r)}</span></li>`).join("")}</ol></section>
        <section>
          <h3>Paths</h3>
          <p class="stat">This prologue has <b>${stats.paths}</b> paths and <b>${stats.outcomes}</b> outcomes. Yours: <b>${OUTCOME_WORDS.VERSION[v.VERSION] ?? "?"}</b>, and <b>${OUTCOME_WORDS.LETTER[v.LETTER] ?? "?"}</b>.</p>
          <p class="quiet">Next, Chapter 1: Stint. The bells are ringing for him, and his own men are waiting on the bridge.</p>
        </section>
        <div class="actions">
          ${chapterDone ? `<button class="btn" data-testid="to-ch1">Continue to Chapter 1</button>` : ""}
          <button class="btn ${chapterDone ? "ghost" : ""}" data-testid="again">Play again</button>
          <button class="btn ghost" data-testid="end-journal">Open the journal</button>
        </div>
      </div>`;
    layer.querySelector('[data-testid="to-ch1"]')?.addEventListener("click", () => {
      chapterStart = route.length;
      chapterBreak = false;
      layer.innerHTML = "";
      bar.hidden = false; stage.hidden = false;
      advance();
    });
  }
  layer.querySelector('[data-testid="again"]')!.addEventListener("click", () => start(null));
  layer.querySelector('[data-testid="end-journal"]')!.addEventListener("click", () => openJournal("travelers"));
}

// ---------------------------------------------------------------------------
// Journal
type Tab = "travelers" | "ballad" | "road" | "settings";
function openJournal(tab: Tab = "travelers") {
  unseenJournal = false; updateBar();
  const sheet = document.createElement("div");
  sheet.className = "sheet";
  sheet.dataset.testid = "journal-sheet";
  const tabs: [Tab, string][] = [["travelers", "Travelers"], ["ballad", "Ballad"], ["road", "Road"], ["settings", "Settings"]];
  sheet.innerHTML = `<div class="sheet-inner" role="dialog" aria-label="Journal">
      <div class="tabs" role="tablist">${tabs.map(([id, l]) => `<button class="tab" role="tab" data-tab="${id}">${l}</button>`).join("")}
      <button class="close" aria-label="Close journal">×</button></div>
      <div class="sheet-body"></div></div>`;
  const body = sheet.querySelector<HTMLElement>(".sheet-body")!;
  const v = vars();
  const render = (t: Tab) => {
    sheet.querySelectorAll<HTMLElement>(".tab").forEach((b) => b.setAttribute("aria-selected", String(b.dataset.tab === t)));
    if (t === "travelers") {
      body.innerHTML = knows.size
        ? [...knows].map(([id, text]) => `<div class="entry ${id === "aubric" && route.length >= 2 ? "dead" : ""}"><h4>${esc(WHO[id]?.name ?? id)}</h4><p>${esc(text)}</p></div>`).join("")
        : `<p class="note">People, places and things you learn about appear here.</p>`;
    } else if (t === "ballad") {
      const b = v.VERSION ? inkText("ballad") : "";
      body.innerHTML = b
        ? `<p class="note">What Isolde has written so far. It changes as you do.</p><p class="ballad">${esc(b)}</p>`
        : `<p class="note">Isolde hasn't written anything you've seen yet.</p>`;
    } else if (t === "road") {
      const here = Math.max(0, ROAD.findIndex((r) => r.place === v.PLACE));
      body.innerHTML = `<p class="note"><b>${v.DAYS_LEFT}</b> days until the surrender lapses.</p><ol class="road">${ROAD.map((r, i) =>
        `<li class="${i < here ? "past" : i === here ? "here" : ""}"><span class="pip"></span><span>${esc(r.place)}<small>${esc(r.note)}</small></span></li>`).join("")}</ol>`;
    } else {
      const size = document.documentElement.dataset.size ?? "m";
      body.innerHTML = `<div><p class="note">Text size</p><div class="seg">${[["s", "Small"], ["m", "Medium"], ["l", "Large"]].map(([k, l]) =>
        `<button data-size="${k}" aria-pressed="${size === k}">${l}</button>`).join("")}</div></div>
        <button class="danger" data-testid="restart">Restart the prologue</button>
        <p class="note">Your place is saved in this browser after every choice.</p>`;
      body.querySelectorAll<HTMLButtonElement>("[data-size]").forEach((b) => b.addEventListener("click", () => {
        document.documentElement.dataset.size = b.dataset.size!;
        store.set(PREF_KEY, { size: b.dataset.size });
        render("settings");
      }));
      const r = body.querySelector<HTMLButtonElement>('[data-testid="restart"]')!;
      r.addEventListener("click", () => {
        if (r.dataset.armed) { sheet.remove(); start(null); return; }
        r.dataset.armed = "1"; r.textContent = "Tap again to restart";
      });
    }
  };
  sheet.querySelectorAll<HTMLElement>(".tab").forEach((b) => b.addEventListener("click", () => render(b.dataset.tab as Tab)));
  sheet.querySelector(".close")!.addEventListener("click", () => sheet.remove());
  sheet.addEventListener("click", (e) => { if (e.target === sheet) sheet.remove(); });
  app.appendChild(sheet);
  render(tab);
}

// ---------------------------------------------------------------------------
// Input
stage.addEventListener("click", () => { if (!story?.currentChoices.length || queue.length) advance(); });
journalBtn.addEventListener("click", (e) => { e.stopPropagation(); openJournal(); });
document.addEventListener("keydown", (e) => {
  if (app.querySelector(".sheet")) { if (e.key === "Escape") app.querySelector(".sheet")!.remove(); return; }
  if (stage.hidden || layer.innerHTML) return;
  if (story.currentChoices.length && !queue.length) {
    const n = Number(e.key);
    if (n >= 1 && n <= story.currentChoices.length) choose(n - 1);
  } else if (e.key === " " || e.key === "Enter") { e.preventDefault(); advance(); }
});

// Keep a game in progress across a live republish of the page (artifact viewers only).
const hot = (window as any).claude?.hot;
hot?.snapshot?.(() => (story ? { ink: story.state.toJson(), panel, knows: [...knows], route, unseen: unseenJournal, v: 1 } : null));
const boot = (data: any) => (data && data.ink ? start(data as Save) : showTitle());
hot?.ready ? hot.ready(boot) : boot(hot?.data ?? null);
