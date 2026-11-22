"""Vertical films (1080x1920, 30 fps) built from the game's own panels: slow camera moves, lanterns that flicker,
the game's fonts, captions and choice buttons laid over the pictures (never drawn into them), synthesised sound.

  python3 tools/films/film.py <film> stills      # key frames + contact sheet in reports/films/<film>/
  python3 tools/films/film.py <film> video       # render, sound, game copies, then checks
  python3 tools/films/film.py <film> check       # checks + review packet only

Films are defined in tools/films/<film>.py (SHOTS, TITLE, OUT_NAME). Only changed shots re-render.
"""
import os, sys, math, json, re, glob, subprocess, hashlib, importlib, inspect, wave
import numpy as np
from PIL import Image, ImageDraw, ImageFont
from scipy.ndimage import gaussian_filter

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(ROOT, "tools", "promo"))
import sound as S  # noqa: E402  (synth helpers: lp, hp, bp, bell, thump, clink, add)

W, H, FPS = 1080, 1920, 30
FONT = os.path.join(ROOT, "tools", "promo", "fonts")
BONE = np.array([233, 228, 216], np.float32)
INK = np.array([16, 14, 12], np.float32)
AMBER = np.array([255, 170, 80], np.float32)


def font(name, size):
    return ImageFont.truetype(os.path.join(FONT, name), size)


F_NARR = font("alegreya-latin-400-italic.ttf", 54)
F_SAY = font("alegreya-latin-400-normal.ttf", 54)
F_SONG = font("grenze-latin-700-normal.ttf", 58)
F_CHOICE = font("alegreya-latin-400-normal.ttf", 44)
F_KEY = font("alegreya-sans-sc-latin-500-normal.ttf", 34)
F_TITLE = font("grenze-latin-700-normal.ttf", 168)
F_KICK = font("alegreya-sans-sc-latin-500-normal.ttf", 40)
F_SMALL = font("alegreya-sans-sc-latin-500-normal.ttf", 34)


class Shot:
    def __init__(self, name, dur, panel=None, cam=((0.5, 0.5, 1.0), (0.5, 0.5, 1.06)), captions=(), choices=None, title=None,
                 fade_in=0.4, fade_out=0.4, sound=None, events=(), review=(), flicker=0.14, dim=0.0, tear=None):
        self.name, self.dur, self.panel, self.cam = name, dur, panel, cam
        self.captions, self.choices, self.title = list(captions), choices, title
        self.fade_in, self.fade_out = fade_in, fade_out
        self.sound = sound or {}
        self.events, self.review, self.flicker, self.dim = list(events), list(review), flicker, dim
        # tear = (panel, cam_a, cam_b, t0, t1): the picture rips open from left to right between t0 and t1, showing panel
        self.tear = tear


def cut(name, dur, panel, a, b, text=None, style="narr", **kw):
    """One caption, one framing: a hard cut with a slow move from a to b (cx, cy, zoom)."""
    caps = [(0.3, dur - 0.25, text, style)] if text else []
    kw.setdefault("fade_in", 0.0)
    kw.setdefault("fade_out", 0.0)
    return Shot(name, dur, panel, cam=(a, b), captions=caps, **kw)


def smooth(x):
    x = min(max(x, 0.0), 1.0)
    return x * x * (3 - 2 * x)


# ---------------------------------------------------------------- pictures
_src = {}


def panel_file(panel):
    """A game panel (assets/panels/<id>) or a film-only picture (assets/films/<folder>/<id>)."""
    for base in (os.path.join(ROOT, "assets", "panels"), os.path.join(ROOT, "assets", "films")):
        hits = [f for f in glob.glob(os.path.join(base, panel + ".*")) if not f.endswith(".svg")]
        if hits:
            return hits[0]
    return None


