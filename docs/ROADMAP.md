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

## Where we are (updated 2026-11-18, night, after round 18)

**The demo (the prologue):** every automated test passes (108,864 paths; browser playthroughs). Wren has a want of their own (the promise), and the dawn scene now has a choice under Marrow's knife while Isolde prices Wren's death.

**Reader panel:** round 16 met **every** written rule for the first time, including the First Law reader's 4. Rounds 17 and 18 did not repeat it (First Law 3 and 3). The nine feel criteria have passed in seven of the last nine rounds. So the pass is real but not stable, and **the M0.5 box stays unticked** (`reports/readers/2026-11-18-prologue-rounds-16-18.md`).

**Next task (one session): the voice pass on the prologue.** The First Law readers' three standing complaints are about manner across the whole chapter, not one scene: (1) Marrow, Isolde and the narration share one dry wit: give each the sound `story/CAST.md` specifies; (2) nearly every paragraph ends on a one-liner: end two in three flat; (3) fear does not last: the knife at dawn must mark Wren for the rest of the chapter (flinch at Marrow, cannot sit near Isolde). Also from the new players: say the deadline once in Wren's own plain words. Then three panel rounds. Pass twice running before ticking M0.5.

**After that:** chapter 1 scenes 1–3, third round, carrying the promise, the knife and these rules across.

**One chat at a time:** `docs/IN_PROGRESS.md` is the lock. Read it first.

**Done since (2026-11-18, evening):** the chapter 1 beat sheet, in its third draft after three blind readers (`story/BEATS.md`, `reports/readers/2026-11-18-ch01-beats.md`): eleven scenes, Corporal Dobb and Aubric's own escort, one inspection, and somebody hurt in Stint on every path. The first three scenes are written (`story/ch01_stint.ink`) and have had two panel rounds (`reports/readers/2026-11-18-ch01-opening.md`): seven of nine pass; temptation and fear for the narrator do not; First Law feel 3 of 5. The same reader now gives the prologue 4 of 5. Chapter 1 is **not linked into the playable demo yet**: the story test plays every path, and it needs a per-chapter mode first.

**What the two rounds settled about method:** plain paragraph endings alone make Wren a camera. Keep the endings plain and keep Wren's sour, bodily, self-serving thought under every act. That is now in `docs/WRITING_GUIDE.md`.

