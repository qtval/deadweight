"""Procedural B&W ink-style placeholder panels (1080x1920) for the demo.
Stand-ins until GPT-Image-2 panels exist. Same composition rules as the real art:
environment first, figures small and silhouetted, no faces, no text.
Run: python3 tools/make-placeholders.py
"""
import math, random, os

W, H = 1080, 1920
OUT = os.path.join(os.path.dirname(__file__), "..", "assets", "panels")
os.makedirs(OUT, exist_ok=True)


def f(x):
    return f"{x:.0f}"


class Panel:
    def __init__(self, seed):
        self.r = random.Random(seed)
        self.parts = []

    def add(self, s):
        self.parts.append(s)

    # sky / paper ---------------------------------------------------------
    def gradient(self, top, bottom, y0=0, y1=H, gid="g"):
        self.add(f'<defs><linearGradient id="{gid}" x1="0" y1="0" x2="0" y2="1">'
                 f'<stop offset="0" stop-color="{top}"/><stop offset="1" stop-color="{bottom}"/></linearGradient></defs>'
                 f'<rect x="0" y="{y0}" width="{W}" height="{y1-y0}" fill="url(#{gid})"/>')

    # hatching ------------------------------------------------------------
    def strokes(self, n, x0, x1, y0, y1, length=(20, 120), color="#fff", op=(0.05, 0.4), width=(1, 3), angle=0, jitter=4):
        r = self.r
        d = []
        for _ in range(n):
            x, y = r.uniform(x0, x1), r.uniform(y0, y1)
            L = r.uniform(*length)
            a = math.radians(angle + r.uniform(-jitter, jitter))
            d.append(f'<line x1="{f(x)}" y1="{f(y)}" x2="{f(x + L*math.cos(a))}" y2="{f(y + L*math.sin(a))}" '
                     f'stroke-opacity="{r.uniform(*op):.2f}" stroke-width="{r.uniform(*width):.1f}"/>')
        self.add(f'<g stroke="{color}" stroke-linecap="round">{"".join(d)}</g>')

    def treeline(self, y, height, color="#000", density=70, x0=0, x1=W):
        r = self.r
        pts = [f"{x0},{H}"]
        x = x0
        while x <= x1:
            pts.append(f"{f(x)},{f(y - r.uniform(0.2, 1.0) * height)}")
            x += r.uniform(6, W / density)
            pts.append(f"{f(x)},{f(y - r.uniform(0, 0.35) * height)}")
        pts.append(f"{x1},{H}")
        self.add(f'<polygon points="{" ".join(pts)}" fill="{color}" filter="url(#rough)"/>')

    def hills(self, y, amp, color, seedshift=0):
        r = self.r
        pts = [f"0,{H}"]
        for i in range(0, W + 41, 40):
            pts.append(f"{i},{f(y + amp * math.sin(i / 170 + seedshift) + r.uniform(-8, 8))}")
        pts.append(f"{W},{H}")
        self.add(f'<polygon points="{" ".join(pts)}" fill="{color}" filter="url(#rough)"/>')

    def glow(self, x, y, rad, op=0.9):
        gid = f"glow{len(self.parts)}"
        self.add(f'<defs><radialGradient id="{gid}"><stop offset="0" stop-color="#fff" stop-opacity="{op}"/>'
                 f'<stop offset="0.25" stop-color="#fff" stop-opacity="{op*0.35}"/><stop offset="1" stop-color="#fff" stop-opacity="0"/></radialGradient></defs>'
                 f'<circle cx="{f(x)}" cy="{f(y)}" r="{f(rad)}" fill="url(#{gid})"/>')

    def shape(self, d, fill="#000", op=1):
        self.add(f'<path d="{d}" fill="{fill}" fill-opacity="{op}" filter="url(#rough)"/>')

    def svg(self):
        defs = ('<defs>'
                '<filter id="rough" x="-5%" y="-5%" width="110%" height="110%">'
                '<feTurbulence type="fractalNoise" baseFrequency="0.035" numOctaves="2" seed="3"/>'
                '<feDisplacementMap in="SourceGraphic" scale="9"/></filter>'
                '<filter id="grain"><feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="7" stitchTiles="stitch"/>'
                '<feColorMatrix values="0 0 0 0 0.5  0 0 0 0 0.5  0 0 0 0 0.5  0 0 0 0.9 0"/></filter>'
                '<radialGradient id="vig" cx="0.5" cy="0.45" r="0.75"><stop offset="0.55" stop-color="#000" stop-opacity="0"/>'
                '<stop offset="1" stop-color="#000" stop-opacity="0.75"/></radialGradient>'
                '</defs>')
        overlay = (f'<rect width="{W}" height="{H}" filter="url(#grain)" opacity="0.22" style="mix-blend-mode:overlay"/>'
                   f'<rect width="{W}" height="{H}" fill="url(#vig)"/>')
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" preserveAspectRatio="xMidYMid slice">'
                f'{defs}{"".join(self.parts)}{overlay}</svg>')


