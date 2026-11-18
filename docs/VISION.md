# DEADWEIGHT — Vision & Story Bible

> **Working title.** "Deadweight" is provisional: it is the hero's corpse the player carries, and the player's own standing in a world that has no use for them. Rename freely; nothing else in the project depends on it.

## One line

The realm's one true hero dies stupidly, a day's ride from the end of his famous quest. You are his squire. Carry the body, the letter that ends the war, and the lie — home.

## What this is

A story-driven, choice-based visual novel for phones (built on the web first). Black-and-white (plus one amber accent for light), environment-first illustrated panels; concise first-person prose in Wren's voice; choices with a visible stake and a hidden bill that arrives later. A gritty, subversive low-fantasy in the *spirit* of Joe Abercrombie's First Law — no one is chosen, the wise are self-interested, victory is a cost, humor and horror share a sentence — without borrowing its specific characters, factions, or tics (see `docs/WRITING_GUIDE.md` for the do-not-copy list).

Target: **2–3 hours** for one playthrough, **6 chapters** (prologue + 5) of 20–30 minutes each, **5 endings** defined by what they cost rather than by win/lose, and enough branching that a second run reads differently.

## The experience we are building

The player should finish a chapter feeling they have *been* someone in this world, not read about them: a small, low-born person on a wet road, among people more dangerous and more charming than they are, making shabby choices they could defend to anyone but themselves, and laughing at things that are not funny. That is the feeling of reading a First Law book. We get there with our own world and people, by building these into every chapter:

