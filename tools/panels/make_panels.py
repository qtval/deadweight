"""Panels drawn by code in an engraving style: the scene is composed as tones (tools/promo/draw.py), then
re-inked as tone-weighted lines like a woodcut or engraving. Amber only for real light. No faces, no text.

  python3 tools/panels/make_panels.py [panel_id ...]   -> art/engraved/<panel_id>.png (1024x1536)
"""
import os, sys
import numpy as np
from PIL import Image
from scipy.ndimage import gaussian_filter, sobel

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools", "promo"))
from draw import (Canvas, INK, BONE, AMBER, alders, water, gravel, reeds, cart, lantern, horse_rider,  # noqa: E402
                  lying_knight, standing, crouched, shape, limb)

W, H = 1024, 1536
OUT = os.path.join(ROOT, "art", "engraved")


def engrave(lum, seed=1, period=6.0, angle=-14, wave=5.0, lift=0.0):
    h, w = lum.shape
    c = Canvas(w, h, seed)
    t = np.clip(gaussian_filter(lum, 1.0) + lift, 0, 1)
    dark = 1 - t
    yy, xx = np.mgrid[0:h, 0:w].astype(np.float32)
    a = np.radians(angle)
    warp = (c.noise(300) - 0.5) * wave * 3 + (c.noise(70) - 0.5) * wave
    v = yy * np.cos(a) + xx * np.sin(a) + warp
    ph = np.abs(((v / period) % 1.0) - 0.5) * 2
    width = np.clip(dark * 1.1, 0, 1)
    ink1 = np.clip((width - ph) * period * 0.6 + 0.5, 0, 1)
    a2 = np.radians(angle + 64)
    v2 = yy * np.cos(a2) + xx * np.sin(a2) + warp * 0.6
    ph2 = np.abs(((v2 / (period * 1.15)) % 1.0) - 0.5) * 2
    w2 = np.clip((dark - 0.58) * 1.7, 0, 1)
    ink2 = np.clip((w2 - ph2) * period * 0.6 + 0.5, 0, 1)
    ink = np.maximum(ink1, ink2)
    ink = np.where(dark > 0.94, 1.0, ink)
    e = np.hypot(sobel(gaussian_filter(lum, 1.4), 0), sobel(gaussian_filter(lum, 1.4), 1))
    e = np.clip(e / (np.percentile(e, 99) + 1e-6) - 0.22, 0, 1)
    ink = np.maximum(ink, e * 0.95)
    ink = np.clip(ink + (c.noise(1.5) - 0.5) * 0.25 * ink * (1 - ink) * 4, 0, 1)  # ragged ink edges
    paper = 0.92 + (c.noise(3) - 0.5) * 0.06 + (c.noise(40) - 0.5) * 0.04
    inkt = 0.06 + (c.noise(2) - 0.5) * 0.04
    return paper * (1 - ink) + inkt * ink


def finish(c, lift=0.0, seed=1):
    L = engrave(np.clip(c.lum, 0, 1), seed=seed, lift=lift)
    rgb = INK + (BONE - INK) * L[..., None]
    g = np.clip(c.glow, 0, 3)[..., None]
    rgb = rgb + AMBER * g * 0.85 + np.array([255, 235, 200]) * np.clip(g - 1.2, 0, 2) * 0.5
    yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
    d = np.sqrt(((xx - W / 2) / (W / 2)) ** 2 + ((yy - H / 2) / (H / 2)) ** 2)
    rgb = rgb * np.clip(1 - 0.35 * np.clip(d - 0.6, 0, 1) ** 1.3, 0, 1)[..., None]
    return Image.fromarray(np.clip(rgb, 0, 255).astype(np.uint8))


def sky(c, y1, top, bottom, clouds=0.10):
    c.lum = c.vgrad(0, y1, top, bottom).copy()
    c.lum += (c.fbm((400, 130, 40, 12)) - 0.5) * clouds * c.vgrad(0, y1, 1, 0.3)
    c.strokes(500, (0, 0.02, 1, y1 - 0.03), length=(60, 260), angle=-3, jitter=3, width=(3, 8), tone=bottom + 0.15, op=(0.03, 0.12), blur=3)


