# Beat sheet

The full sheet for chapters 1–5 is written in M1, one block per scene, using the template in `docs/WRITING_GUIDE.md`. This file currently holds (1) what every chapter must contain, and (2) the prologue as built, as the worked example.

## What every chapter contains

A chapter is 15–20 scenes, 20–30 minutes, one main location. Each one has all of these; the beat sheet marks which scene carries which.

| Beat | What it is | Why |
|---|---|---|
| **Arrival + the body** | The first scene says where we are, what day it is, and what state Aubric is in now (smell, flies, what the lie currently needs). | The clock you can smell. |
| **A nobody** | One minor person with their own day, who does not care about the war. You improve or ruin that day. | The world is bigger than the plot. |
| **A temptation** | A choice where one option is the easy, selfish thing, written so the player wants it. | Complicity. |
| **A fire scene** | Night, camp or lodging. You sit with ONE of the companions; the others are busy. Talk, food, a small confidence, something they want. No plot decision. | You have to like them before it can cost you. |
| **A thought choice** | A small act that carries an excuse (the gloves). Stored, and thrown back later. | The player writes their own self-deception. |
| **A bill** | A hidden cost from an earlier chapter arrives, flagged with a `# remember:` line. | The game is seen remembering. |
| **Meanwhile** | One thing each companion did off-screen for their own reasons, discovered, not announced. | Nobody waits for the protagonist. |
| **The turn** | The last scene ends on a line that changes what the chapter meant. | Leave on the snap. |

Across the game: Wren's hurt from the prologue (the cough, or the bad knee) is mentioned at least once per chapter until it heals or gets worse. What people call Wren changes with what Wren has done (see `story/VOICE.md`).

## Prologue — The Greywater (as built, 2026-11-18, after reader-panel round 6)

Missing by design: no fire scene, no nobody, no bill (nothing earlier to bill). Chapter 1 is the first full chapter.

```
ID:            ch00_s01_ford
Place:         The Greywater ford, near bank, night
Purpose:       Make the player like Aubric, and show what Wren is to him.
Present:       Wren, Aubric (drunk, mounted). Marrow across the river. Isolde asleep in the cart.
Wants:         Aubric — to arrive by sunrise for the bells. Marrow — to wait for morning. Wren — a bed.
Choice:        Drink with him / hand the skin back. (He gives Wren his gloves.) Then: take his bridle / shout for Marrow / say nothing.
Immediate:     None of it stops him.
Delayed:       DRANK → Marrow smells it (s04). AT_FORD → Marrow's regard (s04, s06).
Body:          Wet feet, tired.
Turn:          He rides in sitting very straight, in case anyone is watching.
Panel:         greywater_ford_night
```

```
ID:            ch00_s02_water
Place:         Mid-ford
Purpose:       The hero dies stupidly, and Wren is part of it either way.
Choice:        Go in after him / run for the rope.
Immediate:     In: he drags Wren under; Wren hits him to get free. Rope: the horse drags him out face down.
Delayed:       WENT_IN → the "hero" lie is believable or not (s05); Wren's hurt (cough / bad knee) from s07 on. In: the broken nose, which Marrow sees (s04).
Turn:          It took longer to get him out than it took him to die.
Panel:         greywater_water_churn
```

```
ID:            ch00_s03_bank
Place:         Near bank, the body
Purpose:       Wren's real first thought (wages), then the stakes (the letter, nine days).
Choice:        Take his purse / leave it. Then: hide the letter in your shirt / leave it on his belt.
Delayed:       PURSE → Marrow notices and takes his spurs (s06). LETTER → who holds the surrender.
Panel:         greywater_bank_body
```

```
ID:            ch00_s04_marrow
Place:         Near bank, lantern light
Purpose:       Marrow's want: not to hang. She offers the first lie.
Wants:         Marrow — a story in which the guide is blameless.
Choice:        Agree to the ambush story / refuse to lie / decide by dawn. (If Wren has the letter: show it / deny it.)
Delayed:       TOLD_MARROW vs. what Wren later tells Isolde → trust, and her price.
Panel:         greywater_marrow_wading
```

