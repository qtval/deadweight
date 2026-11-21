"""Charcoal-and-ink drawing kit for the promo video.

Everything is drawn on a float luminance canvas (0 = ink, 1 = bone) plus a separate
amber "glow" channel that is used ONLY for real light sources (lanterns, flames, lit
windows), as the art rules require. No text is ever drawn into a picture.
"""
import math
import numpy as np
from PIL import Image, ImageDraw
from scipy.ndimage import gaussian_filter, shift as nd_shift

INK = np.array([14, 13, 11], np.float32)
BONE = np.array([233, 228, 216], np.float32)
AMBER = np.array([255, 158, 62], np.float32)


class Canvas:
    def __init__(self, w, h, seed, base=0.1):
        self.w, self.h = w, h
        self.rng = np.random.default_rng(seed)
        self.lum = np.full((h, w), base, np.float32)
        self.glow = np.zeros((h, w), np.float32)

    # coordinates ------------------------------------------------------
    def P(self, x, y):
        return (x * self.w, y * self.h)

    def pts(self, seq):
        return [self.P(x, y) for x, y in seq]

    # noise ------------------------------------------------------------
    def noise(self, cell, w=None, h=None):
        w = w or self.w
        h = h or self.h
        gw, gh = max(2, int(w / cell) + 2), max(2, int(h / cell) + 2)
        small = self.rng.random((gh, gw)).astype(np.float32)
        img = Image.fromarray(small, "F").resize((int(gw * cell), int(gh * cell)), Image.BICUBIC)
        a = np.asarray(img, np.float32)[:h, :w]
        return a

    def fbm(self, cells=(400, 120, 40, 12), weights=(0.5, 0.25, 0.15, 0.1)):
        out = np.zeros((self.h, self.w), np.float32)
        for c, wt in zip(cells, weights):
            out += self.noise(c) * wt
        return out / sum(weights)

    # masks ------------------------------------------------------------
    def blank(self):
        return Image.new("L", (self.w, self.h), 0)

    def mask_from(self, img, rough=0.0, blur=1.2, cell=10):
        m = np.asarray(img, np.float32) / 255.0
        if rough > 0:
            m = gaussian_filter(m, 3)
            m = np.clip((m - 0.5 + (self.noise(cell) - 0.5) * rough) * 5 + 0.5, 0, 1)
        if blur > 0:
            m = gaussian_filter(m, blur)
        return m

    def poly(self, seq, rough=0.25, blur=1.0, cell=10):
        img = self.blank()
        ImageDraw.Draw(img).polygon(self.pts(seq), fill=255)
        return self.mask_from(img, rough, blur, cell)

    def ellipse(self, cx, cy, rx, ry, rough=0.25, blur=1.0):
        img = self.blank()
        x, y = self.P(cx, cy)
        ImageDraw.Draw(img).ellipse([x - rx * self.w, y - ry * self.h, x + rx * self.w, y + ry * self.h], fill=255)
        return self.mask_from(img, rough, blur)

    def band(self, y0, y1, wobble=0.01, rough=0.3, blur=2, cell=60):
        """Mask between two wavy horizontal lines (y in 0..1)."""
        xs = np.linspace(0, 1, 40)
        top = [(x, y0 + wobble * math.sin(x * 9 + self.rng.random() * 6)) for x in xs]
        bot = [(x, y1 + wobble * math.sin(x * 7 + self.rng.random() * 6)) for x in xs[::-1]]
        return self.poly(top + bot, rough, blur, cell)

    def vgrad(self, y0, y1, a, b):
        """Vertical gradient image from a (at y0) to b (at y1)."""
        y = np.linspace(0, 1, self.h, dtype=np.float32)[:, None]
        t = np.clip((y - y0) / max(1e-6, y1 - y0), 0, 1)
        return np.broadcast_to(a + (b - a) * t, (self.h, self.w)).astype(np.float32)

    # painting ---------------------------------------------------------
    def paint(self, mask, tone, op=1.0):
        m = np.clip(mask * op, 0, 1)
        if np.isscalar(tone):
            self.lum = self.lum * (1 - m) + tone * m
        else:
            self.lum = self.lum * (1 - m) + tone * m

    def strokes(self, n, box, length=(20, 80), angle=0, jitter=8, width=(1, 3), tone=1.0, op=(0.1, 0.5),
                mask=None, curve=0.0, blur=0.7):
        """Charcoal strokes in a box (x0, y0, x1, y1 in 0..1), painted towards `tone`."""
        x0, y0, x1, y1 = box
        layer = Image.new("L", (self.w, self.h), 0)
        d = ImageDraw.Draw(layer)
        r = self.rng
        for _ in range(int(n)):
            x = r.uniform(x0, x1) * self.w
            y = r.uniform(y0, y1) * self.h
            L = r.uniform(*length)
            a = math.radians(angle + r.uniform(-jitter, jitter))
            pts = []
            segs = 4
            for i in range(segs + 1):
                t = i / segs
                bend = curve * L * (t - 0.5) ** 2
                pts.append((x + math.cos(a) * L * t - math.sin(a) * bend, y + math.sin(a) * L * t + math.cos(a) * bend))
            d.line(pts, fill=int(255 * r.uniform(*op)), width=max(1, int(round(r.uniform(*width)))))
        m = np.asarray(layer, np.float32) / 255.0
        if blur:
            m = gaussian_filter(m, blur)
        if mask is not None:
            m = m * mask
        self.paint(m, tone)

    def grain(self, amount=0.05):
        self.lum += (self.noise(2.5) - 0.5) * amount + (self.noise(9) - 0.5) * amount * 0.6

    def smudge(self, sigma=1.2):
        self.lum = gaussian_filter(self.lum, sigma)

    def rim(self, mask, dx=0, dy=6, tone=0.6, op=0.7):
        """Bright edge on the side facing the light (light from -dx,-dy)."""
        edge = np.clip(mask - nd_shift(mask, (dy, dx), order=1, mode="constant"), 0, 1)
        edge = gaussian_filter(edge, 0.8)
        self.paint(edge, tone, op)

    # light ------------------------------------------------------------
    def light(self, cx, cy, core=0.008, halo=0.12, strength=1.0):
        """An amber light source: a hot core plus a halo. Glow channel only."""
        yy, xx = np.mgrid[0:self.h, 0:self.w].astype(np.float32)
        x, y = self.P(cx, cy)
        d = np.sqrt((xx - x) ** 2 + (yy - y) ** 2) / self.w
        g = np.exp(-(d / core) ** 2) * 1.6 + np.exp(-(d / halo) ** 2) * 0.35 + np.exp(-(d / (halo * 3)) ** 2) * 0.08
        self.glow += g.astype(np.float32) * strength
        # the light also lifts the paper a little around it (still neutral)
        self.lum += (np.exp(-(d / halo) ** 2) * 0.10 * strength).astype(np.float32)

    def reflection(self, cx, y0, y1, width=0.012, strength=0.6):
        """Broken vertical amber streak on water under a light."""
        layer = Image.new("L", (self.w, self.h), 0)
        d = ImageDraw.Draw(layer)
        r = self.rng
        y = y0
        while y < y1:
            t = (y - y0) / max(1e-6, y1 - y0)
            ww = width * (0.4 + 1.6 * t) * r.uniform(0.4, 1.4)
            x = cx + r.normal(0, width * 0.6)
            d.line([self.P(x - ww, y), self.P(x + ww, y)], fill=int(255 * r.uniform(0.3, 1.0) * (1 - 0.6 * t)), width=r.integers(1, 4))
            y += r.uniform(0.003, 0.012)
        m = gaussian_filter(np.asarray(layer, np.float32) / 255.0, 1.2)
        self.glow += m * strength


