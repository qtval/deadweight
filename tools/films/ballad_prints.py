"""Woodcut prints for the ballad film ("Before the Greywater").

  python3 tools/films/ballad_prints.py add <id>=<image> [...]   # the owner's prints -> assets/films/ballad/<id>.webp
  python3 tools/films/ballad_prints.py standins                 # rough stand-ins until the prints arrive

The prints are the in-world broadsheet of the Lantern's song: black ink on cream paper, no colour, no text.
Ids: lantern, war, ride, surrender, bells, deathbed (art/prompts/BALLAD.md).
"""
import os, sys
import numpy as np
from PIL import Image, ImageFilter
from scipy.ndimage import gaussian_filter

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
OUT = os.path.join(ROOT, "assets", "films", "ballad")
IDS = ["lantern", "war", "ride", "surrender", "bells", "deathbed"]
PAPER = np.array([236, 226, 204], np.float32)
INK = np.array([24, 20, 16], np.float32)


def add(pairs):
    os.makedirs(OUT, exist_ok=True)
    for pair in pairs:
        pid, path = pair.split("=", 1)
        assert pid in IDS, f"unknown print id {pid}; use one of {IDS}"
        im = Image.open(path).convert("RGB")
        if im.width > 1024:
            im = im.resize((1024, round(im.height * 1024 / im.width)), Image.LANCZOS)
        a = np.asarray(im, np.float32)
        sat = (a.max(-1) - a.min(-1)) / np.maximum(a.max(-1), 1)
        print(f"{pid}: {im.width}x{im.height}, colour pixels {float((sat > 0.35).mean()) * 100:.2f}% (should be near 0)")
        im.save(os.path.join(OUT, pid + ".webp"), quality=88)


def standins():
    """Hatched, thresholded stand-ins made from game panels: only for timing and layout, never shipped as final."""
    src = {"lantern": "stint_bridge_dusk", "war": "road_beech_wood_noon", "ride": "road_to_stint_morning",
           "surrender": "stint_tollhouse", "bells": "stint_square_bells", "deathbed": "stint_chapel_door"}
    d = os.path.join(OUT, "standin")
    os.makedirs(d, exist_ok=True)
    for pid, panel in src.items():
        g = np.asarray(Image.open(os.path.join(ROOT, "assets", "panels", panel + ".webp")).convert("L"), np.float32)
        g = (g - gaussian_filter(g, 40)) * 1.6 + 128  # local contrast, like a carver choosing edges
        g = gaussian_filter(g, 1.0)
        yy, xx = np.mgrid[0:g.shape[0], 0:g.shape[1]]
        hatch = 34 * np.sin((yy + 0.35 * xx) / 2.4)
        ink = g < (118 + hatch)
        rgb = np.where(ink[..., None], INK, PAPER)
        rgb += gaussian_filter(np.random.default_rng(3).standard_normal(g.shape).astype(np.float32), 1.5)[..., None] * 6
        Image.fromarray(np.clip(rgb, 0, 255).astype(np.uint8)).filter(ImageFilter.SMOOTH).save(os.path.join(d, pid + ".webp"), quality=85)
        print("stand-in", pid)


if __name__ == "__main__":
    if sys.argv[1] == "add":
        add(sys.argv[2:])
    else:
        standins()
