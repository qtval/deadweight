// Process picked images into game panels so every panel matches, whatever chat or day it came from.
//   node tools/process-panel.mjs <panel_id>=<image> [<panel_id>=<image> ...] [--note "text"]
//
// Steps: crop to 1080x1920 (centre) → enforce the palette (everything grey except amber light;
// stray colours ChatGPT adds become grey) → normalise black/white points → same grain and vignette →
// WebP into assets/panels/<id>.webp. Removes that panel's placeholder SVG and logs provenance to art/LOG.csv.
import { appendFileSync, existsSync, rmSync, readFileSync } from "node:fs";
import { basename, dirname, join, resolve } from "node:path";
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const sharp = require("sharp");

const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const W = 1080, H = 1920;
const AMBER = [255, 168, 72];

const args = process.argv.slice(2);
const noteIdx = args.indexOf("--note");
const note = noteIdx >= 0 ? args.splice(noteIdx, 2)[1] : "";
const model = "ChatGPT (GPT-Image-2), ChatGPT app";
if (!args.length) { console.error("usage: process-panel.mjs <panel_id>=<image> ..."); process.exit(1); }

const smooth = (e0, e1, x) => { const t = Math.min(1, Math.max(0, (x - e0) / (e1 - e0))); return t * t * (3 - 2 * t); };
function hsv(r, g, b) {
  const mx = Math.max(r, g, b), mn = Math.min(r, g, b), d = mx - mn;
  let h = 0;
  if (d) h = mx === r ? ((g - b) / d) % 6 : mx === g ? (b - r) / d + 2 : (r - g) / d + 4;
  return [(h * 60 + 360) % 360, mx ? d / mx : 0, mx / 255];
}
function rng(seed) { let s = seed >>> 0 || 1; return () => ((s = (s * 1664525 + 1013904223) >>> 0) / 4294967296); }

export async function processPanel(id, src) {
  const { data, info } = await sharp(src).rotate().resize(W, H, { fit: "cover", position: "centre" }).removeAlpha().raw().toBuffer({ resolveWithObject: true });
  const n = info.width * info.height;
  const lum = new Float32Array(n), amber = new Float32Array(n);
  for (let i = 0; i < n; i++) {
    const r = data[i * 3], g = data[i * 3 + 1], b = data[i * 3 + 2];
    lum[i] = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    const [h, s, v] = hsv(r, g, b);
    // Amber = warm hue (orange→yellow), clearly saturated, not in deep shadow.
    const hueW = smooth(8, 22, h) * (1 - smooth(52, 66, h));
    amber[i] = hueW * smooth(0.18, 0.42, s) * smooth(0.12, 0.3, v);
  }
  // Levels: stretch the 0.5th–99.5th percentile of luminance to near-black..near-white.
  const sorted = Float32Array.from(lum).sort();
  const lo = sorted[Math.floor(n * 0.005)], hi = sorted[Math.floor(n * 0.995)];
  const span = Math.max(1, hi - lo);
  const rand = rng([...id].reduce((a, c) => a * 31 + c.charCodeAt(0), 7));
  const out = Buffer.alloc(n * 3);
  let amberPx = 0;
  for (let i = 0; i < n; i++) {
    const x = i % W, y = (i / W) | 0;
    let L = Math.min(1, Math.max(0, (lum[i] - lo) / span));
    L = 0.03 + 0.93 * L;
    const dx = (x / W - 0.5) * 1.1, dy = (y / H - 0.45);
    L *= 1 - 0.55 * smooth(0.28, 0.75, Math.sqrt(dx * dx + dy * dy)); // vignette
    const grain = (rand() + rand() - 1) * 0.045;
    const g = Math.min(1, Math.max(0, L + grain)) * 255;
    const a = amber[i];
    if (a > 0.05) amberPx++;
    const glow = Math.min(1, 0.25 + L * 1.25);
    // Neutral greys with a faint paper warmth; amber pixels blend toward one fixed amber.
    out[i * 3]     = Math.min(255, g * 1.015 * (1 - a) + AMBER[0] * glow * a);
    out[i * 3 + 1] = Math.min(255, g * (1 - a) + AMBER[1] * glow * a);
    out[i * 3 + 2] = Math.min(255, g * 0.975 * (1 - a) + AMBER[2] * glow * a);
  }
  const dest = join(root, "assets/panels", `${id}.webp`);
  await sharp(out, { raw: { width: W, height: H, channels: 3 } }).webp({ quality: 82 }).toFile(dest);
  const svg = join(root, "assets/panels", `${id}.svg`);
  if (existsSync(svg)) rmSync(svg);
  return { dest, amberShare: amberPx / n };
}

const log = join(root, "art/LOG.csv");
for (const pair of args) {
  const [id, src] = pair.split(/=(.*)/s);
  if (!id || !src || !existsSync(src)) { console.error(`skip: ${pair} (missing file)`); process.exitCode = 1; continue; }
  const { dest, amberShare } = await processPanel(id, src);
  appendFileSync(log, `${id},${new Date().toISOString().slice(0, 10)},${model},${basename(src).replace(/,/g, " ")},picked,"${note.replace(/"/g, "'")}"\n`);
  console.log(`${id} -> ${dest.replace(root + "/", "")}  (amber ${(amberShare * 100).toFixed(1)}% of pixels)`);
}
