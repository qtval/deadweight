# Roadmap

Ten milestones. Each has an **exit test** — the milestone is done when the test passes, not when the tasks are ticked. Every milestone also has the same **testing gate** (`docs/TESTING.md`): story test green on every path, browser playthroughs green, reports in the handoff, and for content milestones a story-lock playtest with people. Durations are rough, for one person working part-time with AI tooling; they are there to spot drift, not to be hit.

Guiding rules (carried over from the previous project because they were right):
- World and consequence before dialogue polish.
- Choices, not morality points.
- Mystery without confusion (see `docs/WRITING_GUIDE.md`).
- Original work only.
- **Web first, Android last.** No mobile work before M7.
- No scope expansion without writing it down here first.
- **Every iteration ends with testing.** No task is ticked until `npm test` passes.

---

## M0 — Foundation (≈1 week)

Repo, tooling, and a reader that runs.

- [x] Planning docs: VISION, WRITING_GUIDE, ART_PIPELINE, TECH, ROADMAP, TESTING
- [ ] Decide title, protagonist name/pronoun approach (player-chosen recommended; the demo uses a fixed "Wren")
- [x] Vite + TypeScript project; `npm run dev` shows a title screen
- [x] inkjs + `tools/compile-ink.mjs`; the prologue demo plays end to end
- [x] Tag parser for `# panel:` `# title:` `# know:` `# remember:` `# end:`
- [x] Story test (`tools/test-story.mjs`) and browser test (`tools/test-e2e.mjs`)
- [x] GitHub Actions written: CI on every push; deploy to GitHub Pages on `main`
- [ ] GitHub repo created and pushed; CI green on GitHub; Pages link live
- [x] `CLAUDE.md` working method committed

**Exit test:** a stranger opens the Pages link on a phone and plays the prologue demo.

## M0.5 — Agreement demo (now)

A playable prologue to agree on tone, writing, UI, systems and testing before M1 commits to the full beat sheet.

- [x] Prologue "The Greywater" in ink: 7 scenes, 432 paths, 9 outcomes, 4 remember-lines
- [x] Reader: chapter card, panel crossfade, tap-to-continue, choices, journal (Travelers / Ballad / Road / Settings), autosave, end screen with recap and ballad
- [x] Procedural placeholder panels (stand-ins for GPT-Image-2 art)
- [x] Tests green: story 432/432 paths, browser 36/36 checks
- [ ] **Owner verdict** on: premise, tone and prose, UI, the journal and remember-lines, the art direction, and the testing reports

**Exit test:** the owner says "yes, build this" — or lists what to change, and the changes are made and re-tested.

## M1 — Story bible and beat sheet (≈2 weeks)

Everything the writing needs before writing.

- [ ] Lock the premise (or swap to an alternative from VISION)
- [ ] Cast sheet: each of the six characters — want, fear, secret, breaking point, how they talk, what they're doing in every chapter
- [ ] Location sheet: the ~15 locations with fixed descriptions (feeds both prose and art)
- [ ] `story/VOICE.md`: 10 reference paragraphs
- [ ] `story/BEATS.md`: every scene of all six chapters in the scene template; 15–20 scenes per chapter
- [ ] The five endings mapped back to flags; every ending reachable on paper
- [ ] Consequence table: each hidden cost, where it is set, where it surfaces (≤2 chapters later), the `# remember:` line
- [ ] Ballad verses outlined per chapter per major branch

**Exit test:** two readers of BEATS.md (not the docs) can pass the story-lock test from the beat sheet alone.

## M2 — Prologue and Chapter 1 playable, text only (≈2 weeks)

- [ ] ch00 and ch01 written in ink to the beat sheet
- [ ] Systems: variables, relationship functions, day clock, recap function, Ballad stitch for ch0–1
- [ ] Reader UI: textbox, choices, autosave, manual saves, Travelers screen, Road screen, Ballad screen, settings (text size, reduced motion, dyslexia-friendly font)
- [ ] `fuzz-story` in CI, green
- [ ] Grey placeholder panels with the panel ID printed on them

**Exit test:** three outside players finish ch0–1 in 40–60 minutes on a phone and pass the story-lock test for those chapters.

