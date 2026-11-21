"""The shots of the promo, drawn in the game's style: black-and-white charcoal and ink,
environment first, figures small or seen from behind, no faces, no text in any picture,
amber only for real light (lanterns, flames, lit windows).

Times are seconds inside each shot. Captions are Wren's narration (italic) or quoted
dialogue taken from the prologue; they are laid over the picture like the game's text box,
never drawn into it.
"""
import math
import numpy as np
from PIL import Image, ImageDraw
from scipy.ndimage import gaussian_filter
from draw import charcoal, Canvas, alders, water, gravel, reeds, rider_from_behind, cart, lantern, horse_rider, crouched, lying_knight, standing, shape, limb, spline, place


class Shot:
    def __init__(self, name, dur, draw=None, anim=None, cam=((0, 0, 1, 1), (0, 0, 1, 1)), captions=(),
                 fade_in=0.5, fade_out=0.5, flicker=0.12, seed=1, title=False, choices=None, review=()):
        self.name, self.dur, self.draw, self.anim, self.choices, self.review = name, dur, draw, anim, choices, review
        self.cam, self.captions = cam, list(captions)
        self.fade_in, self.fade_out, self.flicker, self.seed, self.title = fade_in, fade_out, flicker, seed, title


def zoom(cx, cy, z):
    """Camera box of relative size 1/z centred near (cx, cy), kept inside the picture."""
    w = h = 1 / z
    x0 = min(max(cx - w / 2, 0), 1 - w)
    y0 = min(max(cy - h / 2, 0), 1 - h)
    return (x0, y0, x0 + w, y0 + h)


# ---------------------------------------------------------------------
def night_sky(c, y1, top=0.05, bottom=0.17):
    c.lum = c.vgrad(0, y1, top, bottom).copy()
    clouds = c.fbm((500, 160, 50, 15))
    c.lum += (clouds - 0.5) * 0.08 * c.vgrad(0, y1, 1, 0.3)
    c.strokes(900, (0, 0.02, 1, y1 - 0.05), length=(80, 300), angle=-2, jitter=3, width=(2, 6), tone=0.2, op=(0.02, 0.10), blur=3)


def d_ford_wide(c):
    night_sky(c, 0.44, top=0.05, bottom=0.20)
    alders(c, 0.44, height=(0.10, 0.24), density=80)
    water(c, 0.44, 0.84, base=0.10, sheen=0.50, n=5500)
    c.reflection(0.67, 0.455, 0.82, width=0.010, strength=0.55)
    lantern(c, 0.67, 0.445, 0.022, lit=1.0)
    gravel(c, 0.82, 1.0, n=500, base=0.07, light=0.25)
    reeds(c, 0.80, 1.02, n=700)
    cart(c, 0.14, 0.86, 0.11, covered=True)
    horse_rider(c, 0.40, 0.87, 0.21, arm_up=False)
    c.grain(0.05)

def d_rider(c):
    night_sky(c, 0.36, top=0.05, bottom=0.22)
    alders(c, 0.36, height=(0.10, 0.24), density=70)
    water(c, 0.36, 1.0, base=0.12, sheen=0.55, n=7000)
    c.reflection(0.86, 0.37, 0.95, width=0.012, strength=0.55)
    lantern(c, 0.86, 0.355, 0.03, lit=1.0)
    reeds(c, 0.86, 1.05, n=500)
    horse_rider(c, 0.28, 1.02, 0.50, arm_up=True, rim=0.6)
    c.grain(0.05)

def d_water(c):
    night_sky(c, 0.40, top=0.05, bottom=0.20)
    alders(c, 0.40, height=(0.10, 0.22), density=70)
    water(c, 0.40, 1.02, base=0.11, sheen=0.50, n=6000)
    c.reflection(0.84, 0.41, 0.95, width=0.012, strength=0.5)
    lantern(c, 0.84, 0.395, 0.026, lit=1.0)
    c.grain(0.05)

