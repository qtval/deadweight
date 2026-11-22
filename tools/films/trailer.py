"""The trailer: 90 s, vertical, built from the demo's own panels. Captions are Wren's narration (italic) or dialogue
taken word for word from the prologue; the two choice moments use the game's real choice labels."""
from film import Shot

TITLE = "Deadweight — trailer"
OUT_NAME = "deadweight-trailer"
PUBLIC_NAME = "promo"
POSTER_AT = 88.0
LENGTH = (85, 95)
N, Y = "narr", "say"

CHOICE_FORD = ["Grab his bridle. He’ll hate you for it.", "Shout for Marrow. Let her be the one he blames.", "Say nothing. Tomorrow he pays you."]
CHOICE_MARROW = ["Agree. An ambush, and nobody here hangs.", "Refuse, with her knife on your wrist", "Tell her you’ll decide by dawn"]


def cut(name, dur, panel, a, b, text=None, style=N, **kw):
    """One caption, one framing: a hard cut with a slow move from a to b (cx, cy, zoom)."""
    caps = [(0.3, dur - 0.25, text, style)] if text else []
    kw.setdefault("fade_in", 0.0)
    kw.setdefault("fade_out", 0.0)
    return Shot(name, dur, panel, cam=(a, b), captions=caps, **kw)


FORD, CHURN, BODY, MARROW, DAWN, COINS, ROAD = ("greywater_ford_night", "greywater_water_churn", "greywater_bank_body",
                                                "greywater_marrow_wading", "greywater_dawn_cart", "greywater_breastplate_silver",
                                                "road_to_stint_morning")
RIVER = {"river": 0.45, "wind": 0.28, "drone": 0.12}

