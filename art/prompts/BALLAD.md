# The ballad prints (world film, "Before the Greywater")

Six woodcut prints: the official, flattering version of the Lantern, as sold on a broadsheet ballad. They are
deliberately unlike the game's charcoal sketches; the film tears the last print away to show the charcoal truth.

Save them anywhere and send them; they are added with
`python3 tools/films/ballad_prints.py add lantern=<file> war=<file> ride=<file> surrender=<file> bells=<file> deathbed=<file>`
then `python3 tools/films/film.py intro video`.

## One prompt for Gemini (copy all of it)

```
Make 6 separate images, one at a time, all in exactly the same style. Portrait 2:3.

STYLE: an old woodcut print from a 16th-century broadsheet ballad. Bold black carved lines and cross-hatching on cream laid paper, slight ink bleed and uneven inking, flat stiff perspective, figures stiff and heroic like propaganda. Pure black ink on cream paper only: no colour, no grey wash, no gold.
RULES FOR EVERY IMAGE: no text, no letters, no numbers, no writing on banners, scrolls or signs. No readable faces: knights have visors down, other figures are hooded, small, or turned away. No border lettering. One single image per picture, not a page of panels.

1. A knight in full plate armour on a rearing horse on a hilltop, sword raised high, visor down. A lantern hangs from his saddle and carved sun-rays burst from it across the whole sky. Tiny enemy soldiers flee down the hill below him. Absurdly glorious.

2. Ten years of war: rows of tiny identical soldiers with pikes marching in lines across terraced mountains, past hill towns burning in carved spiral smoke. A row of gallows stands on a far ridge. Crows in the sky.

3. The same knight riding alone up a winding mountain road toward the gate of a walled hill town, no sword in his hand, one gauntlet raised in peace. Hooded townsfolk watch from the walls.

4. Hill-town elders in long hoods kneeling in a line before the mounted knight. The first elder holds up a rolled scroll with a wax seal (blank, no writing). The knight reaches down to take it. Mountains behind.

5. A town square packed with tiny cheering crowds throwing caps in the air. A tall bell tower with great bells swinging, drawn with carved motion lines. The knight rides in through an archway, raising a wine cup high.

6. The knight as a very old man, peaceful in a great canopied bed. His armour hangs on a stand beside the bed, a lantern on the bedside table, tall candles. Hooded mourners kneel around the bed.
```

Ids for the files, in order: `lantern`, `war`, `ride`, `surrender`, `bells`, `deathbed`.
