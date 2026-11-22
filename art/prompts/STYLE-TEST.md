# Style test — one scene, three hands

Why: the first ChatGPT panels looked too polished, didn't match each other and had no personality. Before any more
panels, pick ONE look from three that each have a clear point of view, rooted in printmaking traditions old
enough to be public domain. The winner becomes the style reference for every panel, and every image then goes
through `tools/panels/finish.py`, which removes the remaining polish and makes them match.

Every version shows the same moment from Wren's eye: crouched on the near bank, the knight about to ride in.

## The prompt (paste as one message into a new ChatGPT chat)

```
Make THREE separate images, one after another, of the same scene in three different hand-made styles. Tall portrait 2:3 for each.

THE SCENE (same in all three): night, a shallow river ford. We are crouched low on the near bank among dead reeds, at the eye height of a frightened servant. A knight on a grey horse, seen from behind, small, is just stepping into black water; his arm is raised with a wineskin. Far across the river, one tiny lantern. Ragged clouds, no moon visible. Lots of empty dark space. The knight must NOT look heroic: slumped, a little ridiculous.

STYLE 1 — ETCHING AND AQUATINT, like early-1800s Spanish war etchings: scratchy needle lines, flat grainy grey washes, bitter and plain, a visible plate mark around the edge, foxed old paper.
STYLE 2 — EARLY WOODCUT, like a 1500s broadsheet print: bold gouged black shapes, coarse parallel cuts for shading, crude confident drawing, slightly uneven ink.
STYLE 3 — FIELD SKETCH in charcoal and ink on rough paper, as if drawn on the road by someone who was there: fast, smudged, unfinished, construction lines left in, a thumbprint smear, uneven pressure.

FOR ALL THREE:
- Black, white and grey only. The ONLY colour is the lantern: a small warm amber glow and its reflection. Nothing else amber.
- No faces. No text, letters, signatures or signs anywhere.
- It must look made by a human hand with real materials: imperfect lines, uneven tone, slightly wrong perspective is fine.
- NOT digital painting, NOT smooth gradients, NOT cinematic lighting, NOT glossy, NOT concept art, no glow or bloom except the lantern.
```

## After

Send the three images back in chat (and, if you still have them, two or three of the old ChatGPT panels you didn't
like, so the finishing pass can be tuned on real images). I run all of them through the finish and send them back
side by side; you pick one style; I then rewrite all 13 panel prompts around it, each a specific moment framed from
Wren's eye (hands, the rope, the boots, the case, the knife), not a generic establishing shot.
