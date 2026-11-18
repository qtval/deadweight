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

const types = { ".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml", ".json": "application/json", ".webp": "image/webp" };
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
  "secret letter, false hero": { plan: [1, 2, 1, 1, 0, 0, 1, 2, 0, 0, 2], expectText: ["Isolde remembers you were dry above the knee."], expectRecap: "told isolde the river took it" },
};

const browser = await chromium.launch();
const ctxOpts = { viewport: { width: 390, height: 844 }, deviceScaleFactor: 2, isMobile: true, hasTouch: true };

async function newPage(errors) {
  const ctx = await browser.newContext(ctxOpts);
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