1. **You are in Wren's head.** First-person narration with opinions, grudges and excuses. The gap between what Wren thinks and what Wren says is on the page.
2. **You choose the excuse as well as the act.** *Thought choices* are small acts that carry an excuse (what Wren does with the dead man's gloves); they let the player pick what Wren believes about themself. The game stores it and quotes it back when Wren acts against it.
3. **You like the people who will cost you.** One *fire scene* per chapter: a night with one companion, food, talk, no plot decision. Betrayal only hurts if there was a fire first.
4. **You are always in a body.** Cold, feet, weight, hunger. Wren carries one hurt out of the prologue for the rest of the game. Aubric rots on schedule, and every chapter opens with how he is doing.
5. **Nobody waits for you.** Each companion does something off-screen in every chapter, for their own reasons. Each chapter has one nobody with their own day who does not care about the war.
6. **You are what people call you.** Hardly anyone uses Wren's name. What they call you instead changes with what you have done. This replaces any reputation meter.
7. **Every choice tempts and every kindness bills.** One option is always the easy, selfish thing, and it is written to be wanted.

The craft rules behind these are in `docs/WRITING_GUIDE.md`; the sound is in `story/VOICE.md`; the per-chapter checklist is in `story/BEATS.md`.

## Design pillars

1. **Nobody is chosen.** The hero is dead on page one. The player is not secretly special. They matter because of what they carry, what they know, and what they are willing to say.
2. **Stories are weapons.** The ballad of what happened will outlive what happened. Who writes it, and what they leave out, is the real power in the game — not magic, not armies.
3. **Victory is a bill.** The war is already won when the game starts. The whole game is about who pays for the peace.
4. **Mercy charges interest.** Kindness, lies, and promises all come back, usually at a bad moment, and the game tells you when they do.
5. **Funny and horrifying in the same breath.** Never a joke to defuse tension; never horror without a human absurdity in it.
6. **Mystery without confusion.** The player may not know whom to trust. They must always know where they are, who is present, what each person wants, and why the decision cannot wait. (The previous project failed this test; it is a hard rule here.)

## Setting

**The Sallow Marches**, a wet, hilly border province of the **Kingdom of Ambre**. For ten years the Crown has fought the **Hollin Compact** — a league of hill towns that refused a salt tax, hanged the tax assessors, and found they had started a war of secession. Neither side is an empire. Neither side has a prophet. The Compact are stubborn farmers and quarrymen with good archers; the Crown's army is tired, unpaid, and commanded by a man who has made a career of the war.

Magic is almost gone and mostly fraud: hedge-saints, relic-sellers, a Church of the Hearth that needs miracles the way an army needs bread. One event in the game may or may not be genuinely miraculous; the game never says.

The physical world is the art: mud roads, drowned fords, gallows-woods, siege camps gone to seed, pilgrim chapels built on battlefields, and finally the stone capital, **Vellmouth**, where none of it feels real.

## The premise

**Sir Aubric Dane, called the Lantern** — the only knight anyone has a ballad about — was sent to negotiate the Compact's surrender, and did. He carries a sealed **Instrument of Surrender**, signed by the Compact council, which lapses in **nine days** unless it is countersigned by the Crown in Vellmouth.

On the way home, fording the Greywater at night, drunk, in full armor, he drowns.

His squire, **Wren**, pulls the body out. The letter is dry. Nobody else saw.

The game is the nine days between the Greywater and Vellmouth.

## Cast

Six speaking characters, deliberately few. Faces are rare in the art; everyone is seen at distance, from behind, in silhouette, or by what they leave in a room.

- **Wren (the player)** — Aubric's squire for six years; child of a camp laundress; can read, which is rare and the reason Aubric kept them. Not a fighter. Not clever enough to be safe, clever enough to be dangerous. *Recommendation (owner to decide): keep the name Wren and offer no pronoun choice. First-person narration never needs a pronoun, the other characters say "squire" or "you", and a named narrator with a past is what makes the voice work.*
- **Isolde Ferrant** — the chronicler the Crown attached to Aubric to write the ballad of the peace. Warm, quick, and entirely ruthless about the story. Her draft ballad is a real in-game document that changes with your choices. She is the game's "wise mentor" figure and she is not magic, not old, and not your friend; she is a career.
- **Marrow** — a Compact deserter turned road-guide, hired by Aubric for the crossing. Knows every ford and every grave. When she is violent it is fast, ugly, and over, and she does not enjoy it. She has her own reason to see the surrender delivered — or not.
- **Brother Tobin Ask** — itinerant friar of the Church of the Hearth who attaches himself to the party at the first town. Kind in the way of a man who has already decided what your body is worth. He wants Aubric's corpse for his chapel: a saint means pilgrims, and pilgrims mean a roof.
- **Lord-Marshal Severin Coste** — commander of the Crown's army in the Marches. He "won" the war and he needs the Lantern to ride into Vellmouth alive and grateful so the Marshal's version of events becomes the official one. A living hero is a rival. A dead one is an opportunity — if he controls the story.
- **Hesper Dane** — Aubric's wife, in Vellmouth. A brewer's daughter he married for money; she has run his estate and paid his debts for ten years while he was in ballads. She never liked him. She is the last person you have to lie to, or not.

Minor: **Ottil Rask**, the Compact's envoy riding behind the party to confirm the surrender arrives; a tollkeeper at Stint; a camp surgeon; two child scavengers who strip the battlefield in Chapter 2.

## Chapter outline

Each chapter is one primary location (cheap on art, strong on mood) and one dramatic question.

| # | Chapter | Place | Question | Key choice |
|---|---------|-------|----------|------------|
| 0 | **The Greywater** | A night ford | How did the Lantern die? | Which version of his death you tell Isolde and Marrow at dawn — and whether you tell them about the letter. |
| 1 | **Stint** | A tollhouse town | What is the story worth? | Tobin offers a roof and a reliquary; Coste's riders offer an escort "for the hero's safety." Taking either help puts the body in someone else's hands. |
| 2 | **The Hanging Wood** | A road through last year's battlefield | Who does the peace belong to? | Compact stragglers want the letter read aloud; Rask the envoy arrives; Marrow's past surfaces. The game's first real violence, and you decide whether it happens. |
| 3 | **Barrow Hill** | Coste's siege camp, rotting | What is the Lantern's successor? | Coste offers to make you the witness of a heroic death — or to bury the letter and end the war on his terms. The midpoint turn: the letter is now a threat to someone powerful. |
| 4 | **Saint Weir** | A pilgrim chapel on a drowned battlefield | What does a miracle cost? | The body "performs a miracle." Isolde's ballad is nearly finished; you decide what the legend becomes and whom it names. |
| 5 | **Vellmouth** | The capital | What survives? | Hesper, the court, the countersignature, and the final telling. Endings. |
| — | **Epilogue: The Ballad / The Account** | — | — | Two columns: the song Isolde publishes, and what actually happened. |

## Endings (by cost, not victory)

1. **The Lantern Lives** — You keep the lie whole. The peace holds. The ballad is beautiful. You are not in it.
2. **The Honest Squire** — You tell the truth to the one person it matters to. The peace may not survive it. Isolde is ruined; Hesper is free.
3. **Coste's Peace** — The letter is buried or sold. The war ends anyway, worse, with the Marshal as the Marches' master. You have a pension.
4. **Saint Aubric** — The Church gets the body and the miracle. The peace holds on a lie bigger than yours. The chapel gets its roof.
5. **Deadweight** — You walk away with nothing and no one, and life goes on, which is the point.

Variations within each: whether Marrow lives, whether Isolde's ballad names you, whether Rask gets home.

## Systems (what the choices touch)

No morality meter and no good/evil labels anywhere in the interface.

- **Three tracks, shown only as prose consequences, never as numbers:** **Legend** (how heroic the story of Aubric — and of you — is becoming), **Truth** (how much of what happened still survives in anyone's mouth), **Debt** (favors you owe and are owed).
- **Relationships** with Isolde, Marrow and Tobin: trust and fear, tracked separately.
- **The clock:** days left to Vellmouth. Some choices spend a day. Running out does not end the game; it changes who is waiting.
- **Thought choices:** a few times per chapter the player chooses what Wren tells themself (first: `SELF` in the prologue, set by what Wren does with Aubric's gloves: back on his hands / his hands folded like the songs / kept). No immediate effect; the narration throws it back later.
- **The body clock:** Aubric's state advances with the days and sets how hard the "wounded hero" lie is to keep. Wren's own hurt (the cough, or the bad knee, from the prologue) persists.
- **What they call you:** an epithet set by deeds, used by the road and by Marrow from about chapter 2.
- **Consequence memory:** every hidden cost surfaces within two chapters, and the game flags it in one line when it does ("Marrow remembers the ford."). Players must be able to *see* the game remembering.
- **The Ballad:** a living document in the pause menu, rewritten at each chapter break from the current state. In the epilogue it is shown beside The Account.
- **Saves:** automatic at every node, three manual slots, export/import.

## Alternative premises (if this one doesn't land)

Kept short so you can pick a direction rather than a draft.

- **The Tithe.** You are a Crown assessor sent to tax a valley that "won" the war. Everyone there is a hero; nobody can pay; the hero who saved them is the one who bankrupted them. A game about who gets the bill for a happy ending.
- **Second Son.** Your younger sibling was the prophesied one, and succeeded. The world is saved, broke, and embarrassed by them. You are sent to fetch them from the monastery where they have been politely hidden, and to decide what to do with a chosen one nobody needs.

Both keep the pillars; both are art-cheap; both avoid First Law's surface.

## Audience, tone, content

Adults. Themes of war, coercion, grief, religious fraud, and one on-screen killing per the chapter plan. No sexual violence. Dark humor is constant; cruelty is never played for fun. A content note ships with the game.