**Next tasks, in order:**
1. Chapter 1 scenes 1–3, round 3: work through "Still open" in the opening report (Dobb reaches for the feet on the bridge and Wren has to stop him; a selfish option at the toll; the Marshal's sergeant seen from the bridge; let one excuse stand uncaught; carry the nose, the ear, the purse and the gloves across from the prologue). Fresh panel.
2. Per-chapter story test (`docs/TECH.md`): seed chapter 1 from the prologue's possible end states, so chapter 1 can be linked into the demo without multiplying 108,864 paths. Then link it, add placeholder panels, and extend the browser test.
3. Write scenes 4–12 of chapter 1 to the third-draft beat sheet, a few scenes at a time, each batch through the panel.
4. Panels for the prologue: check for a `panels/ch00` branch or pull request from the Codex trial (`AGENTS.md`).
5. Owner, whenever he likes: whether the demo is good enough for him as it stands; title; the fixed name Wren; the inventions listed in the cast sheet and at the foot of the chapter 1 beat sheet.

---

## M0 — Foundation (≈1 week)

Repo, tooling, and a reader that runs.

- [x] Planning docs: VISION, WRITING_GUIDE, ART_PIPELINE, TECH, ROADMAP, TESTING
- [ ] Decide title, protagonist name/pronoun approach (now recommended: fixed name Wren, no pronoun choice, since first person never needs one)
- [x] Vite + TypeScript project; `npm run dev` shows a title screen
- [x] inkjs + `tools/compile-ink.mjs`; the prologue demo plays end to end
- [x] Tag parser for `# panel:` `# title:` `# know:` `# remember:` `# end:`
- [x] Story test (`tools/test-story.mjs`) and browser test (`tools/test-e2e.mjs`)
- [x] GitHub Actions written: CI on every push; deploy to GitHub Pages on `main`
- [x] GitHub repo created and pushed; CI green on GitHub; Pages link live: https://qtval.github.io/deadweight/
- [x] `CLAUDE.md` working method committed

**Exit test:** a stranger opens the Pages link on a phone and plays the prologue demo.

## M0.5 — Agreement demo (now)

A playable prologue to agree on tone, writing, UI, systems and testing before M1 commits to the full beat sheet.

- [x] Prologue "The Greywater" in ink: 7 scenes, 108,864 paths, 9 outcomes, 9 remember-lines
- [x] Prologue rewritten for voice (2026-11-18): first-person Wren, two new choices (the wine, the purse); craft rules added to WRITING_GUIDE
- [x] Reader: chapter card, panel crossfade, tap-to-continue, choices, journal (Travelers / Ballad / Road / Settings), autosave, end screen with recap and ballad
- [x] Procedural placeholder panels (stand-ins for GPT-Image-2 art)
- [x] Art direction revised: B&W ink + amber light accent; prompt pack for the 7 prologue panels; `process-panel.mjs` palette/levels/grain pipeline
- [ ] 7 prologue panels generated in ChatGPT, processed and in the game
- [x] Groundwork for the feel (2026-11-18): the experience target in VISION, immersion devices in WRITING_GUIDE, draft `story/VOICE.md`, chapter checklist in `story/BEATS.md`, first thought choice (`SELF`) and Wren's hurt in the prologue, voice check in the story test
- [x] Blind reader panel built (`tests/reader-panel.md`, `npm run transcripts`) and run for six rounds on the prologue
- [ ] Reader panel passes on the prologue (round 9: 8 of 9 criteria pass; temptation 3.67; First Law feel 3/5, unchanged since round 6)
- [x] Tests green: story 108,864/108,864 paths, browser 38/38 checks
- [ ] Owner verdict, if and when he gives one (no longer the gate)

**Exit test:** the blind reader panel passes on the prologue, with the tests green. The owner may overrule either way.

## M1 — Story bible and beat sheet (≈2 weeks)

Everything the writing needs before writing.

- [ ] Lock the premise (or swap to an alternative from VISION)
- [x] Cast sheet (`story/CAST.md`, 2026-11-18): each of the six — want, fear, secret, breaking point, how they talk, what they're doing in every chapter. Blind voice test passed 10/10 ×3. Draft until the owner locks it
- [ ] Location sheet: the ~15 locations with fixed descriptions (feeds both prose and art)
- [ ] `story/VOICE.md`: owner edits and approves the draft; add one paragraph per speaking character once the cast sheet is locked
- [ ] `story/BEATS.md`: every scene of all six chapters in the scene template; 15–20 scenes per chapter; each chapter ticks the checklist at the top of that file (body, nobody, temptation, fire scene, thought choice, bill, meanwhile, turn)
- [ ] Thought-choice map: each excuse, where it is chosen, where it is quoted back
- [ ] Body clock: Aubric's condition per day, and what the lie needs each day; Wren's hurt per chapter
- [ ] What people call Wren: the epithets, and which deeds earn which
- [ ] The five endings mapped back to flags; every ending reachable on paper
- [ ] Consequence table: each hidden cost, where it is set, where it surfaces (≤2 chapters later), the `# remember:` line
- [ ] Ballad verses outlined per chapter per major branch

**Exit test:** two readers of BEATS.md (not the docs) can pass the story-lock test from the beat sheet alone.

## M2 — Prologue and Chapter 1 playable, text only (≈2 weeks)

- [ ] ch00 and ch01 written in ink to the beat sheet
- [ ] Systems: variables, relationship functions, day clock, recap function, Ballad stitch for ch0–1; thought-choice call-backs; fire-scene picker; epithet function
- [ ] Reader UI: textbox, choices, autosave, manual saves, Travelers screen, Road screen, Ballad screen, settings (text size, reduced motion, dyslexia-friendly font)
- [ ] `fuzz-story` in CI, green
- [ ] Grey placeholder panels with the panel ID printed on them

**Exit test:** three outside players finish ch0–1 in 40–60 minutes on a phone and pass the story-lock test for those chapters.

## M3 — Art pipeline proven on Chapter 1 (≈2 weeks)

- [ ] Lock `art/prompts/STYLE.md` after a 12-image comparison sheet
- [ ] Location prompts for ch0–1 locations (Greywater, the road, Stint)
- [ ] `process-panel.mjs` working on real panels from the ChatGPT app; `check-panels` in CI (`gen-panel.mjs` via the API only if volume demands it)
- [ ] ~40 processed panels placed for ch0–1
- [ ] Panel crossfade, subtle pan, blurred placeholder loading
- [ ] `art/LOG.csv` started

**Exit test:** ch0–1 played with final-quality art; a side-by-side of all ~40 panels reads as one artist's work.

## M4 — Chapters 2–3 (≈3 weeks)

- [ ] ch02 (Hanging Wood) and ch03 (Barrow Hill) written and implemented; midpoint turn works
- [ ] Panels for ch2–3 (~70)
- [ ] First audio: 6–8 ambient loops, a handful of stingers; captions for audio in settings
- [ ] Save migration table in place; old saves survive content changes

**Exit test:** outside players reach the end of ch3 and can explain, unprompted, why the letter is now dangerous to Sayle.

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
| 2026-10-25 | Repo public at qtval/deadweight; Claude GitHub app on all repos | Free Pages demo link; any new repo works with no extra setup |
| 2026-10-25 | Art: B&W ink plus amber for light sources only | Owner found pure B&W placeholders too dull; amber gives the Lantern a visual motif |
| 2026-10-25 | Panels made in the ChatGPT app from a prompt pack, saved to Pictures\\Deadweight, processed by Claude | Owner's choice: uses the existing subscription; API stays the fallback for volume |
| 2026-11-18 | Narration changed from close third to first-person Wren, past tense; UI text stays "you" | Owner: the demo lacked the First Law feel. A compromised narrator's voice is the core of it, and third person without pronouns read flat |
| 2026-11-18 | Prologue gains two choices (drink with Aubric; take his purse); wall-of-text limit raised from 260 to 300 words | Choices that tempt and make the player complicit; the voice needs slightly more room |
| 2026-11-18 | The target is stated as an experience: the player feels they are a person inside a First Law-like world (original world and people) | Owner's direction |
| 2026-11-18 | Immersion devices adopted for every chapter: thought choices, one fire scene, the body clock and Wren's hurt, epithets instead of a reputation meter, "meanwhile" beats, one nobody. Inside the existing word budget, no new art | These are what the feel is made of; owner may veto any at the M0.5 verdict |
| 2026-11-18 | Recommended: fixed name Wren, no pronoun choice (owner still to confirm) | First person removes the need; a named narrator carries the voice |
| 2026-11-18 | Story test gains a voice check (first person, banned phrases and names, refrain limits) | Keeps the voice from drifting between sessions and models |
| 2026-11-18 | Trial: panels generated by a Codex task on the owner's ChatGPT Plus allowance, into `art/incoming/` via pull request (`AGENTS.md`) | Owner wants minimum manual work; this is OpenAI's supported agent, unlike automating the ChatGPT app. Adopt only after a successful first run |
| 2026-11-18 | Every task is tested as if the owner is absent. A blind reader panel (three fresh AI readers, fixed questionnaire, pass rules) gates all prose; M0.5's exit test is now the panel, not the owner's verdict | Owner's instruction: "treat every task like I am not there to test it" |
| 2026-11-18 | Prologue grew to 13 decision points (answer Isolde's plan; admit or hide the elbow) and about 12 minutes | Reader findings: the player watched the plan being made, and the worst act was taken out of their hands |
| 2026-11-18 | Wren's hurt on the rope route is a bad knee, not raw hands | Wren is wearing Aubric's gloves |
| 2026-11-18 | Thought choices are acts that carry the excuse (first: what Wren does with Aubric's gloves), not "tell yourself" labels | Readers in two rounds found the labelled version abstract; none objected to the act |
| 2026-11-18 | Prologue parked at 8 of 9 after six panel rounds; M1 cast sheet goes first | The remaining objections (distinct voices, a named antagonist, room) cannot be fixed inside the prologue |
| 2026-11-18 | Agreeing to Isolde's plan gives Wren Aubric's signet (`RING`); objecting puts Wren under the canvas with the body | Every answer to the plan now has a visible result |
| 2026-11-18 | The named antagonist is Marshal Sayle himself, not a new man at court. In game text he is "Marshal Sayle"; the "Lord-" is dropped | Keeps the cast at six. "Lord Marshal" is a First Law title |
| 2026-11-18 | Cast spine: six creditors of a dead man's spoken promises, each trying to get it in writing | Gives every character a want of the same shape as Wren's, and makes the letter the one promise he kept |
| 2026-11-18 | The lantern night: Sayle held the light, Aubric got the song, Isolde wrote it, Hesper paid for the cut verse | Gives Sayle a petty, human motive and makes the legend a lie before the game begins. Uses the "third verse" already in the prologue |
| 2026-11-18 | Wren has written Aubric's letters for six years, in his hand; Hesper has known | A reason for Sayle's threat ("your squire reads"), a skill that matters when the letter is in doubt, and a payoff in chapter 5 |
| 2026-11-18 | Marrow sold the Hanging Wood to Sayle's quartermaster; Isolde was awake at the ford; Tobin knows the Lantern is dead from Stint | Secrets required by the cast sheet. Each is revealed no earlier than the chapter named there |
| 2026-11-18 | Blind voice test added (`tests/voice-test.md`) as the gate for the cast sheet. The one-line prologue change was checked by a single clarity reader, not the full panel | The full panel is scheduled with the prologue voice pass; running it for one passage would repeat a known fail |
| 2026-11-18 | Owner: finish the demo before the chapter 1 beat sheet. Prologue voice pass done and put to three more panel rounds (7–9) | Owner's instruction |
| 2026-11-18 | The Marshal is renamed Sayle (was Coste) | The First Law reader in round 7: "Coste" is too near "Cosca" for a scheming military man. The panel rule is that anything listed as lifted is fixed |
| 2026-11-18 | The ford choice now stakes Wren's pay and the promised room; Aubric's escort is a day ahead in Stint; the King is not mentioned in the prologue (the council signs) | Readers found the ford choice foregone, the missing escort odd, and "council or King" confusing |
| 2026-11-18 | Refusing Marrow at the body costs Wren a notched ear, and she then tells Isolde her version | Readers in rounds 7–8: no real menace; honest choices are free |
| 2026-11-18 | "Squires carry things" is used once in the prologue, not twice. "Lantern" counts as a name for Aubric in the proper-noun check | A reader heard the refrain as an imitation of Abercrombie's mantras. The epithet is the same person, and counting it twice left no room to name Stint in scene 1 |
| 2026-11-18 | Wall-of-text limit raised from 300 to 340 words between choices | Room for Wren's commentary and for fear to last. The new-player reader still flags the bank and the dawn scene as long; do not raise it again |
| 2026-11-18 | Chapter 1 is eleven scenes; it opens with the armour coming off in a wood; Aubric's own escort under Corporal Dobb is in Stint; the forged letter moves to chapter 2 | Three blind readers of the beat sheet: it contradicted the prologue, spent its clock twice, and hurt nobody |
| 2026-11-18 | Drafting rule: paragraphs end plainly, and Wren's sour, bodily thought runs under every act, in contractions; big moments are played, not summarised | Round 1 of the chapter 1 panel: plain rules alone turned the narrator into a camera |
| 2026-11-18 | A lock file, `docs/IN_PROGRESS.md`: one chat works on the repo at a time | Two chats did the same task at once on 2026-11-18 |
| 2026-11-18 | Prologue: decent choices now cost on the page (Marrow takes the purse Wren leaves; the truth is paid for by rehearsing the lie); the rope is thrown and fails | Readers: decent choices were free, and nobody tried anything and failed |
| 2026-11-18 | Wren's own want is the promise: the room and six years' wages, written out by Wren in Aubric's hand, wanting his name. New last choice in the prologue: forge it on the road or wait (`DEED`) | Owner asked for the necessary changes after twelve rounds; the First Law readers said Wren wanted nothing. Owner may strike it |
| 2026-11-18 | Isolde prices Wren's death in the dawn scene (silver on the breastplate) | Readers: nobody frightened them; a threat must be done, not said |
| 2026-11-18 | Three more prologue rounds (13–15) in the same day, beyond the three-per-session limit | A new task from the owner, with a story change to test |
| 2026-11-18 | Dawn scene reworked: Isolde is wrong before she is clever; new choice under the knife (`SOLD`: hand / face / begged) | Owner: make the demo pass all rules. First Law readers: the plan was handed over, and nobody was frightening |
| 2026-11-18 | M0.5 is ticked only after the panel passes every rule two rounds running | Round 16 passed and rounds 17–18 did not; one pass in three is luck, not a result |
