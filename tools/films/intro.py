"""The world film, "Before the Greywater": about 65 s, vertical, told by Wren looking back. It gives a new player the
world before the game begins (the salt-tax revolt, ten years of war, the Marshal who was paid for every year of it,
the songs that made Aubric the Lantern, the surrender and the nine days) and ends as he rides into the ford, where
the prologue starts. It shows no death: the game does that. Facts follow docs/VISION.md and the prologue's text."""
from film import Shot, cut

TITLE = "Deadweight — Before the Greywater"
OUT_NAME = "deadweight-before-the-greywater"
PUBLIC_NAME = "intro"
POSTER_AT = 26.0
LENGTH = (54, 80)
N, Y = "narr", "say"

WOOD, SQUARE, BRIDGE, TOLL, FORD = "road_beech_wood_noon", "stint_square_bells", "stint_bridge_dusk", "stint_tollhouse", "greywater_ford_night"
W1 = {"wind": 0.35, "leaves": 0.15, "drone": 0.14}
TOWN = {"crowd": 0.4, "wind": 0.15, "strings": 0.12}
RIV = {"river": 0.45, "wind": 0.3, "drone": 0.14}

SHOTS = [
    cut("salt", 4.4, WOOD, (0.62, 0.24, 1.8), (0.62, 0.22, 1.95), "Ten years ago the hill towns refused a tax on salt.", fade_in=1.2, sound=W1,
        events=[(0.8, "softhit")]),
    cut("hanged", 3.6, WOOD, (0.66, 0.2, 2.4), (0.66, 0.19, 2.6), "They hanged the men sent to collect it.", sound=W1),
    cut("war", 5.0, WOOD, (0.5, 0.4, 1.0), (0.52, 0.36, 1.08), "The Crown hanged some of theirs back, and that was the war.", sound=W1),
    cut("years", 4.8, SQUARE, (0.45, 0.48, 1.2), (0.45, 0.5, 1.32), "It went on for ten years. Nobody could remember how to stop it.",
        sound={"wind": 0.2, "crowd": 0.12, "drone": 0.22}),
    cut("songs", 3.2, BRIDGE, (0.4, 0.78, 1.6), (0.42, 0.76, 1.7), "Then the songs found a hero.", sound=TOWN, events=[(0.4, "bell:196")]),
    cut("lantern", 3.8, BRIDGE, (0.64, 0.28, 2.0), (0.64, 0.3, 2.15), "Sir Aubric Dane. They called him the Lantern.", sound=TOWN, flicker=0.25,
        events=[(0.4, "bell:233")]),
    cut("promise", 4.6, BRIDGE, (0.5, 0.45, 1.0), (0.5, 0.5, 1.06), "He went up into the hills with one promise: no one hangs.", sound=TOWN,
        events=[(0.5, "bell:174")]),
    cut("signed", 3.2, TOLL, (0.32, 0.5, 1.5), (0.3, 0.52, 1.62), "The hill towns signed their surrender.",
        sound={"wind": 0.2, "drone": 0.2, "strings": 0.1}),
    cut("council", 5.2, TOLL, (0.5, 0.45, 1.0), (0.48, 0.48, 1.08), "The council in the capital would sign it too, from his hand, in nine days.",
        sound={"wind": 0.2, "drone": 0.2, "strings": 0.1}),
    cut("squire", 4.8, FORD, (0.5, 0.45, 1.0), (0.5, 0.48, 1.06), "I was his squire. I carried his boots, his letters and his wine.", fade_in=0.6,
        sound=RIV),
    cut("river", 4.6, FORD, (0.62, 0.3, 1.6), (0.64, 0.3, 1.75), "A day short of the bells of Stint, we came to the Greywater.", sound=RIV),
    cut("died", 3.6, FORD, (0.44, 0.52, 1.3), (0.43, 0.54, 1.42), "The songs will tell you how he died.", sound={"river": 0.5, "drone": 0.22}),
    cut("there", 3.2, FORD, (0.42, 0.53, 1.75), (0.41, 0.55, 1.9), "I was there.", fade_out=0.6, sound={"river": 0.5, "drone": 0.25},
        events=[(0.3, "softhit")]),
    Shot("title", 5.5, FORD, cam=((0.5, 0.45, 1.0), (0.5, 0.45, 1.03)), dim=0.84, fade_in=0.8, fade_out=1.0,
         title=[("DEADWEIGHT", "title", 700, 0.3), ("PROLOGUE · THE GREYWATER", "kick", 920, 1.2)],
         sound={"river": 0.25, "drone": 0.25}, events=[(0.3, "bell:98")]),
]

SOUND_NOTES = [
    "The war: wind in a bare wood, a soft low hit, a low string drone.",
    "The Marshal: a murmur in the square.",
    "The songs: a crowd on the bridge and three bells.",
    "The surrender: quiet, wind, the drone and a faint higher string.",
    "The ford: the river at night and wind; a soft hit on 'I was there.'",
    "Title: a low bell over the river.",
]