## M3 — Art pipeline proven on Chapter 1 (≈2 weeks)

- [ ] Lock `art/prompts/STYLE.md` after a 12-image comparison sheet
- [ ] Location prompts for ch0–1 locations (Greywater, the road, Stint)
- [ ] `gen-panel.mjs` (API) and `process-panel.mjs` working; `check-panels` in CI
- [ ] ~40 processed panels placed for ch0–1
- [ ] Panel crossfade, subtle pan, blurred placeholder loading
- [ ] `art/LOG.csv` started

**Exit test:** ch0–1 played with final-quality art; a side-by-side of all ~40 panels reads as one artist's work.

## M4 — Chapters 2–3 (≈3 weeks)

- [ ] ch02 (Hanging Wood) and ch03 (Barrow Hill) written and implemented; midpoint turn works
- [ ] Panels for ch2–3 (~70)
- [ ] First audio: 6–8 ambient loops, a handful of stingers; captions for audio in settings
- [ ] Save migration table in place; old saves survive content changes

**Exit test:** outside players reach the end of ch3 and can explain, unprompted, why the letter is now dangerous to Coste.

## M5 — Chapters 4–5 and endings (≈3 weeks)

- [ ] ch04 (Saint Weir) and ch05 (Vellmouth); all five endings and their variations
- [ ] Epilogue: Ballad vs Account, two-column layout
- [ ] Panels for ch4–5 and endings (~70); all ~180 placed
- [ ] Full-run fuzz: every ending reached by the fuzzer; no unreachable knots

**Exit test:** two full playthroughs by outside players end in different endings and both players can say what they paid for theirs.

## M6 — Content lock and polish (≈3 weeks)

- [ ] Full read-through edit pass against VOICE.md; cut 10%
- [ ] Second-run rewards: at least 20 lines that change on a repeat play
- [ ] Music: title, two travel themes, ending; adaptive by chapter only (no dynamic mixing)
- [ ] Service worker for offline play; performance targets met
- [ ] Accessibility pass: contrast, font scaling, screen-reader labels, reduced motion
- [ ] External beta: 8–10 players, feedback form, fix release blockers
- [ ] Content note, credits (including AI disclosure), license files
- [ ] **Content lock** — after this, only bug fixes

**Exit test:** beta players' median completion 2–3 hours; no story-lock failures; zero known dead ends.

## M7 — Android (≈2 weeks)

- [ ] Capacitor 8 init; Android project; safe areas, status bar, back button, haptics, pause/resume autosave
- [ ] Storage interface swapped to native; saves verified across app updates
- [ ] Device matrix: three real phones (small / mid / large), one tablet
- [ ] Signed AAB; Play Console closed test track; privacy policy page; store listing assets (screenshots are game panels + UI, no text in art)

**Exit test:** closed testers install from Play, finish the game, and their saves survive one update.

## M8 — Launch (≈2 weeks)

- [ ] Monetization decision (recommended: free prologue + one-time unlock, or paid app; **no ads**)
- [ ] Web demo (ch0–1) on itch.io linking to the store
- [ ] Open test → production; iOS go/no-go
- [ ] Post-launch: crash monitoring, one patch window scheduled

**Exit test:** it is in the store and strangers are finishing it.

---

## Explicitly deferred (not in 1.0)

Combat systems, inventory, character creator beyond name/pronouns, voice acting, color art, multiple protagonists, cloud saves, achievements platforms, localization (plan for it: keep strings in ink, no text in art — but don't do it), iOS before Android proves out.

## Decisions log

| Date | Decision | Why |
|------|----------|-----|
| 2026-10-25 | Fresh start; the Ashen Oath repos are reference only | Its story did not hold together for its author |
| 2026-10-25 | B&W environment-first art, faces rare | Plays to AI image gen's strength; avoids face consistency |
| 2026-10-25 | Tight scope: 2–3 h, 6 chapters, 5 endings, ~180 panels | Finishable by one person |
| 2026-10-25 | Web (Vite + TS) + ink/inkjs + Capacitor 8 | Writer-friendly story format; web build wraps unchanged |
| 2026-10-25 | GPT-Image-2 for panels, hand-curated, uniformly post-processed | Consistency comes from the processing step and fixed location prompts |
