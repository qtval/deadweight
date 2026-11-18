# Technical Plan

**Web first, mobile last.** The game is a static web app until it is content-locked; then it is wrapped, unchanged, into native apps. Nothing mobile-specific is written before milestone M7.

## Stack

| Layer | Choice | Why |
|-------|--------|-----|
| Narrative | **ink** (inkle's scripting language), compiled with **inkjs** (v2.4+, includes a JavaScript compiler — no .NET needed) | Writer-friendly branching with variables, conditionals, tunnels, and tags. Battle-tested in *80 Days*, *Heaven's Vault*, *Sorcery!*. Replaces hand-written JSON node graphs, which are where the previous project spent most of its effort. |
| App | **Vite + TypeScript**, no UI framework | A visual novel reader is a few hundred lines: a panel, a text box, a choice list, a menu. A framework adds build weight and nothing else. TypeScript catches the save-format and tag-parsing bugs. |
| Styling | Plain CSS, custom properties, `prefers-reduced-motion` / `prefers-color-scheme` aware | Portrait-first layout; desktop simply shows the phone-shaped column centered. |
| Panels | `assets/panels/`, imported by Vite (WebP final, SVG placeholders now), lazy-loaded per chapter | Keeps the first load small; 180 panels at ~150 KB ≈ 27 MB total, loaded as needed. |
| Audio | Howler.js (or plain Web Audio) for ambient loops and stingers | Small, handles mobile autoplay rules. No voice acting. |
| Saves | `localStorage` behind a tiny storage interface; export/import as JSON | Same interface is swapped to Capacitor Preferences/Filesystem in M7 without touching game code. |
| Hosting (web) | **GitHub Pages** via Actions | Free, automatic on push to `main`. Playtesters get a link. |
| Mobile | **Capacitor 8** (Android first, iOS if the budget allows) | Wraps the built `dist/` as-is. Native plugins for haptics, status bar, safe areas, share, and secure storage. |
| CI | GitHub Actions: compile ink, typecheck, unit tests, **story reachability fuzz**, **panel coverage**, Playwright screenshots at 390×844, deploy | The two custom checks are what stop a 3-hour branching story from rotting. |

## Repository layout

This is the target layout. Today the reader is one file (`src/main.ts` + `src/style.css`); it is split into the modules below when chapter 1 is added (M2). `gen-panel.mjs` does not exist yet; panels are made in the ChatGPT app (see `docs/ART_PIPELINE.md`).

```
deadweight/
├── README.md
├── CLAUDE.md                 # working method for AI sessions (project memory)
├── docs/                     # VISION, WRITING_GUIDE, ART_PIPELINE, TECH, ROADMAP
├── story/
│   ├── main.ink              # includes the chapters
│   ├── ch00_greywater.ink … ch05_vellmouth.ink
│   ├── systems.ink           # variables, recap(), ballad()
│   ├── GLOSSARY.json         # every proper noun; the story test enforces it
│   ├── BEATS.md              # the beat sheet (one scene template per scene)
│   └── VOICE.md              # the voice: Wren, how each character talks, reference paragraphs
├── art/
│   ├── prompts/STYLE.md      # the locked base style string
│   ├── prompts/locations/    # one file per location
│   ├── SHOTLIST.csv
│   ├── LOG.csv               # provenance for every shipped panel
│   └── candidates/           # not committed (gitignored); curated picks move to public/
├── assets/
│   ├── panels/               # processed panels (SVG placeholders now, WebP later)
│   └── audio/
├── src/
│   ├── generated/            # story.json + story-stats.json, written by the tools (not hand-edited)
│   ├── main.ts               # boot, routing between title / game / menu
│   ├── reader.ts             # drives inkjs: continue, choices, tag handling
│   ├── tags.ts               # parses # panel: / # sfx: / # music: / # recap: / # remember:
│   ├── ui/                   # panel, textbox, choices, travelers screen, road screen, ballad
│   ├── save.ts               # storage interface + localStorage impl
│   └── ballad.ts             # renders Isolde's ballad from state
├── tools/
│   ├── compile-ink.mjs       # ink → src/generated/story.json
│   ├── test-story.mjs        # plays EVERY path; see docs/TESTING.md
│   ├── test-e2e.mjs          # browser playthroughs at phone size
│   ├── make-placeholders.py  # procedural placeholder panels
│   ├── gen-panel.mjs         # GPT-Image-2 API batch generation from SHOTLIST.csv
│   └── process-panel.mjs     # grayscale / levels / grain / resize / WebP
├── tests/story-spec.mjs      # what the story must do: scene order, outcomes, invariants, remember-lines
├── reports/                  # test reports (generated)
└── .github/workflows/        # ci.yml, pages.yml
```

## How ink carries the game

- **Panels, audio, and system events are ink tags**, so the writer controls presentation from the script:
  ```ink
  === ch02_s04 ===
  # panel: ch02_hangingwood_gibbets_dusk
  # ambient: wind_rope
  The road bent into the clearing and the rope-creak came before the sight did.
  * [Let the children work] -> ch02_s05
  * [Pay them to leave]      -> pay_children
  * [Cut the bodies down]    # day: -0.25
      ~ HANGED_CUT_DOWN = true
      -> cut_down
  ```
- **State lives in ink variables**: `LEGEND`, `TRUTH`, `DEBT`, `DAYS_LEFT`, `TRUST_ISOLDE`, `FEAR_MARROW`, flags per consequence. The app never mutates them directly; it only reads them for the Travelers/Road/Ballad screens.
- **Consequence memory** is an ink tag the writer places where a cost surfaces: `# remember: Marrow remembers the ford.` The reader shows it as the italic line.
- **Chapter recaps** are ink functions (`=== function recap_ch02 ===`) that emit three lines from state.
- **The Ballad** is an ink stitch per chapter that writes the verse from current flags; the app just renders what ink returns.
- **Saves** store the inkjs story state JSON plus a schema version; a migration table handles old saves after content changes.

## Testing

See `docs/TESTING.md`. In short: `tools/test-story.mjs` plays every path exhaustively (the prologue has 5184) and checks logic, reachability, consequences and writing rules; `tools/test-e2e.mjs` plays real routes in a phone-sized browser. If the full game's path count grows too large for exhaustive play, the story test switches to exhaustive-per-chapter (seeded from each chapter's possible entry states) plus random whole-game runs.

## Performance targets (web, mid-range Android phone in Chrome)

- First playable screen under 2 s on 4G; chapter 0 assets under 4 MB.
- Panel crossfade at 60 fps with `will-change` and no layout thrash.
- Works offline after first load (service worker, added in M6).

## Mobile (M7, not before)

- `npx cap init`, add Android; the web build is the app. Handle: safe-area insets, status-bar style, back button → menu, haptics on choice, app pause/resume with autosave, storage swap.
- Target Android 10+ (the floor Capacitor 8 supports is higher than the game needs; verify at M7).
- Store build: AAB, signed; closed test track first.
- iOS is the same codebase plus a Mac and a developer account; decide at M7.
