// End-to-end test: plays the built game in a real browser at phone size.
// Routes are played by tapping, exactly as a player would. Writes reports/e2e-report.md and screenshots.
// Run after `npm run build`.
import { createServer } from "node:http";
import { readFileSync, existsSync, mkdirSync, writeFileSync } from "node:fs";
import { join, extname, resolve, dirname } from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { chromium } = require("playwright");
const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const dist = join(root, "dist");
const shots = join(root, "reports/screens");
mkdirSync(shots, { recursive: true });

const types = { ".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml", ".json": "application/json", ".webp": "image/webp", ".mp4": "video/mp4", ".webm": "video/webm", ".jpg": "image/jpeg" };
const server = createServer((req, res) => {
  const p = join(dist, decodeURIComponent(req.url.split("?")[0]).replace(/\/$/, "/index.html"));
  if (!p.startsWith(dist) || !existsSync(p)) { res.writeHead(404); return res.end(); }
  res.writeHead(200, { "content-type": types[extname(p)] ?? "application/octet-stream" });
  res.end(readFileSync(p));
}).listen(4173);
const URL_ = "http://localhost:4173/";

const results = [];
const check = (name, pass, detail = "") => { results.push({ name, pass: !!pass, detail }); console.log(`${pass ? "✓" : "✗"} ${name}${detail ? ` — ${detail}` : ""}`); };

// Choice plans: index to pick at each decision, in order. "last" = last option.
const ROUTES = {
  "first options": { plan: [0, 0, 0, 0, 0, 0, 0, 0, 0], expectText: ["Marrow remembers the wine on your breath.", "Marrow remembers the purse was gone.", "Marrow remembers the Lantern's broken nose."], expectRecap: "you took his bridle" },
  "last options": { plan: ["last", "last", "last", "last", "last", "last", "last", "last"], expectText: [], expectRecap: "you said nothing" },
  "secret letter, false hero": { plan: [1, 2, 1, 1, 0, 0, 1, 2, 0, 0, 0, 2], expectText: ["Isolde remembers you were dry above the knee."], expectRecap: "told isolde the river took it" },
};

const browser = await chromium.launch();
const ctxOpts = { viewport: { width: 390, height: 844 }, deviceScaleFactor: 2, isMobile: true, hasTouch: true };

async function newPage(errors, { reveal = false } = {}) {
  const ctx = await browser.newContext(ctxOpts);
  // The route playthroughs read with text "all at once" (a player setting) so they stay fast; the reveal has its own test.
  if (!reveal) await ctx.addInitScript(() => { try { if (!localStorage.getItem("deadweight.prefs.v1")) localStorage.setItem("deadweight.prefs.v1", JSON.stringify({ reveal: false })); } catch {} });
  // Web fonts come from Google Fonts, which CI sandboxes may block; stub them so only app errors count.
  await ctx.route(/fonts\.(googleapis|gstatic)\.com/, (r) => r.fulfill({ status: 200, body: "", contentType: "text/css" }));
  const page = await ctx.newPage();
  page.on("pageerror", (e) => errors.push(String(e)));
  page.on("console", (m) => { if (m.type() === "error" && !/fonts\.(googleapis|gstatic)/.test(m.text())) errors.push(m.text()); });
  page.on("requestfailed", () => {}); // fonts may be blocked in CI; not an app error
  return { ctx, page };
}

async function playRoute(page, plan, name) {
  const seen = [];
  let picks = 0, steps = 0, shotN = 0;
  while (steps++ < 400) {
    if (await page.locator('[data-testid="end-card"]').count()) break;
    if (await page.locator('[data-testid="chapter-card"]').count()) { await page.locator('[data-testid="chapter-card"]').click(); continue; }
    const choices = page.locator(".choice");
    const n = await choices.count();
    const text = (await page.locator(".box").innerText()).trim();
    if (text && seen.at(-1) !== text) seen.push(text);
    if (n > 0) {
      const toasts = await page.locator(".toast").count();
      if (toasts > 1) check(`[${name}] at most one toast on screen`, false, `${toasts}`);
      if (picks === 1 && shotN === 0) { await page.waitForTimeout(1200); await page.screenshot({ path: join(shots, `${name.replace(/\W+/g, "-")}-choice.png`) }); shotN++; }
      const want = plan[picks] ?? 0;
      const i = want === "last" ? n - 1 : Math.min(want, n - 1);
      const h = await choices.nth(i).evaluate((el) => el.getBoundingClientRect().height);
      if (h < 44) check(`[${name}] choice buttons are at least 44px tall`, false, `${h}px`);
      await choices.nth(i).click();
      picks++;
    } else {
      await page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
    }
  }
  return { seen, picks, steps };
}

