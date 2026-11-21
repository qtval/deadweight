"""Render the Deadweight promo.

  python3 tools/promo/render.py stills            # key frames to reports/promo/stills/ (fast check)
  python3 tools/promo/render.py video [--jobs 2]  # full 1920x1080 30 fps render + sound

Output: reports/promo/deadweight-promo.mp4 (also copied to public/promo.mp4 for the game).
"""
import os, sys, subprocess, shutil, math, json
import numpy as np
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
sys.path.insert(0, HERE)
from draw import Canvas, INK, BONE, AMBER, charcoal  # noqa: E402
import scenes  # noqa: E402

W, H, FPS = 1920, 1080, 30
BIG = 1.16  # pictures are drawn larger than the frame so the camera can move inside them
BW, BH = int(W * BIG), int(H * BIG)
OUT = os.path.join(ROOT, "reports", "promo")
FONT = os.path.join(HERE, "fonts")


def font(name, size):
    return ImageFont.truetype(os.path.join(FONT, name), size)


F_NARR = font("alegreya-latin-400-italic.ttf", 50)
F_SAY = font("alegreya-latin-400-normal.ttf", 50)
F_TITLE = font("grenze-latin-700-normal.ttf", 190)
F_KICK = font("alegreya-sans-sc-latin-500-normal.ttf", 38)
F_SMALL = font("alegreya-sans-sc-latin-500-normal.ttf", 32)


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


def caption_layer(text, style):
    """RGBA caption over a soft dark band, in the game's text style. Laid over, never drawn into, the art."""
    f = F_NARR if style == "narr" else F_SAY
    lines = wrap(text, f, 1400)
    lh = 66
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    band = np.zeros((H, W), np.float32)
    y = np.arange(H, dtype=np.float32)[:, None]
    top = H - 120 - lh * len(lines) - 60
    band[:] = np.clip((y - top) / 160, 0, 1) * 0.82
    a = (band * 255).astype(np.uint8)
    base = np.zeros((H, W, 4), np.uint8)
    base[..., :3] = INK.astype(np.uint8)
    base[..., 3] = a
    img = Image.fromarray(base, "RGBA")
    d = ImageDraw.Draw(img)
    y0 = H - 120 - lh * len(lines)
    for i, ln in enumerate(lines):
        w = f.getlength(ln)
        d.text(((W - w) / 2, y0 + i * lh), ln, font=f, fill=tuple(int(v) for v in BONE) + (255,))
    return np.asarray(img, np.float32) / 255.0


F_CHOICE = font("alegreya-latin-400-normal.ttf", 40)
F_KEY = font("alegreya-sans-sc-latin-500-normal.ttf", 30)


def choice_layer(labels, pick, picked, alpha_each):
    """The game's choice buttons, laid over the picture as in the game (dark box, brass left edge)."""
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    bw, bh, gap = 1100, 78, 16
    x0 = (W - bw) // 2
    y0 = H - 70 - len(labels) * (bh + gap)
    bone = tuple(int(v) for v in BONE)
    for i, lab in enumerate(labels):
        a = alpha_each[i]
        if a <= 0.01:
            continue
        y = y0 + i * (bh + gap)
        chosen = picked and i == pick
        bg = (36, 33, 27) if chosen else (25, 24, 21)
        d.rectangle([x0, y, x0 + bw, y + bh], fill=bg + (int(235 * a),), outline=(74, 70, 61, int(255 * a)), width=1)
        d.rectangle([x0, y, x0 + (6 if chosen else 3), y + bh], fill=(184, 154, 90, int(255 * a)))
        d.text((x0 + 30, y + 22), str(i + 1), font=F_KEY, fill=(154, 149, 138, int(255 * a)))
        d.text((x0 + 70, y + 14), lab, font=F_CHOICE, fill=bone + (int(255 * a),))
    return np.asarray(img, np.float32) / 255.0


