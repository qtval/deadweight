# Incoming panels

Raw generated images land here, one per panel, named `<panel_id>.png` (extra candidates: `<panel_id>_b.png`, `_c.png`).
They are not used by the game. A Claude session picks them up, runs `tools/process-panel.mjs`, and moves the
result into `assets/panels/`. See "Panel generation task" in `AGENTS.md`.
