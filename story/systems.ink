// State. The app reads these for the Road / Travelers / Ballad screens.
// Nothing here is ever shown to the player as a number.

VAR DAYS_LEFT = 9
VAR PLACE = "The Greywater"

// What Wren did at the ford: "bridle" | "called" | "silent"
VAR AT_FORD = ""
VAR WENT_IN = false
// Whether Wren drank with Aubric before the crossing, and took his purse on the bank.
VAR DRANK = false
VAR PURSE = false

// Where the surrender is: "body" (on Aubric's belt) | "wren" | "isolde" | "hidden" (Wren has it and says the river took it; Isolde may suspect; Marrow knows and will want paying)
VAR LETTER = ""
VAR MARROW_KNOWS_LETTER = false

// What Wren said to Marrow on the bank: "ambush" | "truth" | "wait"
VAR TOLD_MARROW = ""
// The version of the death Wren gave Isolde at dawn: "truth" | "ambush" | "hero"
VAR VERSION = ""

// What Wren tells themself the journey is for: "peace" | "him" | "wages". Chosen by an act (what Wren does with his gloves):
// later chapters quote it back when Wren acts against it.
VAR SELF = ""

// What Wren said to Isolde's plan: "agreed" | "bargained" | "objected". Bargaining makes Isolde promise a place in writing.
VAR PLAN = ""
VAR ISOLDE_OWES = false
// Agreeing gets Wren Aubric's signet: Wren may speak in his name.
VAR RING = false

// If Wren went in and told Isolde the truth: did Wren admit hitting him? "" | "told" | "hidden". If told, Isolde holds it.
VAR ELBOW = ""

// Wren's own paper: the room and the wages, written out by Wren, wanting Aubric's name. "signed" (forged on the road, the day after he died) | "waiting" (to be done in Vellmouth, with seal and witness)
VAR DEED = ""

// What Wren did with Marrow's knife under the jaw while Isolde counted out the price: "hand" (sold the forging hand) | "face" (his men know Wren) | "begged"
VAR SOLD = ""
// Whether Wren read Isolde's ballad while the women talked, and saw the struck-out verse with "squire — river? cheaper" in the margin.
VAR READ_BALLAD = false

VAR ISOLDE_SAW_NOSE = false

VAR TRUST_MARROW = 0
VAR TRUST_ISOLDE = 0
VAR LEGEND = 0
VAR DEBT_MARROW = false

// ---------------------------------------------------------------
// Three-line recap, shown at the end of a chapter and at the top of the next.
=== function recap()
{ AT_FORD:
- "bridle": At the ford, you took his bridle. He shook you off.
- "called": At the ford, you shouted for Marrow. She came too late.
- "silent": At the ford, you said nothing, the way you'd learned to.
}
{ VERSION:
- "truth": You told Isolde the truth: he drowned, drunk, in water to his waist.
- "ambush": You told Isolde Marrow's story: an ambush, an arrow, a fighting death.
- "hero": You told Isolde he died going into the river after you.
}
{ LETTER:
- "isolde": Isolde carries the surrender now.
- "wren": You carry the surrender, and everyone knows it.
- "hidden": You carry the surrender. You told Isolde the river took it.
}

// ---------------------------------------------------------------
// Isolde's ballad, as it stands. Rewritten at every chapter break.
=== function ballad()
{ VERSION:
- "truth":
    Two verses stand. Where the third should be, the page is blank.
    Isolde says it is the most honest thing she has ever written, and that it won't last past Stint.
- "ambush":
    By the roadside, black as a broken vow,
    the robbers waited with their bows.
    The Lantern stood where a lesser man fell,
    and how he stood, the hedgerow knows.
- "hero":
    Into the river, cold as a stone,
    the Lantern went for the squire he kept.
    He gave the river his breath for theirs,
    {WENT_IN:and the squire came out, and the Lantern slept.|and the river kept him, and the squire wept.}
}