# silhouettes ---------------------------------------------------------------
def rider(x, y, s=1.0):
    # horse body + legs + rider, facing right
    return (f"M{x-60*s},{y} q{20*s},{-35*s} {70*s},{-32*s} q{25*s},0 {40*s},{-25*s} l{18*s},{-10*s} l{6*s},{14*s} "
            f"q{-6*s},{14*s} {-14*s},{30*s} l{-4*s},{40*s} l{-7*s},0 l{-2*s},{-35*s} l{-40*s},{4*s} l{-6*s},{36*s} "
            f"l{-7*s},0 l{-3*s},{-38*s} q{-20*s},{-2*s} {-26*s},{-14*s} z "
            f"M{x-5*s},{y-34*s} l{-6*s},{-48*s} q{4*s},{-10*s} {14*s},{-10*s} l{4*s},{-14*s} q{8*s},{-4*s} {12*s},{4*s} "
            f"l{-2*s},{12*s} q{8*s},{6*s} {6*s},{20*s} l{-6*s},{40*s} z")


def standing(x, y, s=1.0):
    # cloaked figure, from behind
    return (f"M{x},{y-150*s} q{14*s},0 {16*s},{16*s} q{2*s},{14*s} {-6*s},{22*s} q{30*s},{12*s} {36*s},{60*s} "
            f"l{14*s},{52*s} l{-34*s},0 l{-6*s},{-10*s} l{-6*s},{10*s} l{-40*s},0 l{12*s},{-56*s} "
            f"q{6*s},{-44*s} {32*s},{-56*s} q{-8*s},{-8*s} {-6*s},{-22*s} q{2*s},{-16*s} {14*s},{-16*s} z")


def kneeling(x, y, s=1.0):
    return (f"M{x},{y-95*s} q{13*s},0 {14*s},{14*s} q0,{12*s} {-6*s},{18*s} q{26*s},{8*s} {30*s},{40*s} "
            f"l{26*s},{8*s} l{-2*s},{15*s} l{-60*s},0 q{-26*s},0 {-22*s},{-22*s} q{4*s},{-28*s} {22*s},{-40*s} "
            f"q{-8*s},{-6*s} {-6*s},{-18*s} q{1*s},{-14*s} {12*s},{-14*s} z")


def lying(x, y, s=1.0):
    # armored body on its back, long low shape with a helm at one end
    return (f"M{x-170*s},{y} q{-12*s},{-34*s} {20*s},{-38*s} l{60*s},{-6*s} q{30*s},{-16*s} {70*s},{-10*s} "
            f"l{120*s},{6*s} q{30*s},{4*s} {40*s},{20*s} l{30*s},{4*s} q{6*s},{12*s} {-6*s},{18*s} "
            f"l{-120*s},{8*s} q{-50*s},{4*s} {-110*s},0 z")


def wrapped(x, y, s=1.0):
    return (f"M{x-200*s},{y} q{-10*s},{-40*s} {30*s},{-44*s} l{340*s},{-6*s} q{40*s},{6*s} {36*s},{30*s} "
            f"q{-4*s},{22*s} {-40*s},{22*s} l{-330*s},{6*s} q{-24*s},0 {-26*s},{-8*s} z")


def cart(x, y, s=1.0, canvas=True):
    d = (f"M{x-160*s},{y-40*s} l{320*s},0 l{-10*s},{50*s} l{-300*s},0 z "
         f"M{x+150*s},{y-20*s} l{110*s},{-14*s} l{2*s},{8*s} l{-110*s},{16*s} z ")
    if canvas:
        d += f"M{x-150*s},{y-40*s} q{10*s},{-90*s} {150*s},{-96*s} q{140*s},{6*s} {150*s},{96*s} z "
    for wx in (x - 95 * s, x + 95 * s):
        r = 46 * s
        d += f"M{wx-r},{y+30*s} a{r},{r} 0 1,0 {2*r},0 a{r},{r} 0 1,0 {-2*r},0 z "
    return d


