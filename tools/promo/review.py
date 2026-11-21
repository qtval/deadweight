"""Check the finished promo and build the review packet for the blind viewer panel.

  python3 tools/promo/review.py

Automatic checks (fail = exit 1): length, size, frame rate, loudness, true peak, web copies exist and are small enough,
every caption is readable in the time it is on screen, and every line of quoted dialogue is word for word in the game's
ink, so the trailer never puts words in a character's mouth. Writes reports/promo/review/ (frames + script) and
reports/promo/checks.md.
"""
import os, sys, re, json, subprocess, glob

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
sys.path.insert(0, HERE)
import scenes  # noqa: E402

OUT = os.path.join(ROOT, "reports", "promo")
REV = os.path.join(OUT, "review")
VID = os.path.join(OUT, "deadweight-promo.mp4")
results = []


def check(name, ok, detail=""):
    results.append((name, bool(ok), detail))
    print(("✓ " if ok else "✗ ") + name + (f" — {detail}" if detail else ""))


def probe(path):
    out = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration:stream=codec_type,width,height,r_frame_rate", "-of", "json", path],
                         capture_output=True, text=True).stdout
    return json.loads(out)


def norm(s):
    return s.replace("\u2019", "'").replace("\u2018", "'").replace("\u201c", '"').replace("\u201d", '"').replace("\u00a0", " ")


