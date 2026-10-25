# Working method for AI sessions

This file is read by Claude (and any other AI tool) at the start of a session in this repo.

## Read first, in this order

1. `docs/ROADMAP.md` — find the current milestone and the smallest unfinished task.
2. `docs/VISION.md` and `docs/WRITING_GUIDE.md` — if the task touches story.
3. `docs/ART_PIPELINE.md` — if the task touches panels or prompts.
4. `docs/TECH.md` — if the task touches code.
5. `story/BEATS.md` and `story/VOICE.md` once they exist — before writing a single line of prose.

## Rules

- **Web first, Android last.** Do not add Capacitor, native plugins, or store assets before milestone M7.
- **One small, coherent task per session.** Finish it, verify it, commit it. Do not start a second thing because it is nearby.
- **Story clarity is a hard rule.** Every scene passes the four questions (where / who / what they want / why now) in its first three nodes. One new proper noun per scene.
- **Do not copy** Abercrombie's characters, factions, names, or mantras, nor anything from the previous project (Garren Vale, Red Hollow, Carrion Road). The checklist is in `docs/WRITING_GUIDE.md`.
- **Prose is human-led.** AI drafts are rewritten in the voice (`story/VOICE.md`) before commit.
- **No morality labels** anywhere in UI or data. No numbers shown to the player for Legend / Truth / Debt.
- **No text in artwork.** Ever.
- **No scope expansion** without adding a row to the decisions log in `docs/ROADMAP.md`.
- Keep `docs/ROADMAP.md` honest: tick a task only when its verification passed; move a milestone only when its exit test passed.

## Before implementing

Review the roadmap, the relevant docs, the current story data, and the playable build (`npm run dev` or the Pages link). Preserve unrelated working features.

## After implementing

- `npm run check` (typecheck, ink compile, story fuzz, panel coverage) must pass.
- If story data changed: play the changed scenes once in the browser.
- Commit with a message that names the roadmap task; push.
- Update `docs/ROADMAP.md` only when the task is truly complete.

## At handoff, report

What was completed, files changed, what was tested, whether GitHub is in sync, and the exact next recommended task from the roadmap.
