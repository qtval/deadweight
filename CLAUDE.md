# Working method for AI sessions

This file is read by Claude (and any other AI tool or model) at the start of a session in this repo. The repo is the only source of project state; do not rely on earlier chats.

## What we are making, in one line

A choice-driven visual novel that makes the player feel they are a small person living inside a First Law-like world: Wren, a dead hero's squire, telling it in the first person. Original world, people and phrases; nothing of Abercrombie's is copied. See "The experience we are building" in `docs/VISION.md`.

## Read first, in this order

1. `docs/ROADMAP.md` — the "Where we are" block at the top names the next task.
2. `story/VOICE.md`, then `story/ch00_greywater.ink` — the sound, and the worked example. Read both before writing or editing any prose.
3. `docs/VISION.md` and `docs/WRITING_GUIDE.md` — if the task touches story.
4. `story/BEATS.md` — what every chapter contains; the scene template is in the writing guide.
5. `docs/ART_PIPELINE.md` — if the task touches panels or prompts.
6. `docs/TECH.md` and `docs/TESTING.md` — if the task touches code or tests.

## The owner is not there to test

Treat every task as if the owner will not play, read or check the result. Nothing is "ready for your verdict". Before a task is called done, it is tested as far as it can be tested without him:

- Code and story logic: `npm test` (every path, browser playthroughs).
- Anything visual: open the screenshots and look at them.
- Any prose or story-structure change: the **blind reader panel** (`tests/reader-panel.md`, `docs/TESTING.md` layer 3). Fresh readers, at most three rounds, results in `reports/readers/`.
- Decide instead of asking, log the decision in `docs/ROADMAP.md`, and say plainly what failed or could not be tested. The owner can overrule anything afterwards; his word wins.

## Rules

- **Web first, Android last.** Do not add Capacitor, native plugins, or store assets before milestone M7.
- **One small, coherent task per session.** Finish it, verify it, commit it. Do not start a second thing because it is nearby.
- **Voice.** Narration is Wren, first person, past tense. Choice labels, recap, remember-lines and the journal address the player as "you". Match `story/VOICE.md`; when unsure, write less.
- **Story clarity is a hard rule.** Every scene passes the four questions (where / who / what they want / why now) in its first three nodes. One new proper noun per scene.
- **Every chapter ticks the checklist** in `story/BEATS.md` (body, nobody, temptation, fire scene, thought choice, bill, meanwhile, turn).
- **Do not copy** Abercrombie's characters, factions, names, or mantras, nor anything from the previous project (Garren Vale, Red Hollow, Carrion Road). The checklist is in `docs/WRITING_GUIDE.md`; the story test fails on the known ones.
- **Prose is drafted by AI and gated by the reader panel**; the owner edits when he chooses. Never "improve" a line the owner wrote without being asked.
- **No morality labels** anywhere in UI or data. No numbers shown to the player for Legend / Truth / Debt.
- **No text in artwork.** Ever.
- **No scope expansion** without adding a row to the decisions log in `docs/ROADMAP.md`.
- **Ask before** creating anything public or making an irreversible change.
- Keep `docs/ROADMAP.md` honest: tick a task only when its verification passed; move a milestone only when its exit test passed. Update the "Where we are" block in the same commit.

## The feel test (for any prose change)

Before committing, reread the changed scene and answer:

1. What does Wren want here that is not noble, and where is the excuse?
2. Where is the line in which what Wren thinks and what Wren says differ?
3. What does Wren's body feel?
4. Which option is the tempting, selfish one, and is it the most appealing label?
5. Does the joke (if any) come from a person in the scene, inside the worst moment?
6. Does the last line change what the scene meant?

If two answers are "nowhere", the scene is not done.

## Before implementing

Review the roadmap, the relevant docs, the current story data, and the playable build (`npm run dev` or the Pages link). Preserve unrelated working features.

## After implementing

- Prose or story structure changed: run the blind reader panel and record it. A failing panel is reported as failing.
- `npm test` must pass: ink compile, story test on every path (logic, clarity and voice checks), typecheck, build, browser playthroughs at phone size. Reports land in `reports/`.
- If story structure changed: update `tests/story-spec.mjs` and the routes in `tools/test-e2e.mjs` in the same commit.
- Look at two or three screenshots in `reports/screens/`.
- Commit with a message that names the roadmap task; push to `main` (CI redeploys the demo).
- Update `docs/ROADMAP.md` only when the task is truly complete.

## At handoff, report

What was completed, files changed, what was tested (including the reader-panel table and what still fails), whether GitHub is in sync, and the exact next recommended task from the roadmap.
