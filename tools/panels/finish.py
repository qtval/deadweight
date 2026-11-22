"""Ink finish: takes any generated image and makes it look printed by hand, and like every other panel.

  python3 tools/panels/finish.py <panel_id>=<image> [...] [--strength 1.0] [--preview out.jpg]

Why: generated images look polished (perfect gradients, glossy light, micro-detail everywhere) and drift in style
from one image to the next. This pass is the same for every panel, so it removes the polish and pulls them together:

  1. Crop to the game's frame (1080x1920, centre) and keep amber only where it is real warm light.
  2. Simplify: flatten the smooth digital gradients into a few charcoal tones (the main anti-polish step).
  3. Ink: ragged dark lines along the big edges, engraved hatching in the mid-darks, solid blacks in the deep darks.
  4. Paper: fibre, a little foxing, uneven ink density, dust; the amber printed slightly off register.

Writes assets/panels/<panel_id>.webp (replacing the placeholder SVG) unless --preview is given.
"""
import os, sys, math
import numpy as np
from PIL import Image, ImageFilter
from scipy.ndimage import gaussian_filter, sobel, median_filter

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
W, H = 1080, 1920
INK = np.array([16, 14, 12], np.float32)
PAPER = np.array([226, 220, 206], np.float32)
AMBER = np.array([255, 160, 64], np.float32)


def noise(rng, h, w, cell):
    gh, gw = int(h / cell) + 2, int(w / cell) + 2
    small = rng.random((gh, gw)).astype(np.float32)
    return np.asarray(Image.fromarray(small, "F").resize((int(gw * cell), int(gh * cell)), Image.BICUBIC), np.float32)[:h, :w]


def smooth(e0, e1, x):
    t = np.clip((x - e0) / (e1 - e0), 0, 1)
    return t * t * (3 - 2 * t)


