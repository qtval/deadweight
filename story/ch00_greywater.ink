// PROLOGUE — THE GREYWATER
// One night at a ford, and the dawn after.
// Dramatic question: how did the Lantern die — and who gets to say?
// Voice: Wren, first person. See docs/WRITING_GUIDE.md and story/VOICE.md.

=== ch00 ===
# title: Prologue :: The Greywater
-> s01_ford

// ---------------------------------------------------------------
= s01_ford
# scene: s01_ford
# panel: greywater_ford_night
The Greywater was loud in the dark, fast and black and no deeper than my belt, and Sir Aubric Dane had decided to cross it drunk.
I was his squire. I had been his squire six years, which is long enough to tell a thing he had decided from a thing he could be talked out of. This was the first kind.
"By sunrise, Wren," he said, for the fourth time. "They'll ring every bell in the south for the Lantern. I'll not turn up at noon like a tinker with a cough."
"Yes, Sir Aubric," I said, which was what I said to most things.
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
The Lantern was what the songs called him, and three days back he had earned it. Ten years of war, and he had talked the hill towns into signing a surrender in one afternoon.
They had sent him off with two skins of their wine, to show there were no hard feelings, and he had drunk most of both before the river to show there were none on his side.
He sat his grey horse like a statue of himself, in full armor, polished for the bells. I had done the polishing. Squires carry things, and clean them.
A light moved on the far bank. That was Marrow, the guide. She had waded over to test the bottom and shouted back three words, and the words were "Wait for morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
He held the last of the wine down to me. "Drink, Wren. Tomorrow you're squire to the man who ended the war. You'll never pay for a cup again."
In six years he had never once paid me, either. But he said it so warmly that I forgot to mind. You warmed your hands at him and didn't count your fingers till later.
* [Drink with him]
    ~ DRANK = true
    I drank. It was sweet and strong, and I had not eaten since noon, and it went straight to my knees.
    "There," he said, pleased, as if he had taught me something.
* [Hand the skin back untouched]
    I handed it back. "One of us should be able to find the road," I said.
    "One of us is a horse," said Aubric, and slapped the grey's neck, and laughed at his own joke the way he always did, until you were laughing as well.
- Then he noticed my feet. I had been in and out of the shallows with the horses, and I was wet to the shins and shaking, and drunk as he was, he saw it.
He pulled off his riding gloves, the good ones with the fleece inside, and dropped them into my hands. "Can't have you sneezing through my triumph. Your mother would never forgive me. How is her chest?"
My mother washed shirts for the army and had spoken to him once, six years ago. He had asked after her chest every winter since. It would have been easier to hate him if he had forgotten. I put the gloves on. The mud at the river's edge sucked at my boots and stank of dead reeds.
He gathered the reins. Behind us the cart sat dark on the bank, with the chronicler asleep in it. There was nobody awake to stop him but me.
* [Take his bridle and hold him back]
    ~ AT_FORD = "bridle"
    I caught the bridle. The grey tossed its head. Aubric leaned down, breathing wine, and unpicked my fingers one at a time, humming.
    "You're a good squire," he said. "The best I've had. But you are a squire."
* [Shout across to Marrow to stop him]
    ~ AT_FORD = "called"
    "Marrow!" The river ate most of it. Over the water the light stopped, then started back toward us at a run.
    Aubric laughed. "She can't hear you," he said, "and I won't."
* [Say nothing. He hates being corrected.]
    ~ AT_FORD = "silent"
    I said nothing. Corrected, he got twice as stubborn and three times as loud, and I was tired, and my feet were wet, and I wanted my bed.
- Then he put his heels to the grey and rode into the Greywater, sitting very straight, in case anyone was watching.
-> s02_water

// ---------------------------------------------------------------
= s02_water
# scene: s02_water
# panel: greywater_water_churn
The grey went in to its belly, snorting. Halfway over, it put a hoof on a stone that wasn't there.
It went down on one shoulder. Aubric went off sideways, without a word, in sixty pounds of steel, and the water shut over him.
I waited for him to stand up. The river came no higher than his belt. Any moment he would rise up roaring and blame the horse, and I would spend tomorrow drying armor.
He didn't stand up. A gauntlet came out of the water, opened, closed on nothing, and went back in.
* [Go into the river after him]
    ~ WENT_IN = true
    I went in. The cold took my legs before the stones did. I went down on my hands and came up with a mouthful of river, and I didn't find him so much as fall on him.
    He got a hand in my collar. He pulled me down onto his breastplate and held me under. I don't think he knew it was me. He was holding on to the nearest thing.
    I couldn't get his fingers open. My chest was going. So I hit him. I hit the Lantern in the face with my elbow, three times, four, and felt something in his nose give, and he let go.
    I came up and breathed and was sick. By the time I had a strap in my fist and had started to pull, he had stopped helping.