def a_water(c, t, lum, glow):
    """He goes over: horse and rider tip into the ford and under; then the river boils where he was."""
    from scipy.ndimage import shift as nd_shift
    if not hasattr(c, "_hr"):
        tmp = Canvas(c.w, c.h, 5)
        allm, rider = horse_rider(tmp, 0.36, 0.86, 0.46, arm_up=False, paint=False)
        c._hr = (allm, rider)
        big = Canvas(c.w // 4, c.h * 2, 91)
        stretch = lambda a: np.asarray(Image.fromarray(a, "F").resize((c.w, c.h * 2), Image.BICUBIC), np.float32)
        c._foam = stretch(big.fbm((60, 25, 8, 3)))
        c._foam2 = stretch(big.fbm((40, 14, 5, 2)))
    def ease(x):
        x = min(max(x, 0), 1)
        return x * x * (3 - 2 * x)
    wl = 0.70  # waterline
    tip = ease((t - 0.3) / 1.6)
    sink = ease((t - 0.9) / 2.0)
    yy, xx = np.mgrid[0:c.h, 0:c.w].astype(np.float32)
    if sink < 0.999:
        cx, cy = 0.52 * c.w, 0.62 * c.h
        def move(m):
            im = Image.fromarray(np.ascontiguousarray(m), "F").rotate(-38 * tip, center=(cx, cy), resample=Image.BILINEAR,
                                                                      translate=(0.06 * c.w * tip, 0.55 * c.h * sink))
            return np.asarray(im, np.float32)
        allm, rider = move(c._hr[0]), move(c._hr[1])
        above = np.clip((wl * c.h - yy) / 3 + 0.5, 0, 1)
        allm, rider = allm * above, rider * above
        horse = np.clip(allm - rider, 0, 1)
        lum = lum * (1 - horse) + 0.30 * horse
        lum = lum * (1 - rider) + 0.05 * rider
        edge = np.clip(allm - nd_shift(allm, (6, -3), order=1), 0, 1)
        lum = lum + gaussian_filter(edge, 1) * 0.45
    # foam where he went in
    energy = ease(t / 0.8) * (1 - ease((t - 4.0) / 2.0) * 0.6)
    off = int(t * 70)
    f1 = c._foam[off:off + c.h]
    f2 = c._foam2[c.h - off // 2: 2 * c.h - off // 2]
    d = np.sqrt(((xx / c.w - 0.52) / 0.30) ** 2 + ((yy / c.h - wl) / 0.07) ** 2)
    zone = np.exp(-d ** 2 * 1.5) * (0.3 + 0.9 * energy)
    foam = np.clip(((f1 * 0.6 + f2 * 0.4) - 0.64 + zone * 0.40) * 9, 0, 1) * np.clip(zone * 2, 0, 1)
    lum = lum * (1 - foam * 0.85) + (0.50 + 0.30 * f2) * foam * 0.85
    layer = Image.new("L", (c.w, c.h), 0)
    dr = ImageDraw.Draw(layer)
    r = np.random.default_rng(int(t * 30) + 7)
    for _ in range(int(600 * energy * (1 - sink * 0.7))):
        x, y = 0.52 * c.w + r.normal(0, 0.09) * c.w, wl * c.h - abs(r.normal(0, 0.10)) * c.h
        rr = r.uniform(1, 3.5)
        dr.ellipse([x - rr, y - rr, x + rr, y + rr], fill=int(255 * r.uniform(0.3, 1)))
    sp = gaussian_filter(np.asarray(layer, np.float32) / 255.0, 0.7)
    lum = lum * (1 - sp) + 0.85 * sp
    return lum, glow

def d_hand(c):
    night_sky(c, 0.36, top=0.04, bottom=0.17)
    alders(c, 0.36, height=(0.10, 0.22), density=70)
    water(c, 0.36, 1.02, base=0.08, sheen=0.40, n=5500)
    c.reflection(0.84, 0.37, 0.90, width=0.012, strength=0.45)
    lantern(c, 0.84, 0.355, 0.024, lit=1.0)
    c.grain(0.05)

def hand_mask(c, cx, base_y, rise, openness, scale):
    """A bare hand reaching up out of the water, fingers spreading and closing on nothing."""
    S = scale
    ox, oy = cx, base_y - rise * S
    m = limb(c, [(0.0, 0.9), (0.0, 0.45), (0.0, 0.05)], [0.15, 0.14, 0.12], ox, oy, S)       # forearm
    palm = shape(c, [(-0.085, 0.04), (-0.10, -0.08), (-0.085, -0.20), (0.0, -0.24), (0.09, -0.21), (0.10, -0.08), (0.08, 0.04)], ox, oy, S, rough=0.1)
    m = np.clip(m + palm, 0, 1)
    for i, (bx, ang, L) in enumerate(((-0.075, -14, 0.24), (-0.026, -4, 0.27), (0.024, 5, 0.26), (0.07, 15, 0.21))):
        a = math.radians(-90 + ang * (0.6 + 1.2 * openness))
        curl = 1 - openness
        x0, y0 = bx, -0.21
        j1 = (x0 + math.cos(a) * L * 0.5, y0 + math.sin(a) * L * 0.5)
        a2 = a + curl * math.radians(85)
        j2 = (j1[0] + math.cos(a2) * L * 0.3, j1[1] + math.sin(a2) * L * 0.3)
        a3 = a2 + curl * math.radians(70)
        tip = (j2[0] + math.cos(a3) * L * 0.22, j2[1] + math.sin(a3) * L * 0.22)
        m = np.clip(m + limb(c, [(x0, y0), j1, j2, tip], [0.050, 0.044, 0.038, 0.030], ox, oy, S), 0, 1)
    ta = math.radians(-150 + 60 * (1 - openness))
    t1 = (-0.09 + math.cos(ta) * 0.10, -0.06 + math.sin(ta) * 0.10)
    t2 = (t1[0] + math.cos(ta + 0.5 * (1 - openness)) * 0.08, t1[1] + math.sin(ta + 0.5 * (1 - openness)) * 0.08)
    m = np.clip(m + limb(c, [(-0.08, -0.02), t1, t2], [0.055, 0.045, 0.035], ox, oy, S), 0, 1)
    wl = int(base_y * c.h)
    m[wl:, :] = 0
    return m

def a_hand(c, t, lum, glow):
    # rise 0-1.0, open 1.0-2.2, close on nothing 2.4-3.1, sink 3.3-4.6
    def ease(x):
        x = min(max(x, 0), 1)
        return x * x * (3 - 2 * x)
    rise = ease(t / 1.0) - ease((t - 3.3) / 1.3)
    openness = 0.3 + 0.7 * ease((t - 0.8) / 1.2) - 1.0 * ease((t - 2.4) / 0.7)
    openness = min(max(openness, 0.0), 1.0)
    base_y = 0.70
    m = hand_mask(c, 0.47, base_y, rise * 0.55, openness, 0.30)
    if m.max() > 0:
        from scipy.ndimage import distance_transform_edt
        if not hasattr(c, '_tex'):
            c._tex = (c.fbm((40, 12, 4, 2)) - 0.5) * 0.16
        dist = distance_transform_edt(m > 0.5)
        shade = np.clip(dist / 10.0, 0, 1)
        skin = (0.40 + 0.30 * shade + (c._tex if hasattr(c, '_tex') else 0) * 1.6) * (1 - 0.25 * (np.mgrid[0:c.h, 0:c.w][1] / c.w - 0.5))
        lum = lum * (1 - m) + skin.astype(np.float32) * m
        # wet highlights along the top edges
        from scipy.ndimage import shift as nd_shift
        edge = np.clip(m - nd_shift(m, (5, 3), order=1), 0, 1)
        lum = lum + gaussian_filter(edge, 1.0) * 0.35
    yy, xx = np.mgrid[0:c.h, 0:c.w].astype(np.float32)
    dx = (xx - 0.47 * c.w) / c.w
    dy = (yy - base_y * c.h) / c.h * 3.2
    rr = np.sqrt(dx * dx + dy * dy)
    ring = np.zeros_like(lum)
    for k in range(4):
        R = 0.04 + ((t * 0.06 + k * 0.07) % 0.32)
        ring += np.exp(-((rr - R) / 0.004) ** 2) * (1 - R / 0.36)
    ring *= (yy > base_y * c.h - 0.08 * c.h)
    lum = lum + ring * 0.28
    return lum, glow

def d_body(c):
    night_sky(c, 0.30, top=0.06, bottom=0.18)
    alders(c, 0.30, height=(0.08, 0.20), density=60)
    water(c, 0.30, 0.56, base=0.09, sheen=0.4, n=3500)
    gravel(c, 0.55, 1.0, n=1300, base=0.12, light=0.42)
    k = c.h / c.w
    # the knight on his back across the stones: armour, legs to the right, head turned away
    torso = c.poly([(0.38, 0.62), (0.44, 0.595), (0.56, 0.60), (0.59, 0.625), (0.57, 0.69), (0.42, 0.70), (0.37, 0.67)], rough=0.25, cell=6)
    legs = c.poly([(0.56, 0.615), (0.70, 0.62), (0.80, 0.63), (0.84, 0.615), (0.86, 0.64), (0.82, 0.665), (0.70, 0.67), (0.57, 0.685)], rough=0.25, cell=6)
    head = c.ellipse(0.345, 0.645, 0.026, 0.034, rough=0.4)
    arm = c.poly([(0.42, 0.68), (0.36, 0.73), (0.30, 0.76), (0.285, 0.75), (0.34, 0.715), (0.40, 0.665)], rough=0.25, cell=5)
    hand = c.poly([(0.285, 0.745), (0.26, 0.755), (0.245, 0.77), (0.255, 0.775), (0.27, 0.77), (0.29, 0.76)], rough=0.3, cell=4)
    m = np.clip(torso + legs + head + arm, 0, 1)
    c.paint(m, 0.035)
    c.paint(hand, 0.30)
    # wet hair over the face, so there is no face
    c.strokes(120, (0.32, 0.61, 0.37, 0.68), length=(10, 40), angle=100, jitter=30, width=(1, 2), tone=0.16, op=(0.2, 0.6), mask=head)
    # plate edges catching the light
    c.strokes(40, (0.40, 0.60, 0.84, 0.69), length=(20, 70), angle=2, jitter=6, width=(1, 2), tone=0.5, op=(0.2, 0.7), curve=0.3, mask=np.clip(torso + legs, 0, 1))
    c.rim(m, dy=4, tone=0.6, op=0.85)
    # the river still running out of him
    c.strokes(60, (0.36, 0.69, 0.62, 0.74), length=(10, 50), angle=20, jitter=40, width=(1, 2), tone=0.35, op=(0.1, 0.4))
    c.grain(0.05)


def d_letter(c):
    gravel(c, -0.05, 1.0, n=2200, base=0.16, light=0.50)
    from draw import spline as _sp
    # his belt across the stones, and on it the oilskin case: flat, oiled cloth, flap folded over, strapped and sealed
    # his armoured hip across the top of the picture: plate, then the belt coming off it
    hip = c.poly([(-0.05, -0.05), (1.05, -0.05), (1.05, 0.30), (0.70, 0.26), (0.40, 0.18), (0.10, 0.16), (-0.05, 0.20)], rough=0.06, cell=8)
    c.paint(hip, 0.12)
    c.strokes(160, (0, 0, 1, 0.3), length=(80, 300), angle=6, jitter=4, width=(1, 3), tone=0.6, op=(0.05, 0.3), curve=0.3, mask=hip)
    c.rim(hip, dy=-6, tone=0.85, op=0.85)
    for x in (0.12, 0.30, 0.48, 0.66, 0.84):
        rv = c.ellipse(x, 0.12 + x * 0.12, 0.005, 0.008, rough=0, blur=0.8)
        c.paint(rv, 0.7)
    belt = c.poly([(-0.05, 0.24), (1.05, 0.56), (1.05, 0.64), (-0.05, 0.32)], rough=0.1, cell=6)
    c.paint(belt, 0.05)
    c.strokes(300, (0, 0.3, 1, 0.7), length=(30, 120), angle=16, jitter=3, width=(1, 2), tone=0.25, op=(0.05, 0.3), mask=belt)
    c.rim(belt, dy=4, tone=0.45, op=0.7)
    case = c.poly(_sp([(0.40, 0.42), (0.52, 0.39), (0.63, 0.42), (0.65, 0.52), (0.64, 0.66), (0.52, 0.69), (0.41, 0.66), (0.39, 0.54)]), rough=0.08, cell=8)
    sh = c.poly([(0.38, 0.43), (0.70, 0.43), (0.71, 0.76), (0.40, 0.77)], rough=0.2, blur=14, cell=8)
    c.paint(sh * (1 - case), 0.02, 0.7)
    c.paint(case, 0.13)
    yy, xx = np.mgrid[0:c.h, 0:c.w].astype(np.float32)
    sheen = np.exp(-(((xx / c.w - 0.47) / 0.06) ** 2 + ((yy / c.h - 0.50) / 0.16) ** 2)) * 0.30
    c.lum += (sheen * case).astype(np.float32)
    c.strokes(260, (0.36, 0.37, 0.68, 0.73), length=(20, 90), angle=80, jitter=25, width=(1, 2), tone=0.55, op=(0.05, 0.3), curve=0.5, mask=case)
    flap = c.poly([(0.36, 0.42), (0.52, 0.56), (0.67, 0.42), (0.66, 0.40), (0.52, 0.37), (0.37, 0.40)], rough=0.06, cell=6)
    c.paint(flap, 0.20)
    c.rim(flap, dy=-4, tone=0.05, op=0.8)
    strap = c.poly([(0.345, 0.60), (0.685, 0.60), (0.685, 0.635), (0.345, 0.635)], rough=0.08, cell=4)
    c.paint(strap, 0.04)
    c.rim(strap, dy=3, tone=0.4, op=0.6)
    img = c.blank()
    dd = ImageDraw.Draw(img)
    X, Y = c.P(0.60, 0.617)
    dd.rectangle([X - 24, Y - 30, X + 24, Y + 30], outline=255, width=7)
    c.paint(c.mask_from(img, 0.1, 0.8, 3), 0.65)
    seal = c.ellipse(0.52, 0.535, 0.017, 0.028, rough=0.4)
    c.paint(seal, 0.07)
    c.rim(seal, dx=-2, dy=2, tone=0.5, op=0.6)
    c.rim(case, dx=-3, dy=4, tone=0.75, op=0.6)
    r = c.rng
    for _ in range(25):
        x, y = r.uniform(0.38, 0.66), r.uniform(0.42, 0.70)
        c.paint(c.ellipse(x, y, 0.0018, 0.003, rough=0, blur=0.6) * case, 0.85, 0.7)
    c.grain(0.05)

def d_knife(c):
    night_sky(c, 0.30, top=0.03, bottom=0.14)
    alders(c, 0.30, height=(0.08, 0.20), density=60)
    water(c, 0.30, 0.54, base=0.10, sheen=0.45, n=3500)
    gravel(c, 0.52, 1.0, n=1300, base=0.10, light=0.38)
    lying_knight(c, 0.26, 0.74, 0.42)
    # Marrow crouched beyond the body, facing us, her lantern on the stones beside her;
    # Wren large in the foreground, back to us; her knife laid on the inside of Wren's wrist
    crouched(c, 0.56, 0.70, 0.40, reach=(-0.30, -0.10))
    crouched(c, 0.30, 1.04, 0.72, flip=True, reach=(-0.50, -0.38))
    blade = c.poly([(0.455, 0.655), (0.505, 0.648), (0.507, 0.656), (0.457, 0.663)], rough=0.02, blur=0.7, cell=3)
    c.paint(blade, 0.95)
    lantern(c, 0.66, 0.70, 0.09, lit=1.2, tone=0.22)
    c.grain(0.05)

def d_dawn(c):
    c.lum = c.vgrad(0, 0.46, 0.62, 0.78).copy()
    c.lum += (c.fbm((600, 200, 60, 20)) - 0.5) * 0.06
    alders(c, 0.46, height=(0.07, 0.16), tone=0.42, density=60, rough=0.4)
    mill = c.poly([(0.20, 0.47), (0.20, 0.33), (0.23, 0.31), (0.25, 0.335), (0.27, 0.30), (0.30, 0.32), (0.33, 0.30), (0.34, 0.47)], rough=0.3, cell=5)
    c.paint(mill, 0.30)
    for x in (0.235, 0.265, 0.30):
        c.strokes(1, (x, 0.29, x + 0.001, 0.291), length=(25, 40), angle=-60, jitter=5, width=(3, 4), tone=0.25, op=(0.9, 1))
    for (wx0, wy0) in ((0.24, 0.37), (0.29, 0.36)):
        win = c.poly([(wx0, wy0), (wx0 + 0.02, wy0), (wx0 + 0.02, wy0 + 0.05), (wx0, wy0 + 0.05)], rough=0.1, cell=3)
        c.paint(win, 0.62)
    water(c, 0.47, 0.66, base=0.55, sheen=0.85, n=3000)
    gravel(c, 0.64, 1.0, n=1100, base=0.36, light=0.75)
    # the body on the stones, his jaw tied with Wren's neckcloth (no face); the chronicler with her satchel, Marrow with her knife
    lying_knight(c, 0.10, 0.88, 0.36, rim=0.8)
    m1, _ = standing(c, 0.62, 0.92, 0.46, rim=0.75)
    bag = c.poly([(0.632, 0.70), (0.660, 0.70), (0.662, 0.76), (0.630, 0.76)], rough=0.1, cell=3)
    c.paint(bag, 0.10)
    strap = c.poly([(0.605, 0.52), (0.612, 0.52), (0.650, 0.70), (0.643, 0.70)], rough=0.05, cell=3)
    c.paint(strap, 0.08)
    m2, _ = standing(c, 0.76, 0.93, 0.50, rim=0.75)
    knife = c.poly([(0.795, 0.70), (0.800, 0.70), (0.803, 0.76), (0.798, 0.76)], rough=0.02, blur=0.6, cell=3)
    c.paint(knife, 0.92)
    c.grain(0.045)

def a_dawn(c, t, lum, glow):
    """Mist drifting across the water."""
    if not hasattr(c, "_mist"):
        big = Canvas(int(c.w * 1.6), c.h, 77)
        c._mist = big.fbm((500, 180, 60, 20))
    off = int(t * 40)
    mist = c._mist[:, off:off + c.w]
    y = np.linspace(0, 1, c.h, dtype=np.float32)[:, None]
    band = np.exp(-((y - 0.55) / 0.12) ** 2) * 0.9 + np.exp(-((y - 0.30) / 0.10) ** 2) * 0.4
    a = np.clip((mist - 0.35) * 2.2, 0, 1) * band
    return lum * (1 - a * 0.6) + 0.86 * a * 0.6, glow


def d_coins(c):
    gravel(c, -0.05, 1.0, n=1800, base=0.34, light=0.70)
    yy, xx = np.mgrid[0:c.h, 0:c.w].astype(np.float32)
    plate = shape(c, [(-0.40, -0.40), (-0.14, -0.44), (0.0, -0.38), (0.14, -0.44), (0.40, -0.40), (0.44, -0.10), (0.38, 0.20),
                      (0.30, 0.40), (-0.30, 0.40), (-0.38, 0.20), (-0.44, -0.10)], 0.5, 0.50, 1.25, rough=0.04)
    nx = (xx / c.w - 0.5) / 0.30
    shade = 0.10 + 0.30 * np.exp(-((nx + 0.30) / 0.45) ** 2) + 0.35 * np.exp(-(nx / 0.05) ** 2) * np.clip((yy / c.h - 0.0), 0, 1)
    c.lum = c.lum * (1 - plate) + shade.astype(np.float32) * plate
    c.strokes(200, (0.25, 0.0, 0.75, 1.0), length=(80, 300), angle=88, jitter=6, width=(1, 3), tone=0.6, op=(0.03, 0.16), curve=0.3, mask=plate)
    c.rim(plate, dy=6, tone=0.85, op=0.8)
    c.rim(plate, dy=-6, tone=0.02, op=0.8)
    for side in (-1, 1):  # pauldrons and arms lying at his sides
        pm = shape(c, [(0.30 * side, -0.46), (0.52 * side, -0.48), (0.62 * side, -0.30), (0.56 * side, -0.14), (0.40 * side, -0.20)], 0.5, 0.50, 1.25, rough=0.05)
        c.paint(pm, 0.16)
        c.rim(pm, dy=5, tone=0.8, op=0.8)
        am = shape(c, [(0.50 * side, -0.16), (0.62 * side, -0.16), (0.64 * side, 0.40), (0.52 * side, 0.40)], 0.5, 0.50, 1.25, rough=0.05)
        c.paint(am, 0.12)
        c.rim(am, dx=-4 * side, dy=3, tone=0.6, op=0.7)
    gorget = shape(c, [(-0.16, -0.46), (0.0, -0.36), (0.16, -0.46), (0.10, -0.52), (-0.10, -0.52)], 0.5, 0.50, 1.25, rough=0.05)
    c.paint(gorget, 0.20)
    c.rim(gorget, dy=4, tone=0.85, op=0.8)
    belt = c.poly([(0.20, 0.93), (0.80, 0.93), (0.80, 0.98), (0.20, 0.98)], rough=0.05, cell=4)
    c.paint(belt, 0.05)
    for x in np.linspace(0.33, 0.67, 7):
        c.paint(c.ellipse(x, 0.08 + abs(x - 0.5) * 0.15, 0.004, 0.007, rough=0, blur=0.7) * plate, 0.8)
    r = c.rng
    for _ in range(30):
        x, y = r.uniform(0.3, 0.7), r.uniform(0.1, 0.9)
        c.paint(c.ellipse(x, y, 0.0022, 0.0035, rough=0, blur=0.6) * plate, 0.9, 0.7)
    c.grain(0.05)

COIN_TIMES = (4.3, 4.9, 5.4, 5.9)


def coin_mask(c, cx, cy, r):
    img = Image.new("L", (c.w, c.h), 0)
    d = ImageDraw.Draw(img)
    X, Y = cx * c.w, cy * c.h
    R = r * c.h
    d.ellipse([X - R, Y - R * 0.8, X + R, Y + R * 0.8], fill=255)
    return gaussian_filter(np.asarray(img, np.float32) / 255.0, 1.0)


def a_coins(c, t, lum, glow):
    spots = [(0.47, 0.50), (0.50, 0.53), (0.47, 0.56), (0.51, 0.58)]
    for i, ct in enumerate(COIN_TIMES):
        if t < ct:
            continue
        x, y = spots[i]
        dt = t - ct
        drop = max(0.0, 1 - dt / 0.12)
        y -= drop * 0.03
        if i == 3:  # the fourth rolls off across the plate and away
            x += min(dt, 1.6) * 0.20
            y += min(dt, 1.6) * 0.12
        m = coin_mask(c, x, y, 0.040)
        sh = coin_mask(c, x + 0.006, y + 0.012, 0.040) * (1 - m)
        lum = lum * (1 - sh * 0.5)
        lum = lum * (1 - m) + 0.72 * m
        edge = np.clip(m - coin_mask(c, x + 0.002, y + 0.004, 0.040), 0, 1)
        lum = lum + edge * 0.35
        lum = lum - (coin_mask(c, x, y, 0.030) - coin_mask(c, x, y, 0.026)) * 0.25
    return lum, glow

def d_stint(c):
    c.lum = c.vgrad(0, 0.55, 0.20, 0.38).copy()
    c.lum += (c.fbm((600, 200, 60, 20)) - 0.5) * 0.07
    c.strokes(500, (0, 0.05, 1, 0.45), length=(100, 400), angle=-3, jitter=2, width=(3, 8), tone=0.08, op=(0.03, 0.12), blur=3)
    # the hill and the town on it
    hill = c.poly([(-0.05, 0.75), (0.30, 0.66), (0.50, 0.56), (0.62, 0.50), (0.80, 0.48), (1.05, 0.52), (1.05, 1.05), (-0.05, 1.05)], rough=0.3, cell=12)
    c.paint(hill, 0.06)
    r = c.rng
    img = c.blank()
    d = ImageDraw.Draw(img)
    windows = []
    for i in range(34):
        x = r.uniform(0.50, 0.98)
        base = 0.53 - (x - 0.5) * 0.06 + r.uniform(0, 0.08)
        w, h = r.uniform(0.018, 0.035), r.uniform(0.03, 0.06)
        X, Y = c.P(x, base)
        W_, H_ = w * c.w, h * c.h
        d.rectangle([X - W_ / 2, Y - H_, X + W_ / 2, Y], fill=255)
        d.polygon([(X - W_ / 2 - 4, Y - H_), (X + W_ / 2 + 4, Y - H_), (X, Y - H_ - H_ * r.uniform(0.6, 1.0))], fill=255)
        if r.random() < 0.35:
            windows.append((x + r.uniform(-w / 3, w / 3), base - h * 0.45))
    # the bell tower
    X, Y = c.P(0.72, 0.50)
    d.rectangle([X - 22, Y - 230, X + 22, Y], fill=255)
    d.polygon([(X - 30, Y - 230), (X + 30, Y - 230), (X, Y - 330)], fill=255)
    tm = c.mask_from(img, 0.25, 1.0, 4)
    c.paint(tm, 0.035)
    c.rim(tm, dy=3, tone=0.30, op=0.6)
    bell = c.poly([(0.7155, 0.32), (0.7245, 0.32), (0.7245, 0.36), (0.7155, 0.36)], rough=0.1, cell=3)
    c.paint(bell, 0.28)  # the open belfry, light behind
    for (wx, wy) in windows:
        c.light(wx, wy, core=0.0016, halo=0.012, strength=0.55)
    # torches at the gate
    for gx in (0.565, 0.60):
        c.light(gx, 0.585, core=0.002, halo=0.03, strength=0.8)
    # the road climbing to the gate, pale with mud
    road = c.poly([(0.05, 1.05), (0.22, 0.88), (0.38, 0.76), (0.50, 0.66), (0.58, 0.60), (0.60, 0.605), (0.53, 0.68), (0.42, 0.79), (0.30, 0.92), (0.22, 1.05)],
                  rough=0.3, cell=8)
    c.paint(road, 0.22)
    c.strokes(300, (0.05, 0.6, 0.6, 1.0), length=(20, 80), angle=-35, jitter=10, width=(1, 2), tone=0.05, op=(0.1, 0.4), mask=road)
    # the cart on the road with the covered load, and a walker beside it, small
    cart(c, 0.335, 0.82, 0.07, covered=True)
    walker = c.poly([(0.385, 0.83), (0.382, 0.80), (0.386, 0.785), (0.39, 0.778), (0.394, 0.785), (0.398, 0.80), (0.395, 0.83)], rough=0.2, cell=3)
    c.paint(walker, 0.03)
    lantern(c, 0.315, 0.778, 0.012, lit=0.7)
    # crows
    for _ in range(9):
        x, y = r.uniform(0.35, 0.85), r.uniform(0.12, 0.32)
        s = r.uniform(0.006, 0.012)
        c.strokes(1, (x - s, y, x - s + 0.0001, y + 0.0001), length=(s * c.w, s * c.w), angle=-20, jitter=8, width=(2, 3), tone=0.02, op=(0.9, 1), curve=0.6, blur=0.4)
        c.strokes(1, (x, y, x + 0.0001, y + 0.0001), length=(s * c.w, s * c.w), angle=20, jitter=8, width=(2, 3), tone=0.02, op=(0.9, 1), curve=-0.6, blur=0.4)
    c.grain(0.05)


def d_title(c):
    c.lum[:] = 0.03
    c.lum += (c.fbm((400, 120, 40, 12)) - 0.5) * 0.04
    lantern(c, 0.5, 0.82, 0.075, lit=0.8, tone=0.42)
    c.grain(0.04)


def d_black(c):
    c.lum[:] = 0.02
    c.lum += (c.fbm((400, 120, 40, 12)) - 0.5) * 0.03


# ---------------------------------------------------------------------
NARR, SAY = "narr", "say"

SHOTS = [
    Shot("02_ford", 11.0, d_ford_wide, cam=(zoom(0.5, 0.6, 1.02), zoom(0.50, 0.66, 1.16)),
         captions=[(0.8, 3.6, "The songs called him the Lantern.", NARR),
                   (4.0, 7.4, "He had talked a ten-year war to death in one afternoon.", NARR),
                   (7.7, 10.6, "I had been his squire six years, unpaid.", NARR)], fade_in=1.2, seed=12),
    Shot("03_rider", 13.0, d_rider, cam=(zoom(0.5, 0.55, 1.04), zoom(0.52, 0.48, 1.12)),
         captions=[(0.5, 4.8, "“By sunrise, Wren,” he said. “They’ll ring every bell in Stint for the Lantern.”", SAY),
                   (5.0, 8.0, "He meant to cross the river tonight, drunk.", NARR)],
         choices=(8.2, 12.8, ["Grab his bridle. He’ll hate you for it.", "Shout for Marrow. Let her be the one he blames.",
                             "Say nothing. Tomorrow he pays you."], 2, 11.0), seed=13),
    Shot("04_water", 6.0, d_water, anim=a_water, cam=(zoom(0.5, 0.58, 1.06), zoom(0.5, 0.62, 1.12)),
         captions=[(1.0, 5.6, "He rode into the Greywater. It came no higher than his belt.", NARR)], fade_in=0.0, fade_out=0.0, seed=14, review=(1.5,)),
    Shot("05_hand", 5.0, d_hand, anim=a_hand, cam=(zoom(0.5, 0.58, 1.06), zoom(0.48, 0.58, 1.14)),
         captions=[(0.5, 4.7, "A hand came out of the water, bare and white, and closed on nothing.", NARR)], fade_in=0.0, fade_out=0.6, seed=15),
    Shot("06_beat", 0.5, d_black, fade_in=0.0, fade_out=0.0, seed=16),
    Shot("07_body", 7.5, d_body, cam=(zoom(0.5, 0.6, 1.0), zoom(0.42, 0.62, 1.12)),
         captions=[(0.8, 6.4, "It took longer to get him onto the stones than it had taken him to die.", NARR)], fade_in=1.2, seed=17),
    Shot("08_letter", 7.5, d_letter, cam=(zoom(0.5, 0.55, 1.0), zoom(0.52, 0.55, 1.18)),
         captions=[(0.5, 3.4, "On his belt: the surrender that ended the war.", NARR),
                   (3.7, 7.2, "The council would sign it for him and no one else.", NARR)], seed=18),
    Shot("09_knife", 11.0, d_knife, cam=(zoom(0.45, 0.62, 1.0), zoom(0.45, 0.66, 1.10)),
         captions=[(0.6, 4.3, "“Crown hero drowns at a ford,” said Marrow, the guide. “Who hangs?”", SAY),
                   (4.5, 6.9, "“Guide hangs.”", SAY)],
         choices=(7.1, 10.8, ["Agree. An ambush, and nobody here hangs.", "Refuse, with her knife on your wrist",
                              "Tell her you’ll decide by dawn"], 0, 9.6), flicker=0.18, seed=19),
    Shot("10_dawn", 8.0, d_dawn, anim=a_dawn, cam=(zoom(0.5, 0.6, 1.08), zoom(0.55, 0.62, 1.0)),
         captions=[(0.6, 4.4, "“Then he is not dead,” said the chronicler. “He has a fever.”", SAY),
                   (4.6, 7.6, "“He’ll stink by day three,” said Marrow.", SAY)], seed=20),
    Shot("11_coins", 7.0, d_coins, anim=a_coins, cam=(zoom(0.50, 0.5, 1.0), zoom(0.50, 0.53, 1.14)),
         captions=[(0.3, 3.4, "Then they worked out what I would cost them dead.", NARR),
                   (3.6, 6.7, "“Ten silver,” said Marrow. “Six,” said the chronicler.", SAY)], seed=21, review=(6.4,)),
    Shot("12_stint", 7.5, d_stint, cam=(zoom(0.40, 0.70, 1.15), zoom(0.55, 0.58, 1.0)),
         captions=[(0.5, 3.0, "Nine days to the capital.", NARR),
                   (3.3, 7.1, "Carry the body. Carry the letter. Carry the lie.", NARR)], seed=22),
    Shot("13_title", 6.0, d_title, fade_in=0.8, fade_out=1.2, seed=23, title=True),
]
