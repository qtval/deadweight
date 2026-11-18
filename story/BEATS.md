# Beat sheet

The full sheet for chapters 1–5 is written in M1, one block per scene, using the template in `docs/WRITING_GUIDE.md`. This file currently holds (1) what every chapter must contain, and (2) the prologue as built, as the worked example.

## What every chapter contains

A chapter is 15–20 scenes, 20–30 minutes, one main location. Each one has all of these; the beat sheet marks which scene carries which.

| Beat | What it is | Why |
|---|---|---|
| **Arrival + the body** | The first scene says where we are, what day it is, and what state Aubric is in now (smell, flies, what the lie currently needs). | The clock you can smell. |
| **A nobody** | One minor person with their own day, who does not care about the war. You improve or ruin that day. | The world is bigger than the plot. |
| **A temptation** | A choice where one option is the easy, selfish thing, written so the player wants it. | Complicity. |
| **A fire scene** | Night, camp or lodging. You sit with ONE of the companions; the others are busy. Talk, food, a small confidence, something they want. No plot decision. | You have to like them before it can cost you. |
| **A thought choice** | "Tell yourself…": the player picks Wren's excuse, not Wren's action. Stored, and quoted back later. | The player writes their own self-deception. |
| **A bill** | A hidden cost from an earlier chapter arrives, flagged with a `# remember:` line. | The game is seen remembering. |
| **Meanwhile** | One thing each companion did off-screen for their own reasons, discovered, not announced. | Nobody waits for the protagonist. |
| **The turn** | The last scene ends on a line that changes what the chapter meant. | Leave on the snap. |

Across the game: Wren's hurt from the prologue (the cough, or the bad knee) is mentioned at least once per chapter until it heals or gets worse. What people call Wren changes with what Wren has done (see `story/VOICE.md`).

## Prologue — The Greywater (as built, 2026-11-18, after reader-panel round 3)

Missing by design: no fire scene, no nobody, no bill (nothing earlier to bill). Chapter 1 is the first full chapter.

```
ID:            ch00_s01_ford
Place:         The Greywater ford, near bank, night
Purpose:       Make the player like Aubric, and show what Wren is to him.
Present:       Wren, Aubric (drunk, mounted). Marrow across the river. Isolde asleep in the cart.
Wants:         Aubric — to arrive by sunrise for the bells. Marrow — to wait for morning. Wren — a bed.
Choice:        Drink with him / hand the skin back. (He gives Wren his gloves.) Then: take his bridle / shout for Marrow / say nothing.
Immediate:     None of it stops him.
Delayed:       DRANK → Marrow smells it (s04). AT_FORD → Marrow's regard (s04, s06).
Body:          Wet feet, tired.
Turn:          He rides in sitting very straight, in case anyone is watching.
Panel:         greywater_ford_night
```

```
ID:            ch00_s02_water
Place:         Mid-ford
Purpose:       The hero dies stupidly, and Wren is part of it either way.
Choice:        Go in after him / run for the rope.
Immediate:     In: he drags Wren under; Wren hits him to get free. Rope: the horse drags him out face down.
Delayed:       WENT_IN → the "hero" lie is believable or not (s05); Wren's hurt (cough / bad knee) from s07 on. In: the broken nose, which Marrow sees (s04).
Turn:          It took longer to get him out than it took him to die.
Panel:         greywater_water_churn
```

```
ID:            ch00_s03_bank
Place:         Near bank, the body
Purpose:       Wren's real first thought (wages), then the stakes (the letter, nine days).
Choice:        Take his purse / leave it. Then: hide the letter in your shirt / leave it on his belt.
Delayed:       PURSE → Marrow notices and takes his spurs (s06). LETTER → who holds the surrender.
Panel:         greywater_bank_body
```

```
ID:            ch00_s04_marrow
Place:         Near bank, lantern light
Purpose:       Marrow's want: not to hang. She offers the first lie.
Wants:         Marrow — a story in which the guide is blameless.
Choice:        Agree to the ambush story / refuse to lie / decide by dawn. (If Wren has the letter: show it / deny it.)
Delayed:       TOLD_MARROW vs. what Wren later tells Isolde → trust, and her price.
Panel:         greywater_marrow_wading
```

```
ID:            ch00_s05_dawn
Place:         By the cart, dawn
Purpose:       Isolde's want: a usable death. She makes the plan: he is "wounded", nine days under canvas.
Wants:         Isolde — to control the story before anyone else has one.
Choice:        Tell her the truth (and, if Wren went in: admit the elbow / leave it out) / Marrow's ambush / that he died saving you. Then: answer her plan (agree / ask what's in it for you / call it madness). Then: who carries the letter (or "the river took it").
Delayed:       VERSION → the ballad. LETTER = hidden → Isolde will forge or search.
Panel:         greywater_dawn_cart
```

```
ID:            ch00_s06_wrap
Place:         Near bank, morning
Purpose:       The title image: carrying him. Wren's excuse. The first bills arrive.
Choice:        THOUGHT — For the peace. / For him. / For what I'm owed. (SELF). Under review: readers found it abstract.
Immediate:     Remember-lines for the bridle, the purse, lying for one and not the other, dry to the knee.
Delayed:       SELF is quoted back whenever Wren acts against it.
Panel:         greywater_wrapping
```

```
ID:            ch00_s07_road
Place:         The road to Stint, full light
Purpose:       Set the company and the clock: eight days, three people, one corpse.
Body:          The cough, or the bad knee.
Turn:          Hoping he would enjoy the bells.
Panel:         road_to_stint_morning
```