def source(panel):
    if panel not in _src:
        if panel is None:
            a = np.zeros((1536, 1024, 3), np.float32) + INK * 0.6
        else:
            fn = panel_file(panel)
            a = np.asarray(Image.open(fn).convert("RGB"), np.float32)
        mx, mn = a.max(-1), a.min(-1)
        sat = (mx - mn) / np.maximum(mx, 1)
        warm = (a[..., 0] > a[..., 1] * 1.05) & (a[..., 1] > a[..., 2])
        amb = (warm & (sat > 0.35) & (mx > 120)).astype(np.float32)
        amb = np.clip(gaussian_filter(amb, 3) * 2.5, 0, 1)
        _src[panel] = (Image.fromarray(np.clip(a, 0, 255).astype(np.uint8)), Image.fromarray(amb, "F"))
    return _src[panel]


def cam_box(img, cx, cy, z):
    w, h = img.size
    ch = h / z
    cw = ch * W / H
    if cw > w:  # source narrower than 9:16 at this zoom: fit width instead
        cw = w / max(1.0, z)
        ch = cw * H / W
    x0 = min(max(cx * w - cw / 2, 0), w - cw)
    y0 = min(max(cy * h - ch / 2, 0), h - ch)
    return (x0, y0, x0 + cw, y0 + ch)


_grain, _vig = None, None