* [Stay on the bank. Run for the rope.]
    ~ WENT_IN = false
    There was a rope on the cart. I ran for it. I told myself a squire who drowns beside his knight is no use to anyone. Some part of me that had polished that armor every night for six years thought, quite clearly: let it rust.
    I fell twice in the mud, the second time with my knee on a stone. I got a loop over the grey's saddle as it floundered out, and hauled, and the grey did the rest. It dragged him ashore by one stirrup, face down, like a sack of wet washing.
- It took longer to get him onto the stones than it had taken him to die.
-> s03_bank

// ---------------------------------------------------------------
= s03_bank
# scene: s03_bank
# panel: greywater_bank_body
He lay on his back on the near bank with the river running out of him. He smelled of wine and river mud.
I shook him. I thumped his breastplate with both fists, which did nothing but hurt my hands, so I heaved him over on his side. A great deal of water came out of him, and most of the wine, and no breath.
"Get up," I said. I was crying. I was so cold my teeth hurt.
And under the crying, small and perfectly clear, I thought that I would not have to be up before dawn to arm him.
Then I sat back on my heels and did sums.
Six years' wages, which he had always been about to pay. His purse hung on his belt. He gave silver to beggars where people could see, and owed it everywhere else.
* [Take what he owed you]
    ~ PURSE = true
    Six years. I took the purse. It didn't come to six weeks.
    I took his gloves off to do it. I don't know why.
* [Leave the purse]
    I let it hang. I'm not sure that was honesty. I couldn't stand to be paid at last and find out how little it came to.
- The sums went on. A place in his household in Vellmouth, the capital: promised, never written down. Myself: a laundress's child who could read, squire to a dead man.
An hour back on the road he had told me the third verse of his song didn't scan. He had meant to have it mended before the bells.
Then I thought about the letter, and the sums got worse.
It was on the same belt, in an oilskin case: the surrender the hill towns had signed three days back. The King's council in Vellmouth had to countersign it before the month ran out, and the month had nine days left in it. After that it was only paper, and the war started again in the spring.
# know: letter :: The surrender, signed by the hill towns. The King's council in Vellmouth, the capital, must countersign it within nine days, or the war starts again.
He had explained all this at every inn on the road south. He had loved explaining it.
The case was dry. Whoever held it was worth keeping alive for nine days. I couldn't think of one other thing about me that was.
Out on the water, Marrow's light was coming back, low and quick.
* [Take the case and hide it under your shirt]
    ~ LETTER = "wren"
    The buckle was stiff with cold, and my hands were worse. I got it open and pushed the case inside my shirt, flat against my ribs, where it sat like ice.
* [Leave it on his belt]
    ~ LETTER = "body"
    I didn't touch it. A squire found with the peace inside their shirt and a dead knight at their feet has a good deal to explain, and I have never been quick at explaining.
- -> s04_marrow

// ---------------------------------------------------------------
= s04_marrow
# scene: s04_marrow
# panel: greywater_marrow_wading
Marrow came up out of the river with her lantern held high, and stopped when the light reached him.
She said nothing for some time. Then she said, "That's my fee gone."
{ AT_FORD == "called":
    "You called," she said. "I heard. I'd have come quicker if I'd thought he would listen to either of us."
    ~ TRUST_MARROW += 1
}
{ AT_FORD == "silent":
    "I was watching from the far side," she said. "You never said a word to him."
}
{ DRANK:
    # remember: drank_with_him :: Marrow remembers the wine on your breath.
    She leaned in and sniffed, and it wasn't him she was sniffing. "And you've been at it too," she said. "Lovely."
}
{ WENT_IN:
    His nose was bent flat to one side and leaking blood. I had pulled his wet hair across it, and it would not stay. I had hit him, and then he had stopped.
}
{ WENT_IN:
    She turned his face to the light with one finger. She looked at his nose, then at my elbow, then at me. "River do that?"
    "He fell on the stones," I said. What I thought was: four times.
    # remember: broken_nose :: Marrow remembers the Lantern's broken nose.
    "Course he did," said Marrow. She let his head go, and it rolled.
}
She crouched across the body from me. There was a short knife on her belt. I had watched her gut a hare with it at noon.
"Here's how it goes," she said. "A Crown hero drowns at a ford. The guide who picked the ford deserted from the other side. Who hangs?"
I didn't answer. I was working something out. Two people had seen him drown. She only needed there to be one.
"So he didn't drown," said Marrow. "Hill stragglers, in the dark. An arrow. He died with his sword out. Nobody hangs for that but stragglers, and they're hanging anyway."
* [Agree to her story: an ambush]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    "An ambush," I said. "I saw it." I had never seen an arrow hit anything but straw.
    Marrow's shoulders came down an inch, and her hand came away from her belt. I had not seen it go there.
    "Good," she said. "You're quicker than he was."