SHOTS = [
    cut("lantern", 4.0, FORD, (0.44, 0.52, 1.3), (0.43, 0.54, 1.42), "The songs called him the Lantern.", fade_in=1.0, sound=RIVER),
    cut("war", 4.8, FORD, (0.5, 0.45, 1.0), (0.5, 0.48, 1.07), "He had talked a ten-year war to death in one afternoon.", sound=RIVER),
    cut("unpaid", 3.8, FORD, (0.42, 0.53, 1.75), (0.41, 0.55, 1.9), "I had been his squire six years, unpaid.", sound=RIVER),
    Shot("choose", 8.0, FORD, cam=((0.47, 0.5, 1.2), (0.44, 0.55, 1.4)), fade_in=0.0, fade_out=0.0,
         captions=[(0.3, 2.9, "He rode into the shallows, drunk.", N)], choices=(3.1, 7.8, CHOICE_FORD, 2, 5.7),
         sound={"river": 0.5, "drone": 0.22}),
    cut("hand", 4.0, CHURN, (0.4, 0.3, 1.5), (0.36, 0.2, 1.8), "A hand came out of the water, bare and white.",
        sound={"river": 1.0, "drone": 0.25}, events=[(0.05, "splash"), (0.05, "hit")]),
    cut("rope", 4.0, CHURN, (0.5, 0.62, 1.0), (0.5, 0.56, 1.08), "I ran for the rope. Too late.", fade_out=0.5,
        sound={"river": 0.7, "drone": 0.15}),
    Shot("beat", 0.4, None, fade_in=0.0, fade_out=0.0),
    cut("belt", 3.8, BODY, (0.5, 0.42, 1.0), (0.54, 0.45, 1.06), "The river came no higher than his belt.", fade_in=0.6,
        sound={"river": 0.35, "drone": 0.2}, events=[(0.4, "softhit")]),
    cut("stones", 5.6, BODY, (0.56, 0.5, 1.3), (0.58, 0.48, 1.42), "It took longer to get him onto the stones than it had taken him to die.",
        sound={"river": 0.3, "drone": 0.22}),
    cut("surrender", 3.6, BODY, (0.38, 0.72, 1.5), (0.36, 0.74, 1.62), "On his belt: the surrender that ended the war.",
        sound={"river": 0.3, "drone": 0.25}),
    cut("council", 4.0, BODY, (0.5, 0.62, 1.2), (0.5, 0.6, 1.12), "The council would sign it for him and no one else.",
        sound={"river": 0.3, "drone": 0.25}),
    cut("marrow", 4.4, MARROW, (0.5, 0.48, 1.0), (0.5, 0.44, 1.08), "“Crown hero drowns at a ford,” said Marrow, the guide. “Who hangs?”", Y,
        flicker=0.2, sound={"river": 0.4, "drone": 0.28}),
    cut("why", 4.0, MARROW, (0.5, 0.34, 1.6), (0.5, 0.32, 1.75), "She picked the ford, and once fought for the hill towns.",
        flicker=0.2, sound={"river": 0.35, "drone": 0.3}, events=[(0.2, "heartbeat")]),
    Shot("hangs", 7.0, MARROW, cam=((0.47, 0.42, 1.3), (0.45, 0.4, 1.4)), fade_in=0.0, fade_out=0.3, flicker=0.2,
         captions=[(0.3, 2.8, "“Guide hangs,” she said.", Y)], choices=(3.0, 6.8, CHOICE_MARROW, 0, 5.6),
         sound={"river": 0.35, "drone": 0.3}),
    cut("slept", 4.0, DAWN, (0.35, 0.42, 1.8), (0.34, 0.42, 1.95), "The chronicler had slept through it all, in the cart.", fade_in=0.5,
        sound={"river": 0.25, "wind": 0.3, "strings": 0.14}, events=[(0.4, "bell:220")]),
    cut("fever", 4.0, DAWN, (0.36, 0.42, 1.5), (0.4, 0.42, 1.38), "“Then he is not dead,” she said. “He has a fever.”", Y,
        sound={"river": 0.25, "wind": 0.3, "strings": 0.14}),
    cut("stink", 3.4, DAWN, (0.5, 0.52, 1.0), (0.5, 0.5, 1.05), "“He’ll stink by day three,” said Marrow.", Y,
        sound={"river": 0.25, "wind": 0.3, "strings": 0.12}),
    cut("price", 3.7, COINS, (0.5, 0.5, 1.0), (0.5, 0.46, 1.08), "Then they worked out what killing me would cost.",
        sound={"drone": 0.22, "wind": 0.12}),
    cut("silver", 3.4, COINS, (0.46, 0.32, 1.45), (0.45, 0.3, 1.55), "“Ten silver,” said Marrow. “Six,” said the chronicler.", Y,
        sound={"drone": 0.22, "wind": 0.12}, events=[(0.4, "coins")]),
    cut("eight", 3.0, ROAD, (0.5, 0.42, 1.0), (0.5, 0.45, 1.05), "Eight days to the capital.", fade_in=0.4,
        sound={"wind": 0.3, "strings": 0.2, "drone": 0.25}, events=[(0.2, "softhit"), (0.8, "bell:196")]),
    cut("carry", 3.6, ROAD, (0.46, 0.6, 1.45), (0.45, 0.62, 1.55), "Carry the body. Carry the letter. Carry the lie.",
        sound={"wind": 0.3, "strings": 0.22, "drone": 0.25}),
    Shot("title", 3.5, FORD, cam=((0.5, 0.45, 1.0), (0.5, 0.45, 1.02)), dim=0.8, fade_in=0.4, fade_out=0.8,
         title=[("DEADWEIGHT", "title", 600, 0.1), ("A STORY IN SIX CHAPTERS", "kick", 820, 0.5),
                ("PLAY THE DEMO FREE IN YOUR BROWSER", "small", 1010, 0.9), ("QTVAL.GITHUB.IO/DEADWEIGHT", "small", 1062, 0.9)],
         sound={"river": 0.2, "drone": 0.3, "strings": 0.15}, events=[(0.1, "hit"), (0.1, "bell:98")]),
]

SOUND_NOTES = [
    "Ford: the river at night and wind; a low string drone comes in.",
    "The fall: a deep hit and a splash; the river roars, then quietens for the hand.",
    "A beat of silence, then the body on the stones with a soft hit.",
    "Marrow: a heartbeat under her knife.",
    "Dawn: one far bell and a higher string voice.",
    "Coins: four clinks on steel.",
    "The road: bells far off, the strings swell.",
    "Title: a deep hit and a low bell.",
]