# ---------------------------------------------------------------------
# reusable subjects (all silhouettes; never a face)

def alders(c, y_base, height=(0.10, 0.22), x0=-0.05, x1=1.05, tone=0.035, density=70, rough=0.5):
    img = c.blank()
    d = ImageDraw.Draw(img)
    r = c.rng
    for _ in range(density):
        x = r.uniform(x0, x1)
        h = r.uniform(*height)
        w = h * r.uniform(0.35, 0.7)
        for _ in range(6):
            bx = x + r.normal(0, w * 0.35)
            by = y_base - h * r.uniform(0.35, 0.9)
            br = w * r.uniform(0.25, 0.55)
            X, Y = c.P(bx, by)
            d.ellipse([X - br * c.w, Y - br * c.w * 0.8, X + br * c.w, Y + br * c.w * 0.8], fill=255)
        X, Y = c.P(x, y_base)
        d.rectangle([X - 3, Y - h * c.h * 0.5, X + 3, Y + 4], fill=255)
    d.rectangle([0, int(y_base * c.h) - int(0.045 * c.h), c.w, int(y_base * c.h) + int(0.03 * c.h)], fill=255)
    m = c.mask_from(img, rough=rough, blur=1.5, cell=7)
    c.paint(m, tone)
    # twigs against the sky
    c.strokes(density * 18, (x0, y_base - height[1], x1, y_base - height[0] * 0.5), length=(6, 26), angle=-90,
              jitter=55, width=(1, 2), tone=tone, op=(0.3, 0.8), blur=0.5)
    return m


