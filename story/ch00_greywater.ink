// PROLOGUE — THE GREYWATER
// One night at a ford, and the dawn after.
// Dramatic question: how did the Lantern die — and who gets to say?

=== ch00 ===
# title: Prologue :: The Greywater
-> s01_ford

// ---------------------------------------------------------------
= s01_ford
# scene: s01_ford
# panel: greywater_ford_night
The river was loud in the dark, fast and shallow and black, and Sir Aubric Dane wanted to cross it tonight.
"By sunrise," he said, for the fourth time. "They'll ring the bells for the Lantern, Wren. I'll not have them ring for a man who turns up at noon like a tinker with a cough."
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
Six years as his squire, and Wren knew this voice. Two skins of the hill towns' wine, poured at the surrender to show there were no hard feelings. Full armor, polished for the bells.
Out on the far bank, a lantern moved. That was Marrow, the guide. She'd waded across to test the bottom and shouted back one word, which had been "Morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
Aubric gathered his reins. The grey stamped and blew. Behind them, the cart sat dark on the near bank with the chronicler asleep in it.
* [Take his bridle and hold him back]
    ~ AT_FORD = "bridle"
    Wren caught the bridle. The grey tossed its head; Aubric leaned down, smelling of wine and polish, and very gently pried the fingers loose one at a time.
    "You're a good squire," he said. "But you're a squire."
* [Shout across to Marrow to stop him]
    ~ AT_FORD = "called"
    "Marrow!" The river took most of it. Across the water the lantern stopped, then started back toward the edge, quick.
    Aubric laughed. "Calling the help to fetch the help."
* [Say nothing. He hates being corrected.]
    ~ AT_FORD = "silent"
    Wren said nothing. Six years had taught that much: Aubric corrected was Aubric twice as stubborn, and louder.
- Then he put his heels to the grey, and they went into the Greywater together.
-> s02_water

// ---------------------------------------------------------------
= s02_water
# scene: s02_water
# panel: greywater_water_churn
The ford was waist-deep on a man and knee-deep on a horse. Halfway over, the grey put a hoof on a stone that wasn't there.
It went down on its shoulder. Aubric went off its back, sideways, in sixty pounds of steel and two skins of wine, and the black water closed over the polish like a lid.
He didn't come up. The water was only waist-deep, but he was lying in it, and he couldn't get his feet under him.
* [Go into the river after him]
    ~ WENT_IN = true
    Wren was in the water before deciding to be. The cold hit like a slammed door. The current shoved at the knees, the stones rolled, and somewhere under the noise a gauntlet was scraping against rock.
    Wren found an arm, then a collar strap, and pulled, and the river pulled back.
* [Run for the rope on the cart]
    ~ WENT_IN = false
    The rope. There was a rope on the cart. Wren ran for it along the bank, slipped, ran, threw a loop around the grey's saddle as it floundered free, and hauled.
    The grey did the rest. It dragged him in by one stirrup, face down, like a sack of something.
- It took longer to get him onto the stones than it had taken him to die.
-> s03_bank

// ---------------------------------------------------------------
= s03_bank
# scene: s03_bank
# panel: greywater_bank_body
He lay on his back on the near bank, streaming, with his mouth open as if he'd thought of one more thing to say.
The last thing he had said, on the road an hour ago, was that the third verse of his song didn't scan.
Wren knelt. Under the water and the wine he smelled the way he always had, of oil and leather, like a shop.
On his belt, in an oilskin case, was the reason for all of it: the surrender. The hill towns' council had signed it that morning. It had to reach the King's council in Vellmouth, the capital, and be countersigned within nine days. If it didn't, the hill towns were free of it, and the war began again with the spring.
# know: letter :: The surrender: signed by the hill towns this morning. Must be countersigned in Vellmouth, the capital, within nine days, or the war starts again.
Aubric had explained this at every inn between here and the hills. He'd liked explaining it.
The case was dry. Out on the water, Marrow's lantern was coming back across, low and fast.
* [Take the case and hide it under your shirt]
    ~ LETTER = "wren"
    The buckle was stiff with cold. Wren worked it loose and pushed the case inside a sodden shirt, flat against the ribs. It felt like holding a stranger's hand.
* [Leave it on his belt, where it belongs]
    ~ LETTER = "body"
    Wren left it. It was his. Everything here was still his, for another few minutes, until somebody decided otherwise.
