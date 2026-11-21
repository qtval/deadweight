"""Sound for the promo, synthesised (no samples, nothing borrowed): river, drone, hits,
coins, bells. Timed from the shot list so it follows any re-cut."""
import numpy as np
from scipy.signal import butter, sosfilt
import wave

SR = 48000


def starts(shots):
    out, t = {}, 0.0
    for s in shots:
        out[s.name] = t
        t += s.dur
    return out, t


def lp(x, f, order=2):
    return sosfilt(butter(order, f, "low", fs=SR, output="sos"), x)


def hp(x, f, order=2):
    return sosfilt(butter(order, f, "high", fs=SR, output="sos"), x)


def bp(x, f0, f1, order=2):
    return sosfilt(butter(order, [f0, f1], "band", fs=SR, output="sos"), x)


def env(n, pts):
    """Piecewise-linear envelope from [(time, level), ...]."""
    t = np.arange(n) / SR
    xs, ys = zip(*pts)
    return np.interp(t, xs, ys).astype(np.float32)


def bell(t0, dur, f0, n, amp=0.3, rng=None):
    """Inharmonic struck bell."""
    t = np.arange(int(dur * SR)) / SR
    partials = [(0.5, 1.0, 0.9), (1.0, 0.8, 1.0), (1.19, 0.6, 0.7), (1.5, 0.45, 0.5), (2.0, 0.5, 0.35), (2.51, 0.3, 0.25), (2.66, 0.25, 0.2), (3.01, 0.2, 0.15)]
    y = np.zeros_like(t)
    for ratio, a, decay in partials:
        y += a * np.sin(2 * np.pi * f0 * ratio * t + (rng.random() * 6 if rng is not None else 0)) * np.exp(-t / (dur * decay * 0.5))
    y *= np.minimum(1, t / 0.004)
    return int(t0 * SR), (y * amp).astype(np.float32)


def thump(dur=1.6, f=48, amp=0.9):
    t = np.arange(int(dur * SR)) / SR
    fr = f * (1 + 1.5 * np.exp(-t * 18))
    ph = 2 * np.pi * np.cumsum(fr) / SR
    return (np.sin(ph) * np.exp(-t * 3.2) * amp).astype(np.float32)


def clink(rng, amp=0.25):
    t = np.arange(int(0.6 * SR)) / SR
    y = np.zeros_like(t)
    for f in (3150, 4720, 6130, 8020):
        y += np.sin(2 * np.pi * f * rng.uniform(0.97, 1.03) * t) * np.exp(-t * rng.uniform(9, 16))
    return (y * amp / 4).astype(np.float32)


def add(buf, i, y):
    if i >= len(buf):
        return
    j = min(len(buf), i + len(y))
    buf[i:j] += y[: j - i]


