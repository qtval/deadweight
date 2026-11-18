# Writing Guide

How the prose, scenes and choices are written. This document exists because the previous project's story "did not make sense" to its own author; clarity is a hard rule here, not a polish task.

## Voice

- **First person, past tense: Wren telling it afterward.** Wren is a narrator with opinions, grudges and excuses, not a camera. The narration is allowed to be wrong about Wren; it is never wrong about facts the player needs. (Changed 2026-11-18 from close third; see the decisions log.) First person also keeps Wren nameable and ungendered without the prose dodging pronouns.
- **Choice labels, the recap, remember-lines and the journal stay in "you".** That is the game talking to the player; the prose is Wren talking.
- **Short sentences in action. Longer ones when someone is lying.** Characters reveal themselves by what they do while they talk.
- **Every character wants something in every scene**, and says something *else*. The gap is where the humor and the horror both live.
- **Humor is never relief.** A joke lands *inside* the dread, not after it. If a line could be cut without the scene getting darker, cut it.
- **No narrator sermons.** The game never tells the player what a choice meant. Consequences do that.
- **Concision.** A node is 40–120 words. A choice label is under 12 words and states the action, not the attitude ("Hand Tobin the letter", not "Trust the friar").

## What makes the voice work (the craft we take from First Law)

The first demo had the right plot and no vibe. These are the things that were missing. Every scene is checked against them.

1. **The narrator is compromised.** Wren wants things that are not noble: wages, a place, to be in the song, to go to bed. The first thought over the body is arithmetic, not grief. Each scene shows one self-serving motive and one excuse for it.
2. **The gap is on the page.** What Wren thinks and what Wren says are different lines, next to each other. "I would like to say…" followed by what actually happened.
3. **Build the legend before breaking it.** The player must enjoy Aubric for a minute, his warmth and his jokes, before he drowns. A hero nobody liked is not an undercut.
4. **Everyone is likeable and no one is safe.** Charm is a tool. Isolde is kind and it is for something. Marrow is honest and it is a price.
5. **The body is always there.** Cold, wet feet, weight, smell. Violence is clumsy and a little shameful for whoever did it.
6. **Jokes come from the people in the scene, inside the worst moment,** never from the narrator standing outside it.
7. **Every choice tempts.** At least one option in each choice is the easy, selfish thing, written so the player wants it. Complicity, not procedure.
8. **End the scene on the turn.** The last line of a scene changes what the scene meant.
9. **One refrain, ours, used sparingly.** Wren's is "Squires carry things": at most four times a chapter, meaning something different each time.

## What the reader panel taught us (2026-11-18)

Nine blind readers over three rounds (`reports/readers/2026-11-18-prologue.md`). These are now rules.

- **Show the warmth, don't report it.** "That was his gift" scored 3. The gloves and "How is her chest?" scored 4 from everyone.
- **Think the ugly thing and don't apologise.** Wren's worst thought goes on the page plain. No "I am not proud of that", no hindsight ("a long time since").
- **Say one line, think another, in the same breath**, at least twice a scene: `"He fell on the stones," I said. What I thought was: four times.`
- **Stay in the moment.** Wren is cold, frightened and in danger now. The telling-it-later frame is used at most twice a chapter.
- **Unbutton.** Not every paragraph ends on a turn. If three in a row do, flatten two. Save the turn for the scene's end.
- **Three kinds of wit.** Aubric boasts warmly. Marrow prices things. Isolde is gracious and exact. Wren's jokes are thought, rarely said. If a line could be moved to another mouth, rewrite it.
- **Explanation is an argument.** Anything the player must understand is fought over by two people who want different things, in plain words, with speaker tags. Never a briefing.
- **Honesty costs on the spot.** A truthful choice that everyone overrules reads as a choice that did not count.
- **Dirt.** Smell, mud, sick, blood, swearing. Clean prose reads young.
- **Check the ledger.** Every remember-line and every later reference must be true on the path that reaches it.

## Immersion devices (how the player ends up *in* it)

These are structural, and the beat sheet schedules them (`story/BEATS.md`).

- **Thought choices** (under review: readers found the first version abstract; see the reader report). The label is the thought itself ("For him."), or better, a small concrete act that carries the excuse. The options are excuses, not plot actions, and all of them are partly true. Two or three per chapter. Each sets a variable; a later scene quotes the chosen excuse in italics at the moment Wren acts against it. Never punish a thought choice; only remember it.
- **Fire scenes.** One per chapter, at night. The player picks one companion to sit with. 150–250 words, food or a small task, one confidence, one thing they want from Wren that is not the plot. No plot decision is made at a fire. Reuses the chapter's camp panel.
- **The body, twice.** (a) Every scene has one physical sensation of Wren's in its first three nodes. (b) Every chapter's first scene states Aubric's condition and what the lie now requires (more lavender, a closed cart, a story about the wound).
- **Names.** Characters address Wren as listed in `story/VOICE.md`. Using Wren's name is an event. No one refers to Wren in the third person with a pronoun; they say "the squire" or talk to Wren directly.
- **Meanwhile.** In each chapter, each companion has done one thing off-screen that Wren finds out about. The beat sheet has a line for it.
- **Nobodies.** One per chapter. They get a name only if they return.
- **Temptation.** In every plot choice one option is the comfortable, selfish one, and its label is the most appealing on the list.

