# Art bible — style setup and rules

**Made with (22 Nov):** Gemini, from the scene prompts in `ch00.md`/`ch01.md`, with panel 1 (`assets/panels/greywater_ford_night.webp`) attached as the style reference. Warm sepia paper is part of the look. Add new panels with `python3 tools/panels/add.py <id>=<image>` (light touch only).

**Hand (decided 2026-11-22):** a field sketch in charcoal and ink on rough paper, as if drawn on the road by someone who was there: fast, smudged, unfinished, uneven pressure, construction lines left in, with the sample's own darkness and grey paper (the owner preferred it to a darker version). Each panel is a moment from Wren's eye. Style reference: `art/style/field-sketch-sample.jpg` (attach it to every request). Every result gets only the light palette step (`tools/process-panel.mjs`: amber kept only on light, levels, grain), not the heavier ink finish, so the look stays as in the sample. No signature scribbles.

**Look (decided 2026-10-25):** black-and-white ink and charcoal, with **one accent colour: amber**, used only for real light sources. The Lantern's light is the visual motif of the game: amber is warm and alive while he is; after the Greywater, it only comes from other people's lamps, fires and dawns.

## Rules for every panel

1. Black, white and greys only, **except light sources** (lanterns, fire, candles, a low sun), which glow amber and may cast a faint amber spill on nearby surfaces. Nothing else is amber: no clothing, no objects, no sky tint.
2. Environment is the subject. People are small, distant, silhouetted or seen from behind. **No visible faces.**
3. **No text** of any kind: no signs, letters, runes, banners, watermarks.
4. Tall portrait, 2:3. Keep everything important in the **central 80%**: the game crops the edges to fit phone screens.
5. Ink and charcoal, heavy grain, dry brush, cross-hatching, deep blacks. Not clean digital art, not photographic, not anime.
6. No fantasy glamour: no glowing armour, no magic effects, no dragons, no capes billowing heroically.

## Style setup message (paste first, once per ChatGPT chat)

```
I'm making illustrated panels for a grim, low-fantasy visual novel. Please keep ONE consistent style for every image I ask for in this chat:

STYLE: black-and-white ink and charcoal illustration, heavy paper grain, dry brush and cross-hatching, deep velvety blacks and paper whites. Grim medieval world, rain, mud, cold. Think of a skilled printmaker's woodcut-meets-charcoal look, not clean digital art, not photographic, not anime.

THE ONE COLOUR: the only colour allowed is warm amber, and only for real light sources (lanterns, fire, candles, a low sun) plus a faint glow they cast nearby. Everything else stays strictly black, white and grey.

ALWAYS: tall portrait 2:3. The place is the subject. Any people are small, distant, silhouetted or seen from behind, with no visible faces. Keep important things in the centre; the edges may be cropped.

NEVER: any text, letters, signs, runes or watermarks; visible faces; glowing armour or magic; colour other than amber light.

Reply "Ready" and wait. I'll send one scene per message; make exactly one image for each.
```

## Panel prompts

Per-chapter prompt files live next to this one (`ch00.md`, ...). Each prompt is self-contained so it also works in a fresh chat, but results are most consistent in one chat that started with the setup message.