```
ID:            ch00_s05_dawn
Place:         By the cart, dawn
Purpose:       Isolde's want: a usable death. She makes the plan: he is "wounded", nine days under canvas.
Wants:         Isolde — to control the story before anyone else has one.
Choice:        Tell her the truth (and, if Wren went in: admit the elbow / leave it out) / Marrow's ambush / that he died saving you. Then: answer her plan (agree / ask what's in it for you / call it madness). Then: who carries the letter (or "the river took it").
Delayed:       VERSION → the ballad. LETTER = hidden → Isolde will forge or search.
Panel:         greywater_dawn_cart
```

```
ID:            ch00_s06_wrap
Place:         Near bank, morning
Purpose:       The title image: carrying him. Wren's excuse. The first bills arrive.
Choice:        THOUGHT, as an act — put his gloves back on his hands (for him) / fold his hands on his sword like the songs (for the peace) / keep them (for what I'm owed). Sets SELF.
Immediate:     Remember-lines for the bridle, the purse, lying for one and not the other, dry to the knee.
Delayed:       SELF is quoted back whenever Wren acts against it.
Panel:         greywater_wrapping
```

```
ID:            ch00_s07_road
Place:         The road to Stint, full light
Purpose:       Set the company and the clock: eight days, three people, one corpse.
Body:          The cough, or the bad knee.
Turn:          Hoping he would enjoy the bells.
Panel:         road_to_stint_morning
```

---

## Chapter 1 — Stint (beat sheet, third draft 2026-11-18)