// --- three full routes ----------------------------------------------------------
for (const [name, r] of Object.entries(ROUTES)) {
  const errors = [];
  const { ctx, page } = await newPage(errors);
  await page.goto(URL_);
  await page.locator('[data-testid="begin"]').click();
  const { seen, picks, steps } = await playRoute(page, r.plan, name);
  const ended = await page.locator('[data-testid="end-card"]').count();
  check(`[${name}] reaches the end of the prologue`, ended, `${picks} choices, ${steps} taps`);
  const all = seen.join("\n");
  for (const t of r.expectText) check(`[${name}] shows remembered consequence`, all.includes(t), t);
  if (ended) {
    const endText = await page.locator('[data-testid="end-card"]').innerText();
    check(`[${name}] recap reflects the route`, endText.toLowerCase().includes(r.expectRecap), r.expectRecap);
    const ballad = (await page.locator('[data-testid="ballad"]').innerText()).trim();
    check(`[${name}] ballad is written`, ballad.length > 20);
    const listed = await page.locator(".route li").count();
    check(`[${name}] every choice is listed on the end screen`, listed === picks, `${listed}/${picks}`);
    check(`[${name}] end screen hides the game behind it`, !(await page.locator('[data-testid="stage"]').isVisible()) && !(await page.locator(".bar").isVisible()));
    await page.waitForTimeout(900);
    await page.screenshot({ path: join(shots, `${name.replace(/\W+/g, "-")}-end.png`), fullPage: false });
    await page.locator('[data-testid="end-journal"]').click();
    const journal = await page.locator('[data-testid="journal-sheet"]').innerText();
    check(`[${name}] journal lists the travelers met`, ["Marrow", "Isolde Ferrant", "Sir Aubric Dane"].every((s) => journal.includes(s)));
    await page.locator('.tab[data-tab="road"]').click();
    check(`[${name}] road shows the party on the road to Stint`, (await page.locator(".road li.here").innerText()).includes("The road to Stint"));
  }
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth > window.innerWidth);
  check(`[${name}] no horizontal overflow`, !overflow);
  check(`[${name}] no console or page errors`, errors.length === 0, errors.slice(0, 2).join(" | "));
  await ctx.close();
}

// --- on into chapter 1 ------------------------------------------------------------
{
  const errors = [];
  const { ctx, page } = await newPage(errors);
  await page.goto(URL_);
  await page.locator('[data-testid="begin"]').click();
  await playRoute(page, [0], "chapter 1");
  check("[chapter 1] prologue end card offers Continue", await page.locator('[data-testid="to-ch1"]').count() === 1);
  await page.locator('[data-testid="to-ch1"]').click();
  let steps = 0, sawTitle = false, sawStint = false;
  while (steps++ < 300 && !(await page.locator('[data-testid="demo-end"]').count())) {
    if (await page.locator('[data-testid="chapter-card"]').count()) { sawTitle = true; await page.locator('[data-testid="chapter-card"]').click(); continue; }
    const box = (await page.locator(".box").innerText().catch(() => "")) || "";
    if (box.includes("beech wood")) sawStint = true;
    const n = await page.locator(".choice").count();
    if (n) await page.locator(".choice").nth(0).click();
    else await page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
  }
  check("[chapter 1] shows the chapter title card", sawTitle);
  check("[chapter 1] opens in the beech wood", sawStint);
  check("[chapter 1] reaches the end of the demo", await page.locator('[data-testid="demo-end"]').count() === 1, `${steps} taps`);
  await page.waitForTimeout(600);
  await page.screenshot({ path: join(shots, "chapter-1-end.png") });
  check("[chapter 1] no console or page errors", errors.length === 0, errors.slice(0, 2).join(" | "));
  await ctx.close();
}