def greywater_ford_night(c):
    sky(c, 0.40, 0.22, 0.42)
    alders(c, 0.40, height=(0.08, 0.16), tone=0.12, density=40)
    water(c, 0.40, 0.82, base=0.28, sheen=0.75, n=4500)
    c.reflection(0.70, 0.41, 0.78, width=0.016, strength=0.55)
    lantern(c, 0.70, 0.402, 0.018, lit=1.0)
    gravel(c, 0.80, 1.0, n=500, base=0.22, light=0.55)
    reeds(c, 0.78, 1.02, n=500, tone=0.08)
    cart(c, 0.16, 0.86, 0.075, covered=True, tone=0.06)
    horse_rider(c, 0.36, 0.86, 0.17, arm_up=True, tone=0.05, rim=0.75)


def greywater_bank_body(c):
    sky(c, 0.26, 0.24, 0.40)
    alders(c, 0.26, height=(0.06, 0.13), tone=0.12, density=36)
    water(c, 0.26, 0.52, base=0.30, sheen=0.75, n=3200)
    c.reflection(0.78, 0.27, 0.50, width=0.012, strength=0.4)
    lantern(c, 0.78, 0.262, 0.014, lit=0.9)  # Marrow's light, still out on the water
    gravel(c, 0.50, 1.0, n=1500, base=0.36, light=0.75)
    lying_knight(c, 0.20, 0.66, 0.70, tone=0.06, rim=0.85)
    c.strokes(60, (0.25, 0.66, 0.70, 0.72), length=(10, 40), angle=20, jitter=40, width=(1, 2), tone=0.6, op=(0.1, 0.4))


def greywater_dawn_cart(c):
    c.lum = c.vgrad(0, 0.42, 0.70, 0.86).copy()
    c.lum += (c.fbm((500, 160, 50, 15)) - 0.5) * 0.06
    alders(c, 0.42, height=(0.06, 0.12), tone=0.48, density=40, rough=0.4)
    mill = c.poly([(0.16, 0.43), (0.16, 0.33), (0.19, 0.315), (0.22, 0.335), (0.25, 0.305), (0.29, 0.325), (0.33, 0.305), (0.34, 0.43)], rough=0.3, cell=5)
    c.paint(mill, 0.34)
    for (wx0, wy0) in ((0.20, 0.355), (0.27, 0.35)):
        c.paint(c.poly([(wx0, wy0), (wx0 + 0.025, wy0), (wx0 + 0.025, wy0 + 0.035), (wx0, wy0 + 0.035)], rough=0.1, cell=3), 0.70)
    water(c, 0.43, 0.60, base=0.62, sheen=0.92, n=2500)
    gravel(c, 0.58, 1.0, n=1300, base=0.48, light=0.85)
    cart(c, 0.78, 0.66, 0.11, covered=False, load=True, tone=0.08)
    lying_knight(c, 0.12, 0.86, 0.50, tone=0.08, rim=0.9)
    standing(c, 0.56, 0.80, 0.24, rim=0.8, tone=0.06)
    standing(c, 0.68, 0.81, 0.26, rim=0.8, tone=0.06)


PANELS = {"greywater_ford_night": (greywater_ford_night, 0.0), "greywater_bank_body": (greywater_bank_body, 0.0),
          "greywater_dawn_cart": (greywater_dawn_cart, 0.0)}

if __name__ == "__main__":
    os.makedirs(OUT, exist_ok=True)
    for name in (sys.argv[1:] or PANELS):
        fn, lift = PANELS[name]
        c = Canvas(W, H, abs(hash(name)) % 1000)
        fn(c)
        finish(c, lift, seed=7).save(os.path.join(OUT, name + ".png"))
        print(name)