- -> s04_marrow

// ---------------------------------------------------------------
= s04_marrow
# scene: s04_marrow
# panel: greywater_marrow_wading
Marrow came out of the river with the lantern held high and stopped when the light reached him.
She didn't say anything for a while. Then she said, "Well. Shit."
{ AT_FORD == "called":
    "You called," she said. "I heard you. I'd have come faster if I'd thought he'd listen to either of us."
    ~ TRUST_MARROW += 1
}
{ AT_FORD == "silent":
    "I was watching from the other side," she said. "You didn't say a word to him."
}
She crouched by the body without touching it and looked at Wren over the lantern. She wasn't frightened, quite. She was counting.
"Here's how this goes," she said. "A Crown hero drowns at a ford. The guide who picked the ford is a deserter from the other side. Who hangs?"
Wren didn't need to answer.
"So he didn't drown," Marrow said. "Hill stragglers in the dark. An arrow. He died fighting. Nobody hangs for that except stragglers, and they're hanging already."
* [Agree to her story: an ambush]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    Wren nodded. Marrow let out a breath that hadn't been visible until it went.
    "Good," she said. "You're quicker than him."
* [Tell her you won't lie about how he died]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," Wren said. "That's what happened."
    Marrow looked at the river, then at Wren, as if measuring the distance between them for a rope.
    "That's what happened," she agreed. "It's just not what's going to have happened."
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," Wren said. "I'll decide at dawn."
    "Dawn's when she wakes up," Marrow said, with a jerk of her head at the cart. "Decide before that."
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That still dry?"
    It was. She nodded slowly, and didn't reach for it, which Wren noticed.
    ~ MARROW_KNOWS_LETTER = true
- else:
    Her eyes went to his belt, and the empty buckle. "Where's his letter?"
    -> marrow_asks_letter
  }
  -> s05_dawn

= marrow_asks_letter
* [Show her you have it]
    ~ MARROW_KNOWS_LETTER = true
    ~ TRUST_MARROW += 1
    Wren opened the shirt enough to show the oilskin. Marrow looked at it, and at Wren, and something in her face rearranged itself.
    "Keep it there," she said.