def grain(i):
    global _grain
    if _grain is None:
        rng = np.random.default_rng(5)
        _grain = [np.asarray(Image.fromarray((rng.random((H // 2, W // 2), dtype=np.float32) - 0.5), "F").resize((W, H), Image.BILINEAR))[..., None]
                  for _ in range(6)]
    return _grain[i % 6]


def vignette():
    global _vig
    if _vig is None:
        yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
        d = np.sqrt(((xx - W / 2) / (W / 2)) ** 2 + ((yy - H / 2) / (H / 2)) ** 2)
        _vig = np.clip(1.0 - 0.28 * np.clip(d - 0.6, 0, 1) ** 1.3, 0, 1)[..., None]
    return _vig


def wrap(text, f, maxw):
    words, lines, cur = text.split(" "), [], ""
    for w in words:
        t = (cur + " " + w).strip()
        if f.getlength(t) > maxw and cur:
            lines.append(cur)
            cur = w
        else:
            cur = t
    lines.append(cur)
    return lines


_caps = {}


def caption_layer(text, style):
    key = (text, style)
    if key in _caps:
        return _caps[key]
    f = {"narr": F_NARR, "say": F_SAY, "song": F_SONG}[style]
    lines = wrap(text, f, 930)
    lh = 72
    y0 = H - 230 - lh * len(lines)
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    for i, ln in enumerate(lines):
        d.text(((W - f.getlength(ln)) / 2, y0 + i * lh), ln, font=f, fill=tuple(int(v) for v in BONE) + (255,))
    a = np.asarray(img, np.float32) / 255.0
    y = np.arange(H, dtype=np.float32)[:, None]
    band = np.clip((y - (y0 - 220)) / 240, 0, 1) * 0.80
    _caps[key] = (a, band)
    return _caps[key]


def choice_layer(labels, pick, picked, alphas):
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    bw, gap = 960, 18
    x0 = (W - bw) // 2
    rows = []
    for lab in labels:
        rows.append(wrap(lab, F_CHOICE, bw - 110))
    heights = [40 + 56 * len(r) for r in rows]
    y = H - 170 - sum(heights) - gap * (len(rows) - 1)
    for i, (r, bh) in enumerate(zip(rows, heights)):
        a = alphas[i]
        if a > 0.01:
            chosen = picked and i == pick
            d.rectangle([x0, y, x0 + bw, y + bh], fill=((38, 34, 28) if chosen else (24, 23, 20)) + (int(236 * a),), outline=(74, 70, 61, int(255 * a)))
            d.rectangle([x0, y, x0 + (7 if chosen else 3), y + bh], fill=(184, 154, 90, int(255 * a)))
            d.text((x0 + 30, y + 24), str(i + 1), font=F_KEY, fill=(154, 149, 138, int(255 * a)))
            for k, ln in enumerate(r):
                d.text((x0 + 78, y + 16 + 56 * k), ln, font=F_CHOICE, fill=tuple(int(v) for v in BONE) + (int(255 * a),))
        y += bh + gap
    return np.asarray(img, np.float32) / 255.0


def title_layer(t, spec):
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    bone, ash = tuple(int(v) for v in BONE), (170, 164, 150)

    def centred(text, f, y, col, a):
        d.text(((W - f.getlength(text)) / 2, y), text, font=f, fill=col + (int(255 * min(max(a, 0), 1)),))

    for (text, kind, y, t0) in spec:
        f = {"title": F_TITLE, "kick": F_KICK, "small": F_SMALL}[kind]
        centred(text, f, y, bone if kind != "kick" else ash, (t - t0) / 0.9)
    return np.asarray(img, np.float32) / 255.0


def picture(panel, cam, p, t, flicker, seed):
    img, amb = source(panel)
    (a0, b0, z0), (a1, b1, z1) = cam
    box = cam_box(img, a0 + (a1 - a0) * p, b0 + (b1 - b0) * p, z0 + (z1 - z0) * p)
    rgb = np.asarray(img.resize((W, H), Image.BICUBIC, box=box), np.float32)
    m = np.asarray(amb.resize((W, H), Image.BILINEAR, box=box), np.float32)[..., None]
    fl = flicker * (0.6 * math.sin(t * 11.3 + seed) + 0.4 * math.sin(t * 23.1) + 0.3 * math.sin(t * 4.7))
    return rgb * (1 + m * fl) + AMBER * m * max(0.0, fl) * 0.25


_jag = None


def tear_edge():
    """A ragged rip line (one x offset per row), fixed so it is the same in every frame."""
    global _jag
    if _jag is None:
        rng = np.random.default_rng(23)
        steps = rng.standard_normal(H).astype(np.float32)
        walk = np.cumsum(steps) * 3.0
        walk -= np.linspace(walk[0], walk[-1], H)
        fine = gaussian_filter(rng.standard_normal(H).astype(np.float32), 1.2) * 9
        _jag = walk + fine + np.linspace(-140, 140, H)  # leans a little, like a real rip
    return _jag


def frame(shot, t, fi):
    p = smooth(t / shot.dur)
    rgb = picture(shot.panel, shot.cam, p, t, shot.flicker, len(shot.name))
    if shot.tear:
        tp, ta, tb, t0, t1 = shot.tear
        q = min(max((t - t0) / (t1 - t0), 0.0), 1.0)
        if q > 0:
            q = 1 - (1 - q) ** 2.2  # fast start, like a hand ripping paper
            under = picture(tp, (ta, tb), min(max((t - t0) / (shot.dur - t0), 0.0), 1.0), t, 0.14, 7)
            edge = (q * (W + 420) - 210 + tear_edge())[:, None]
            xx = np.arange(W, dtype=np.float32)[None, :]
            d = edge - xx  # > 0: torn away, showing what is under
            rgb = np.where((d > 0)[..., None], under, rgb)
            fringe = np.clip(1 - np.abs(d + 9) / 9, 0, 1)[..., None]  # pale paper fibres along the rip
            rgb = rgb * (1 - fringe * 0.85) + np.array([238, 230, 210], np.float32) * fringe * 0.85
            shade = np.clip(1 - (d - 2) / 26, 0, 1)[..., None] * (d > 0)[..., None]  # shadow under the torn lip
            rgb = rgb * (1 - shade * 0.45)
    if shot.dim:
        rgb = rgb * (1 - shot.dim)
    rgb = rgb + grain(fi // 2) * 9
    rgb = rgb * vignette()
    for (t0, t1, text, style) in shot.captions:
        if t0 - 0.01 <= t <= t1 + 0.01:
            a = smooth((t - t0) / 0.45) * (1 - smooth((t - (t1 - 0.45)) / 0.45))
            cap, band = caption_layer(text, style)
            rgb = rgb * (1 - band[..., None] * a)
            al = cap[..., 3:4] * a
            rgb = rgb * (1 - al) + cap[..., :3] * 255 * al
    if shot.choices:
        c0, c1, labels, pick, tp = shot.choices
        if c0 <= t <= c1:
            fin, out = smooth((t - c0) / 0.4), 1 - smooth((t - (c1 - 0.4)) / 0.4)
            picked = t >= tp
            alphas = [fin * out * (1 - smooth((t - tp) / 0.35) if picked and i != pick else 1) for i in range(len(labels))]
            y = np.arange(H, dtype=np.float32)[:, None, None]
            rgb = rgb * (1 - np.clip((y - (H - 900)) / 300, 0, 1) * 0.78 * fin * out)
            cl = choice_layer(labels, pick, picked, alphas)
            al = cl[..., 3:4]
            rgb = rgb * (1 - al) + cl[..., :3] * 255 * al
    if shot.title:
        tl = title_layer(t, shot.title)
        al = tl[..., 3:4]
        rgb = rgb * (1 - al) + tl[..., :3] * 255 * al
    fade = 1.0
    if shot.fade_in > 0:
        fade *= smooth(t / shot.fade_in)
    if shot.fade_out > 0:
        fade *= smooth((shot.dur - t) / shot.fade_out)
    return np.clip(rgb * fade, 0, 255).astype(np.uint8)


# ---------------------------------------------------------------- sound
def soundtrack(path, shots):
    SR = S.SR
    starts, t = [], 0.0
    for s in shots:
        starts.append(t)
        t += s.dur
    total = t
    n = int(total * SR)
    rng = np.random.default_rng(11)
    L = np.zeros(n, np.float32)
    R = np.zeros(n, np.float32)
    tt = np.arange(n) / SR
    white = rng.standard_normal((2, n)).astype(np.float32)
    beds = {
        "river": np.stack([S.lp(S.hp(w, 80), 900) for w in white]) * 0.8,
        "wind": np.stack([S.bp(w, 300, 900) for w in white]) * 0.9,
        "crowd": np.stack([S.bp(w, 400, 1400) for w in white]) * 0.7,
        "leaves": np.stack([S.hp(w, 2500) for w in white]) * 0.12,
    }
    # crowd murmur: uneven swells
    beds["crowd"] *= (0.6 + 0.4 * np.sin(2 * np.pi * 0.7 * tt) * np.sin(2 * np.pi * 0.23 * tt + 1)).astype(np.float32)
    drone = np.zeros(n, np.float32)
    for f, a in ((36.71, 0.5), (73.42, 0.35), (110.0, 0.16), (146.83, 0.08), (174.61, 0.06)):
        ph = 2 * np.pi * np.cumsum(f * (1 + 0.002 * np.sin(2 * np.pi * 4.7 * tt + f))) / SR
        drone += (a * (np.sin(ph) + 0.35 * np.sin(2 * ph) + 0.15 * np.sin(3 * ph))).astype(np.float32)
    beds["drone"] = np.stack([S.lp(drone, 900)] * 2)
    upper = np.zeros(n, np.float32)
    for f, a in ((174.61, 0.12), (220.0, 0.10), (261.63, 0.05)):
        upper += a * np.sin(2 * np.pi * f * tt * (1 + 0.003 * np.sin(2 * np.pi * 5.1 * tt)))
    beds["strings"] = np.stack([S.lp(upper, 1500)] * 2)
    # lute: a plain ballad tune, plucked (decaying harmonics), for the song
    lute = np.zeros(n, np.float32)
    tune = [62, 66, 69, 66, 64, 62, 64, 66, 67, 66, 64, 62, 61, 62, 64, 57,
            62, 66, 69, 71, 69, 67, 66, 64, 66, 64, 62, 61, 62, 57, 62, 62]
    beat, k, ln = 0.46, 0, int(1.6 * SR)
    pt = np.arange(ln) / SR
    while k * beat < total:
        midi = tune[k % len(tune)]
        f = 440.0 * 2 ** ((midi - 69) / 12)
        y = np.zeros(ln, np.float32)
        for h, a in ((1, 1.0), (2, 0.5), (3, 0.28), (4, 0.14), (5, 0.07)):
            y += (a * np.sin(2 * np.pi * f * h * pt) * np.exp(-pt * (2.6 + 2.2 * h))).astype(np.float32)
        y *= np.minimum(1, pt / 0.004).astype(np.float32)
        i0 = int(k * beat * SR)
        S.add(lute, i0, y * (0.9 if k % 4 == 0 else 0.6))
        if k % 4 == 0:  # a low drone string under each bar
            fb = f / 2 if midi > 60 else f
            S.add(lute, i0, (0.35 * np.sin(2 * np.pi * fb / 2 * pt) * np.exp(-pt * 1.6)).astype(np.float32))
        k += 1
    beds["lute"] = np.stack([lute, lute * 0.92])
    for k in beds:
        pts = [(0.0, 0.0)]
        for s, st in zip(shots, starts):
            lv = s.sound.get(k, 0.0)
            pts += [(st + min(1.0, s.dur / 3), lv), (st + s.dur - min(0.6, s.dur / 4), lv)]
        pts.append((total, 0.0))
        e = S.env(n, pts)
        L += beds[k][0] * e
        R += beds[k][1] * e
    for s, st in zip(shots, starts):
        for (et, kind) in s.events:
            i = int((st + et) * SR)
            if kind == "hit":
                y = S.thump(2.4, 42, 0.9); S.add(L, i, y); S.add(R, i, y)
            elif kind == "softhit":
                y = S.thump(2.0, 46, 0.45); S.add(L, i, y); S.add(R, i, y)
            elif kind == "splash":
                ln = int(2.5 * SR)
                y = S.bp(rng.standard_normal(ln).astype(np.float32), 200, 5000) * np.exp(-np.arange(ln) / SR * 2.2) * 1.3
                S.add(L, i, y); S.add(R, i, y * 0.9)
            elif kind == "heartbeat":
                for k in range(9):
                    y = S.thump(0.5, 52, 0.4)
                    S.add(L, i + int(k * 0.8 * SR), y); S.add(R, i + int(k * 0.8 * SR), y)
                    S.add(L, i + int((k * 0.8 + 0.22) * SR), y * 0.6); S.add(R, i + int((k * 0.8 + 0.22) * SR), y * 0.6)
            elif kind == "coins":
                for k in range(4):
                    y = S.clink(rng, 0.35); S.add(L, i + int(k * 0.5 * SR), y); S.add(R, i + int(k * 0.5 * SR), y * 0.8)
            elif kind == "rip":  # paper tearing: crackle in a rising band
                ln = int(1.0 * SR)
                x = np.arange(ln) / SR
                crack = (rng.random(ln) < 0.06).astype(np.float32) * rng.standard_normal(ln).astype(np.float32)
                y = S.bp(rng.standard_normal(ln).astype(np.float32) * 0.5 + crack * 3, 900, 7000) * np.exp(-x * 2.0) * np.minimum(1, x / 0.02)
                S.add(L, i, y * 1.2); S.add(R, i, y)
            elif kind.startswith("bell"):
                f0 = float(kind.split(":")[1]) if ":" in kind else 196.0
                j, y = S.bell(st + et, 6, f0, 8, 0.15, rng)
                S.add(L, j, y); S.add(R, j, y * 0.85)
    mix = np.stack([L, R], 1)
    mix = S.hp(mix.T, 25).T
    rms = np.sqrt(np.mean(mix ** 2)) + 1e-9
    mix = np.tanh(mix / (rms * 6) * 1.2) / np.tanh(1.2)
    mix = mix * 0.89 / (np.max(np.abs(mix)) + 1e-9)
    pcm = (mix * 32767).astype(np.int16)
    with wave.open(path, "wb") as w:
        w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR); w.writeframes(pcm.tobytes())


# ---------------------------------------------------------------- render
def load(film):
    return importlib.import_module(film)


def outdir(film):
    d = os.path.join(ROOT, "reports", "films", film)
    os.makedirs(os.path.join(d, "parts"), exist_ok=True)
    return d


def signature(shot):
    src = [repr((shot.dur, shot.panel, shot.cam, shot.captions, shot.choices, shot.title, shot.fade_in, shot.fade_out, shot.flicker, shot.dim, shot.tear))]
    src.append(inspect.getsource(frame) + inspect.getsource(picture) + inspect.getsource(tear_edge) + inspect.getsource(caption_layer)
               + inspect.getsource(choice_layer) + inspect.getsource(title_layer))
    for pn in (shot.panel, shot.tear[0] if shot.tear else None):
        if pn:
            fn = panel_file(pn)
            src.append(f"{pn}:{os.path.getsize(fn)}:{int(os.path.getmtime(fn))}")
    return hashlib.sha1("\n".join(src).encode()).hexdigest()


def render_shot(args):
    film, idx = args
    shot = load(film).SHOTS[idx]
    d = os.path.join(outdir(film), "parts")
    final, sigf = os.path.join(d, f"{idx:02d}_{shot.name}.mp4"), os.path.join(d, f"{idx:02d}_{shot.name}.sig")
    sig = signature(shot)
    if os.path.exists(final) and os.path.exists(sigf) and open(sigf).read() == sig:
        return final
    tmp = final + ".tmp.mp4"
    p = subprocess.Popen(["ffmpeg", "-y", "-loglevel", "error", "-f", "rawvideo", "-pix_fmt", "rgb24", "-s", f"{W}x{H}", "-r", str(FPS), "-i", "-",
                          "-c:v", "libx264", "-preset", "veryfast", "-crf", "21", "-pix_fmt", "yuv420p", "-g", "60", tmp], stdin=subprocess.PIPE)
    for i in range(int(round(shot.dur * FPS))):
        p.stdin.write(frame(shot, i / FPS, i).tobytes())
    p.stdin.close()
    if p.wait() == 0:
        os.replace(tmp, final)
        open(sigf, "w").write(sig)
    return final


def video(film, jobs=2):
    from multiprocessing import Pool
    mod = load(film)
    d = outdir(film)
    order = sorted(range(len(mod.SHOTS)), key=lambda i: -mod.SHOTS[i].dur)
    with Pool(jobs) as pool:
        pool.map(render_shot, [(film, i) for i in order])
    lst = os.path.join(d, "parts", "list.txt")
    with open(lst, "w") as f:
        for i, s in enumerate(mod.SHOTS):
            f.write(f"file '{i:02d}_{s.name}.mp4'\n")
    silent, wav = os.path.join(d, "silent.mp4"), os.path.join(d, "sound.wav")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "concat", "-safe", "0", "-i", lst, "-c", "copy", silent], check=True)
    soundtrack(wav, mod.SHOTS)
    out = os.path.join(d, f"{mod.OUT_NAME}.mp4")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", silent, "-i", wav, "-map", "0:v", "-map", "1:a", "-c:v", "copy",
                    "-af", "loudnorm=I=-16:TP=-1.5:LRA=11,alimiter=limit=0.5:level=false:attack=1:release=80", "-ar", "48000",
                    "-c:a", "aac", "-b:a", "160k", "-shortest", "-movflags", "+faststart", out + ".tmp.mp4"], check=True)
    os.replace(out + ".tmp.mp4", out)
    pub = os.path.join(ROOT, "public")
    base = os.path.join(pub, mod.PUBLIC_NAME)
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", out, "-vf", "scale=720:1280:flags=lanczos", "-c:v", "libx264", "-preset", "slow", "-crf", "31",
                    "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "96k", "-movflags", "+faststart", base + ".tmp.mp4"], check=True)
    os.replace(base + ".tmp.mp4", base + ".mp4")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", out, "-vf", "scale=720:1280:flags=lanczos", "-c:v", "libvpx-vp9", "-b:v", "0", "-crf", "38",
                    "-row-mt", "1", "-deadline", "good", "-cpu-used", "4", "-c:a", "libopus", "-b:a", "96k", base + ".tmp.webm"], check=True)
    os.replace(base + ".tmp.webm", base + ".webm")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", str(mod.POSTER_AT), "-i", out, "-frames:v", "1", "-vf", "scale=720:1280", "-q:v", "4",
                    base + "-poster.jpg"], check=True)
    return out


