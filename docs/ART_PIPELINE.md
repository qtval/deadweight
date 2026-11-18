# Art Pipeline — GPT image generation for B&W environment-first panels

The art is the most expensive thing in the game by volume and the easiest thing to get wrong by consistency. This pipeline is designed around what AI image generation does well (mood, places, weather, texture) and away from what it does badly (the same face, twice).

## The look

- **Full-screen portrait panels**, one clean image per story beat. Generated at the model's portrait size, delivered at **1080×1920** (9:16) with a **3:4 safe area** in the center so phones with other ratios and the desktop window crop, not stretch.
- **Black and white plus one amber accent.** Ink, charcoal, dry brush, cross-hatching, heavy grain, deep blacks. The only colour is amber, and only for real light sources (lanterns, fire, a low sun) and the faint glow they cast. The Lantern's light is the visual motif: amber is alive while he is; after the Greywater it only comes from other people's lamps and dawns. Each chapter's prompt file states its "amber arc".
- **Environment-first.** The place is the subject: rain, fog, mud, smoke, worn timber, drowned stone, severe architecture. Where people appear they are **small (under ~15% of frame), distant, silhouetted, from behind, or cropped** — a hand, a boot, a shape under a cloak.
- **Faces are rare.** A face may appear at most once per chapter, never the player's, and never clearly enough to need to match a previous one.
- **No text of any kind** in images. No signs, no runes, no lettering, no UI. (Say it twice in every prompt; GPT-Image-2 is *good* at text, which is the problem.)
- **The body is always present** in chapters 0–4, usually wrapped, on a cart, over a saddle, on a bier. It is the game's one recurring "character" the art must show, and it is a shape, which is why this works.

## Volume and budget

Tight scope: ~**180 delivered panels**.

- ~**15 locations** × 3–5 variants (time of day, weather, approach/leave) ≈ **60 reusable location panels**.
- ~**120 unique beat panels** for specific moments.
- Generate **3 candidates per panel** on average → ~**550 generations**. At GPT-Image-2 API pricing (image output billed per token; the equivalent of a few cents to low tens of cents per image depending on size and quality) this is a budget of tens of dollars, not thousands. Doing it through ChatGPT instead of the API is fine for the first chapter but will not scale to 550 images without a lot of clicking.

## The art bible (`art/prompts/STYLE.md`)

One **base style string** that opens every prompt, locked after M3 and never edited afterwards without regenerating a comparison sheet:

```
Black-and-white ink and charcoal illustration, heavy paper grain, dry brush and cross-hatching,
deep blacks and paper whites, very few mid-greys. Grim medieval low-fantasy, rain-soaked,
muddy, cold. Environment is the subject. Any figures are small, distant, silhouetted or seen
from behind; no visible faces. Portrait composition, 9:16, important content kept within the
central 3:4 area. No text, no lettering, no signs, no symbols, no watermark, no UI.
```

Followed by a **location block** (from the location sheet, reused word-for-word every time that location appears) and a **beat block** (what is happening, what the weather and light are, where the body is).

Then a **do-not list** per panel: `no faces, no text, no color, no clean lines, no fantasy armor glow, no dragons`.

## Location sheets (`art/prompts/locations/*.md`)

For each of the ~15 locations: a fixed 3–5 sentence description, a canonical "establishing" panel chosen in M3, and the list of generated variants. Every later prompt for that location pastes the fixed description. This — not reference images — is what keeps the Greywater looking like the Greywater across 20 panels. GPT-Image-2's multi-image mode (several coherent images from one prompt) is used to generate a location's variants in one go.

## Shot list (`art/SHOTLIST.csv`)

One row per panel, created from the beat sheet before any generation:

```
panel_id, chapter, scene_id, location_id, reuse_of, time, weather, body_position, beat_description, status
ch02_hangingwood_gibbets_dusk, 2, ch02_s04, hangingwood, ch02_hangingwood_road_dusk, dusk, drizzle, on cart (left), "gibbet clearing; three shapes hanging; two small figures at the base", todo
```

`status` moves `todo → generated → curated → processed → placed`. The CI panel check fails the build if any `# panel:` tag in the ink has no processed file.

## Generation → curation → processing

**Current workflow (decided 2026-10-25): the ChatGPT app, semi-automated.** Claude writes `art/prompts/<chapter>.md` and publishes it as a prompt-pack page (`tools/make-prompt-pack.mjs`) with a style-setup message and one copy-button prompt per panel. The owner pastes them into one ChatGPT chat and saves the images in `Pictures\Deadweight` on their PC (any file names). Claude picks them up through the linked computer, identifies each panel by looking at it, processes, tests and pushes. Automating the ChatGPT app itself is not used: it is against OpenAI's terms and slow. If volume makes this tedious, the API path below (a GitHub Action with an `OPENAI_API_KEY` secret) replaces the manual step without changing anything else.

**Trial (2026-11-18): Codex on the ChatGPT plan.** OpenAI's Codex agent can generate images with its built-in tool on the owner's Plus allowance (images use the allowance 3–5× faster than text turns). The owner starts one Codex task on this repo ("generate panels for ch00"); `AGENTS.md` tells it to write raw images to `art/incoming/` on a `panels/<chapter>` branch and open a pull request. A Claude session then reviews, processes and places them. This is OpenAI's own agent, not automation of the ChatGPT app. Unproven until the first run succeeds; the manual route above stays valid.

1. **Generate** 1–3 candidates per panel in ChatGPT from the prompt pack (or later, via the API).
2. **Curate** by hand into `art/candidates/<panel_id>/`; pick one; note why in the shot list (this gets fast).
3. **Process** every picked image with `tools/process-panel.mjs <panel_id>=<image>` (uses `sharp`): crop to 1080×1920 from the centre, **enforce the palette** (every pixel becomes neutral grey except amber light, which is pulled to one fixed amber, so stray colours from ChatGPT disappear), normalise black/white points, add the same grain and vignette, export **WebP** (quality 82). It removes the panel's SVG placeholder and logs provenance to `art/LOG.csv`. This step is what makes 180 images from different sessions look like one artist.
4. **Place** into `public/panels/<panel_id>.webp`. Commit the prompt, model, date and candidate choice into `art/LOG.csv`.

## Rights and disclosure

- Keep `art/LOG.csv` (prompt, model, date, chosen candidate) for every shipped panel. It is the provenance record if a store or platform asks.
- OpenAI's terms (as of this writing) give you ownership of outputs you generate; confirm the current terms before launch and note the date you checked.
- Credit "Illustrations generated with OpenAI GPT-Image-2 and hand-processed" in the game's credits; some platforms (Steam, for instance) require AI-content disclosure, and it costs nothing to be upfront on mobile stores too.
- Do not use real artists' names in prompts ("in the style of ...").

## What is not in scope

- Character sprites, portraits, expressions. (Deliberately.)
- Animation beyond subtle parallax/pan and crossfades done in CSS.
- Any colour other than the amber light accent.
