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

// Where the surrender is: "body" (on Aubric's belt) | "wren" | "isolde" | "hidden" (Wren has it; Isolde thinks it's lost)
VAR LETTER = ""
VAR MARROW_KNOWS_LETTER = false

// What Wren said to Marrow on the bank: "ambush" | "truth" | "wait"
VAR TOLD_MARROW = ""
// The version of the death Wren gave Isolde at dawn: "truth" | "ambush" | "hero"
VAR VERSION = ""

// What Wren tells themself the journey is for: "peace" | "him" | "wages". A thought choice:
// later chapters quote it back when Wren acts against it.
VAR SELF = ""

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
- "hidden": You carry the surrender. Isolde believes the river took it.
}

// ---------------------------------------------------------------
// Isolde's ballad, as it stands. Rewritten at every chapter break.
=== function ballad()
{ VERSION:
- "truth":
    The page is blank.
    Isolde says a blank page is the most honest thing she has ever written, and that it won't last past Stint.
- "ambush":
    By the Greywater, black as a broken vow,
    the hill-men waited with their bows.
    The Lantern stood where a lesser man fell,
    and how he stood, the river knows.
- "hero":
    Into the Greywater, cold as a debt,
    the Lantern went for the squire he kept.
    He gave the river his breath for theirs,
    {WENT_IN:and the squire came out, and the Lantern slept.|and the river kept him, and the squire wept.}
}