def main():
    os.makedirs(REV, exist_ok=True)
    total = sum(s.dur for s in scenes.SHOTS)
    p = probe(VID)
    dur = float(p["format"]["duration"])
    v = [s for s in p["streams"] if s["codec_type"] == "video"][0]
    check("runs about a minute and a half (85-95 s)", 85 <= dur <= 95, f"{dur:.1f}s")
    check("1920x1080 at 30 fps", v["width"] == 1920 and v["height"] == 1080 and v["r_frame_rate"] == "30/1", f'{v["width"]}x{v["height"]} {v["r_frame_rate"]}')
    check("has sound", any(s["codec_type"] == "audio" for s in p["streams"]))
    ebu = subprocess.run(["ffmpeg", "-hide_banner", "-nostats", "-i", VID, "-af", "ebur128=peak=true", "-f", "null", "-"], capture_output=True, text=True).stderr
    summ = ebu[ebu.rfind("Summary:"):]
    I = float(re.search(r"I:\s+(-?[\d.]+) LUFS", summ).group(1))
    TP = float(re.search(r"Peak:\s+(-?[\d.]+) dBFS", summ).group(1))
    check("loudness near -16 LUFS (web/social standard)", -18 <= I <= -14, f"{I} LUFS")
    check("true peak below -1 dBFS", TP <= -1.0, f"{TP} dBFS")
    for name, limit in (("promo.mp4", 15), ("promo.webm", 15)):
        f = os.path.join(ROOT, "public", name)
        mb = os.path.getsize(f) / 1e6 if os.path.exists(f) else 0
        check(f"game copy public/{name} exists and is under {limit} MB", 0 < mb < limit, f"{mb:.1f} MB")
    check("full-size file under 60 MB", os.path.getsize(VID) / 1e6 < 60, f"{os.path.getsize(VID) / 1e6:.1f} MB")

    # captions: readable, and dialogue word for word from the game
    ink = norm(" ".join(open(f).read() for f in glob.glob(os.path.join(ROOT, "story", "*.ink"))))
    ink = re.sub(r"\{[^{}|]*\|", "", ink)
    ink = re.sub(r"\s+", " ", ink)
    script, start = [], 0.0
    for s in scenes.SHOTS:
        for (t0, t1, text, style) in s.captions:
            words = len(text.split())
            secs = t1 - t0
            check(f"caption readable in time ({words} words, {secs:.1f}s): {text[:40]}…", words / secs <= 3.4 and secs >= 2.4, f"{words / secs:.1f} words/s")
            if style == "say":
                for q in re.findall(r"\u201c([^\u201d]+)\u201d", text):
                    frag = norm(q).strip().rstrip(",.?!").strip()
                    check(f"dialogue is in the game: \u201c{q}\u201d", frag in ink)
            script.append((start + t0, start + t1, text, style))
        if s.choices:
            c0, c1, labels, pick, tp = s.choices
            for lab in labels:
                check(f"choice is word for word from the game: {lab}", ("[" + norm(lab) + "]") in ink)
            check("choices stay up long enough to read before the pick", tp - c0 >= 2.4, f"{tp - c0:.1f}s")
            script.append((start + (c0 + tp) / 2, start + (c0 + tp) / 2, "[choice on screen] " + " / ".join(labels), "choice"))
            script.append((start + (tp + c1) / 2, start + (tp + c1) / 2, f"[picked] {labels[pick]}", "choice"))
        start += s.dur

    # review frames: the middle of every caption, plus the moments without one
    frames = [((a + b) / 2, text) for a, b, text, _ in script]
    st = 0.0
    for s in scenes.SHOTS:
        for rt in getattr(s, "review", ()):
            frames.append((st + rt, "(moment without a new caption)"))
        if not s.captions and s.dur > 2:
            frames.append((st + s.dur * (0.62 if s.name != "13_title" else 0.75), "(no caption, title card)" if s.title else "(no caption)"))
        st += s.dur
    frames.sort()
    lines = ["# Promo review packet", "", f"Length {dur:.1f} s. Frames below are taken from the finished file.", ""]
    for i, (t, text) in enumerate(frames):
        fn = os.path.join(REV, f"f{i:02d}_{t:05.1f}.jpg")
        subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-ss", f"{t:.2f}", "-i", VID, "-frames:v", "1", "-vf", "scale=1280:720", "-q:v", "3", fn], check=True)
        lines.append(f"- {t:5.1f}s  `{os.path.relpath(fn, ROOT)}`  {text}")
    T, acc = {}, 0.0
    for sh in scenes.SHOTS:
        T[sh.name] = acc
        acc += sh.dur
    f = lambda n: f"{T[n]:.0f}"  # noqa: E731
    cues = ["", "## Sound (as designed)", "",
            f"- 0–{f('04_water')} s: the river at night, rising; a low string drone comes in under the second shot.",
            f"- {f('04_water')} s: a deep hit and a splash as the horse goes down; the river roars.",
            f"- {f('05_hand')}–{f('06_beat')} s: muffled, as if under water, while the hand rises and closes; then silence for a beat.",
            f"- {f('07_body')}–{f('09_knife')} s: the river quieter; the drone returns; a soft hit on the body.",
            f"- {f('09_knife')}–{f('10_dawn')} s: a heartbeat under the knife.",
            f"- {f('10_dawn')}–{f('11_coins')} s: one far bell at dawn; a second, higher string voice.",
            f"- {f('11_coins')}–{f('12_stint')} s: four coins clink on steel; the fourth rolls away.",
            f"- {f('12_stint')}–{f('13_title')} s: the bells of the town; the strings swell.",
            f"- {f('13_title')}–{acc:.0f} s: a deep hit and a low bell under the title; fade out."]
    with open(os.path.join(REV, "packet.md"), "w") as f:
        f.write("\n".join(lines + cues) + "\n")
    ok = all(r[1] for r in results)
    with open(os.path.join(OUT, "checks.md"), "w") as f:
        f.write(f"# Promo checks\n\n**Result: {'PASS' if ok else 'FAIL'}** — {sum(r[1] for r in results)}/{len(results)}\n\n")
        f.write("\n".join(f"- {'✅' if r[1] else '❌'} {r[0]}{(' — ' + r[2]) if r[2] else ''}" for r in results) + "\n")
    print(("PASS" if ok else "FAIL") + f": {sum(r[1] for r in results)}/{len(results)}")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