def horse(x, y, s=1.0):
    return (f"M{x-60*s},{y} q{20*s},{-35*s} {70*s},{-32*s} q{25*s},0 {40*s},{-25*s} l{18*s},{-10*s} l{6*s},{14*s} "
            f"q{-6*s},{14*s} {-14*s},{30*s} l{-4*s},{40*s} l{-7*s},0 l{-2*s},{-35*s} l{-40*s},{4*s} l{-6*s},{36*s} "
            f"l{-7*s},0 l{-3*s},{-38*s} q{-20*s},{-2*s} {-26*s},{-14*s} z")


# panels --------------------------------------------------------------------
def ford_night():
    p = Panel(1)
    p.gradient("#050505", "#262626")
    p.glow(760, 420, 260, 0.35)
    p.add('<circle cx="760" cy="420" r="46" fill="#d9d9d9" filter="url(#rough)"/>')
    p.strokes(260, 0, W, 300, 600, (80, 260), "#bdbdbd", (0.03, 0.12), (6, 16), 2, 2)  # cloud bands
    p.treeline(860, 170, "#0a0a0a")
    p.add(f'<rect x="0" y="860" width="{W}" height="700" fill="#141414"/>')
    p.strokes(900, 0, W, 870, 1520, (15, 90), "#fff", (0.04, 0.32), (1, 3), 0, 3)  # water
    p.strokes(120, 640, 880, 880, 1150, (10, 50), "#fff", (0.2, 0.5), (1, 2.5), 0, 4)  # moon on water
    p.glow(890, 845, 60, 0.95)
    p.add('<circle cx="890" cy="845" r="5" fill="#fff"/>')  # Marrow's lantern on far bank
    p.shape(rider(510, 1090, 1.2), "#000")
    p.hills(1540, 30, "#050505")
    p.strokes(260, 0, W, 1480, 1700, (40, 160), "#777", (0.15, 0.5), (1.5, 3), -90, 12)  # reeds
    p.shape(cart(170, 1560, 0.9), "#000")
    return p


def water_churn():
    p = Panel(2)
    p.gradient("#000", "#151515")
    p.strokes(1600, 0, W, 0, H, (20, 140), "#fff", (0.03, 0.25), (1, 4), 0, 8)
    p.strokes(260, 240, 840, 820, 1200, (30, 160), "#fff", (0.15, 0.55), (1.5, 4), -8, 18)  # churned surface
    p.strokes(120, 320, 760, 760, 900, (10, 60), "#fff", (0.3, 0.8), (1, 3), -70, 30)  # spray
    p.glow(540, 1000, 340, 0.18)
    # horse legs, flailing, from the upper right
    p.shape("M760,560 l40,-20 l120,380 l-34,12 z M860,520 l36,-10 l60,330 l-36,8 z", "#000")
    # a gauntlet and forearm breaking the surface
    p.shape("M420,1240 l40,-150 q10,-30 34,-26 l20,-40 q12,-14 22,0 l6,30 q16,-24 26,-10 l-6,40 q20,10 10,36 l-60,150 z", "#050505")
    p.strokes(160, 380, 600, 1200, 1300, (20, 80), "#fff", (0.3, 0.8), (1.5, 4), 0, 30)
    return p


def bank_body():
    p = Panel(3)
    p.gradient("#0a0a0a", "#202020")
    p.treeline(560, 120, "#030303")
    p.add(f'<rect x="0" y="560" width="{W}" height="520" fill="#171717"/>')
    p.strokes(700, 0, W, 570, 1080, (20, 110), "#fff", (0.04, 0.28), (1, 3), 0, 3)
    p.add(f'<rect x="0" y="1080" width="{W}" height="840" fill="#2b2b2b" filter="url(#rough)"/>')
    r = p.r
    stones = "".join(f'<ellipse cx="{f(r.uniform(0,W))}" cy="{f(r.uniform(1100,1900))}" rx="{f(r.uniform(20,80))}" ry="{f(r.uniform(10,34))}" '
                     f'fill="#{r.choice(["3a3a3a","1c1c1c","4a4a4a","111"])}"/>' for _ in range(90))
    p.add(f'<g filter="url(#rough)">{stones}</g>')
    p.strokes(500, 0, W, 1090, 1900, (10, 40), "#000", (0.2, 0.6), (1, 2.5), 35, 6)
    p.shape(lying(560, 1380, 1.25), "#000")
    p.add('<rect x="560" y="1352" width="46" height="22" fill="#9a9a9a" filter="url(#rough)"/>')  # the oilskin case
    p.shape(kneeling(300, 1400, 1.35), "#000")
    return p