def title_layer(t):
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    bone = tuple(int(v) for v in BONE)
    ash = (154, 149, 138)
    brass = (184, 154, 90)

    def centred(text, f, y, col, alpha):
        w = f.getlength(text)
        d.text(((W - w) / 2, y), text, font=f, fill=col + (int(255 * alpha),))

    def ramp(t0, t1):
        return min(max((t - t0) / max(1e-6, t1 - t0), 0), 1)

    centred("DEADWEIGHT", F_TITLE, 300, bone, ramp(0.6, 1.8))
    centred("A STORY IN SIX CHAPTERS", F_KICK, 530, ash, ramp(1.6, 2.6))
    centred("PLAY THE DEMO FREE IN YOUR BROWSER", F_SMALL, 610, ash, ramp(2.8, 3.8))
    centred("QTVAL.GITHUB.IO/DEADWEIGHT", F_SMALL, 660, bone, ramp(2.8, 3.8))
    return np.asarray(img, np.float32) / 255.0


_cache = {}


def shot_layers(shot):
    if shot.name not in _cache:
        c = Canvas(BW, BH, shot.seed)
        shot.draw(c)
        if not shot.title and shot.draw.__name__ != "d_black":
            charcoal(c)
        c.lum = np.clip(c.lum, 0, 1.2).astype(np.float32)
        _cache[shot.name] = c
    return _cache[shot.name]


def smooth(x):
    x = min(max(x, 0.0), 1.0)
    return x * x * (3 - 2 * x)


GRAIN = None