def stills(film):
    mod = load(film)
    d = outdir(film)
    picks, st = [], 0.0
    for s in mod.SHOTS:
        ts = [(a + b) / 2 for a, b, *_ in s.captions] or [s.dur * 0.6]
        if s.choices:
            ts.append((s.choices[0] + s.choices[4]) / 2)
        for t in ts:
            fn = os.path.join(d, f"still_{s.name}_{t:04.1f}.jpg")
            Image.fromarray(frame(s, t, int(t * FPS))).resize((540, 960)).save(fn, quality=88)
            picks.append(fn)
        st += s.dur
    th = [Image.open(f).resize((270, 480)) for f in picks]
    cols = 6
    sheet = Image.new("RGB", (cols * 270, math.ceil(len(th) / cols) * 480))
    for i, im in enumerate(th):
        sheet.paste(im, ((i % cols) * 270, (i // cols) * 480))
    sheet.save(os.path.join(d, "contact-sheet.jpg"), quality=85)
    return picks


# ---------------------------------------------------------------- checks
def norm(s):
    return s.replace("\u2019", "'").replace("\u2018", "'").replace("\u201c", '"').replace("\u201d", '"').replace("\u00a0", " ")


def check(film):
    mod = load(film)
    d = outdir(film)
    vid = os.path.join(d, f"{mod.OUT_NAME}.mp4")
    res = []

    def ok(name, cond, detail=""):
        res.append((name, bool(cond), detail))
        print(("✓ " if cond else "✗ ") + name + (f" — {detail}" if detail else ""))

    pr = json.loads(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration:stream=codec_type,width,height,r_frame_rate", "-of", "json", vid],
                                   capture_output=True, text=True).stdout)
    dur = float(pr["format"]["duration"])
    v = [s for s in pr["streams"] if s["codec_type"] == "video"][0]
    lo, hi = mod.LENGTH
    ok(f"length {lo}-{hi} s", lo <= dur <= hi, f"{dur:.1f}s")
    ok("1080x1920 at 30 fps (vertical, phone)", v["width"] == 1080 and v["height"] == 1920 and v["r_frame_rate"] == "30/1")
    ebu = subprocess.run(["ffmpeg", "-hide_banner", "-nostats", "-i", vid, "-af", "ebur128=peak=true", "-f", "null", "-"], capture_output=True, text=True).stderr
    summ = ebu[ebu.rfind("Summary:"):]
    I = float(re.search(r"I:\s+(-?[\d.]+) LUFS", summ).group(1))
    TP = float(re.search(r"Peak:\s+(-?[\d.]+) dBFS", summ).group(1))
    ok("loudness near -16 LUFS", -18 <= I <= -14, f"{I}")
    ok("true peak below -1 dBFS", TP <= -1.0, f"{TP}")
    for ext in ("mp4", "webm"):
        f = os.path.join(ROOT, "public", f"{mod.PUBLIC_NAME}.{ext}")
        mb = os.path.getsize(f) / 1e6 if os.path.exists(f) else 0
        ok(f"game copy {mod.PUBLIC_NAME}.{ext} under 15 MB", 0 < mb < 15, f"{mb:.1f} MB")
    ink = norm(" ".join(open(f).read() for f in glob.glob(os.path.join(ROOT, "story", "*.ink"))))
    ink = re.sub(r"\s+", " ", ink)
    st, script = 0.0, []
    for s in mod.SHOTS:
        if s.panel:
            ok(f"picture exists: {s.panel}", panel_file(s.panel) is not None)
        if s.tear:
            ok(f"picture exists: {s.tear[0]}", panel_file(s.tear[0]) is not None)
        for (t0, t1, text, style) in s.captions:
            words = len(text.split())
            ok(f"readable in time ({words} w / {t1 - t0:.1f}s): {text[:38]}…", words / (t1 - t0) <= 3.4 and t1 - t0 >= 2.4, f"{words / (t1 - t0):.1f} w/s")
            if style == "say":
                for q in re.findall(r"\u201c([^\u201d]+)\u201d", text):
                    frag = norm(q).strip().rstrip(",.?!").strip()
                    ok(f"dialogue is in the game: \u201c{q}\u201d", frag in ink)
            script.append((st + (t0 + t1) / 2, text))
        if s.choices:
            c0, c1, labels, pick, tp = s.choices
            for lab in labels:
                ok(f"choice word for word from the game: {lab}", ("[" + norm(lab) + "]") in ink)
            ok("choices up long enough to read", tp - c0 >= 2.4, f"{tp - c0:.1f}s")
            script.append((st + (c0 + tp) / 2, "[the game's choice buttons] " + " / ".join(labels)))
            script.append((st + (tp + c1) / 2, f"[picked] {labels[pick]}"))
        for rt in s.review:
            script.append((st + rt, "(no new caption)"))
        if not s.captions and not s.choices and not s.review and s.dur >= 2:
            script.append((st + s.dur * 0.6, "(title card)" if s.title else "(no caption)"))
        st += s.dur
    rev = os.path.join(d, "review")
    os.makedirs(rev, exist_ok=True)
    for f in glob.glob(os.path.join(rev, "*.jpg")):
        os.remove(f)
    lines = [f"# Review packet — {mod.TITLE}", "", f"Length {dur:.1f} s, vertical (phone). Frames from the finished file, in order.", ""]
    for i, (t, text) in enumerate(sorted(script)):
        fn = os.path.join(rev, f"f{i:02d}_{t:05.1f}.jpg")
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", f"{t:.2f}", "-i", vid, "-frames:v", "1", "-vf", "scale=540:960", "-q:v", "3", fn], check=True)
        lines.append(f"- {t:5.1f}s  `{os.path.relpath(fn, ROOT)}`  {text}")
    lines += ["", "## Sound (as designed)", ""] + [f"- {x}" for x in mod.SOUND_NOTES]
    open(os.path.join(rev, "packet.md"), "w").write("\n".join(lines) + "\n")
    good = all(r[1] for r in res)
    with open(os.path.join(d, "checks.md"), "w") as f:
        f.write(f"# {mod.TITLE} — checks\n\n**{'PASS' if good else 'FAIL'}** {sum(r[1] for r in res)}/{len(res)}\n\n" +
                "\n".join(f"- {'✅' if r[1] else '❌'} {r[0]}{(' — ' + r[2]) if r[2] else ''}" for r in res) + "\n")
    print(("PASS" if good else "FAIL") + f": {sum(r[1] for r in res)}/{len(res)}")
    return good


if __name__ == "__main__":
    film, cmd = sys.argv[1], (sys.argv[2] if len(sys.argv) > 2 else "stills")
    if cmd == "stills":
        print(len(stills(film)), "stills")
    elif cmd == "video":
        print(video(film))
        sys.exit(0 if check(film) else 1)
    elif cmd == "check":
        sys.exit(0 if check(film) else 1)