def marrow_wading():
    p = Panel(4)
    p.gradient("#030303", "#1c1c1c")
    p.treeline(700, 160, "#080808")
    p.add(f'<rect x="0" y="700" width="{W}" height="1220" fill="#121212"/>')
    p.strokes(1100, 0, W, 710, H, (15, 120), "#fff", (0.03, 0.28), (1, 3.5), 0, 3)
    p.glow(560, 900, 380, 0.5)
    p.add('<circle cx="560" cy="905" r="9" fill="#fff"/>')
    p.strokes(160, 470, 650, 1180, 1700, (15, 70), "#fff", (0.25, 0.7), (1.5, 3), 0, 3)  # lantern reflection
    p.shape(standing(560, 1250, 1.45) + " M590,1050 l60,-140 l12,6 l-58,140 z", "#000")  # arm raised to the lantern
    p.strokes(180, 380, 740, 1210, 1260, (20, 80), "#fff", (0.3, 0.6), (1.5, 3), 0, 6)  # water line at the waist
    return p


def dawn_cart():
    p = Panel(5)
    p.gradient("#9a9a9a", "#3d3d3d")
    p.strokes(300, 0, W, 200, 900, (100, 300), "#fff", (0.04, 0.12), (10, 30), 0, 1)  # fog
    p.treeline(860, 140, "#555")
    p.hills(980, 20, "#2a2a2a")
    p.strokes(300, 0, W, 1000, H, (20, 90), "#000", (0.15, 0.45), (1, 3), -20, 10)
    p.shape(cart(420, 1240, 1.3), "#0b0b0b")
    p.shape(kneeling(600, 1300, 1.2), "#000")  # Isolde on the cart step, blanket
    p.shape(standing(860, 1330, 1.15), "#111")  # Marrow
    p.shape(lying(520, 1520, 1.15), "#000")
    p.shape(horse(140, 1320, 1.6), "#1a1a1a")
    return p


def wrapping():
    p = Panel(6)
    p.gradient("#8a8a8a", "#2e2e2e")
    p.strokes(260, 0, W, 300, 1000, (120, 320), "#fff", (0.04, 0.12), (12, 30), 0, 1)
    p.hills(1000, 24, "#3a3a3a")
    p.strokes(400, 0, W, 1050, H, (15, 80), "#000", (0.15, 0.5), (1, 3), 30, 10)
    p.shape(wrapped(540, 1450, 1.35), "#cfcfcf", 0.9)
    p.strokes(80, 300, 800, 1390, 1450, (40, 120), "#000", (0.3, 0.6), (1.5, 3), 85, 8)  # rope ties
    p.shape(kneeling(260, 1420, 1.4), "#000")
    p.shape(kneeling(820, 1430, 1.4).replace("M820", "M820"), "#000")
    p.shape(standing(560, 1360, 1.5), "#050505")
    return p


def road_to_stint():
    p = Panel(7)
    p.gradient("#e0e0e0", "#6a6a6a")
    p.glow(300, 300, 400, 0.6)
    p.strokes(200, 0, W, 150, 700, (150, 400), "#fff", (0.05, 0.15), (14, 30), -4, 2)
    p.hills(760, 40, "#9a9a9a", 1)
    p.hills(900, 60, "#6d6d6d", 2)
    p.hills(1080, 70, "#3b3b3b", 3)
    p.hills(1300, 50, "#1d1d1d", 4)
    # the road: a pale ribbon narrowing into the hills
    p.add('<path d="M380,1920 C460,1600 760,1500 620,1300 S500,1060 560,900 L575,900 C530,1060 660,1250 680,1310 S560,1650 700,1920 Z" '
          'fill="#b8b8b8" filter="url(#rough)"/>')
    p.strokes(200, 380, 720, 1300, 1920, (15, 60), "#000", (0.2, 0.5), (1, 2.5), -70, 15)
    p.shape(cart(600, 1420, 0.55), "#000")
    p.shape(standing(690, 1350, 0.45), "#000")  # Marrow ahead
    p.shape(horse(500, 1440, 0.6), "#111")  # the grey behind, empty saddle
    return p


PANELS = {
    "greywater_ford_night": ford_night,
    "greywater_water_churn": water_churn,
    "greywater_bank_body": bank_body,
    "greywater_marrow_wading": marrow_wading,
    "greywater_dawn_cart": dawn_cart,
    "greywater_wrapping": wrapping,
    "road_to_stint_morning": road_to_stint,
}

if __name__ == "__main__":
    for pid, fn in PANELS.items():
        svg = fn().svg()
        with open(os.path.join(OUT, f"{pid}.svg"), "w") as fh:
            fh.write(svg)
        print(f"{pid}.svg  {len(svg)//1024} KB")
