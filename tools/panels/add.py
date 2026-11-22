"""Add finished panels to the game with only a light, shared touch, so they keep the look the owner chose.

  python3 tools/panels/add.py <panel_id>=<image> [...] [--source "Gemini, field-sketch style"]

Each image: resized to 1024x1536 (2:3; the game fills the screen with object-fit: cover), black and white points
set to the same targets as every other panel (colour kept: the warm sepia paper is part of the chosen look), one
shared fine grain, WebP into assets/panels/<id>.webp. The placeholder SVG is removed and a line goes to art/LOG.csv.
Also reports how much of the picture is warm, saturated colour, as a check that colour is only on the lights.
"""
import os, sys, datetime
import numpy as np
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
W, H = 1024, 1536


def add(pid, src, source):
    im = Image.open(src).convert("RGB")
    s = max(W / im.width, H / im.height)
    im = im.resize((round(im.width * s), round(im.height * s)), Image.LANCZOS)
    x0, y0 = (im.width - W) // 2, (im.height - H) // 2
    a = np.asarray(im.crop((x0, y0, x0 + W, y0 + H)), np.float32)
    lum = a @ np.array([0.2126, 0.7152, 0.0722], np.float32)
    lo, hi = np.percentile(lum, 0.5), np.percentile(lum, 99.5)
    a = (a - lo) * ((236 - 12) / max(1, hi - lo)) + 12
    rng = np.random.default_rng(sum(map(ord, pid)))
    a += (rng.standard_normal((H, W, 1)) * 3.0).astype(np.float32)
    a = np.clip(a, 0, 255)
    # warm, clearly saturated, bright pixels = "amber"
    mx, mn = a.max(-1), a.min(-1)
    sat = (mx - mn) / np.maximum(mx, 1)
    warm = (a[..., 0] > a[..., 1]) & (a[..., 1] > a[..., 2])
    amber = float((warm & (sat > 0.45) & (mx > 140)).mean())
    dest = os.path.join(ROOT, "assets", "panels", pid + ".webp")
    Image.fromarray(a.astype(np.uint8)).save(dest, quality=84, method=6)
    svg = os.path.join(ROOT, "assets", "panels", pid + ".svg")
    if os.path.exists(svg):
        os.remove(svg)
    with open(os.path.join(ROOT, "art", "LOG.csv"), "a") as f:
        f.write(f"{pid},{datetime.date.today()},{source},{os.path.basename(src)},picked,\"light touch only (tools/panels/add.py)\"\n")
    return dest, amber


if __name__ == "__main__":
    args = sys.argv[1:]
    source = "Gemini, field-sketch style"
    if "--source" in args:
        i = args.index("--source"); source = args[i + 1]; del args[i:i + 2]
    for pair in args:
        pid, src = pair.split("=", 1)
        dest, amber = add(pid, src, source)
        print(f"{pid:32s} -> {os.path.relpath(dest, ROOT)}  {os.path.getsize(dest) // 1024} KB  amber {amber * 100:.2f}%")