// --- save and resume -------------------------------------------------------------
{
  const errors = [];
  const { ctx, page } = await newPage(errors);
  await page.goto(URL_);
  await page.locator('[data-testid="begin"]').click();
  await page.screenshot({ path: join(shots, "chapter-card.png") });
  let picks = 0;
  for (let s = 0; s < 100 && picks < 2; s++) {
    if (await page.locator('[data-testid="chapter-card"]').count()) { await page.locator('[data-testid="chapter-card"]').click(); continue; }
    if (await page.locator(".choice").count()) { await page.locator(".choice").first().click(); picks++; }
    else await page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
  }
  await page.reload();
  const cont = await page.locator('[data-testid="continue"]').count();
  check("[save] title offers Continue after reload", cont);
  check("[title] top bar hidden on the title screen", !(await page.locator(".bar").isVisible()));
  await page.waitForTimeout(900);
  await page.screenshot({ path: join(shots, "title.png") });
  if (cont) {
    await page.locator('[data-testid="continue"]').click();
    let found = false;
    for (let s = 0; s < 30 && !found; s++) {
      const t = await page.locator(".box").innerText();
      if (t.includes("Go into the river")) found = true;
      else if (await page.locator(".choice").count()) break;
      else await page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
    }
    check("[save] resumes at the same point in the story (the river decision)", found);
    const days = await page.locator('[data-testid="days"]').innerText();
    check("[save] day counter restored", days.includes("9"), days);
    await page.screenshot({ path: join(shots, "bank-choice.png") });
  }
  check("[save] no console or page errors", errors.length === 0, errors.slice(0, 2).join(" | "));
  await ctx.close();
}

// --- scene sound and paced text ------------------------------------------------------
async function tapOn(page) {
  if (await page.locator('[data-testid="chapter-card"]').count()) return page.locator('[data-testid="chapter-card"]').click();
  if (await page.locator(".choice").count()) return page.locator(".choice").first().click();
  return page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
}
{
  const errors = [];
  const { ctx, page } = await newPage(errors, { reveal: true });
  await page.goto(URL_);
  await page.locator('[data-testid="begin"]').click();
  await page.waitForTimeout(400);
  let snd = await page.evaluate(() => window.__sound());
  check("[sound] starts after the first tap", snd.state === "running", JSON.stringify(snd));
  check("[sound] the opening plays the ford at night", snd.scene === "greywater_ford_night", snd.scene);
  await page.waitForTimeout(2500);
  snd = await page.evaluate(() => window.__sound());
  check("[sound] the river is up at the ford", snd.layers.river > 0.2 && snd.layers.crowd < 0.05, JSON.stringify(snd.layers));
  // paced text: a paragraph of several sentences arrives one sentence at a time; a tap shows the rest, without moving on
  let caught = null;
  for (let i = 0; i < 40 && !caught; i++) {
    await tapOn(page);
    await page.waitForTimeout(80);
    const n = await page.locator(".box .line .s").count();
    if (n >= 3 && !(await page.locator(".box.shown").count())) {
      const op = await page.locator(".box .line .s").last().evaluate((el) => +getComputedStyle(el).opacity);
      caught = { op, text: (await page.locator(".box .line").innerText()).slice(0, 40) };
    }
  }
  check("[reveal] long paragraphs arrive sentence by sentence", caught && caught.op < 0.5, JSON.stringify(caught));
  if (caught) {
    await page.locator('[data-testid="stage"]').click({ position: { x: 195, y: 500 } });
    await page.waitForTimeout(80);
    const after = (await page.locator(".box .line").innerText()).slice(0, 40);
    const op2 = await page.locator(".box .line .s").last().evaluate((el) => +getComputedStyle(el).opacity);
    check("[reveal] a tap shows the whole paragraph and stays on it", op2 > 0.99 && caught.text === after, `${op2} ${caught.text === after}`);
  }
  // the sound button mutes, and the choice is remembered
  await page.locator('[data-testid="sound"]').click();
  snd = await page.evaluate(() => window.__sound());
  check("[sound] the button mutes", snd.muted === true && (await page.locator('[data-testid="sound"]').getAttribute("aria-pressed")) === "false");
  await page.reload();
  snd = await page.evaluate(() => window.__sound());
  check("[sound] muting is remembered", snd.muted === true);
  await page.locator('[data-testid="continue"], [data-testid="begin"]').first().click();
  await page.waitForTimeout(300);
  if (await page.locator('[data-testid="chapter-card"]').count()) await page.locator('[data-testid="chapter-card"]').click();
  // settings: text all at once
  await page.locator('[data-testid="journal"]').click();
  await page.locator('.tab[data-tab="settings"]').click();
  await page.locator('[data-reveal="off"]').click();
  await page.locator(".sheet .close").click();
  for (let i = 0; i < 6; i++) await tapOn(page);
  check("[reveal] 'All at once' turns it off", (await page.locator(".box .line .s").count()) <= 1);
  check("[sound] no console or page errors", errors.length === 0, errors.slice(0, 2).join(" | "));
  await ctx.close();
}

