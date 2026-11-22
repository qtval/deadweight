"""The world film, "Before the Greywater" (about 60 s, vertical): the ballad.

The world first sees the Lantern the way the songs tell it: woodcut prints from a broadsheet ballad, stiff and
flattering, with a plucked tune and the verses in the song face. Every verse is a lie the game later takes apart
(he never lost; one kind word; his word was kept; every debt repaid; died old, in bed). Then the print tears, the
tune stops, and under it is Wren's charcoal: the ford at night. Wren: "That's the song." The truth, then the job.
The ballad verses are original; the facts follow docs/VISION.md and the prologue's text.

Pictures: the owner's woodcut prints in assets/films/ballad/<id>.webp (art/prompts/BALLAD.md); until each one
arrives, a rough stand-in from assets/films/ballad/standin/ is used for timing only.
"""
import os
from film import Shot, cut, ROOT

TITLE = "Deadweight — Before the Greywater (the ballad)"
OUT_NAME = "deadweight-before-the-greywater"
PUBLIC_NAME = "intro"
POSTER_AT = 4.0
LENGTH = (54, 70)
N, G = "narr", "song"


def B(pid):
    real = os.path.join(ROOT, "assets", "films", "ballad", pid + ".webp")
    return f"ballad/{pid}" if os.path.exists(real) else f"ballad/standin/{pid}"


CHURN, FORD = "greywater_water_churn", "greywater_ford_night"
SONG = {"lute": 0.55, "crowd": 0.06}
RIV = {"river": 0.5, "wind": 0.3, "drone": 0.16}


def verse(name, pid, a, b, l1, l2, d1=3.2, d2=3.2, **kw):
    """Two lines of the ballad over one print: each line held long enough to read."""
    dur = 0.3 + d1 + d2 + 0.2
    caps = [(0.3, 0.3 + d1 - 0.1, l1, G), (0.3 + d1, 0.3 + d1 + d2 - 0.1, l2, G)]
    kw.setdefault("fade_in", 0.0)
    kw.setdefault("fade_out", 0.0)
    kw.setdefault("sound", SONG)
    return Shot(name, dur, B(pid), cam=(a, b), captions=caps, flicker=0.0, **kw)


SHOTS = [
    cut("open", 3.6, B("lantern"), (0.5, 0.5, 1.0), (0.5, 0.48, 1.06), "This is the song they sing about him.", fade_in=1.0,
        flicker=0.0, sound=SONG),
    verse("lantern", "lantern", (0.5, 0.42, 1.12), (0.5, 0.38, 1.3),
          "Sir Aubric Dane, the Lantern bright,", "who never lost a single fight."),
    verse("war", "war", (0.5, 0.5, 1.05), (0.46, 0.55, 1.18),
          "Ten years the hill towns burned and bled,", "ten years our sons came home dead.", events=[(0.4, "softhit")]),
    verse("ride", "ride", (0.5, 0.6, 1.1), (0.5, 0.4, 1.2),
          "He rode up to them with no sword,", "and ended it with one kind word."),
    verse("surrender", "surrender", (0.5, 0.5, 1.15), (0.5, 0.52, 1.3),
          "The hill towns knelt, and signed, and wept.", "He gave his word. His word was kept."),
    verse("bells", "bells", (0.5, 0.35, 1.2), (0.5, 0.5, 1.05),
          "So ring the bells in Stint for him,", "and fill his cup up to the brim.",
          events=[(0.5, "bell:196"), (1.6, "bell:233"), (3.6, "bell:174")], sound={"lute": 0.5, "crowd": 0.3}),
    verse("deathbed", "deathbed", (0.5, 0.5, 1.05), (0.5, 0.5, 1.2),
          "He died in bed, grown old and grey,", "with every debt he owed repaid."),
    # the print rips away: the tune stops, the river is under it
    Shot("tear", 2.4, B("deathbed"), cam=((0.5, 0.5, 1.2), (0.5, 0.5, 1.22)), flicker=0.0, fade_in=0.0, fade_out=0.0,
         tear=(CHURN, (0.5, 0.42, 1.25), (0.5, 0.44, 1.3), 0.35, 1.25),
         sound={"river": 0.5, "wind": 0.2}, events=[(0.3, "rip"), (0.45, "softhit")], review=[0.8, 1.9]),
    cut("song", 3.0, CHURN, (0.5, 0.44, 1.3), (0.5, 0.45, 1.36), "That's the song.", sound=RIV),
    cut("drunk", 4.3, FORD, (0.5, 0.5, 1.0), (0.5, 0.52, 1.07), "He died drunk, in a river, a day short of the bells.", sound=RIV),
    cut("there", 3.0, FORD, (0.42, 0.53, 1.6), (0.41, 0.55, 1.75), "I was there.", sound={"river": 0.5, "drone": 0.25},
        events=[(0.3, "softhit")]),
    cut("carry", 4.0, FORD, (0.62, 0.3, 1.5), (0.64, 0.3, 1.62), "Nine days to the capital, with him and the lie.", fade_out=0.6,
        sound={"river": 0.45, "drone": 0.25}),
    Shot("title", 5.5, FORD, cam=((0.5, 0.45, 1.0), (0.5, 0.45, 1.03)), dim=0.84, fade_in=0.8, fade_out=1.0,
         title=[("DEADWEIGHT", "title", 700, 0.3), ("PROLOGUE · THE GREYWATER", "kick", 920, 1.2)],
         sound={"river": 0.25, "drone": 0.25}, events=[(0.3, "bell:98")]),
]

SOUND_NOTES = [
    "The song: a plain plucked ballad tune (lute-like), a faint crowd; three bells under the bells verse; a soft low hit under the war.",
    "The tear: paper ripping, the tune cut off, the river underneath.",
    "The truth: the river at night and wind, a low drone; a soft hit on 'I was there.'",
    "Title: a low bell over the river.",
]
