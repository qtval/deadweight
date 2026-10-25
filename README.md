# DEADWEIGHT

*Working title.*

A grim, choice-driven low-fantasy visual novel for phones, built on the web first.

> The realm's one true hero dies stupidly, a day's ride from the end of his famous quest. You are his squire. Carry the body, the letter that ends the war, and the lie — home.

Black-and-white, environment-first illustrated panels. Concise prose. Choices with a visible stake and a hidden bill. No chosen ones, no morality meter, five endings defined by what they cost.

## Status

**Agreement demo (M0.5).** The prologue, *The Greywater*, is playable end to end with placeholder art: 7 scenes, 432 paths, 9 outcomes, all tested. Start with the docs:

| Doc | What it is |
|-----|-----------|
| [`docs/VISION.md`](docs/VISION.md) | Pillars, setting, premise, cast, chapter outline, endings, systems |
| [`docs/WRITING_GUIDE.md`](docs/WRITING_GUIDE.md) | Voice, the clarity rules, what we take from First Law and what we never copy |
| [`docs/ART_PIPELINE.md`](docs/ART_PIPELINE.md) | The GPT-Image-2 → curate → process pipeline for ~180 B&W panels |
| [`docs/TECH.md`](docs/TECH.md) | Vite + TypeScript + ink/inkjs now, Capacitor 8 at the end; repo layout; CI checks |
| [`docs/TESTING.md`](docs/TESTING.md) | The three testing layers every iteration ends with |
| [`docs/ROADMAP.md`](docs/ROADMAP.md) | M0–M8 with exit tests; decisions log |

## Plan in one paragraph

Write the whole game as a beat sheet before writing prose (M1). Make the prologue and chapter 1 playable with placeholder art and prove the story-lock test with outside players (M2). Prove the art pipeline on those same chapters (M3). Then chapters 2–3 (M4), 4–5 and endings (M5), polish and content lock with an external beta (M6). Only then wrap the finished web game with Capacitor for Android (M7) and launch (M8).

## Running it

```
npm install
npm run dev          # play locally (compiles the ink first)
npm run test:story   # play every path through the story; report in reports/story-report.md
npm run build        # story test + typecheck + production build (fails if the story test fails)
npm test             # build + browser playthroughs at phone size; report in reports/e2e-report.md
```

## Rights

Code: MIT (see `LICENSE-CODE.md`, to be added). Story, characters, setting, and all artwork and audio: all rights reserved by the project owner (see `LICENSE-ASSETS.md`, to be added). Illustrations are generated with OpenAI GPT-Image-2 and hand-processed; provenance for every shipped panel is kept in `art/LOG.csv`.

## Content note

Intended for adults. Themes of war, coercion, grief, and religious fraud; one on-screen killing per the chapter plan; dark humor throughout. No sexual violence.
