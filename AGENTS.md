# Instructions for Codex / ChatGPT agents

The full working method for this repo is in `CLAUDE.md`; read it for any task other than the one below.

## Panel generation task

When asked to "generate panels for <chapter>" (for example `ch00`):

1. Read `art/prompts/STYLE.md` and `art/prompts/<chapter>.md`. Each `## <panel_id>` heading in the chapter file has one fenced prompt.
2. For each panel, in file order, skip it if `art/incoming/<panel_id>.png` already exists. Otherwise generate ONE image with your **built-in image generation** (gpt-image-2 on the ChatGPT plan). Do not use an API key.
   - Prompt = the base style string from `STYLE.md`, then the panel's fenced prompt, then the do-not list from `STYLE.md`. Use the text as written; do not rewrite or embellish it.
   - Portrait, 9:16 (1080×1920, or the nearest portrait size available). Important content inside the central 3:4 area.
   - Black-and-white ink and charcoal. The only colour allowed is amber, only where the panel prompt asks for it. No text, lettering, signs or watermark. No visible faces.
3. Save the image as `art/incoming/<panel_id>.png` and **commit after every single image** to the branch `panels/<chapter>`, so partial progress survives if the usage limit is reached.
4. When every panel has one image and usage remains, make a second candidate per panel as `art/incoming/<panel_id>_b.png`, same rules.
5. Open a pull request from `panels/<chapter>` into `main` titled `Panels: <chapter> raw candidates`. Do not merge it.

Hard rules for this task:

- Change nothing outside `art/incoming/`. Do not process, resize, rename or place panels; do not touch story, code, tests or docs.
- If built-in image generation is not available in your environment, **stop and say so**. Never substitute SVG, code-drawn, placeholder or downloaded images.
- If you hit a usage limit, stop, push what you have, and report which panels are done.