def water(c, y0, y1, base=0.08, sheen=0.5, n=4000, angle=0):
    m = c.band(y0, y1, wobble=0.004, rough=0.1, blur=1)
    c.paint(m * c.vgrad(y0, y1, 1.0, 1.0), base)
    # long dark current lines
    c.strokes(n * 0.3, (0, y0, 1, y1), length=(60, 240), angle=angle, jitter=3, width=(1, 3), tone=0.02, op=(0.2, 0.6), mask=m)
    # broken highlights, denser and longer towards the viewer
    for k in range(4):
        t0 = y0 + (y1 - y0) * k / 4
        t1 = y0 + (y1 - y0) * (k + 1) / 4
        L = 10 + 30 * k
        c.strokes(n * (0.15 + 0.1 * k), (0, t0, 1, t1), length=(L, L * 3), angle=angle, jitter=2, width=(1, 2 + k // 2),
                  tone=sheen, op=(0.05, 0.45), mask=m, blur=0.6)
    return m


def gravel(c, y0, y1, n=900, base=0.13, light=0.45):
    m = c.band(y0, 1.05, wobble=0.01, rough=0.3)
    c.paint(m, base)
    r = c.rng
    img_d = c.blank()
    img_l = c.blank()
    dd, dl = ImageDraw.Draw(img_d), ImageDraw.Draw(img_l)
    for _ in range(n):
        y = r.uniform(y0, y1 + 0.05)
        t = (y - y0) / max(1e-6, (y1 - y0))
        rx = (0.004 + 0.022 * t * t) * r.uniform(0.5, 1.5)
        ry = rx * r.uniform(0.35, 0.6) * c.w / c.h
        x = r.uniform(-0.02, 1.02)
        X, Y = c.P(x, y)
        box = [X - rx * c.w, Y - ry * c.h, X + rx * c.w, Y + ry * c.h]
        dd.ellipse(box, fill=int(255 * r.uniform(0.4, 1)))
        # top highlight crescent
        dl.arc(box, 200, 340, fill=int(255 * r.uniform(0.3, 1)), width=max(1, int(rx * c.w * 0.18)))
    c.paint(c.mask_from(img_d, 0.4, 1.2, 4) * m, 0.04, 0.6)
    c.paint(c.mask_from(img_l, 0, 0.8) * m, light, 0.8)
    return m


def reeds(c, y0, y1, n=600, tone=0.03):
    c.strokes(n, (0, y0, 1, y1), length=(40, 160), angle=-90, jitter=12, width=(1, 3), tone=tone, op=(0.4, 0.95), curve=0.15, blur=0.6)


def rider_from_behind(c, cx, cy, s, arm_up=True, tone=0.03):
    """Horse rump and armoured rider seen from behind. (cx, cy) = saddle; s = scale (canvas heights)."""
    k = c.h / c.w  # convert height-units to x units

    def T(pts):
        return [(cx + x * s * k, cy + y * s) for x, y in pts]

    horse = T([(-0.30, 0.02), (-0.36, 0.20), (-0.34, 0.45), (-0.20, 0.62), (-0.18, 0.95), (0.18, 0.95), (0.20, 0.62),
               (0.34, 0.45), (0.36, 0.20), (0.30, 0.02), (0.12, -0.04), (0.05, -0.30), (0.09, -0.40), (0.04, -0.37),
               (0.0, -0.32), (-0.04, -0.37), (-0.09, -0.40), (-0.05, -0.30), (-0.12, -0.04)])
    mh = c.poly(horse, rough=0.3, blur=1.2, cell=6)
    body = [(-0.11, 0.02), (-0.15, -0.10), (-0.19, -0.30), (-0.20, -0.42), (-0.10, -0.47), (0.10, -0.47), (0.20, -0.42),
            (0.19, -0.30), (0.15, -0.10), (0.11, 0.02)]
    mb = c.poly(T(body), rough=0.25, blur=1.0, cell=5)
    head = c.ellipse(cx, cy - 0.56 * s, 0.065 * s * k, 0.08 * s, rough=0.4)
    if arm_up:
        arm = [(0.15, -0.40), (0.21, -0.45), (0.33, -0.70), (0.36, -0.84), (0.31, -0.86), (0.27, -0.72), (0.14, -0.50)]
        skin = [(0.30, -0.86), (0.36, -0.92), (0.43, -1.02), (0.40, -1.10), (0.33, -1.04), (0.28, -0.92)]
    else:
        arm = [(0.15, -0.40), (0.21, -0.44), (0.22, -0.20), (0.15, -0.12), (0.12, -0.22)]
        skin = []
    ma = c.poly(T(arm), rough=0.25, blur=1.0, cell=5)
    larm = c.poly(T([(-0.15, -0.40), (-0.21, -0.44), (-0.22, -0.20), (-0.12, -0.08), (-0.10, -0.20)]), rough=0.25, blur=1, cell=5)
    m = np.clip(mh + mb + head + ma + larm, 0, 1)
    if skin:
        m = np.clip(m + c.poly(T(skin), rough=0.3, blur=1, cell=4), 0, 1)
    c.paint(m, tone)
    # tail
    tx, ty = cx, cy + 0.12 * s
    c.strokes(140 * s * 4, (tx - 0.015 * s * 4 * k, ty, tx + 0.015 * s * 4 * k, ty + 0.05 * s), length=(s * c.h * 0.3, s * c.h * 0.6),
              angle=92, jitter=8, width=(1, 3), tone=0.02, op=(0.5, 1), curve=0.2)
    # armour lames and rim light
    for i in range(5):
        yy = -0.12 - i * 0.07
        c.strokes(3, (cx - 0.12 * s * k, cy + yy * s, cx + 0.12 * s * k, cy + yy * s + 0.004), length=(s * c.h * 0.08, s * c.h * 0.16),
                  angle=0, jitter=4, width=(1, 2), tone=0.32, op=(0.3, 0.7), curve=0.4, mask=mb)
    c.rim(m, dy=max(2, int(s * c.h * 0.012)), tone=0.55, op=0.8)
    # hair texture on the back of the head (no face)
    hx, hy = cx, cy - 0.56 * s
    c.strokes(60, (hx - 0.05 * s * k, hy - 0.07 * s, hx + 0.05 * s * k, hy + 0.06 * s), length=(s * c.h * 0.03, s * c.h * 0.08),
              angle=95, jitter=25, width=(1, 2), tone=0.18, op=(0.2, 0.5), mask=head)
    return m


def cart(c, cx, cy, s, covered=True, tone=0.03, load=False):
    k = c.h / c.w

    def T(pts):
        return [(cx + x * s * k, cy + y * s) for x, y in pts]

    box = c.poly(T([(-0.55, -0.05), (0.55, -0.05), (0.52, 0.12), (-0.52, 0.12)]), rough=0.2, blur=1, cell=5)
    m = box
    if covered:
        hood = c.poly(T([(-0.52, -0.05), (-0.50, -0.30), (-0.30, -0.46), (0.0, -0.50), (0.30, -0.46), (0.50, -0.30), (0.52, -0.05)]),
                      rough=0.3, blur=1.2, cell=6)
        m = np.clip(m + hood, 0, 1)
    shaft = c.poly(T([(0.52, 0.0), (0.95, 0.10), (0.95, 0.13), (0.52, 0.05)]), rough=0.1, blur=0.8)
    m = np.clip(m + shaft, 0, 1)
    c.paint(m, tone)
    if covered:
        c.paint(hood, 0.22, 0.55)
        c.strokes(220, (cx - 0.5 * s * k, cy - 0.48 * s, cx + 0.5 * s * k, cy - 0.06 * s), length=(s * c.h * 0.05, s * c.h * 0.2),
                  angle=88, jitter=20, width=(1, 2), tone=0.05, op=(0.2, 0.6), curve=0.3, mask=hood)
        c.rim(hood, dy=max(2, int(s * c.h * 0.02)), tone=0.5, op=0.7)
    if load:
        lump = c.poly(T([(-0.5, -0.05), (-0.42, -0.16), (-0.2, -0.20), (0.05, -0.18), (0.3, -0.2), (0.48, -0.12), (0.5, -0.05)]),
                      rough=0.35, blur=1.2, cell=5)
        c.paint(lump, 0.42)
        c.strokes(120, (cx - 0.5 * s * k, cy - 0.2 * s, cx + 0.5 * s * k, cy - 0.05 * s), length=(10, 40), angle=5, jitter=30,
                  width=(1, 2), tone=0.15, op=(0.2, 0.6), mask=lump)
    for wx in (-0.32, 0.32):
        X, Y = c.P(cx + wx * s * k, cy + 0.15 * s)
        R = 0.17 * s * c.h
        img = c.blank()
        dr = ImageDraw.Draw(img)
        dr.ellipse([X - R, Y - R, X + R, Y + R], outline=255, width=max(2, int(R * 0.18)))
        for a in range(0, 180, 30):
            dx, dy = math.cos(math.radians(a)) * R, math.sin(math.radians(a)) * R
            dr.line([X - dx, Y - dy, X + dx, Y + dy], fill=255, width=max(1, int(R * 0.08)))
        c.paint(c.mask_from(img, 0.2, 0.8, 4), tone)
    return m


def lantern(c, cx, cy, s, lit=1.0, tone=0.04):
    """A small iron lantern (s = height in canvas heights). Its flame is the amber light."""
    k = c.h / c.w
    img = c.blank()
    d = ImageDraw.Draw(img)
    X, Y = c.P(cx, cy)
    H = s * c.h
    Wd = H * 0.55
    d.rectangle([X - Wd / 2, Y - H * 0.08, X + Wd / 2, Y], fill=255)  # base
    d.polygon([(X - Wd / 2, Y - H * 0.78), (X + Wd / 2, Y - H * 0.78), (X, Y - H)], fill=255)  # cap
    d.ellipse([X - H * 0.07, Y - H * 1.12, X + H * 0.07, Y - H * 0.98], outline=255, width=max(1, int(H * 0.025)))
    for i in range(4):
        bx = X - Wd / 2 + Wd * i / 3
        d.line([bx, Y - H * 0.08, bx, Y - H * 0.78], fill=255, width=max(1, int(H * 0.035)))
    c.paint(c.mask_from(img, 0.15, 0.7, 4), tone)
    if lit:
        c.light(cx, cy - s * 0.42, core=s * k * 0.10, halo=s * k * 1.4, strength=lit)


# ---------------------------------------------------------------------
# smooth shapes

def spline(pts, n=12, closed=True):
    """Catmull-Rom curve through control points -> dense point list."""
    P = list(pts)
    if closed:
        P = [P[-1]] + P + [P[0], P[1]]
    else:
        P = [P[0]] + P + [P[-1]]
    out = []
    for i in range(1, len(P) - 2):
        p0, p1, p2, p3 = P[i - 1], P[i], P[i + 1], P[i + 2]
        for k in range(n):
            t = k / n
            t2, t3 = t * t, t * t * t
            x = 0.5 * ((2 * p1[0]) + (-p0[0] + p2[0]) * t + (2 * p0[0] - 5 * p1[0] + 4 * p2[0] - p3[0]) * t2 + (-p0[0] + 3 * p1[0] - 3 * p2[0] + p3[0]) * t3)
            y = 0.5 * ((2 * p1[1]) + (-p0[1] + p2[1]) * t + (2 * p0[1] - 5 * p1[1] + 4 * p2[1] - p3[1]) * t2 + (-p0[1] + 3 * p1[1] - 3 * p2[1] + p3[1]) * t3)
            out.append((x, y))
    if not closed:
        out.append(P[-2])
    return out


def place(pts, ox, oy, s, c, flip=False):
    """Local coords (units of canvas height, y down) -> canvas 0..1 coords."""
    k = c.h / c.w
    return [(ox + (-x if flip else x) * s * k, oy + y * s) for x, y in pts]


def shape(c, pts, ox, oy, s, flip=False, rough=0.15, blur=1.0, cell=6, smooth=True):
    P = spline(pts) if smooth else pts
    return c.poly(place(P, ox, oy, s, c, flip), rough=rough, blur=blur, cell=cell)


def limb(c, pts, widths, ox, oy, s, flip=False, rough=0.1):
    """A tapered limb along a path (local coords), widths per point (local units)."""
    k = c.h / c.w
    path = spline(pts, n=8, closed=False)
    ws = np.interp(np.linspace(0, len(widths) - 1, len(path)), range(len(widths)), widths)
    left, right = [], []
    for i, (x, y) in enumerate(path):
        x2, y2 = path[min(i + 1, len(path) - 1)]
        x1, y1 = path[max(i - 1, 0)]
        dx, dy = x2 - x1, y2 - y1
        L = math.hypot(dx, dy) or 1
        nx, ny = -dy / L, dx / L
        left.append((x + nx * ws[i] / 2, y + ny * ws[i] / 2))
        right.append((x - nx * ws[i] / 2, y - ny * ws[i] / 2))
    poly = left + right[::-1]
    return c.poly(place(poly, ox, oy, s, c, flip), rough=rough, blur=1.0, cell=5)


def horse_rider(c, ox, oy, s, flip=False, arm_up=True, tone=0.03, rim=0.55, water_y=None, horse_tone=0.17, paint=True):
    """Horse and armoured rider, three-quarter view from behind, heading into the picture.
    (ox, oy) = ground point under the horse's rump; s = horse height in canvas heights. No face."""
    U = lambda pts: pts  # noqa: E731
    body = U([(-0.02, -0.60), (0.08, -0.72), (0.30, -0.74), (0.50, -0.78), (0.60, -0.88), (0.68, -1.00), (0.74, -1.06),
              (0.80, -1.07), (0.86, -1.02), (0.95, -0.90), (0.97, -0.84), (0.92, -0.80), (0.84, -0.84), (0.80, -0.80),
              (0.76, -0.66), (0.72, -0.54), (0.58, -0.44), (0.30, -0.42), (0.10, -0.42), (-0.05, -0.48)])
    m = shape(c, body, ox, oy, s, flip)
    ears = shape(c, [(0.76, -1.05), (0.76, -1.15), (0.80, -1.06)], ox, oy, s, flip, smooth=False)
    mane = c.poly(place([(0.52, -0.78), (0.64, -0.98), (0.76, -1.07), (0.73, -0.96), (0.62, -0.86)], ox, oy, s, c, flip), rough=0.6, blur=1, cell=3)
    legs = 0
    for pts, w in (([(0.06, -0.52), (0.04, -0.30), (0.08, -0.14), (0.06, 0.0)], [0.10, 0.07, 0.05, 0.05]),
                   ([(0.20, -0.48), (0.24, -0.28), (0.20, -0.12), (0.22, 0.0)], [0.10, 0.07, 0.05, 0.05]),
                   ([(0.58, -0.52), (0.60, -0.28), (0.60, -0.1), (0.62, 0.02)], [0.09, 0.06, 0.05, 0.05]),
                   ([(0.66, -0.56), (0.70, -0.30), (0.71, -0.12), (0.72, 0.0)], [0.09, 0.06, 0.05, 0.05])):
        legs = legs + limb(c, pts, w, ox, oy, s, flip)
    tail = limb(c, [(-0.02, -0.66), (-0.08, -0.55), (-0.08, -0.40), (-0.05, -0.28)], [0.08, 0.10, 0.08, 0.03], ox, oy, s, flip, rough=0.5)
    # rider: seated over the back, leaning back with drink
    torso = shape(c, [(0.26, -0.74), (0.24, -0.92), (0.22, -1.10), (0.27, -1.20), (0.40, -1.22), (0.47, -1.12), (0.44, -0.92), (0.42, -0.74)],
                  ox, oy, s, flip)
    pauldron = shape(c, [(0.17, -1.10), (0.19, -1.21), (0.27, -1.27), (0.36, -1.24), (0.38, -1.15), (0.30, -1.08)], ox, oy, s, flip)
    pauldron = np.clip(pauldron + shape(c, [(0.38, -1.12), (0.40, -1.22), (0.46, -1.25), (0.50, -1.18), (0.47, -1.10)], ox, oy, s, flip), 0, 1)
    head = shape(c, [(0.29, -1.24), (0.27, -1.31), (0.31, -1.38), (0.37, -1.37), (0.39, -1.30), (0.37, -1.24)], ox, oy, s, flip, rough=0.3)
    leg = limb(c, [(0.30, -0.78), (0.36, -0.68), (0.34, -0.55), (0.36, -0.48)], [0.10, 0.09, 0.07, 0.07], ox, oy, s, flip)
    if arm_up:
        arm = limb(c, [(0.40, -1.18), (0.48, -1.30), (0.55, -1.45), (0.57, -1.58)], [0.08, 0.07, 0.06, 0.05], ox, oy, s, flip)
        skin = shape(c, [(0.55, -1.58), (0.62, -1.56), (0.72, -1.62), (0.76, -1.72), (0.70, -1.80), (0.60, -1.76), (0.55, -1.68)], ox, oy, s, flip, rough=0.15)
        arm = np.clip(arm + skin, 0, 1)
    else:
        arm = limb(c, [(0.40, -1.16), (0.47, -1.04), (0.55, -0.98), (0.62, -0.98)], [0.08, 0.07, 0.06, 0.05], ox, oy, s, flip)
    larm = limb(c, [(0.24, -1.14), (0.22, -1.00), (0.30, -0.90), (0.42, -0.92)], [0.08, 0.07, 0.06, 0.05], ox, oy, s, flip)
    rider = np.clip(torso + pauldron + head + leg + arm + larm, 0, 1)
    allm = np.clip(m + ears + mane + legs + tail + rider, 0, 1)
    if water_y is not None:
        yy = np.arange(c.h, dtype=np.float32)[:, None] / c.h
        allm = allm * np.clip((water_y - yy) * 200 + 0.5, 0, 1)
        rider = rider * np.clip((water_y - yy) * 200 + 0.5, 0, 1)
    horse = np.clip(allm - rider, 0, 1)
    if not paint:
        return allm, rider
    # the grey horse: lighter on the back, dark under the belly and legs
    yy = np.arange(c.h, dtype=np.float32)[:, None] / c.h
    belly = np.clip((yy - (oy - 0.75 * s)) / (0.6 * s), 0, 1)
    dapple = (c.noise(max(3, s * c.h * 0.2)) - 0.5) * 0.04
    c.paint(horse, (horse_tone * (1 - 0.75 * belly) + dapple).astype(np.float32))
    c.strokes(int(220 * s * 6), (ox - 0.1 * s, oy - 1.3 * s, ox + 0.9 * s * c.h / c.w + 0.1 * s, oy), length=(s * c.h * 0.03, s * c.h * 0.12),
              angle=-30, jitter=20, width=(1, 2), tone=0.05, op=(0.05, 0.3), curve=0.3, mask=horse)
    c.paint(rider, tone)
    c.rim(allm, dx=-max(1, int(s * c.h * 0.006)), dy=max(2, int(s * c.h * 0.010)), tone=rim, op=0.85)
    # polished plate: bright streaks
    pb = place([(0.20, -1.26), (0.48, -0.74)], ox, oy, s, c, flip)
    px0, px1 = sorted([pb[0][0], pb[1][0]])
    c.strokes(14, (px0, pb[0][1], px1, pb[1][1]), length=(s * c.h * 0.05, s * c.h * 0.14), angle=-75, jitter=12, width=(2, 4),
              tone=0.6, op=(0.1, 0.35), curve=0.3, mask=rider, blur=1.5)
    # plate: bright curved edges on the pauldrons and back plate, so it reads as steel
    c.rim(pauldron, dx=-max(1, int(s * c.h * 0.004)), dy=max(2, int(s * c.h * 0.012)), tone=0.85, op=0.9)
    c.rim(torso, dx=max(1, int(s * c.h * 0.006)), dy=0, tone=0.55, op=0.7)
    # armour: lames across the back, and a dull shine
    box = place([(0.22, -1.20), (0.46, -0.76)], ox, oy, s, c, flip)
    x0, x1 = sorted([box[0][0], box[1][0]])
    c.strokes(10, (x0, box[0][1], x1, box[1][1]), length=(s * c.h * 0.08, s * c.h * 0.16), angle=-8, jitter=6, width=(1, 2),
              tone=0.30, op=(0.15, 0.4), curve=0.5, mask=rider)
    # hair, back of the head
    hb = place([(0.27, -1.38), (0.39, -1.24)], ox, oy, s, c, flip)
    hx0, hx1 = sorted([hb[0][0], hb[1][0]])
    c.strokes(50, (hx0, hb[0][1], hx1, hb[1][1]), length=(s * c.h * 0.03, s * c.h * 0.07), angle=100, jitter=25, width=(1, 2),
              tone=0.20, op=(0.2, 0.5), mask=head)
    return allm, rider


def crouched(c, ox, oy, s, flip=False, tone=0.03, rim=0.5, reach=None):
    """A cloaked figure crouched on its heels, seen from behind/side. (ox, oy) = feet; s = standing height. No face."""
    cloak = [(-0.16, 0.0), (-0.20, -0.18), (-0.17, -0.36), (-0.10, -0.48), (0.00, -0.52), (0.10, -0.47), (0.15, -0.34), (0.18, -0.16), (0.16, 0.0)]
    m = shape(c, cloak, ox, oy, s, flip, rough=0.2)
    head = shape(c, [(-0.07, -0.50), (-0.08, -0.60), (-0.03, -0.67), (0.04, -0.66), (0.08, -0.59), (0.06, -0.50)], ox, oy, s, flip, rough=0.3)
    m = np.clip(m + head, 0, 1)
    if reach is not None:  # an arm reaching out to a point (local coords)
        rx, ry = reach
        m = np.clip(m + limb(c, [(0.08, -0.42), ((0.08 + rx) / 2, (-0.42 + ry) / 2 - 0.03), (rx, ry)], [0.07, 0.06, 0.05], ox, oy, s, flip), 0, 1)
    c.paint(m, tone)
    c.rim(m, dx=-2, dy=3, tone=rim, op=0.8)
    c.strokes(40, (min(place([(-0.18, -0.5)], ox, oy, s, c, flip)[0][0], place([(0.18, 0)], ox, oy, s, c, flip)[0][0]), oy - 0.48 * s,
                   max(place([(-0.18, -0.5)], ox, oy, s, c, flip)[0][0], place([(0.18, 0)], ox, oy, s, c, flip)[0][0]), oy),
              length=(s * c.h * 0.05, s * c.h * 0.2), angle=95, jitter=12, width=(1, 2), tone=0.12, op=(0.1, 0.4), curve=0.2, mask=m)
    return m


def lying_knight(c, ox, oy, s, tone=0.035, rim=0.6):
    """The knight on his back, head to the left, turned away; s = body length in canvas widths. No face."""
    k = c.w / c.h
    S = s * k  # local units are canvas heights
    torso = shape(c, [(0.00, -0.05), (0.06, -0.075), (0.22, -0.08), (0.30, -0.06), (0.31, 0.0), (0.22, 0.03), (0.05, 0.03), (-0.01, 0.01)], ox, oy, S)
    legs = shape(c, [(0.28, -0.05), (0.50, -0.05), (0.70, -0.04), (0.78, -0.07), (0.82, -0.05), (0.80, 0.0), (0.70, 0.01), (0.50, 0.02), (0.29, 0.02)], ox, oy, S)
    head = shape(c, [(-0.10, -0.03), (-0.09, -0.08), (-0.03, -0.09), (0.01, -0.05), (0.0, 0.0), (-0.06, 0.01)], ox, oy, S, rough=0.3)
    arm = limb(c, [(0.06, 0.0), (0.00, 0.06), (-0.07, 0.09), (-0.12, 0.10)], [0.05, 0.045, 0.04, 0.035], ox, oy, S)
    m = np.clip(torso + legs + head + arm, 0, 1)
    c.paint(m, tone)
    hb = place([(-0.10, -0.09), (0.01, 0.01)], ox, oy, S, c)
    c.strokes(90, (hb[0][0], hb[0][1], hb[1][0], hb[1][1]), length=(S * c.h * 0.02, S * c.h * 0.06), angle=110, jitter=30, width=(1, 2),
              tone=0.18, op=(0.2, 0.6), mask=head)
    bb = place([(0.0, -0.08), (0.8, 0.02)], ox, oy, S, c)
    c.strokes(50, (bb[0][0], bb[0][1], bb[1][0], bb[1][1]), length=(S * c.h * 0.03, S * c.h * 0.10), angle=1, jitter=5, width=(1, 2),
              tone=0.45, op=(0.2, 0.6), curve=0.3, mask=np.clip(torso + legs, 0, 1))
    c.rim(m, dy=3, tone=rim, op=0.85)
    # pauldron, cuisses, sabatons catching the light: it must read as a man in plate
    for (x0, x1) in ((0.00, 0.10), (0.33, 0.45), (0.55, 0.66), (0.76, 0.82)):
        pm = shape(c, [(x0, -0.07), (x1, -0.075), (x1 + 0.01, -0.035), (x0 - 0.01, -0.03)], ox, oy, S, rough=0.05)
        c.rim(pm * m, dy=4, tone=0.85, op=0.8)
    return m


def standing(c, ox, oy, s, flip=False, tone=0.03, rim=0.5, lantern_up=False):
    """A figure in a short cloak and boots, seen from behind. (ox, oy) = feet; s = height. No face.
    Returns (mask, hand_point) where hand_point is the raised hand in canvas coords (or None)."""
    cloak = [(-0.13, -0.30), (-0.15, -0.52), (-0.12, -0.72), (-0.07, -0.82), (0.0, -0.84), (0.07, -0.82), (0.12, -0.72), (0.15, -0.52), (0.14, -0.30), (0.0, -0.28)]
    m = shape(c, cloak, ox, oy, s, flip, rough=0.25)
    for lx in (-0.05, 0.05):
        m = np.clip(m + limb(c, [(lx, -0.34), (lx * 1.1, -0.16), (lx * 1.2, 0.0)], [0.075, 0.06, 0.06], ox, oy, s, flip), 0, 1)
    head = shape(c, [(-0.06, -0.83), (-0.07, -0.92), (-0.03, -0.99), (0.03, -0.99), (0.07, -0.92), (0.06, -0.83)], ox, oy, s, flip, rough=0.3)
    m = np.clip(m + head, 0, 1)
    hand = None
    if lantern_up:
        m = np.clip(m + limb(c, [(0.10, -0.76), (0.20, -0.86), (0.24, -1.00)], [0.06, 0.05, 0.045], ox, oy, s, flip), 0, 1)
        hand = place([(0.24, -1.02)], ox, oy, s, c, flip)[0]
    c.paint(m, tone)
    c.rim(m, dx=-2, dy=3, tone=rim, op=0.8)
    b0 = place([(-0.15, -0.84)], ox, oy, s, c, flip)[0]
    b1 = place([(0.15, -0.30)], ox, oy, s, c, flip)[0]
    c.strokes(50, (min(b0[0], b1[0]), b0[1], max(b0[0], b1[0]), b1[1]), length=(s * c.h * 0.08, s * c.h * 0.3), angle=92, jitter=8,
              width=(1, 2), tone=0.12, op=(0.1, 0.4), curve=0.15, mask=m)
    return m, hand



def charcoal(c, hatch=1.0, ink=1.0):
    """Finishing pass that turns flat shapes into ink and charcoal: inked edges, hatching in the darks,
    smudged mid-tones and paper fibre. Applied to every picture."""
    from scipy.ndimage import sobel
    L = c.lum
    soft = gaussian_filter(L, 1.5)
    edge = np.hypot(sobel(soft, 0), sobel(soft, 1))
    edge = np.clip(edge / (np.percentile(edge, 99.5) + 1e-6), 0, 1)
    wob = 0.6 + 0.8 * c.noise(30)
    c.lum = L - edge * 0.10 * ink * wob
    # diagonal hatching over the darks and mid-darks
    dark = np.clip((0.42 - gaussian_filter(L, 4)) / 0.42, 0, 1)
    layer = Image.new("L", (c.w, c.h), 0)
    d = ImageDraw.Draw(layer)
    r = c.rng
    for _ in range(int(9000 * hatch * c.w * c.h / (2227 * 1253))):
        x, y = r.uniform(0, c.w), r.uniform(0, c.h)
        L_ = r.uniform(14, 46)
        a = math.radians(-58 + r.normal(0, 4))
        d.line([x, y, x + math.cos(a) * L_, y + math.sin(a) * L_], fill=int(255 * r.uniform(0.2, 0.8)), width=1)
    h = gaussian_filter(np.asarray(layer, np.float32) / 255.0, 0.6) * dark
    c.lum = c.lum * (1 - h * 0.35) + (c.lum + 0.07) * h * 0.35
    # smudge: charcoal dragged sideways in the mid-tones
    sm = gaussian_filter(c.lum, (0.8, 3.0))
    mid = np.exp(-((L - 0.35) / 0.2) ** 2)
    c.lum = c.lum * (1 - mid * 0.35) + sm * mid * 0.35
    # paper fibre
    fib = Canvas(c.w // 6, c.h, 99).noise(3)
    fib = np.asarray(Image.fromarray(fib, "F").resize((c.w, c.h), Image.BICUBIC), np.float32)
    c.lum += (fib - 0.5) * 0.035 + (c.noise(1.6) - 0.5) * 0.03
