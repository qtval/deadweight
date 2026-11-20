# Testing

Every iteration ends with testing. Nothing is ticked on the roadmap, and nothing merges to `main`, until all three layers below pass. The automated layers run on every push (`.github/workflows/ci.yml`); their reports are attached to the CI run and summarised in the iteration handoff.

## Layer 1 — Story test (automated, every path)

`npm run test:story` → `reports/story-report.md`

Plays **every** route through the compiled ink, choice by choice, and checks it against `tests/story-spec.mjs`. The build refuses to run if it fails.

| Check | What it catches |
|---|---|
| No dead ends | A path that stops with no choices and no `# end:` tag |
| No ink runtime errors | Bad diverts, missing variables, broken conditionals |
| Every knot and stitch reachable | Content no player can ever see |
| Every choice option taken somewhere | An option that is shown but whose branch is dead |
| Required outcomes reachable | E.g. all 9 combinations of *what you told Isolde* × *where the letter is* |
| End-state invariants | Logic rules that must hold at every ending ("Marrow charges more only if she distrusts you") |
| Scene order | Scenes always move forward; no path jumps back |
| Remember lines earned | A "*Marrow remembers…*" line only fires when its cause happened, and every one fires on some path |
| One-way variables | The day counter never runs backwards |
| Panels | Every `# panel:` exists; no text appears before the first panel |
| Choice labels | ≤12 words, distinct within a choice |
| Proper nouns | Every name is in `story/GLOSSARY.json`; no scene introduces too many new names (the clarity rule) |
| Voice | Narration stays first person; no banned phrases (borrowed mantras and names, old-project names, stock phrases); a refrain is not over-used on any path |
| Recap and ballad | Both render correctly on every ending |

The report also gives **reading time** per playthrough, a **decision map** (every choice and how many paths take each option), and one **example route per outcome**.

When a chapter is added, its scenes, remember lines, outcomes and invariants are added to `tests/story-spec.mjs` in the same commit. A chapter without a spec is not done.

## Layer 2 — Browser playthroughs (automated)

`npm run test:e2e` (after `npm run build`) → `reports/e2e-report.md` + `reports/screens/`

Plays the real build in Chromium at **390×844** (a typical phone) by tapping, as a player would:

- Several complete routes chosen to cover different outcomes, asserting the ending, recap, ballad, journal, road and the specific remember-lines each route should trigger.
- **Save and resume**: play partway, reload, Continue, and land at the same decision.
- Layout: no horizontal overflow, tap targets ≥44px, one toast at a time, end screen covers the game.
- No console or page errors.
- Desktop: the game stays a phone-shaped column and keyboard controls work.
- Screenshots of the key screens, for review.

Add a route here whenever a new ending or major branch is added.

## Layer 3 — Blind reader panel (every prose change; the owner is assumed absent)

`npm run transcripts`, then `tests/reader-panel.md` → `reports/readers/<date>-<what>.md`

Layers 1 and 2 prove the story is wired correctly. This layer judges whether it reads: clarity, and the feel. Three fresh reader agents, who have seen no docs, source or earlier draft, each read one plain-text playthrough and answer a fixed questionnaire: a new player (clarity and pace), a First Law reader (feel and originality), a fiction editor (stock phrases and tics). Pass rules are in `tests/reader-panel.md`. At most three rounds per session; a failing result is reported as failing, with the open items listed, never rounded up.

The writer does not grade their own prose and does not brief the readers. Reader scores run generous; the comments matter more than the numbers. Fixes the readers ask for are made; tics they find become `voice.limits` in `tests/story-spec.mjs` so they stay fixed.

## Layer 4 — People (manual, per milestone)

The reader panel is a stand-in, not a replacement. When real players are available, at the end of each content milestone:

1. **Story-lock test** (see `docs/WRITING_GUIDE.md`): three players who haven't read the docs play the new chapters, then answer the five questions unprompted. Two of three must pass each one.
2. **Timing**: record time to finish; compare to the reading-time estimate in the story report.
3. **Choice interpretation**: for each major choice, ask what they thought they were risking. Mismatches are bugs.
4. Record results in `reports/playtests/<milestone>.md`.

## What each iteration's handoff includes

- Story report summary (paths, coverage, outcomes, failures).
- Browser report summary and two or three screenshots.
- Any new warnings, and what was done about them.
- The reader-panel table and its open items, whenever prose changed.
- Playtest notes, when a milestone ends.

## Screen tour (interface review)

`npm run tour` builds the game and saves a screenshot of every screen to `reports/screens/tour/`: title, first text, first choice, all four journal tabs, large text, a mid-prologue choice, the journal toasts, the prologue end card, the chapter 1 title card, chapter 1 choices, the demo end card and the title after a reload, then the title, a choice and the journal on a 320×568 phone, and a choice in landscape. Open and look at them after any interface change. First run 2026-11-20 found eight faults; see the decisions log.