// --- trailer ------------------------------------------------------------------------
{
  const errors = [];
  const { ctx, page } = await newPage(errors);
  await page.goto(URL_);
  check("[trailer] hidden on the title screen until it passes the viewer panel", await page.locator('[data-testid="trailer"]').count() === 0);
  await page.goto(URL_ + "?trailer");
  const btn = page.locator('[data-testid="trailer"]');
  check("[trailer] title screen offers the trailer with ?trailer", await btn.count() === 1);
  await btn.click();
  const v = page.locator('[data-testid="trailer-player"] video');
  check("[trailer] player opens", await v.count() === 1);
  const meta = await v.evaluate((el) => new Promise((ok) => {
    const done = () => ok({ w: el.videoWidth, h: el.videoHeight, d: el.duration, src: el.currentSrc.split("/").pop() });
    if (el.readyState >= 1) return done();
    el.addEventListener("loadedmetadata", done, { once: true });
    setTimeout(() => ok({ w: 0, h: 0, d: 0, src: el.currentSrc, err: el.error && el.error.code }), 8000);
  }));
  check("[trailer] the film loads in the browser", meta.w === 1280 && meta.h === 720, JSON.stringify(meta));
  check("[trailer] runs about a minute and a half", meta.d > 85 && meta.d < 95, `${Math.round(meta.d)}s`);
  await page.screenshot({ path: join(shots, "trailer.png") });
  await page.locator('[data-testid="trailer-close"]').click();
  check("[trailer] closes back to the title screen", await page.locator('[data-testid="trailer-player"]').count() === 0 && await page.locator('[data-testid="begin"]').isVisible());
  check("[trailer] no console or page errors", errors.length === 0, errors.slice(0, 2).join(" | "));
  await ctx.close();
}

// --- desktop layout ----------------------------------------------------------------
{
  const errors = [];
  const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 } });
  await ctx.route(/fonts\.(googleapis|gstatic)\.com/, (r) => r.fulfill({ status: 200, body: "", contentType: "text/css" }));
  const page = await ctx.newPage();
  page.on("pageerror", (e) => errors.push(String(e)));
  await page.goto(URL_);
  await page.locator('[data-testid="begin"]').click();
  await page.locator('[data-testid="chapter-card"]').click();
  await page.keyboard.press("Space");
  const w = await page.locator("#app").evaluate((el) => el.getBoundingClientRect().width);
  check("[desktop] game stays a phone-shaped column", w <= 540, `${w}px`);
  await page.screenshot({ path: join(shots, "desktop.png") });
  check("[desktop] keyboard advances the story", (await page.locator(".box").innerText()).length > 0);
  await ctx.close();
}

await browser.close();
server.close();

const ok = results.every((r) => r.pass);
const md = [`# Browser test report`, ``, `Generated by \`npm run test:e2e\` against the production build, phone viewport 390×844.`, ``,
  `**Result: ${ok ? "PASS" : "FAIL"}** — ${results.filter((r) => r.pass).length}/${results.length} checks`, ``,
  ...results.map((r) => `- ${r.pass ? "✅" : "❌"} ${r.name}${r.detail ? ` — ${r.detail}` : ""}`), ``,
  `Screenshots: \`reports/screens/\``];
writeFileSync(join(root, "reports/e2e-report.md"), md.join("\n") + "\n");
console.log(`${ok ? "PASS" : "FAIL"}: ${results.filter((r) => r.pass).length}/${results.length}`);
process.exit(ok ? 0 : 1);