Third draft, after three blind readers over two rounds (`reports/readers/2026-11-18-ch01-beats.md`). Eleven scenes, not sixteen. The forged letter (once s07) has moved to chapter 2; scene IDs keep their numbers. Changes: it now agrees with the prologue (his own escort is in Stint; he arrives in plate, tied in the cart's cover, and has to be made into a sick man first; the death story is told aloud to a hostile listener; the surrender is asked for). There is one inspection, not two, and the night decides what the morning is. Somebody is hurt in Stint, on the page, on every path.

**Place:** Stint, a toll town on a bridge, a day south of the Greywater. In by the north gate and the bridge; out by the south gate. **Time:** noon of day 1 to the morning of day 2. Seven days are left when the cart rolls out.
**Dramatic question:** what is the story worth, and to whom?
**The clock:** the Marshal's sergeant is in Stint with the Marshal's own surgeon, sent "for the hero's health" before anyone was ill. The surgeon will look at the patient at first light, with the sergeant as witness.
**The body:** day 1, stiff, in full plate. By night the stiffness is going out of him, which is worse. Flies. The smell is plain inside the hood by dark, and to anyone who puts their head in. The lie needs: the armour off, a shirt, blankets, the cart's hood back on its hoops, a pot carried out, a supper eaten, lavender, something burned, and a voice to say "he is sleeping".

**Drafting rules** (from the round 7–9 report; scenes 1–3 go to the panel before the rest is written):
- A paragraph ends plainly by default. One turn per scene, at its end.
- In any exchange at most one person is witty. The others are slow, literal, frightened or wrong.
- Wren's excuses run long and are not caught.
- Every decent option names its price in the label, and the price is paid on the page before the scene ends.
- One person in each scene can hurt Wren and has a reason to.
- **The public story is one sentence: he took a fever on the road.** What is behind it (an arrow, a ditch he pulled his squire out of, or nothing) is only said when somebody presses, and then it must match what Wren told Isolde. The bridge alibi is dead: his escort left him at the ford. Isolde's new line is that they crossed at dawn, easily, and the guide did well.
- Prices are not a tariff. One choice in the chapter costs nothing. One costs far too much, and somebody else pays it.

**New people** (one new name a scene): **Corporal Dobb** of Aubric's own escort, twenty years with him, who loves him (s02). The tollkeeper, unnamed, and his daughter **Annis** (s03, s11). **Sergeant Lidd** of the Marshal's riders, and **Master Venn**, the surgeon (s04). **Brother Tobin Ask** (s05). A rider's boy, unnamed, who is hungry (s06).

**Checklist:** arrival + body s01 · nobody s03, s11 · temptation s01, s06, s11 · fire scene s08 · thought choice (an act) s06 · bills s03 (the purse), s04 (the ear or the flask; the signet; the surrender; the wave; the armour), s12 (the hurt) · meanwhile s04 (Sayle), s06 (Isolde), s08 (Marrow), s10 (Tobin) · turn s12.

**Carried in:** `PURSE`, `RING`, `ISOLDE_OWES`, `LETTER`, `MARROW_KNOWS_LETTER`, `VERSION`, `TOLD_MARROW`, `PLAN`, `SELF`, `WENT_IN`, `ELBOW`, `DEBT_MARROW`.
**New state:** `ARMOUR` (ditch / cart / sold), `WAVED`, `TOLL` (sick / ring / paid), `SAID` (what Wren told Lidd), `LODGING` (chapel / yard / barn), `SELF1` (owed / him / peace), `FIRE` (marrow / isolde / tobin), `SURGEON` (refused / paid / tobin), `BLED`, `NIGHT_HANDS` (tobin / dobb / wren), `DOBB` (told / lied / silent), `HANDS` (tobin / sayle / none), `OWES_TOBIN`.

```
ID:            ch01_s01_armour
Place:         A beech wood off the south road, a mile short of Stint, noon
Purpose:       Arrival + the body. A man tied in canvas in full plate is a corpse; before the town sees him he has to be a patient. Wren's hands on him for the first time since the river.
Present:       Wren, Isolde, Marrow, the body.
Wants:         Isolde — a sick man in a shirt under blankets, and the cart's hood back up. Marrow — the armour: sixty pounds of good plate. Wren — not to be the one who does it, and is.
Can hurt Wren: The body. He is stiff. An arm will not go through a sleeve unless somebody makes it.
Reveals:       Only Wren knows the buckles. Isolde will not touch him. Marrow will, for a share. Isolde drops the bridge story here: his escort left him at the ford, so they crossed it at dawn and it was nothing.
Choice:        Sink the armour in the pond — nobody can ever find it on you, and it is a farm's worth of steel gone /
               Keep it in the cart, under him — it is his, and it is sixty pounds more for one horse, and it rattles /
               Let Marrow sell it in Stint — half is yours, and there is plate with his badge on it for sale in a town full of his men
Immediate:     The price is paid here: Wren wades in to the thighs to sink it; or lifts him back onto it alone; or watches Marrow file off the badge and miss a rivet.
Delayed:       ARMOUR = sold → Dobb sees a pauldron on a stall (s04 or s11). ARMOUR = cart → the weight slows the cart in ch2. ARMOUR = ditch → no cost. (This is the chapter's free choice.)
Body:          The shoulder has to be forced. It makes a noise. The hole under his arm if the story was an arrow; the nose if Wren went in.
Tells self:    Runs long: six years of putting it on him, so who better.
Turn:          Dressed in his shirt, with his jaw tied, he looks smaller, and like somebody's father.
Panel:         road_beech_wood_noon
```

```
ID:            ch01_s02_bells
Place:         The north gate and the bridge, late afternoon
Purpose:       The lie works in front of people for the first time, or doesn't.
Present:       Wren, Isolde, Marrow, the body under the hood. Two hundred people. The bells. Corporal Dobb and five of Aubric's escort, in his colours, drawn up to receive him.
Wants:         The crowd — a look. Dobb — to take his bridle, as he has for twenty years. Isolde — one wave, no more. Marrow — the back of the cart.
Can hurt Wren: Dobb. He loves the man, he is not stupid, and he is walking toward the tailboard.
Choice:        Put on his glove and put an arm out under the hood (they cheer; it is your arm they cheer) /
               Stand up and say he is sleeping — and be the one who sent two hundred people home /
               Say nothing, and let Isolde do it — she does it better, and takes the reins from you in front of his men
Immediate:     Wave: the cheer; then a child, loudly: "That's not him, that's a little arm." Laughter. Dobb does not laugh. Tell: the cheer dies; a turnip hits the cart; Dobb takes his cap off, slowly, the way you do for worse news. Nothing: Isolde is gracious; Dobb looks at Wren as a man looks at a dog that did not bark. (If Wren objected to the plan in the prologue, Wren is under the hood beside him for all of this, and the choice is made from in there.)
Delayed:       WAVED → Lidd, in s04: "He waved, I'm told. Then he can sit up for a surgeon."
Body:          The bells in Wren's teeth. The cough, or the knee on the cart step.
Turn:          Dobb, at the tailboard, cap in hand: "I'll sit with him tonight, then. I always have when he's poorly."
Panel:         stint_bridge_dusk
```

```
ID:            ch01_s03_toll
Place:         The tollhouse on the bridge
Purpose:       The nobody. The lie goes into a book. The purse comes due.
Present:       Wren, the tollkeeper (a boil on his neck; his daughter marries tomorrow, and the Lantern has had his ringers for three days). Marrow in the doorway.
Wants:         The tollkeeper — fourpence for the cart, the right rate for what is in it, and his bells back. He does not care about the war.
Can hurt Wren: The tollkeeper. He writes down what crosses, and the Marshal's sergeant reads the book every evening.
Reveals:       Sick men cross free. The dead are sixpence a head, since the war. It all goes in the book against a mark.
Choice:        Enter him as a sick man and put your mark to it — your name is now on the lie, in ink /
               Show the signet and cross in the Lantern's name [RING only] — nothing is written, and by dark all Stint knows the squire wears his ring /
               Pay the fourpence for the cart and refuse to put any mark to what is in it — he writes "squire would not say", and the hour
Immediate:     If PURSE, the fourpence comes out of Aubric's purse and the tollkeeper knows the purse; he has changed coin out of it (bill; remember-line). If not, Marrow pays, and says what that makes.
Delayed:       TOLL = sick → evidence in ch3. TOLL = ring → Lidd asks to see the ring (s04). TOLL = paid → Lidd asks what the squire would not say (s04).
Body:          Wren cannot stop looking at the boil.
Turn:          He asks if the Lantern could spare the ringers for an hour tomorrow, for Annis. He asks Wren. Wren is who you ask, now.
Panel:         stint_tollhouse
```

```
ID:            ch01_s04_square
Place:         The square, under the bell tower
Purpose:       The Marshal gets a face in this town. The death story is told aloud to somebody who wants it to be false. The surrender is asked for.
Present:       Wren, Isolde, Marrow, Dobb and his five. Sergeant Lidd and eight of the Marshal's riders. Master Venn, eating.
Wants:         Lidd — to deliver the Lantern to the Marshal, and to have it written that he did; and the surrender "for safe keeping". Venn — to do what he was sent to do and not learn why. Dobb — Lidd's hands off his knight. Marrow — not to be seen by Lidd, who knows her.
Can hurt Wren: Lidd. He has eight men, the toll book, and a use for a thief.
Reveals:       The surgeon was sent before anyone was ill (meanwhile: Sayle). Lidd knows Marrow. He asks how the Lantern took sick, and where, and writes down the answer.
Choice:        What Wren says when Lidd asks how he took sick. It must match what Wren told Isolde (VERSION), or she is standing right there:
               the public story as agreed (a fever; and a robber's arrow, or a river chill, behind it) /
               less than that: "A fever. I'm not a surgeon." — Lidd writes that the squire could not say /
               more than that: a detail of Wren's own, to make it live — Lidd writes it down, and it will have to stay true for seven days
Immediate:     Then Lidd asks for the surrender. If Isolde holds it, she declines beautifully and Lidd looks at Wren's shirt out of habit. If Wren holds it, Lidd has Wren turned out in front of the square "for the purse", because the tollkeeper has mentioned a purse or Wren looks like a thief: a rider's hands go down Wren's sides and stop one hand short. What stops him: Dobb (it costs Dobb a blow in the mouth from Lidd), or Marrow (she walks into Lidd's sight to do it, and he smiles), or Isolde (she says the squire carries the Lantern's linen and would the sergeant like to wash it). Bills: the notched ear ("who marked you?") or Marrow's flask in Lidd's hand, by TOLD_MARROW; the signet, if Wren showed it at the toll (Lidd asks to see it, and tries it on); the wave; and if the armour was sold, Dobb stops at a stall on the way across the square, picks up a pauldron, and turns it over.
Delayed:       SAID. If the story is an arrow on the Marshal's road, Lidd must hang somebody for it, and says so.
Body:          A stranger's hands, flat, going down Wren's ribs.
Turn:          Venn, mouth full: "Fever. Then he's to be bled. I'll bring the bowl at first light."
Panel:         stint_square_bells
```

```
ID:            ch01_s05_friar
Place:         Beside the cart, the square emptying, dusk
Purpose:       Tobin. Kindness as stock-taking. Key choice 1: where the body spends the night decides who touches it.
Present:       Wren, Tobin, Isolde, Dobb. Lidd's men at the inn door. The tollkeeper locking up.
Wants:         Tobin — the sick man under his chapel roof, where nobody carries steel. He has eleven people under that roof, cripples from both armies and four children, and it leaks; a saint means pilgrims and pilgrims mean slates. Dobb — the inn yard, with his own men round the cart. The tollkeeper — he has a barn, and a price.
Can hurt Wren: Tobin. He has laid out more dead than anyone in Stint, and he has come round to the downwind side.
Reveals:       He starts with Wren's feet. He trained the ringers, and is vain about them.
Choice:        The chapel — a bolt on the door and no steel inside it, so a surgeon can come no nearer than the step; and Tobin has the key, and you sleep on that step /
               The inn yard — Dobb and five swords between him and the Marshal's surgeon; and Dobb sits up all night on the tailboard, a foot from him. (Isolde: the fever is catching, and nobody goes under the hood but his squire. Dobb obeys that until Wren is asleep.) /
               The tollkeeper's barn — nobody's roof and nobody's hands but yours; and it costs coin you have to find tonight, and you will have to turn him yourself
Immediate:     Chapel: Lidd posts two men at the chapel door; Dobb spits. Yard: Tobin says "as you think best, child," and goes to fetch vinegar anyway. Barn: the tollkeeper shakes Wren's hand.
Delayed:       LODGING decides s09 and s10.
Body:          Tobin has Wren's boot off before Wren has agreed to it.
Turn:          Tobin, tying the boot again: "And who is it turns him, child? A man in a fever wants turning."
Panel:         stint_chapel_door
```

```
ID:            ch01_s06_supper
Place:         The lodging, by the cart, dark
Purpose:       The chores of the lie. The thought choice, as an act. The boy who will pay for it.
Present:       Wren. A rider's boy of ten or so, sent by Lidd to see the hero eat. He has not eaten today either, and it is the fowl he watches. The town's supper for the Lantern: a roast fowl, white bread, the good wine.
Wants:         The boy — to do as he was told and not be hit. And the fowl.
Can hurt Wren: The boy. He will say what he saw.
Reveals:       The pot must be carried out full. Wren fills it. The plate must come back empty.
Choice:        Eat it yourself, inside the hood, and hand out a clean plate (you have not eaten since yesterday, and you are owed a supper) /
               Give the boy the fowl to say he saw the Lantern eat (he will say it; he will say anything; and you go hungry) /
               Carry it out to the beggars at the chapel wall where people can see, as he always did (and you go hungry, and the boy tells Lidd the hero has no appetite)
Immediate:     Eat: it is the best meal of Wren's life and Wren is sick with it behind the cart an hour later. Boy: he eats like a dog and cries a little. Beggars: one of them blesses the Lantern loudly, and a second asks why the squire's hands shake.
Delayed:       SELF1. If the boy was fed, he lies well, and at first light Lidd finds grease on his shirt and beats him for it in front of the town (s11). This is the choice that costs far too much, and Wren does not pay it.
Body:          Hunger. The pot. His wine.
Tells self:    Each act has its own excuse, and it runs long.
Meanwhile:     Isolde is at the tollhouse door, paying the toll rider. A letter has gone south: the Lantern has a fever and is coming. It is in writing now. She comes back with an armful of lavender and does not say who else she wrote to.
Turn:          The boy, licking his fingers or not: "Is he going to die?" He asks it the way he would ask about a horse.
Panel:         stint_cart_night
```

```
ID:            ch01_s08_fire
Place:         One of three fires, late
Purpose:       The fire scene. One companion; the others are seen at their own business. No plot decision.
Present:       Wren and ONE of:
               Marrow — the stable, new army boots on the straw beside her (meanwhile: she has been drinking with Lidd). She cannot read. Wren has heard the terms read aloud at every inn for three days. She wants the towns named, all of them, in order, and listens for one. Wants: one name, and not to be asked why.
               Isolde — the lamp, the third verse. She asks what he ate for breakfast, the last morning. She writes none of it down. Wants: one true thing she is not allowed to use.
               Tobin — the chapel kitchen, soup, eleven sleepers. He asks about Wren's mother's chest; Dobb told him. Wants: to know what Wren would do for a roof.
Can hurt Wren: Whoever it is, by being kind.
Choice:        Which fire. Then one small thing they ask that is not the plot (name the towns / tell her something about him she cannot use / stir the pot and say where you slept as a child).
Immediate:     FIRE. Warmth. Wren likes them. That is all that happens.
Delayed:       The one chosen: their breaking point is foreshadowed. The two not chosen each hold it against Wren once, in a small way, in ch2.
Body:          Warm for the first time since the river. It hurts as it comes back.
Turn:          Plain, and theirs. Marrow: "Carrow's on it, then." Then the rider's boy is in the doorway, out of breath: "Surgeon's not waiting for light. He's only finishing the jug."
Panel:         stint_stable_fire / stint_cart_night (lamp) / stint_chapel_kitchen
```

```
ID:            ch01_s09_surgeon
Place:         The door of the lodging, deep night
Purpose:       The only inspection. Wren is what stands between a stranger and the body. What Wren does here decides what first light is.
Present:       Wren, Master Venn, drunk enough to be thorough, with his bowl and fleam. Chapel: the door is bolted and Tobin has the key; Venn wants it fetched. Yard: Dobb stands up off the tailboard and says nobody bleeds the Lantern but the Lantern's own man says so, and looks at Wren to say so. Barn: nobody else.
Wants:         Venn — to have bled somebody, to be able to write that he did, and not to find out why he was sent before the man was ill. He is not unkind.
Can hurt Wren: Venn. One breath under the hood. And his fleam.
Reveals:       He dressed the Marshal's hand ten years ago, after a night on a causeway. The Marshal has written left-handed since.
Choice:        Refuse him in the Lantern's name — he goes, and writes down that he was refused, by whom, at what hour; and he was sent to fill a bowl, so he fills it from you /
               Pay him to write that he looked — it takes the purse, or the armour money, or what Marrow will lend; and he still wants his bowl, and takes it from you /
               Fetch the friar (chapel: knock him up; elsewhere: send the boy) — Tobin walks him off with an arm round his shoulders and a jug; your arm is spared; and now it is Tobin who kept the surgeon out
Immediate:     Refuse, pay: Venn says Wren's pulse is "going like a rabbit", sits Wren on the step, and takes a bowl. Wren does the rest of the chapter with a bound arm and a grey edge on everything. Friar: OWES_TOBIN, and Tobin looks at the hood on his way past and does not slow down.
Delayed:       SURGEON, BLED. Refused → Lidd has the note at first light. Paid → Venn lies for Wren at first light and names his price in front of Lidd. Tobin → at first light it is already "our sick brother".
Body:          The fleam. Wren watches the bowl fill and thinks it is a lot.
Turn:          Venn, wiping the fleam, or over Tobin's shoulder: "Very quiet in there. For a fever."
Panel:         stint_cart_night
```

```
ID:            ch01_s10_hands
Place:         The lodging, the last dark to first grey
Purpose:       Meanwhile: Tobin; or Dobb; or nobody. Who touched him in the night, and what they now know. Wren sleeps, after two nights awake and perhaps a bowl of blood, and has no choice about it.
Present:       By LODGING.
               Chapel: Wren wakes on the step. The door is unbolted. Inside he is washed, combed, turned, his jaw tied with a better knot, lavender laid where it will do most good. Isolde's knot on the hood is retied exactly as she tied it. Tobin is lighting the dawn candle and does not turn round.
               Yard: Wren wakes under the cart. Dobb waited until the squire slept, and then he put his hand under the hood to feel the fever. He is on the tailboard with the cold hand in both of his. He has straightened the legs, the way soldiers do it. He is an old man with a wet face and a sword, and he is deciding what Wren is.
               Barn: nobody came. Wren has to turn him alone, on no sleep, and cannot, and gets him half over. In the morning there is a mark down one side of his face, dark as a bruise, where he lay.
Can hurt Wren: Tobin with one sentence to Lidd. Dobb with a sword, and with the question "who was with him?". The mark.
Choice:        Chapel: thank the friar (now he knows you know, and names what the chapel needs) / say nothing (he lets you; the bill is larger) / tell Isolde.
               Yard: tell Dobb the truth of the river, all of it, including your part / tell him Isolde's story and let him choose to believe it / say nothing, and let him ask.
               Barn: cover the mark with the blanket and say the fever has gone to his face / fetch the friar after all.
Immediate:     NIGHT_HANDS, TENCH_KNOWS, OWES_TOBIN. If Dobb is told the truth and Wren went in: he hits Wren, once, open-handed, very hard, and then holds on to Wren's collar as if he might fall down.
Delayed:       Tobin's ask in ch4. DOBB: told → he stands with Wren at first light; lied → he goes home north with his cap off; silent → he is standing beside Lidd at first light.
Body:          The bled arm. Standing up too fast.
Turn:          Chapel — Tobin: "He'll want it again by noon, child. I'll show you how." Yard — Dobb: "Twenty years I sat up with him. I'd have sat up with him for this. Nobody asked me." Barn — the mark, in the first light.
Panel:         stint_chapel_door (dawn) / stint_inn_yard_dawn / stint_barn_dawn
```

```
ID:            ch01_s11_first_light
Place:         The door of the lodging; the square behind it
Purpose:       Key choice 2. Whose is he. And the bills that other people pay.
Present:       Wren, Isolde, Marrow, Tobin, Lidd and his riders, Venn. Dobb, by what he was told. The wedding party on its way to the chapel: the tollkeeper, Annis, her groom, who is a hill man, and half the town. What the night did:
               SURGEON refused: Lidd has Venn's note, and reads it out.
               SURGEON paid: Venn says the Lantern is very poorly, and that the squire owes him the same again at the next town, and says it in front of Lidd.
               SURGEON tobin: Tobin speaks first, and it is already "our sick brother".
Wants:         Lidd — the cart, or a written reason he was refused it. And the surrender, "to ride on my saddle, where it is safe". Tobin — to carry him out under a pall: a holy fever, in the Church's care. Isolde — the hood shut and the road. Marrow — the south gate. The tollkeeper — bells for his daughter.
Can hurt Wren: Lidd. He puts his hand on Isolde's knot. He has a rope on his saddle that he says is for horses.
Before the choice, people are hurt, and none of them is Wren. These add up; they do not replace each other:
               Always: Lidd makes room. If Dobb is at the cart, Lidd has him disarmed in front of his own five men, and when the old man will not give up the sword, hits him in the mouth with the pommel of it. If Dobb has gone north, it is the tollkeeper, who came to ask about his ringers: his book goes in the mud and his keys on Lidd's belt.
               If Wren told Lidd about an arrow: Lidd has to hang a robber for the Marshal's road, and the nearest hill man is Annis's groom. He is taken out of his wedding with his hands tied. Nobody rings.
               If the boy was fed: Lidd finds the grease on his shirt and beats him with the rope's end. It goes on for some time. Nobody stops it.
Choice:        Give him to the friar — a pall, a litter, a holy fever, no steel near him. Tobin walks with the cart from now on, and it is Tobin's sick man /
               Take the Marshal's escort — Lidd offers it plainly: eight swords on a robber road, the fast way, two days saved, the page torn out of the toll book, the groom untied. Venn rides with the cart, and the surrender rides on Lidd's saddle /
               Neither: say no in the Lantern's name. If Dobb's men are behind you it is about to be swords on a bridge, and Marrow stops it the only way she can: she walks up to Lidd and gives him something that is not money, where you can see her do it
Immediate:     HANDS. SELF1 is thrown back at the moment Wren acts against it. The groom goes free only with the escort. Nothing gives Dobb his teeth back, or the boy his morning.
Delayed:       HANDS = tobin → ch4 is his. HANDS = sayle → Barrow Hill comes a day sooner; Venn must be dealt with in ch2; the letter is in the Marshal's keeping. HANDS = none → Lidd sends a rider to the Marshal with one line; Marrow's price is no longer coin.
Body:          The bound arm. Wren speaks for him and the cough comes in the middle of it.
Turn:          Annis, to Wren, quietly, in her wedding ribbons: "Is he very bad?" She is the first person in Stint to ask.
Panel:         stint_square_first_light
```

```
ID:            ch01_s12_south_gate
Place:         The south gate, and a mile of road
Purpose:       Count what the night cost. The body on day 2. The turn.
Present:       Wren, Isolde, Marrow, and whoever now travels with the cart: Tobin with a handcart, or Venn and eight riders, or neither. Dobb, by what he was told: riding behind with his five, or gone north with his cap off, or not seen since dawn.
Reveals:       Seven days. Lavender, vinegar, and under them what they are for. Marrow's price, stated or not. The ink on Wren's fingers. The armour, wherever it is.
Bill:          The hurt. The cough has got into the chest, or the knee has locked; with the bleeding on top, Wren cannot drive. Somebody else takes the reins, and it matters who.
Choice:        None.
Turn:          Said to Wren alone, low. Venn, if he rides with the cart, while he rebinds Wren's arm; otherwise Tobin, who had it from the surgeon over the jug, or Marrow, who had it from Lidd: "He was meant to have a fever. The surgeon was told so before the Lantern ever left the hills."
Panel:         road_south_day2
```

### Where the prices fall

| Choice | Scene | Price | Who pays |
|---|---|---|---|
| Sink the armour | s01 | Nothing | Nobody (the free one) |
| Sell the armour | s01, s04 | Dobb turns over a pauldron | Wren, later |
| Tell the crowd he is sleeping | s02 | The cheer; a turnip; Dobb's helmet in his hands | Wren |
| Refuse to sign the book | s03 | "Squire would not say", and the hour | Wren |
| Say less than the story | s04 | A stranger's hands, one short of the letter | Wren; Dobb's mouth |
| Add a detail (an arrow) | s04, s11 | A hill man taken from his wedding | The groom |
| The barn | s05 | Coin; turning him alone; the mark | Wren, and the body |
| Feed the boy | s06, s11 | A beating with a rope's end | The boy (the one that costs far too much) |
| Refuse or pay the surgeon | s09 | A bowl of blood | Wren |
| Tell Dobb the truth | s10 | An open hand; an old man's face | Wren, and Dobb |
| Whatever Wren does | s11 | A sword pommel in the mouth | Dobb, or the tollkeeper |
| Stand in the door | s11 | What Marrow gives Lidd | Marrow |

### Inventions in this chapter the owner may strike

- **Corporal Dobb** and the escort (needed: the prologue put them in Stint). He was "Tench" in the second draft; a reader found that too near a corporal in *The Heroes*.
- **Venn's last line.** It suggests the Marshal meant Aubric to fall ill at Stint whether or not he drowned. That fits the cast sheet (the dispatch already written and dated tomorrow) but it is a new fact. Without it, the turn is Tobin's line from s10.
- **The groom is a hill man**, and can be taken for the ambush that never happened.
- **Marrow cannot read**, and Carrow is the name she listens for.

### Panels (12 new)

`road_beech_wood_noon`, `stint_bridge_dusk`, `stint_tollhouse`, `stint_square_bells`, `stint_chapel_door` (+ dawn), `stint_cart_night` (+ lamp), `stint_stable_fire`, `stint_chapel_kitchen`, `stint_inn_yard_dawn`, `stint_barn_dawn`, `stint_square_first_light`, `road_south_day2`. Amber arc: a hundred windows and the bell-tower lamp at dusk (his light, borrowed by a town) → one lamp on a tailboard → the surgeon's lantern on a bowl → Tobin's dawn candle → none on the road.
