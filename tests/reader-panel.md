# Blind reader panel

The stand-in for the owner's playtest. Run it whenever prose or story structure changes (see `docs/TESTING.md`, layer 3). The owner is assumed NOT to be available to test; this panel is the gate.

## How to run

1. `npm run transcripts` writes one playthrough per route to `reports/transcripts/`.
2. Start **three fresh reader agents** that have seen nothing of this project: no docs, no source, no chat history. Give each ONE transcript and the prompt below, with one persona each. They must not open any other file.
3. Collect the three answers into `reports/readers/<date>-<what>.md` with the score table and the changes made.
4. Apply the pass rules. If it fails, fix the prose and run again with **new** fresh readers (a reader who has seen an earlier draft is no longer blind). At most three rounds per session; if it still fails, stop and report what is failing.

The writer never grades their own work, and never tells a reader what the intended effect is.

## Personas

- **A — New player.** Plays story games on a phone. Has not read much fantasy. Reads once, at normal speed.
- **B — First Law reader.** Has read Joe Abercrombie's First Law books several times and knows them well. Hard to impress with imitations.
- **C — Fiction editor.** Edits commercial fiction for a living. Allergic to stock phrases, over-writing and prose that sounds machine-made.

## Reader prompt

```
You are a test reader. Persona: <PERSONA>.

Read exactly one file: <PATH>. It is a transcript of one playthrough of the opening chapter of a
text-based game: the story text, the choices the game offered, and the one that was chosen each time.
Do not open, search or read any other file or folder. Do not look anything up. You know nothing else
about this game, and that is intended.

Read it once, straight through, as a player would. Then answer honestly and specifically. Do not be
polite: an unearned good score is useless to the writer. Quote at most a few words when pointing at a line.

PART 1 — What happened (answer from memory, in your own words, one or two sentences each)
1. Who is the narrator, and what are they now trying to do? Is there a deadline, and why?
2. How did the knight actually die?
3. What does the guide want? What does the chronicler want?
4. What account of the death was given to whom in this playthrough, and who knows what about the letter?
5. Pick the two biggest choices. For each: what did you think you were risking?
6. Was anything confusing: a place, a person, a motive, a term? List each, or say "nothing".

PART 2 — Scores (1 = not at all, 5 = completely; one line of reason each)
a. I felt I was inside the narrator's head, a particular person, not a camera.
b. The narrator has selfish or shabby motives, and I still stayed with them.
c. I liked or enjoyed the knight before he died.
d. The other characters felt like people who want things for themselves.
e. I could feel the place and the narrator's body (cold, wet, weight, smell).
f. It was funny and grim at the same moment, and the jokes belonged to the scene.
g. At least one choice tempted me toward the selfish option.
h. Scenes ended on lines that landed.
i. I want to play the next chapter.

PART 3 — Persona questions
- If you are B: how close is the FEEL to a First Law book (1–5), and what is the biggest gap?
  Separately: does anything read as lifted from Abercrombie (a character type, name, phrase, mantra,
  plot beat)? List each, or say "nothing".
- If you are C: list every phrase that is stock, over-written, or sounds machine-made. Which
  paragraph would you cut first?
- If you are A: where, if anywhere, did you want to stop reading? Was it too long before the
  first choice, or between choices?

PART 4 — The three weakest lines or moments, and the three strongest. One line of reason each.

PART 5 — One sentence: what single change would improve it most?

Format your answer with exactly these headings: PART 1 … PART 5. In PART 2 give each score as
"a: 4 — reason".
```

## Pass rules

- **Clarity:** in PART 1, items 1–4 are answered correctly by at least two of three readers, and no confusion in item 6 is reported by two readers.
- **Feel:** each of a–i averages 4.0 or more across the three readers, and no single score is below 3.
- **First Law feel (reader B):** 4 or more.
- **Originality (reader B):** "nothing" lifted. Any item listed is fixed, whatever the scores.
- **Stock phrases (reader C):** every listed phrase is fixed or consciously kept with a reason in the report.

Scores from AI readers run generous. Treat a 4 as "fine", a 3 as "a problem", and the written comments as worth more than the numbers. The owner can overrule the panel at any time; his word wins.