def grain(i):
    global GRAIN
    if GRAIN is None:
        rng = np.random.default_rng(5)
        GRAIN = [(rng.random((H // 2, W // 2), dtype=np.float32) - 0.5) for _ in range(8)]
        GRAIN = [np.asarray(Image.fromarray(g, "F").resize((W, H), Image.BILINEAR)) for g in GRAIN]
    return GRAIN[i % 8]


_vig = None


def vignette():
    global _vig
    if _vig is None:
        yy, xx = np.mgrid[0:H, 0:W].astype(np.float32)
        d = np.sqrt(((xx - W / 2) / (W / 2)) ** 2 + ((yy - H / 2) / (H / 2)) ** 2)
        _vig = np.clip(1.0 - 0.38 * np.clip(d - 0.55, 0, 1) ** 1.4, 0, 1)[..., None]
    return _vig


_cap_cache = {}


def frame(shot, t, fi):
    c = shot_layers(shot)
    lum, glow = c.lum, c.glow
    if shot.anim:
        lum, glow = shot.anim(c, t, lum.copy(), glow.copy())
    # camera
    p = smooth(t / shot.dur) if shot.dur > 0 else 0
    (a0, b0, a1, b1), (c0, d0, c1, d1) = shot.cam
    box = [a0 + (c0 - a0) * p, b0 + (d0 - b0) * p, a1 + (c1 - a1) * p, b1 + (d1 - b1) * p]
    px = (box[0] * BW, box[1] * BH, box[2] * BW, box[3] * BH)
    L = np.asarray(Image.fromarray(np.ascontiguousarray(lum), "F").resize((W, H), Image.BILINEAR, box=px), np.float32)
    G = np.asarray(Image.fromarray(np.ascontiguousarray(glow), "F").resize((W, H), Image.BILINEAR, box=px), np.float32)
    flick = 1.0 + shot.flicker * (0.6 * math.sin(t * 11.3 + shot.seed) + 0.4 * math.sin(t * 23.7) + 0.3 * math.sin(t * 5.1))
    L = np.clip(L + grain(fi // 3) * 0.022, 0, 1.2)
    rgb = INK + (BONE - INK) * L[..., None]
    g = np.clip(G * flick, 0, 3)[..., None]
    rgb = rgb + AMBER * g * 0.85 + np.array([255, 235, 200], np.float32) * np.clip(g - 1.2, 0, 2) * 0.5
    rgb = rgb * vignette()
    # captions
    for (t0, t1, text, style) in shot.captions:
        if t0 - 0.01 <= t <= t1 + 0.01:
            a = smooth((t - t0) / 0.45) * (1 - smooth((t - (t1 - 0.45)) / 0.45))
            key = (text, style)
            if key not in _cap_cache:
                _cap_cache[key] = caption_layer(text, style)
            cap = _cap_cache[key]
            al = cap[..., 3:4] * a
            rgb = rgb * (1 - al) + cap[..., :3] * 255 * al
    if shot.choices:
        c0, c1, labels, pick, tp = shot.choices
        if c0 <= t <= c1:
            fin = smooth((t - c0) / 0.4)
            out = 1 - smooth((t - (c1 - 0.4)) / 0.4)
            picked = t >= tp
            alphas = []
            for i in range(len(labels)):
                a = fin * out
                if picked and i != pick:
                    a *= 1 - smooth((t - tp) / 0.35)
                alphas.append(a)
            key = (tuple(labels), picked, tuple(round(a, 2) for a in alphas))
            cl = choice_layer(labels, pick, picked, alphas)
            al = cl[..., 3:4]
            rgb = rgb * (1 - al * 0.0) if False else rgb
            # darken the bottom of the picture under the buttons, like the game's stage
            y = np.arange(H, dtype=np.float32)[:, None, None]
            band = np.clip((y - (H - 420)) / 220, 0, 1) * 0.75 * fin * out
            rgb = rgb * (1 - band)
            rgb = rgb * (1 - al) + cl[..., :3] * 255 * al
    if shot.title:
        tl = title_layer(t)
        al = tl[..., 3:4]
        rgb = rgb * (1 - al) + tl[..., :3] * 255 * al
    # fades
    fade = 1.0
    if shot.fade_in > 0:
        fade *= smooth(t / shot.fade_in)
    if shot.fade_out > 0:
        fade *= smooth((shot.dur - t) / shot.fade_out)
    rgb = rgb * fade
    return np.clip(rgb, 0, 255).astype(np.uint8)


def ffmpeg_writer(path):
    return subprocess.Popen(["ffmpeg", "-y", "-loglevel", "error", "-f", "rawvideo", "-pix_fmt", "rgb24", "-s", f"{W}x{H}", "-r", str(FPS),
                             "-i", "-", "-c:v", "libx264", "-preset", "veryfast", "-crf", "23", "-pix_fmt", "yuv420p",
                             "-g", "60", path], stdin=subprocess.PIPE)


def signature(shot):
    """What a shot's file depends on: its settings, the code that draws it, and the shared render code."""
    import inspect, hashlib
    src = [repr((shot.dur, shot.cam, shot.captions, shot.fade_in, shot.fade_out, shot.flicker, shot.seed, shot.title))]
    for f in (shot.draw, shot.anim):
        if f:
            src.append(inspect.getsource(f))
    src.append(open(os.path.join(HERE, "draw.py")).read())
    src.append(repr(shot.choices) + inspect.getsource(frame) + inspect.getsource(caption_layer) + inspect.getsource(title_layer)
               + inspect.getsource(choice_layer) + repr((W, H, FPS, BIG)))
    import scenes as _sc
    if shot.anim is not None and shot.anim.__name__ == "a_coins":
        src.append(repr(_sc.COIN_TIMES))
    return hashlib.sha1("\n".join(src).encode()).hexdigest()


def render_shot(idx):
    shot = scenes.SHOTS[idx]
    os.makedirs(os.path.join(OUT, "parts"), exist_ok=True)
    final = os.path.join(OUT, "parts", f"{shot.name}.mp4")
    sig = signature(shot)
    sigf = final + ".sig"
    if os.path.exists(final) and os.path.exists(sigf) and open(sigf).read() == sig:
        return final  # unchanged since the last render
    tmp = os.path.join(OUT, "parts", f"{shot.name}.tmp.mp4")
    n = int(round(shot.dur * FPS))
    p = ffmpeg_writer(tmp)
    for i in range(n):
        p.stdin.write(frame(shot, i / FPS, i).tobytes())
    p.stdin.close()
    if p.wait() == 0:
        os.replace(tmp, final)
        with open(sigf, "w") as f:
            f.write(sig)
    return final


def stills(times=None):
    d = os.path.join(OUT, "stills")
    os.makedirs(d, exist_ok=True)
    picks = []
    start = 0.0
    for idx, s in enumerate(scenes.SHOTS):
        ts = times.get(s.name) if times else None
        if ts is None:
            ts = [s.dur * 0.5]
            if s.captions:
                ts = [(a + b) / 2 for a, b, *_ in s.captions]
            if s.title:
                ts = [6.0]
        for t in ts:
            img = Image.fromarray(frame(s, t, int(t * FPS)))
            fn = os.path.join(d, f"{s.name}_{t:04.1f}.jpg")
            img.save(fn, quality=90)
            picks.append((start + t, fn))
        start += s.dur
    # contact sheet
    th = [Image.open(fn).resize((480, 270)) for _, fn in picks]
    cols = 4
    rows = math.ceil(len(th) / cols)
    sheet = Image.new("RGB", (cols * 480, rows * 270), (0, 0, 0))
    for i, im in enumerate(th):
        sheet.paste(im, ((i % cols) * 480, (i // cols) * 270))
    sheet.save(os.path.join(OUT, "contact-sheet.jpg"), quality=88)
    with open(os.path.join(OUT, "stills.json"), "w") as f:
        json.dump([{"t": round(t, 2), "file": os.path.relpath(fn, ROOT)} for t, fn in picks], f, indent=1)
    return picks


def video(jobs=2):
    from multiprocessing import Pool
    os.makedirs(OUT, exist_ok=True)
    idxs = list(range(len(scenes.SHOTS)))
    # longest first, for balance
    idxs.sort(key=lambda i: -scenes.SHOTS[i].dur * (3 if scenes.SHOTS[i].anim else 1))
    with Pool(jobs) as pool:
        pool.map(render_shot, idxs)
    lst = os.path.join(OUT, "parts", "list.txt")
    with open(lst, "w") as f:
        for s in scenes.SHOTS:
            f.write(f"file '{s.name}.mp4'\n")
    silent = os.path.join(OUT, "silent.mp4")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-f", "concat", "-safe", "0", "-i", lst, "-c", "copy", silent], check=True)
    import sound
    wav = os.path.join(OUT, "sound.wav")
    sound.make(wav, scenes.SHOTS)
    out = os.path.join(OUT, "deadweight-promo.mp4")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", silent, "-i", wav, "-map", "0:v", "-map", "1:a", "-c:v", "copy",
                    "-af", "loudnorm=I=-16:TP=-1.5:LRA=11,alimiter=limit=0.66:level=false:attack=2:release=60", "-ar", "48000", "-c:a", "aac", "-b:a", "160k", "-shortest", "-movflags", "+faststart",
                    out + ".tmp.mp4"], check=True)
    os.replace(out + ".tmp.mp4", out)
    web(out)
    return out


def web(src):
    """A smaller 720p copy for the game itself (public/promo.mp4) and a poster frame."""
    pub = os.path.join(ROOT, "public")
    os.makedirs(pub, exist_ok=True)
    dst = os.path.join(pub, "promo.mp4")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", src, "-vf", "scale=1280:720:flags=lanczos", "-c:v", "libx264", "-preset", "slow",
                    "-crf", "27", "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "96k", "-movflags", "+faststart", dst + ".tmp.mp4"], check=True)
    os.replace(dst + ".tmp.mp4", dst)
    # WebM too: open-source Chromium (and so the CI browser test) cannot play H.264
    wdst = os.path.join(pub, "promo.webm")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", src, "-vf", "scale=1280:720:flags=lanczos", "-c:v", "libvpx-vp9", "-b:v", "0",
                    "-crf", "40", "-row-mt", "1", "-deadline", "good", "-cpu-used", "4", "-c:a", "libopus", "-b:a", "96k", wdst + ".tmp.webm"], check=True)
    os.replace(wdst + ".tmp.webm", wdst)
    t = sum(s.dur for s in scenes.SHOTS) - 2.0
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", f"{t}", "-i", src, "-frames:v", "1", "-vf", "scale=1280:720", "-q:v", "4",
                    os.path.join(pub, "promo-poster.jpg")], check=True)
    return dst


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "stills"
    if cmd == "stills":
        for t, fn in stills():
            print(f"{t:6.2f}s  {os.path.relpath(fn, ROOT)}")
    elif cmd == "video":
        jobs = int(sys.argv[sys.argv.index("--jobs") + 1]) if "--jobs" in sys.argv else 2
        print(video(jobs))
    elif cmd == "shot":
        print(render_shot([s.name for s in scenes.SHOTS].index(sys.argv[2])))