* [Say you haven't seen it]
    "Haven't seen it," Wren said.
    Marrow held the lantern a moment longer than she needed to. Then she lowered it. "River, then," she said, and didn't sound as if she believed it.
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
Dawn came up grey and cold. Isolde Ferrant climbed down from the cart with a blanket around her shoulders and ink on two fingers. She was the chronicler the Crown had sent to write the Lantern's ballad, and she had written most of it already.
She looked at the body for a long time, the way she looked at a page.
"Did anyone else see?" she said.
Not *how*. Not *is he*. Wren filed that away.
"Just us," said Marrow.
Isolde nodded, and turned to Wren, because the squire would know. "Tell me how he died."
* [Tell her the truth: he drowned, drunk]
    ~ VERSION = "truth"
    Wren told it straight: the wine, the polish, the stone that wasn't there, the water only waist-deep.
    Isolde closed her eyes. "In a ford," she said. "Drunk. A child could have crossed it."
    "A child would have waited for morning," said Marrow.
* [Tell her Marrow's story: an ambush]
    ~ VERSION = "ambush"
    ~ LEGEND += 1
    Wren told it the way Marrow had built it: the dark, the bows, the Lantern turning his horse to face them.
    Isolde's eyes went bright and quick. "Did he say anything?"
    "Something about the bells," said Marrow, without a pause.
* [Tell her he went into the river after you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," Wren said. "He came in after me. He got me out. The river kept him."
    Isolde looked at Wren for a long moment, top to toe.
    { WENT_IN:
        Wren was soaked to the collar and still shaking. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        Wren's legs were wet to the knee, no higher. Isolde's mouth moved, very slightly. She nodded anyway.
    }
    "That's the third verse," she said softly. "That's the one that didn't scan."
- -> s05_plan

= s05_plan
Isolde sat down on the cart step and pulled the blanket tighter. When she spoke again it was in her working voice.
"Here is the problem," she said. "There are men at court who have grown rich on this war. When they hear the envoy is dead, they'll say the surrender died with him. Unsigned by the Crown, carried by nobody, worth nothing. And they will be right for exactly as long as it takes to say it."
"So?" said Marrow.
"So he isn't dead." Isolde looked at the body. "He's wounded. A fever. He rides to Vellmouth in the cart, under canvas, and no one sees him till the King's ink is dry. Nine days."
{ VERSION == "truth":
    "And after?" Wren said.
    "After, he can die of whatever we like."
}
{ VERSION == "ambush":
    "And after, he dies of his wounds," she said. "Bravely. In the capital. With the bells."
}
{ VERSION == "hero":
    "And after, he dies of the river," she said. "And you're in the song."
}
"And the surrender?" she said. "Where is it?"
{ LETTER == "body": -> letter_on_body }
-> letter_with_wren

= letter_on_body
Before Wren could move, Isolde had knelt and unbuckled the case from his belt with ink-stained fingers. She checked the seal. She didn't open it.
* [Let her take it]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    She tucked it into her satchel, beside the ballad.
    "Thank you," she said, as if Wren had given it to her.
* [Hold out your hand. "I'm his squire. I carry it."]
    Isolde looked at the hand. For a moment Wren thought she'd refuse, and saw her decide that refusing would cost more than it was worth.
    She put the case in it.
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    "Of course," she said. "His squire."
- -> s06_wrap

= letter_with_wren
* [Give it to her]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    Wren took the case out of the wet shirt and held it out. Isolde checked the seal, didn't open it, and put it in her satchel beside the ballad.
    "Thank you," she said.
* [Keep it. "I'll carry it. I was his squire."]
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    Isolde looked at the shape under Wren's shirt, then at Wren's face.
    "Of course," she said. "His squire."
* [Tell her the river took it]
    ~ LETTER = "hidden"
    "The river," Wren said. "It must have come off in the water."
    Isolde went white, all at once, the way paper does in a fire just before it goes.
    { MARROW_KNOWS_LETTER:
        Marrow said nothing at all. She was looking at the river, very carefully, and not at Wren.
    }
    "Then we are carrying a dead man nine days," Isolde said at last, "to tell the King the war is over, with nothing to show him."
    She stood up and brushed off the blanket.
    "Then we'll find it," she said. "Or something very like it."
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
They wrapped him in the cart's canvas. It took all three of them to lift him, and Marrow did the feet.
{ AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "You were the only one who tried," Marrow said, not looking up from the knots. "With the bridle. I saw."
    ~ TRUST_MARROW += 1
}
{ TOLD_MARROW == "truth" && VERSION != "truth":
    # remember: marrow_refused_then_lied :: Marrow remembers you wouldn't lie for her.
    "You wouldn't lie for me," Marrow said quietly, so only Wren would hear. "But you'll lie for her."
    ~ TRUST_MARROW -= 1
}
{ TOLD_MARROW == "ambush" && VERSION == "truth":
    # remember: marrow_story_dropped :: Marrow remembers you agreed to her story.
    "We had a story," Marrow said, low. "You dropped it in the river with him."
    She tied the last knot hard.
    ~ TRUST_MARROW -= 1
}
{ VERSION == "hero" && not WENT_IN:
    # remember: dry_to_the_knee :: Isolde remembers you were dry to the knee.
    Isolde, passing with the end of the rope, said only, "You'll want to get wet for the next telling," and walked on.
}
{ TRUST_MARROW < 0:
    ~ DEBT_MARROW = true
    When it was done, Marrow wiped her hands on her coat. "Price for the rest of the road just doubled," she said. "Dead men are heavy."
- else:
    When it was done, Marrow wiped her hands on her coat and went to see to the grey without being asked.
}
-> s07_road

// ---------------------------------------------------------------
= s07_road
# scene: s07_road
# panel: road_to_stint_morning
~ DAYS_LEFT = 8
~ PLACE = "The road to Stint"
By full light they were on the road to Stint, the toll town a day to the south, with the Lantern under canvas in the back of the cart.
# know: stint :: Stint: a toll town a day's ride south. The first place anyone will see the Lantern.
The grey walked behind on a lead rein, with an empty saddle that shone.
Isolde sat beside the body with her satchel on her knees and wrote for an hour without stopping. Marrow walked ahead and did not look back.
Wren drove. The reins were still damp. Eight days to Vellmouth.
Somewhere ahead, in Stint, they would be ringing the bells.
# end: ch00
-> END