* [Refuse. Say he drowned.]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," I said. "That's what happened."
    "It's what happened," said Marrow. "It isn't what's going to have happened. And if it comes to your word against mine, squire, think about which of us {WENT_IN:was close enough to break his nose|was standing next to him}."
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," I said. "I'll decide at dawn."
    "Dawn's when she wakes up." Marrow jerked her head at the cart. "Decide before. Her kind don't ask what you saw. They tell you."
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That dry?"
    It was. She nodded slowly, and kept her hands on her knees.
    "There's people I know on that paper," she said. She didn't say whether that was good for them.
    ~ MARROW_KNOWS_LETTER = true
- else:
    Her eyes went to his belt, and the empty buckle. "Where's his letter?" She hadn't raised her voice. Her hand was back at her belt.
    -> marrow_asks_letter
  }
  -> s05_dawn

= marrow_asks_letter
* [Show her you have it]
    ~ MARROW_KNOWS_LETTER = true
    ~ TRUST_MARROW += 1
    I opened my shirt far enough to show the oilskin. My fingers would hardly work the lacing. Marrow looked at it, then at me, for longer than I liked.
    "Keep it there," she said. "And stop showing people. There's people I know on that paper."
* [Say you haven't seen it]
    "Haven't seen it," I said.
    She held the lantern up to my face. I could feel the heat of it on my cheek and the case cold on my ribs, and I kept my arms where they were.
    "River, then," said Marrow at last, the way you would to a child who says the dog ate the cheese. She lowered the lantern. She didn't take her eyes off my shirt.
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
It got light without any sun in it. Isolde Ferrant climbed down from the cart with a blanket round her shoulders and ink on two fingers. She took a draught to sleep, and nothing short of a fire woke her.
She was the chronicler the Crown had sent along to write the Lantern's ballad. She had written most of it before we set out.
She had always been kind to me. She knew my name, and asked after my cough in winter, and I had never worked out what it was for.
I had sat by him all night in wet clothes, in a stink of horse and wet wool. Some time before dawn I had stopped shivering, and Marrow had said that was a bad sign and thrown the horse blanket over me.
Isolde looked at the body the way she would look at a page with a blot on it.
"Did anyone else see?" she said.
"Just us," said Marrow.
Isolde nodded and turned to me. "Wren. Tell me how he died."
* [Tell her the truth: he drowned, drunk]
    ~ VERSION = "truth"
    I told it straight: the wine, the armor, the stone that wasn't there, the water to his belt.
    { WENT_IN: -> truth_elbow }
    -> truth_told
* [Tell her Marrow's story: an ambush]
    ~ VERSION = "ambush"
    ~ LEGEND += 1
    I told it the way Marrow had built it: the dark, the bows, the Lantern turning his horse to face them. It came out easily.
    Isolde leaned forward. "Did he say anything?"
    "Something about bells," said Marrow, at once.{TOLD_MARROW == "truth": She didn't look at me. She didn't need to.}
    "Good. But not hill men," said Isolde. "Robbers. Nobody's men. If the hill towns killed him three days after they signed, the war starts again with no help from us."
    "Robbers," said Marrow. "Fine. They rob."
* [Tell her he went into the river after you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," I said. "He came in after me. He got me out. The river kept him."
    Marrow turned her head and looked at me as she might at a dog that had started talking.{TOLD_MARROW == "ambush": "That's not—" she said, and stopped.}
    { WENT_IN:
        Isolde looked me over. I was soaked to the collar and grey with cold. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        Isolde looked me over. I was mud to the knee and dry above it. The corner of her mouth moved. She nodded anyway. She would sooner have a good lie than an honest squire.
    }
    "That's the third verse," she said softly. "That's the one that didn't scan."
- -> s05_plan

= truth_elbow
* [Tell her about your elbow]
    ~ ELBOW = "told"
    "He had hold of me," I said. "I hit him. In the face. Then he stopped."
    Nobody spoke. Marrow looked at the sky.
    "He struck his face on the stones," said Isolde, after a while. "You will not say otherwise again, and I will not write it down. That is a kindness, Wren. Remember who did it."
* [Leave out your elbow]
    ~ ELBOW = "hidden"
    I left out my elbow. It had started to swell, and I kept that arm under the blanket.
- -> truth_told

= truth_told
Isolde shut her eyes. "In a ford," she said. "Drunk. A child could have crossed it."
"A child would've waited for morning," said Marrow. She had gone very still. "And the guide, in this true story? What happens to her?"
"Nothing happens to anybody," said Isolde, pleasantly, "because nobody is going to tell it. If I hear it from a tollkeeper, Wren, I shall know whose mouth it came out of. I should hate that."
-> s05_plan

= s05_plan
"Listen," said Isolde. "The hill towns didn't surrender to the Crown. They surrendered to him. To his word that nobody hangs."
"His word's on the paper," said Marrow.
"His word is lying there with its mouth open. The hour the court hears he is dead, the men who sell the army its bread will say the paper died with him. Your hill towns will agree."
"So ride the paper south," said Marrow. "Why haul him?"
"Because the council will not sign for a rider. They will sign for the Lantern, or for a door with him behind it." Isolde looked fondly at the body. "So he isn't dead. He has a fever. He rides in the cart till the King's ink is dry."
"He'll stink by the fourth day," said Marrow.
"Heroes do. We'll burn something."
She turned to me. "Nobody will take my word that he is alive in there. They will take his squire's. You carry out his pot. You tell them he is sleeping. Well?"
* [Say you'll do it]
    ~ PLAN = "agreed"
    "I'll do it," I said. What I thought was that nine days is a long time to carry out a dead man's pot, and that nobody had said what becomes of the squire on the tenth.
    "Of course you will," said Isolde, and patted my hand.
* [Ask what's in it for you]
    ~ PLAN = "bargained"
    ~ ISOLDE_OWES = true
    "And what do I get?" I said. My voice shook, and not all of that was the cold.
    Marrow laughed, once. It was the first time I had heard her do it.
    Isolde studied me like a word she had misspelled. Then she smiled. "A place in a household in Vellmouth. Written down, this time. I'll draw it up tonight."
    She knew about the promise. I had never told her about the promise.
* [Tell her it's madness]
    ~ PLAN = "objected"
    "It's madness," I said. "He's dead. Anyone who lifts that canvas—"
    "Then nobody lifts it," said Isolde. "It is nine days of madness or ten more years of war, and I know which I would sooner you drove. Unless you have a third thing?"
    I didn't have a third thing. She waited, politely, until all three of us were sure of it.
- "And the guide who picked the ford?" said Marrow.
"Is paid for a quiet road," said Isolde, "and was never at a ford in her life. We came round by the bridge."
"The bridge is two days east."
"Then we made excellent time."
"The fever is for the road," Isolde said to me. "The dying is for Vellmouth, and for the song. I have been paid for a ballad with a triumph at the end of it, and I have spent the money. {VERSION == "truth":He dies of whatever I can rhyme.}{VERSION == "ambush":He dies of his wounds, in the capital, with the bells.}{VERSION == "hero":He dies of a chill he took pulling you out of a river. Some other river. You are in the song, Wren. Think of that.}"
{ VERSION == "hero":
    I did think of it.
}
She held out an inky hand to me. "Now. The surrender. Where is it?"
{ LETTER == "body": -> letter_on_body }
-> letter_with_wren

= letter_on_body
Before I could move she had knelt and unbuckled the case herself. She checked the seal and didn't open it.
* [Let her take it]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    She tucked it into her satchel, beside the ballad.
    "Thank you, Wren," she said, as though I had given it to her.
    "You're welcome," I said. I have no idea why.
* [Hold out your hand. "I'm his squire. I carry it."]
    Isolde looked at my hand. It wasn't steady. She thought about refusing. Then she saw Marrow watching, with a thumb in her belt.
    She put the case in it.
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    "Of course," she said, and smiled. "His squire." I would have felt better if she had argued.
- -> s06_wrap

= letter_with_wren
* [Give it to her]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    I took the case out of my shirt and held it out. Isolde checked the seal, didn't open it, and put it in her satchel beside the ballad.
    "Thank you, Wren," she said. My ribs felt cold where it had been.
* [Keep it. "I'll carry it. I was his squire."]
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    Isolde looked at the shape under my shirt, then at my face.
    "Of course," she said, and smiled. "His squire." I would have felt better if she had argued.
* [Tell her the river took it]
    ~ LETTER = "hidden"
    "The river," I said. "It must have come off in the water."
    Isolde went white all at once, the way paper does in a fire just before it catches.
    { MARROW_KNOWS_LETTER:
        Marrow said nothing at all. She studied the river, very carefully, and not me. I owed her for that now, and she would know to the penny how much.
    - else:
        Marrow looked at my shirt, and then at the sky, and scratched her neck.
    }
    "Then we are carrying a dead man nine days," Isolde said at last, "to tell the King the war is over, with nothing to show him."
    She looked at my shirt for exactly as long as Marrow had. Then she stood up and shook out the blanket.
    "So we'll find it," she said. "Or something very like it."
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
We wrapped him in the cart's canvas. It took all three of us to lift him. Marrow did the feet.
I had the head. Squires carry things. I had carried his shield, his debts and his excuses to innkeepers, and now I carried him, and my arms shook with the weight. I was still wearing his gloves.
Nobody asked me why I was doing it.
* [For the peace.]
    ~ SELF = "peace"
    Ten years of war, ending in a roll of canvas, and me with one end of it. I held on to that. It was heavier than he was.
* [For him.]
    ~ SELF = "him"
    He never paid me. He gave me his gloves. I couldn't make the two come out even, so I carried him.
* [For what I'm owed.]
    ~ SELF = "wages"
    Somebody in Vellmouth would pay to have him delivered. I only had to learn who, and how much, and stay alive till I had.
- { AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "You were the only one who tried," Marrow said, not looking up from the knots. "With the bridle. I saw you against the water."
    ~ TRUST_MARROW += 1
}
{ PURSE:
    Marrow ran her thumb along his belt where the purse had hung. She looked at me and didn't say a thing. Then she unbuckled his spurs and put them in her coat.
    # remember: light_purse :: Marrow remembers the purse was gone.
    "Fair's fair," she said.
}
{ TOLD_MARROW == "truth" && VERSION != "truth":
    # remember: marrow_refused_then_lied :: Marrow remembers you wouldn't lie for her.
    "You wouldn't lie for me," Marrow said quietly, so only I would hear. "But you'll lie for her."
    ~ TRUST_MARROW -= 1
}
{ TOLD_MARROW == "truth" && VERSION == "truth":
    # remember: honest_twice :: Marrow remembers you wouldn't lie for anyone.
    "You wouldn't lie to save my neck," Marrow said, low. "Then you wouldn't lie for her. That's honest or it's stupid, and I can't afford to find out which. You don't get behind me again."
}
{ TOLD_MARROW == "ambush" && VERSION == "truth":
    "We had a story," Marrow said, low. "You dropped it in the river with him."
    # remember: marrow_story_dropped :: Marrow remembers you agreed to her story.
    She pulled the last knot tight enough to creak.
    ~ TRUST_MARROW -= 1
}
{ VERSION == "hero" && not WENT_IN:
    # remember: dry_to_the_knee :: Isolde remembers you were dry above the knee.
    Isolde, passing with the end of the rope, said only, "Fall in something before the next telling," and walked on.
}
{ TRUST_MARROW < 0:
    ~ DEBT_MARROW = true
    When it was done, Marrow wiped her hands on her coat. "My price for the rest of the road just doubled," she said. "Dead men are heavy."
- else:
    When it was done, Marrow wiped her hands on her coat and went to see to the grey without being asked.
}
Isolde tied the canvas down herself, with a knot I didn't know. I would never get it open again without her seeing that I had.
-> s07_road

// ---------------------------------------------------------------
= s07_road
# scene: s07_road
# panel: road_to_stint_morning
~ DAYS_LEFT = 8
~ PLACE = "The road to Stint"
By full light we were on the road south, with the Lantern under canvas in the back of the cart.
Stint, the toll town where the first bells were waiting, was one night's ride for a man on a good horse. With a cart and a dead man it would take us till dark.
# know: stint :: Stint: the toll town to the south, where the bells are waiting. The first place anyone will ask to see the Lantern.
The grey walked behind on a lead rein, with its empty saddle shining.
Isolde sat by the body with her satchel on her knees and wrote without looking up. {TOLD_MARROW == "truth" && VERSION == "truth":Marrow walked behind the cart, where she could see my back.|Marrow walked ahead and did not look back.}
{ WENT_IN:
    I drove. I was coughing up the Greywater a little at a time, and every cough hurt somewhere new.
- else:
    I drove, with my bad knee stuck out straight like a plank.
}
Eight days to Vellmouth.
Somewhere ahead they would be ringing the bells for him. I caught myself hoping he would enjoy it.
# end: ch00
-> END
