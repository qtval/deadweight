// Screen tour: visits every screen of the built game and saves a screenshot of each, for the interface review.
// Run after `npm run build`:  node tools/screen-tour.mjs
// Writes reports/screens/tour/*.png (phone 390×844, small phone 320×568, landscape 844×390).
import { createServer } from "node:http";
import { readFileSync, existsSync, mkdirSync } from "node:fs";
import { join, extname, resolve, dirname } from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { chromium } = require("playwright");
const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const dist = join(root, "dist");
const out = join(root, "reports/screens/tour");
mkdirSync(out, { recursive: true });

const types = { ".html": "text/html", ".js": "text/javascript", ".css": "text/css", ".svg": "image/svg+xml", ".json": "application/json", ".webp": "image/webp" };
const server = createServer((req, res) => {
  const p = join(dist, decodeURIComponent(req.url.split("?")[0]).replace(/\/$/, "/index.html"));
  if (!p.startsWith(dist) || !existsSync(p)) { res.writeHead(404); return res.end(); }
  res.writeHead(200, { "content-type": types[extname(p)] ?? "application/octet-stream" });
  res.end(readFileSync(p));
}).listen(4174);
const URL_ = "http://localhost:4174/";

const browser = await chromium.launch();
const errors = [];
async function page(viewport) {
  const ctx = await browser.newContext({ viewport, deviceScaleFactor: 2, isMobile: true, hasTouch: true });
  // Text "all at once" (a player setting) so the tour moves quickly; the reveal has its own browser test.
  await ctx.addInitScript(() => { try { if (!localStorage.getItem("deadweight.prefs.v1")) localStorage.setItem("deadweight.prefs.v1", JSON.stringify({ reveal: false })); } catch {} });
  await ctx.route(/fonts\.(googleapis|gstatic)\.com/, (r) => r.fulfill({ status: 200, body: "", contentType: "text/css" }));
  const p = await ctx.newPage();
  p.on("pageerror", (e) => errors.push(String(e)));
  return p;
}
const shot = (p, name, full = false) => p.screenshot({ path: join(out, `${name}.png`), fullPage: full });
const wait = (p, ms = 350) => p.waitForTimeout(ms);

// Tap through text until a choice, an end card or a chapter card shows.
async function toNext(p, max = 80) {
  for (let i = 0; i < max; i++) {
    if (await p.locator('.choice, [data-testid="end-card"], [data-testid="demo-end"], [data-testid="chapter-card"]').count()) return;
    await p.locator('[data-testid="stage"]').click(); await wait(p, 60);
  }
}

// ---- Phone, full tour
const ph = await page({ width: 390, height: 844 });
await ph.goto(URL_); await wait(ph, 800);
await shot(ph, "01-title");
await ph.locator('[data-testid="begin"]').first().click(); await wait(ph, 600);
if (await ph.locator('[data-testid="chapter-card"]').count()) { await shot(ph, "02-chapter-card-prologue"); await ph.locator('[data-testid="chapter-card"]').click(); await wait(ph, 600); }
await shot(ph, "03-first-text");
await toNext(ph); await wait(ph);
await shot(ph, "04-first-choice");
for (const [i, tab] of ["travelers", "ballad", "road", "settings"].entries()) {
  if (!(await ph.locator(".sheet").count())) { await ph.locator('[data-testid="journal"]').click(); await wait(ph); }
  await ph.locator(`.tab[data-tab="${tab}"]`).click(); await wait(ph);
  await shot(ph, `05-journal-${i + 1}-${tab}`);
}
await ph.locator('[data-size="l"]').click(); await wait(ph);
await ph.locator(".sheet .close").click(); await wait(ph);
await shot(ph, "06-large-text-choice");
await ph.locator('[data-testid="journal"]').click(); await ph.locator('.tab[data-tab="settings"]').click(); await ph.locator('[data-size="m"]').click(); await ph.locator(".sheet .close").click(); await wait(ph);
// Play the prologue by first options, shooting a mid-way choice and the toast/remember lines when they appear.
let n = 0;
while (!(await ph.locator('[data-testid="end-card"]').count()) && n < 30) {
  await toNext(ph);
  if (await ph.locator('[data-testid="end-card"]').count()) break;
  if (await ph.locator('[data-testid="chapter-card"]').count()) { await ph.locator('[data-testid="chapter-card"]').click(); await wait(ph); continue; }
  if (n === 5) await shot(ph, "07-mid-prologue-choice");
  await ph.locator(".choice").first().click(); await wait(ph, 120); n++;
  if (await ph.locator(".toast").count()) await shot(ph, `08-toast-${n}`);
}
await wait(ph, 600);
await shot(ph, "09-prologue-end", true);
await ph.locator('[data-testid="to-ch1"]').click(); await wait(ph, 600);
if (await ph.locator('[data-testid="chapter-card"]').count()) { await shot(ph, "10-chapter-card-ch1"); await ph.locator('[data-testid="chapter-card"]').click(); await wait(ph, 600); }
await shot(ph, "11-ch1-first-text");
await toNext(ph); await shot(ph, "12-ch1-first-choice");
n = 0;
while (!(await ph.locator('[data-testid="demo-end"]').count()) && n < 30) {
  await toNext(ph);
  if (await ph.locator('[data-testid="demo-end"]').count()) break;
  if (n === 6) await shot(ph, "13-ch1-square-choice");
  await ph.locator(".choice").first().click(); await wait(ph, 120); n++;
}
await wait(ph, 600);
await shot(ph, "14-demo-end", true);
// Reload: does the title offer Continue?
await ph.reload(); await wait(ph, 800);
await shot(ph, "15-title-after-reload");

// ---- Small phone
const sm = await page({ width: 320, height: 568 });
await sm.goto(URL_); await wait(sm, 800);
await shot(sm, "20-small-title");
await sm.locator('[data-testid="begin"]').first().click(); await wait(sm, 600);
if (await sm.locator('[data-testid="chapter-card"]').count()) { await sm.locator('[data-testid="chapter-card"]').click(); await wait(sm, 600); }
await toNext(sm); await wait(sm);
await shot(sm, "21-small-first-choice");
await sm.locator('[data-testid="journal"]').click(); await wait(sm);
await sm.locator('.tab[data-tab="road"]').click(); await wait(sm);
await shot(sm, "22-small-journal-road");

// ---- Landscape phone
const ls = await page({ width: 844, height: 390 });
await ls.goto(URL_); await wait(ls, 800);
await ls.locator('[data-testid="begin"]').first().click(); await wait(ls, 600);
if (await ls.locator('[data-testid="chapter-card"]').count()) { await ls.locator('[data-testid="chapter-card"]').click(); await wait(ls, 600); }
await toNext(ls); await wait(ls);
await shot(ls, "30-landscape-first-choice");

await browser.close(); server.close();
console.log(errors.length ? `page errors:\n${errors.join("\n")}` : "screen tour: no page errors");
console.log(`screens in ${out}`);