def make(path, shots):
    st, total = starts(shots)
    n = int(total * SR)
    rng = np.random.default_rng(3)
    L = np.zeros(n, np.float32)
    R = np.zeros(n, np.float32)

    # river: brown-ish noise, stereo, rising into the fall, muffled under water, gone at the cut
    white = rng.standard_normal((2, n)).astype(np.float32)
    river = np.stack([lp(hp(w, 80), 900) for w in white]) * 0.9
    hiss = np.stack([bp(w, 1500, 6000) for w in white]) * 0.12
    s_water, s_hand, s_beat = st["04_water"], st["05_hand"], st["06_beat"]
    s_body, s_letter, s_knife = st["07_body"], st["08_letter"], st["09_knife"]
    e = env(n, [(0, 0), (0.2, 0.25), (5, 0.45), (14, 0.5), (s_water, 0.55), (s_water + 0.1, 1.0), (s_hand, 0.9), (s_beat - 0.05, 0.6), (s_beat, 0),
                (s_body + 0.8, 0), (s_body + 2.5, 0.35), (s_knife, 0.3), (st["10_dawn"], 0.25), (st["11_coins"], 0.12), (st["12_stint"], 0.08), (total, 0)])
    eh = env(n, [(0, 0), (0.2, 0.3), (s_water, 0.4), (s_water + 0.1, 1.2), (s_hand, 0.0), (s_body + 2.5, 0.0), (s_body + 3, 0.25), (st["11_coins"], 0.1), (total, 0)])
    # under water: muffle the hand shot
    muff = lp(river[0] + river[1], 300) * 0.8
    em = env(n, [(0, 0), (s_hand, 0), (s_hand + 0.05, 1.0), (s_beat - 0.3, 0.6), (s_beat, 0), (total, 0)])
    L += river[0] * e + hiss[0] * eh + muff * em
    R += river[1] * e + hiss[1] * eh + muff * em

    # splash when the horse goes down
    sp = bp(rng.standard_normal(int(2.5 * SR)).astype(np.float32), 200, 5000) * np.exp(-np.arange(int(2.5 * SR)) / SR * 2.2) * 1.4
    add(L, int(s_water * SR), sp)
    add(R, int(s_water * SR), sp * 0.9)

    # drone: low strings, D, swelling; drops out for the hand, returns for the body
    t = np.arange(n) / SR
    drone = np.zeros(n, np.float32)
    for f, a in ((36.71, 0.5), (73.42, 0.35), (110.0, 0.18), (146.83, 0.10), (174.61, 0.07)):
        vib = 1 + 0.002 * np.sin(2 * np.pi * 4.7 * t + f)
        ph = 2 * np.pi * np.cumsum(f * vib) / SR
        drone += (a * (np.sin(ph) + 0.35 * np.sin(2 * ph) + 0.15 * np.sin(3 * ph))).astype(np.float32)
    drone = lp(drone, 900)
    ed = env(n, [(0, 0), (4, 0), (9, 0.18), (s_water, 0.28), (s_hand, 0.10), (s_beat, 0), (s_body + 1, 0), (s_body + 5, 0.16), (s_knife, 0.22),
                 (st["10_dawn"], 0.14), (st["11_coins"], 0.10), (st["12_stint"], 0.26), (st["13_title"], 0.32), (total - 1.5, 0.12), (total, 0)])
    L += drone * ed
    R += drone * ed * 0.95

    # a second voice a minor third up comes in for the turn (dawn) and the end
    upper = np.zeros(n, np.float32)
    for f, a in ((174.61, 0.12), (220.0, 0.10), (261.63, 0.05)):
        upper += a * np.sin(2 * np.pi * f * t * (1 + 0.003 * np.sin(2 * np.pi * 5.1 * t)))
    upper = lp(upper, 1500)
    eu = env(n, [(0, 0), (st["10_dawn"], 0), (st["10_dawn"] + 3, 0.10), (st["11_coins"], 0.0), (st["12_stint"], 0.0), (st["12_stint"] + 3, 0.14),
                 (total - 1.5, 0.08), (total, 0)])
    L += upper * eu * 0.8
    R += upper * eu

    # heartbeat under the knife
    for k in range(10):
        tt = s_knife + 0.6 + k * 0.78
        hb = thump(0.5, 52, 0.45)
        add(L, int(tt * SR), hb)
        add(R, int(tt * SR), hb)
        add(L, int((tt + 0.22) * SR), hb * 0.6)
        add(R, int((tt + 0.22) * SR), hb * 0.6)

    # hits on the big moments
    for tt, a in ((s_water, 1.0), (s_body + 0.9, 0.5), (st["12_stint"] + 0.2, 0.6), (st["13_title"] + 0.6, 1.0)):
        th = thump(2.4, 42, a)
        add(L, int(tt * SR), th)
        add(R, int(tt * SR), th)

    # coins on the breastplate
    from scenes import COIN_TIMES
    for k, ct in enumerate(COIN_TIMES):
        c = clink(rng, 0.35)
        add(L, int((st["11_coins"] + ct) * SR), c)
        add(R, int((st["11_coins"] + ct) * SR), c * 0.8)
    roll = bp(rng.standard_normal(int(1.6 * SR)).astype(np.float32), 2500, 7000) * 0.05
    add(L, int((st["11_coins"] + COIN_TIMES[3] + 0.1) * SR), roll)
    add(R, int((st["11_coins"] + COIN_TIMES[3] + 0.1) * SR), roll)

    # a single far bell at dawn; the bells of Stint at the end
    i, y = bell(st["10_dawn"] + 0.5, 6, 220, 8, 0.10, rng)
    add(L, i, y * 0.7)
    add(R, i, y)
    for k, (dt, f) in enumerate(((0.4, 196), (2.1, 233), (3.8, 196), (5.4, 174))):
        i, y = bell(st["12_stint"] + dt, 6, f, 8, 0.16, rng)
        add(L, i, y)
        add(R, i, y * 0.8)
    i, y = bell(st["13_title"] + 0.6, 7, 98, 8, 0.22, rng)
    add(L, i, y)
    add(R, i, y)

    mix = np.stack([L, R], 1)
    mix = hp(mix.T, 25).T
    # gentle compression so the hits don't set the level for everything else
    rms = np.sqrt(np.mean(mix ** 2)) + 1e-9
    mix = mix / (rms * 6)
    mix = np.tanh(mix * 1.2) / np.tanh(1.2)
    mix = mix * 0.89 / (np.max(np.abs(mix)) + 1e-9)
    pcm = (mix * 32767).astype(np.int16)
    with wave.open(path, "wb") as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm.tobytes())
    return path