def finish(src, seed=1, strength=1.0):
    rng = np.random.default_rng(seed)
    im = Image.open(src).convert("RGB")
    # cover-crop to 9:16
    s = max(W / im.width, H / im.height)
    im = im.resize((math.ceil(im.width * s), math.ceil(im.height * s)), Image.LANCZOS)
    x0, y0 = (im.width - W) // 2, (im.height - H) // 2
    im = im.crop((x0, y0, x0 + W, y0 + H))
    a = np.asarray(im, np.float32) / 255.0
    r, g, b = a[..., 0], a[..., 1], a[..., 2]
    mx, mn = a.max(-1), a.min(-1)
    sat = np.where(mx > 0, (mx - mn) / np.maximum(mx, 1e-6), 0)
    hue = np.zeros_like(mx)
    d = np.maximum(mx - mn, 1e-6)
    hue = np.where(mx == r, ((g - b) / d) % 6, np.where(mx == g, (b - r) / d + 2, (r - g) / d + 4)) * 60
    amber = smooth(8, 22, hue) * (1 - smooth(52, 66, hue)) * smooth(0.22, 0.45, sat) * smooth(0.25, 0.5, mx)
    amber = np.maximum(gaussian_filter(amber, 1.0), amber * 0.9)  # keep small lights (a far lantern is a few pixels)
    lum = 0.2126 * r + 0.7152 * g + 0.0722 * b

    # levels
    lo, hi = np.percentile(lum, 1), np.percentile(lum, 99.3)
    L = np.clip((lum - lo) / max(1e-3, hi - lo), 0, 1)

    # 2. simplify: knock out micro-detail and smooth gradients, then step the tones
    Ls = median_filter(L, size=5)
    Ls = gaussian_filter(Ls, 1.2)
    steps = 5
    q = np.floor(Ls * steps + 0.5) / steps
    # mottle the step edges like charcoal on rough paper instead of clean bands
    mot = (noise(rng, H, W, 40) - 0.5) * 0.10 + (noise(rng, H, W, 9) - 0.5) * 0.08 + (noise(rng, H, W, 2.5) - 0.5) * 0.06
    q = np.floor(np.clip(Ls + mot, 0, 1) * steps + 0.5) / steps
    q = gaussian_filter(q, 1.5)
    stepped = np.clip(Ls + (q - Ls) * 0.6 * strength + mot * 0.5 * strength, 0, 1)
    stepped = stepped ** 1.15  # a little heavier, like charcoal

    # 3. ink: engraved hatching in mid-darks, solid deep blacks, ragged edge lines
    yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
    warp = (noise(rng, H, W, 320) - 0.5) * 16 + (noise(rng, H, W, 70) - 0.5) * 5
    ang = math.radians(-16)
    v = yy * math.cos(ang) + xx * math.sin(ang) + warp
    period = 7.5
    ph = np.abs(((v / period) % 1.0) - 0.5) * 2
    dark = 1 - stepped
    hatch = np.clip((np.clip(dark * 1.05 - 0.12, 0, 1) - ph) * period * 0.55 + 0.5, 0, 1)
    ang2 = math.radians(48)
    v2 = yy * math.cos(ang2) + xx * math.sin(ang2) + warp * 0.6
    ph2 = np.abs(((v2 / (period * 1.2)) % 1.0) - 0.5) * 2
    hatch2 = np.clip((np.clip((dark - 0.6) * 1.8, 0, 1) - ph2) * period * 0.55 + 0.5, 0, 1)
    ink = np.maximum(hatch, hatch2) * 0.55 * strength
    ink = np.maximum(ink, smooth(0.80, 0.93, dark))
    soft = gaussian_filter(Ls, 1.6)
    e = np.hypot(sobel(soft, 0), sobel(soft, 1))
    e = np.clip(e / (np.percentile(e, 99.2) + 1e-6) - 0.18, 0, 1)
    e = e * smooth(0.25, 0.7, noise(rng, H, W, 25))  # broken, hand-drawn line
    ink = np.maximum(ink, e * 0.9)
    tone = stepped * (1 - ink * 0.85)
    # dry brush: ink breaks up where it meets paper
    brk = noise(rng, H, W, 1.8)
    tone = np.where((ink > 0.25) & (ink < 0.75) & (brk > 0.7), np.minimum(1, tone + 0.25), tone)

    # 4. paper
    fibre = noise(np.random.default_rng(seed + 1), H, W // 6, 3)
    fibre = np.asarray(Image.fromarray(fibre, "F").resize((W, H), Image.BICUBIC), np.float32)
    fox = smooth(0.62, 0.9, noise(rng, H, W, 160)) * 0.10
    grain = (noise(rng, H, W, 1.4) - 0.5) * 0.07
    tone = np.clip(tone + (fibre - 0.5) * 0.04 + grain - fox * (tone > 0.5), 0, 1)
    dx, dy = (xx / W - 0.5) * 1.05, (yy / H - 0.46)
    tone = tone * (1 - 0.45 * smooth(0.32, 0.8, np.sqrt(dx * dx + dy * dy)))
    rgb = INK + (PAPER - INK) * tone[..., None]
    # amber, printed a couple of pixels off register, glowing a little into the paper
    am = np.roll(np.roll(amber, 2, 0), -2, 1)
    glow = np.clip(am * (0.35 + gaussian_filter(lum, 3) * 1.1), 0, 1.2)
    glow = np.maximum(glow, gaussian_filter(glow, 14) * 0.6)
    rgb = rgb * (1 - np.clip(glow, 0, 1)[..., None] * 0.85) + AMBER * (np.clip(glow, 0, 1) * 0.95)[..., None] + np.array([255, 230, 190]) * np.clip(glow - 0.9, 0, 0.3)[..., None]
    return Image.fromarray(np.clip(rgb, 0, 255).astype(np.uint8)), float((amber > 0.15).mean())


if __name__ == "__main__":
    args = sys.argv[1:]
    strength = 1.0
    preview = None
    if "--strength" in args:
        i = args.index("--strength"); strength = float(args[i + 1]); del args[i:i + 2]
    if "--preview" in args:
        i = args.index("--preview"); preview = args[i + 1]; del args[i:i + 2]
    for pair in args:
        pid, src = pair.split("=", 1)
        img, share = finish(src, seed=sum(map(ord, pid)), strength=strength)
        if preview:
            img.save(preview, quality=90)
            print(f"{pid}: preview -> {preview} (amber {share * 100:.2f}% of pixels)")
        else:
            dest = os.path.join(ROOT, "assets", "panels", pid + ".webp")
            img.save(dest, quality=84)
            svg = os.path.join(ROOT, "assets", "panels", pid + ".svg")
            if os.path.exists(svg):
                os.remove(svg)
            print(f"{pid} -> {os.path.relpath(dest, ROOT)} (amber {share * 100:.2f}% of pixels)")