## The clarity rules (non-negotiable)

Every scene must pass these within its first three nodes:

1. **Where** are we, physically, and what just changed?
2. **Who** is present?
3. **What** does each present character immediately want?
4. **Why now** — why can't this decision wait?

And across the game:

- **One new proper noun per scene, maximum.** Each must be tied to a person's need in the same scene it appears ("Rask — the Compact's envoy, riding to make sure the letter arrives, which means he'll want to see it").
- **The causal chain is always visible:** the letter → the countersignature → the peace → who loses if the peace holds. Any node that touches politics must be explicable by a first-time player in one sentence.
- **Every choice shows its known risk.** The later cost may be hidden; the immediate one is not.
- **The game shows itself remembering.** When a hidden cost surfaces, one italic line names the cause ("*Marrow remembers the ford.*").
- **Chapter recaps**: three lines at the top of each chapter, generated from state, saying what the player did, not what happened to them.
- **A Travelers screen** (cast cards: silhouette + two lines, updated as you learn things) and **a Road screen** (the route, days left) are always one tap away.

### The story-lock test

Before a chapter is locked, three people who have not read the docs play it. Each must be able to say, unprompted:

- What Wren is trying to do and why the deadline exists.
- What Isolde, Marrow and Tobin each want.
- How Aubric actually died, and which version Wren has told to whom.
- Who loses if the surrender is countersigned.
- What they knowingly risked in each major choice.

If two of three fail any item, the chapter is not locked.

## What we take from First Law (the spirit)

- No chosen one; competence is small and local.
- The mentor figure is on their own side.
- The quest is nearly pointless and the object of it is mundane.
- Victory arrives with a bill, and the bill is the story.
- Characters mostly do not change; when they do, it costs them.
- Endings are "life goes on", not resolution.
- Violence is fast, clumsy, unglamorous, and has consequences for the person who did it.
- Humor and horror in the same breath.

## What we do not copy (the surface)

A checklist. If a draft trips any of these, rewrite it.

- No torturer or interrogator point-of-view character, no crippled inquisitor.
- No berserker with a second self, no "the Bloody-Nine" style named rage.
- No vain duelist nobleman on a growth arc that resets.
- No ancient bald wizard mentor, no order of magi, no "First of the Magi".
- No two-empire war with an eastern prophet, no Union / Gurkhul analogue.
- No apocalyptic magic weapon used at the climax.
- No "Say one thing, do another" / "Back to the mud" / "You have to be realistic" style recurring mantra. If a character has a catchphrase, it is theirs, it is ours, and it is used fewer than five times.
- No character names, place names, or faction names lifted or lightly altered from Abercrombie (nor from the previous project: no Garren Vale, no Red Hollow, no Carrion Road).
- No cross-cutting POV chapters: this is a visual novel with one viewpoint.

## How AI is used in the writing

- Image generation is AI (see `docs/ART_PIPELINE.md`).
- Prose is drafted by AI to the owner's direction and gated by the blind reader panel (`docs/TESTING.md`, layer 3); the owner edits when he chooses. AI is also used as an editor, continuity checker, and sparring partner for choices and consequences. Reason: a consistent voice is the one thing a 3-hour VN cannot fake, and AI drafts drift. If AI drafts a node, it is rewritten in the voice before it is committed.
- `story/VOICE.md` holds the reference paragraphs and each character's way of talking. It is a draft until the owner approves it in M1. `tools/test-story.mjs` enforces the mechanical parts of the voice on every path: first person, banned phrases and names, refrain limits.

## Scene template (used in the beat sheet, `story/BEATS.md`)

```
ID:            ch02_s04
Place:         The Hanging Wood — the gibbet clearing, dusk
Purpose:       Make the peace feel physical: the Compact dead are still hanging.
Present:       Wren, Marrow, two child scavengers
Wants:         Marrow — to pass without stopping. Children — the boots.
Reveals:       Marrow knew one of the hanged.
Conceals:      Why she deserted.
Choice:        Let the children work / Pay them to leave / Cut the bodies down (spends an hour)
Immediate:     Cutting them down delays you; Marrow helps without a word.
Delayed:       Rask hears of it in ch03; Compact stragglers trust you more.
Branch:        → ch02_s05 (all), with flag HANGED_CUT_DOWN
Panel:         ch02_hangingwood_gibbets_dusk (reuse: ch02_hangingwood_road_dusk)
Wren changes:  First time Wren does something Aubric would not have.
Body:          Wren's cough; the smell from the cart reaches the clearing first.
Tells self:    (thought choice, if any) / (excuse quoted back, if any)
Turn:          The last line, and what it changes.
```
