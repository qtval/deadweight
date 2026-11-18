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
"By sunrise, Wren," he said, again. "They'll ring every bell in the south for the Lantern. I'll not turn up at noon like a tinker with a cough."
"Yes, Sir Aubric," I said. Piss on your bells, I thought. My feet were wet.
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
The Lantern was what the songs called him, and three days back he had earned it. Ten years of war, and he had talked the hill towns into signing a surrender in one afternoon. They had sent him off with two skins of their wine. He had drunk most of both before the river.
He sat his grey horse like a statue of himself, in full armor, polished for the bells. I had done the polishing. Squires carry things, and clean them.
A light moved on the far bank, under the alders. That was Marrow, the guide. She had waded over to test the bottom and shouted back three words, and the words were "Wait for morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
He held the last of the wine down to me. "Drink, Wren. Tomorrow you're squire to the man who ended the war. You'll never pay for a cup again."
He had never once paid me, either. But he said it so warmly that I forgot to mind. You warmed your hands at him and didn't count your fingers till later.
* [Drink with him]
    ~ DRANK = true
    I drank. It was sweet and strong, and I had not eaten since noon, and it went straight to my knees.
    "There," he said.
* [Hand the skin back untouched]
    I handed it back. "One of us should be able to find the road," I said.
    "One of us is a horse," said Aubric, and slapped the animal's neck, and laughed until I was laughing as well.
- "I shall be modest," he said. "I've been practising. 'Good people, I did nothing. A little talking.' Then I look at my boots. Do I look at my boots, Wren, or is that too much?"
"The boots are good, Sir Aubric."
"The boots are good. Then somebody shouts 'The Lantern!' and I say 'No, no,' and wave. Like this." He waved, and nearly came off the horse. "And you'll be paid, Wren. Every penny, the day we ride in. Remind me."
He noticed my feet. I had been in and out of the shallows with the horses. I was wet to the shins and shaking, and drunk as he was, he saw it.
He pulled off his riding gloves, the good ones with the fleece inside, and dropped them into my hands. "Can't have you sneezing through my triumph. Your mother would never forgive me. How is her chest?"
My mother washed shirts for the army and had spoken to him once. He had asked after her chest every winter since. It would have been easier to hate him if he had forgotten. I put the gloves on. The bank was army-cart slop to the ankle, and it stank of dead reeds.
He gathered the reins. Behind us the cart sat dark, with the chronicler asleep in it. There was nobody awake to stop him but me.
* [Take his bridle and hold him back]
    ~ AT_FORD = "bridle"
    I caught the bridle. The horse tossed its head. Aubric leaned down, breathing wine, and unpicked my fingers one at a time, humming.
    "I talked ten years of war to death in an afternoon," he said. "I believe I can manage a stream. You're a good squire, Wren. But you are a squire."
* [Shout across to Marrow to stop him]
    ~ AT_FORD = "called"
    "Marrow!" The river ate most of it. Over the water the light stopped, then began to move along the far bank, hunting for the shallow way back.
    Aubric laughed. "She can't hear you," he said, "and I won't."
* [Say nothing. He hates being corrected.]
    ~ AT_FORD = "silent"
    I said nothing. Corrected, he got twice as stubborn and three times as loud, and I was tired, and I wanted my bed.
- Then he put his heels to the horse and rode into the Greywater, sitting very straight, in case anyone was watching.
-> s02_water

// ---------------------------------------------------------------
= s02_water
# scene: s02_water
# panel: greywater_water_churn
The horse went in to its belly, snorting. Halfway over, it put a hoof on a stone that wasn't there.
It went down on one shoulder. Aubric went off sideways, without a word, in sixty pounds of steel, and the water shut over him.
I waited for him to stand up. The river came no higher than his belt. Any moment he would rise up roaring and blame the horse, and I would spend tomorrow drying armor.
A hand came out of the water, bare and white, opened, closed on nothing, and went back in.
* [Go into the river after him]
    ~ WENT_IN = true
    I went in. The cold took my legs before the stones did. I went down on my hands and came up with a mouthful of river that tasted of mud and horse, and I didn't find him so much as fall on him.
    He got a hand in my collar. He pulled me down onto his breastplate and held me under. I don't think he knew it was me. He was holding on to the nearest thing.
    I couldn't get his fingers open. My chest was going. So I hit him. I hit the Lantern in the face with my elbow, three times, four, and felt something in his nose give, and he let go.
    I came up and breathed and was sick down my own front. By the time I had a strap in my fist and had started to pull, he had stopped helping.
* [Stay on the bank. Run for the rope.]
    ~ WENT_IN = false
    There was a rope on the cart. I ran for it. I told myself a squire who drowns beside his knight is no use to anyone. Some part of me that had polished that armor every night thought, quite clearly: let it rust.
    I fell twice in the slop, the second time with my knee on a stone. I got a loop over the saddle as the horse floundered out, and hauled, and the horse did the rest. It dragged him ashore by one stirrup, face down, like a sack of wet washing.
- It took longer to get him onto the stones than it had taken him to die.
-> s03_bank

// ---------------------------------------------------------------
= s03_bank
# scene: s03_bank
# panel: greywater_bank_body
He lay on his back on the gravel with the river running out of him. He smelled of wine and mud.
I shook him. I thumped his breastplate with both fists, then heaved him over on his side. A great deal of water came out of him, and most of the wine, and no breath.
"Get up," I said. "Get up, you stupid old bastard." I was crying. I was so cold my teeth hurt.
And under the crying I thought, I won't have to be up before dawn to arm him.
Then I sat back on my heels and did sums.
Six years' wages, which he had always been about to pay. His purse hung on his belt. He gave silver to beggars where people could see, and owed it everywhere else.
* [Take what he owed you]
    ~ PURSE = true
    I pulled off the gloves he had given me to do it, and put them on again after. The purse didn't come to six weeks.
* [Leave the purse]
    I let it hang. I am not a thief. I weighed it in my hand first, only to be sure of that.
- There was more. He had promised me a place in his household in Vellmouth, the capital, and never written it down. Without him I was a laundress's child who could read.
An hour back on the road he had told me the third verse of his song didn't scan. He had meant to have it mended before the bells.
Then I thought about the letter, and the sums got worse.
It was on the same belt, in an oilskin case: the surrender. He had explained it, lovingly, at every inn on the road south. The hill towns had signed it for him, on his word that nobody would hang. They would never have signed it for anyone else.
The King's council in Vellmouth had to put their names under his before the month was out, and the month had nine days left in it. If he was known to be dead first, there were men at court who would call it waste paper, and the war would start again in the spring.
# know: letter :: The surrender, signed by the hill towns on Aubric's word. The King's council in Vellmouth, the capital, must countersign it within nine days, and must not learn he is dead first, or the war starts again.
The case was dry. Whoever held it was worth keeping alive for nine days. Whoever was caught holding it without leave was a thief of the King's peace, and they hang those.
Out on the water, Marrow's light was coming back, low and quick.
* [Take the case and hide it under your shirt]
    ~ LETTER = "wren"
    The buckle was stiff with cold, and my hands were worse. I got it open and pushed the case inside my shirt, flat against my ribs. It was colder than I was.
* [Leave it on his belt]
    ~ LETTER = "body"
    I didn't touch it. It wasn't mine to touch. I did try the buckle, twice, to be sure it would open quickly if it had to.
- -> s04_marrow

// ---------------------------------------------------------------
= s04_marrow
# scene: s04_marrow
# panel: greywater_marrow_wading
Marrow came up out of the river with her lantern held high, and stopped when the light reached him.
She looked at him. "That's my fee gone," she said.
{ AT_FORD == "called":
    "You called," she said. "I heard. I'd have come quicker if I'd thought he would listen to either of us."
    ~ TRUST_MARROW += 1
}
{ AT_FORD == "silent":
    "I was watching from the far side," she said. "You never said a word to him."
}
{ DRANK:
    # remember: drank_with_him :: Marrow remembers the wine on your breath.
    She leaned in and sniffed, and it wasn't him she was sniffing. "Two drunks and a river," she said. "I should charge by the fool."
}
{ WENT_IN:
    His nose was bent flat to one side and leaking blood. I had pulled his wet hair across it, and it would not stay.
}
{ WENT_IN:
    She turned his face to the light with one finger. She looked at his nose, then at my elbow, then at me. "River do that?"
    "He fell on the stones," I said. What I thought was: four times.
    # remember: broken_nose :: Marrow remembers the Lantern's broken nose.
    "Course he did," said Marrow. She let his head go, and it rolled.
}
She crouched across the body from me. There was a short knife on her belt. I had watched her gut a hare with it at noon.
"Here's how it goes," she said. "A Crown hero drowns at a ford. His escort's a day ahead, polishing bells. The guide who picked the ford used to fight for the hill towns. Who hangs?"
I didn't answer. Two people had seen him drown. She only needed there to be one.
"So he didn't drown," said Marrow. "Hill stragglers, in the dark. An arrow. He died with his sword out. Nobody hangs for that but stragglers, and they're hanging anyway."
* [Agree to her story: an ambush]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    "An ambush," I said. "I saw it."
    Marrow's hand came away from her belt. I had not seen it go there.
    "Good," she said. "You're quicker than he was." She unstoppered her flask and passed it over the body. It wasn't wine. It was hot all the way down, and I didn't ask.
* [Refuse. Say he drowned.]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," I said. "That's what happened."
    Marrow came round the body quicker than I could stand. She took my collar in her fist, where he had, and pulled my face down to his.
    "Look at him. That's what happened. It isn't what's going to have happened. Say different, and I'll say the squire was close enough to {WENT_IN:break his nose|push him}."
    She let go. I stayed where she had put me.
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," I said. "I'll decide at dawn."
    "Dawn's when she wakes up." Marrow jerked her head at the cart. "Decide before. Her kind don't ask what you saw. They tell you."
    She came round the body and sat down against me, shoulder to shoulder, with the knife out across her knees.
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That dry?"
    It was. She kept her hands on her knees.
    "There's people I know on that paper," she said. She didn't say whether that was good for them.
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
    I opened my shirt far enough to show the oilskin. My fingers would hardly work the lacing. Marrow looked at it, then at me.
    "Keep it there," she said. "And stop showing people. There's people I know on that paper."
* [Say you haven't seen it]
    ~ MARROW_KNOWS_LETTER = true
    ~ TRUST_MARROW -= 1
    "Haven't seen it," I said.
    Marrow took hold of my shirt and opened it, not roughly, the way you'd open a sack to see what was in it. She looked at the oilskin. She did the lacing up again and patted it flat.
    "River's had a busy night," she said. "Lie to the chronicler all you want. Lie to me again and I'll have that off you, and two fingers to carry it in."
    I believed her. My knees had gone to water, and I stayed exactly where I was.
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
It got light without any sun in it. Mist stood on the water, and the first fly found him.
{ TOLD_MARROW:
- "ambush": I had sat by him all night in wet clothes. Some time in the dark Marrow had thrown the horse blanket over me and called me an idiot for needing it.
- "truth": I had sat by him all night in wet clothes. Marrow had the horse blanket round her own shoulders, and I had stopped shivering, which I knew was bad.
- else: I had sat by him all night in wet clothes, with Marrow against me and the knife across her knees. It was the only warm side I had.
}
He had begun to smell, or I had. There was piss in it, his or mine.
Isolde Ferrant climbed down from the cart with ink on two fingers. She had slept through all of it.
She was the Crown's chronicler, sent along to write the Lantern's ballad, and she had written most of it before we set out. She knew my name and used it, and I had never worked out what that was for.
She looked at the body. She sat down on the wet gravel in her good skirt, quite suddenly, and got up again.
"Did anyone else see?" she said.
"Just us," said Marrow.
Isolde turned to me. "Wren. Tell me how he died."
* [Tell her the truth: he drowned, drunk]
    ~ VERSION = "truth"
    I told it straight: the wine, the armor, the hole in the ford. I was careful to get in what I had done to stop him{AT_FORD == "silent":, which took some arranging}.
    { WENT_IN: -> truth_elbow }
    -> truth_told
* [Tell her Marrow's story: an ambush]
    ~ VERSION = "ambush"
    ~ LEGEND += 1
    I told it the way Marrow had built it: the dark, the bows, the Lantern turning his horse to face them.
    Isolde leaned forward. "Did he say anything?"
    "Something about bells," said Marrow, at once.{TOLD_MARROW == "truth": She didn't look at me.}
    "Not hill men, though," said Isolde. "Robbers. Nobody's men. If the hill towns killed him the same week they signed, the war starts again with no help from us.{WENT_IN: And they broke his nose for him. Good. It looks like a fight.} You tell it nicely, Wren. I had no idea."
    I was pleased that she was pleased.
* [Tell her he went into the river after you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," I said. "He came in after me. He got me out. The river kept him."
    He would have, if he had been sober, and if he had noticed, and if there had been people there to see. He would have gone in for a dog, with people there to see. So it was nearly true. And it turned six years of carrying out his pot into something, and I wanted that so badly my ears rang.
    "Oh, you little shit," said Marrow, quite softly.{TOLD_MARROW == "ambush": "We had a story."}
    { WENT_IN:
        Isolde looked me over. I was soaked to the collar and grey with cold. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        Isolde looked me over. I was mud to the knee and dry above it. The corner of her mouth moved. She nodded anyway.
    }
    {WENT_IN:"And his nose?" she said.|"That's the third verse," she said. "That's the one that didn't scan."}
    { WENT_IN:
        "Stones," said Marrow, looking at me.
        "Stones. Then that's the third verse. That's the one that didn't scan."
    }
- -> s05_plan

= truth_elbow
* [Tell her about your elbow]
    ~ ELBOW = "told"
    "He had hold of me," I said. "I hit him. In the face. Then he stopped."
    Nobody spoke. Marrow looked at the sky.
    "He struck his face on the stones," said Isolde, after a while. "You will not say otherwise again, and I will not write it down. That is a kindness, Wren. Remember who did it."
    ~ ISOLDE_SAW_NOSE = true
* [Leave out your elbow]
    ~ ELBOW = "hidden"
    I left out my elbow. It had started to swell, and I kept that arm behind me.
- -> truth_told

= truth_told
Isolde shut her eyes. "In a ford. Drunk. A child could have crossed it."
"A child would've waited for morning," said Marrow. "And the guide, in this true story? What happens to her?"
"Nothing happens to anybody," said Isolde, "because nobody will ever hear it. Say this for me, Wren. He has a fever."
"He has a fever," I said.
"Oh dear. Again, and look at me, not at him."
I said it five times before she was satisfied. Marrow watched me learn.{ELBOW == "hidden": Then Isolde bent and looked at his nose, and at me, and asked nothing, which was worse.}
-> s05_plan

= s05_plan
"Close his mouth, Wren," said Isolde. "He looks surprised."
I pushed his jaw up. It came down again. I tied it shut with my neckcloth.
"Does anybody need it explained what becomes of that paper if he is dead?"
"War," said Marrow.
"War. So he has a fever. He rides in the cart till the King's ink is dry. They will not take my word that he is alive in there, Wren. They will take his squire's. You carry out his pot. You tell them he is sleeping. Well?"
* [Say you'll do it]
    ~ PLAN = "agreed"
    ~ RING = true
    "I'll do it," I said. Nobody had said what becomes of the squire on the tenth day, and I didn't ask.
    "Of course you will." Isolde worked the signet off his finger. It took some twisting. She put it in my hand, still wet. "Then you speak for him. And if anybody asks afterwards who it was that said he was alive, that was you. Try not to enjoy it."
* [Ask what's in it for you]
    ~ PLAN = "bargained"
    ~ ISOLDE_OWES = true
    "What do I get?" I said. My teeth were knocking together.
    "Hah," said Marrow.
    Isolde tore a strip from the foot of a page, wrote on her knee, and blew on it. "A place in a household in Vellmouth. Written down, this time."
    She knew about the promise. I had never told her about the promise. I took the paper anyway. It was the first thing with my name on it I had ever owned.
* [Tell her it's madness]
    ~ PLAN = "objected"
    "It's madness," I said. "He's dead. Anyone who lifts that canvas—"
    "Quite right. I had not thought of that, and I'm obliged to you." Isolde smiled at me. "So when they lift it, they must find somebody under there with him. A squire, nursing his master. You'll ride in the back, Wren, under the canvas, and hold his hand."
    Marrow made a noise into her sleeve.
    I looked for something else to say. I had a neckcloth, and he was wearing it.
- "Ride the paper south," said Marrow. "Leave him here."
"The council will not sign for a rider. They'll sign for him, or for the door of his sickroom."
"He'll stink by the third day."
"Heroes do. We'll burn something."
"And the guide who picked the ford?"
"Is paid for a quiet road," said Isolde, "and was never at a ford in her life. We came round by the bridge."
"The bridge is two days east."
"Then we made excellent time."
"The fever is for the road," Isolde said to me. "The dying is for Vellmouth, and for the song. I have been paid for a ballad with a triumph at the end of it, and I have spent the money. {VERSION == "truth":He dies of whatever I can rhyme.}{VERSION == "ambush":He dies of his wounds, in the capital, with the bells.}{VERSION == "hero":He dies of a chill he took pulling you out of a river. Some other river. You are in the song, Wren. Think of that.}"
{ VERSION == "hero":
    I did think of it.
}
{ VERSION == "ambush":
    "If an arrow killed him, he'll want a hole," said Marrow.
    "Under the arm," said Isolde, "where the plate doesn't cover. Wren, hold him still."
    He didn't need holding. I held him anyway, by the shoulders, and looked at the alders while Marrow did it. It made a noise like a boot coming out of mud.
}
She held out an inky hand to me. "Now. The surrender. Where is it?"
{ LETTER == "body": -> letter_on_body }
-> letter_with_wren

= letter_on_body
She knelt and unbuckled the case herself, and checked the seal.
* [Let her take it]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    She tucked it into her satchel, beside the ballad.
    "Thank you, Wren," she said, as though I had given it to her.
    "You're welcome," I said.
    "That's your neck she's got in there," said Marrow, not quietly.
* [Hold out your hand. "I'm his squire. I carry it."]
    Isolde looked at my hand. It wasn't steady. She thought about refusing. Then she saw Marrow, with a thumb in her belt.
    She put the case in it.
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    "Of course," she said, and smiled. "His squire."
- -> s06_wrap

= letter_with_wren
* [Give it to her]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    I took the case out of my shirt and held it out. Isolde checked the seal, didn't open it, and put it in her satchel beside the ballad.
    "Thank you, Wren," she said. My ribs felt cold where it had been.
    "That's your neck you just gave her," said Marrow, not quietly.
* [Keep it. "I'll carry it. I was his squire."]
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    Isolde looked at the shape under my shirt, then at my face.
    "Of course," she said, and smiled. "His squire." I would have felt better if she had argued.
* [Tell her the river took it]
    ~ LETTER = "hidden"
    "The river," I said. "It must have come off in the water."
    Isolde went white. She went to the body and looked at his belt herself. The buckle was undone, not torn. She looked at it for a while, and then at the river, and not at me.
    "Then we are carrying a dead man nine days," she said, "to tell the King the war is over, with nothing to show him. So we'll find it. Or something very like it. I have seen his hand often enough."
    Behind her, where only I could see, Marrow held out her hand, palm up, and closed it slowly.
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
We wrapped him in the cart's canvas. It took all three of us to lift him. Marrow did the feet.
I had the head. Squires carry things. I had carried his shield and his debts and his excuses to innkeepers, and now I carried him. He was heavier than all of it, and he leaked.
Before the canvas went over his hands, I saw my own. I was still wearing his gloves.
* [Put the gloves back on his hands]
    ~ SELF = "him"
    I pulled them off and worked them onto his hands. His fingers had gone stiff. It took a while, and Marrow swore at me for every finger. He ought to go to his bells with his gloves on. Isolde stopped writing to watch me do it, and I took a little longer over the last one.
* [Fold his hands on his sword, like the songs]
    ~ SELF = "peace"
    I folded his hands on his sword hilt, the way they lie in the songs. Somebody would lift that canvas in the end, and he had to look like what we were selling. It was the peace I was thinking of. I kept the gloves on to do it.
* [Keep them. He gave them to you.]
    ~ SELF = "wages"
    I kept them. They had fleece inside, and he had given them to me with nobody watching, which was the only time he ever gave me anything. If that was my six years' pay, I was having it.
- { AT_FORD == "bridle":
    ~ TRUST_MARROW += 1
}
{
- TOLD_MARROW == "truth" && VERSION != "truth":
    # remember: marrow_refused_then_lied :: Marrow remembers you wouldn't lie for her.
    "You wouldn't lie for me," Marrow said quietly, so only I would hear. "But you'll lie for her."
    ~ TRUST_MARROW -= 1
- TOLD_MARROW == "truth" && VERSION == "truth":
    # remember: honest_twice :: Marrow remembers you wouldn't lie to save her neck.
    "You wouldn't lie to save my neck," Marrow said, low. "And it took her five goes to teach you one. That's honest or it's stupid, and I can't afford to find out which. You don't get behind me again."
- TOLD_MARROW == "ambush" && VERSION == "truth":
    "We had a story," Marrow said, low. "You dropped it in the river with him."
    # remember: marrow_story_dropped :: Marrow remembers you agreed to her story.
    She pulled the last knot tight enough to creak.
    ~ TRUST_MARROW -= 1
- AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "You had hold of his bridle," Marrow said, not looking up from the knots. "I saw you against the water. Should've hung on."
}
{ PURSE:
    Marrow ran her thumb along his belt where the purse had hung. She looked at me and didn't say a thing. Then she unbuckled his spurs and put them in her coat.
    # remember: light_purse :: Marrow remembers the purse was gone.
    "Fair's fair," she said.
}
{ VERSION == "hero" && not WENT_IN:
    # remember: dry_to_the_knee :: Isolde remembers you were dry above the knee.
    Isolde, passing with the end of the rope, said only, "Fall in something before the next telling," and walked on.
}
{ TRUST_MARROW < 0:
    ~ DEBT_MARROW = true
    When it was done, Marrow wiped her hands on her coat. "My price for the rest of the road just doubled," she said. "Dead men are heavy."
- else:
    When it was done, Marrow wiped her hands on her coat and went to see to the horse without being asked.
}
Isolde tied the canvas down herself, with a knot I didn't know. I would never get it open again without her seeing that I had.
-> s07_road

// ---------------------------------------------------------------
= s07_road
# scene: s07_road
# panel: road_to_stint_morning
~ DAYS_LEFT = 8
~ PLACE = "The road to Stint"
By full light we were on the road south to Stint, the toll town where his bells were waiting, with the Lantern under canvas in the back of the cart. Nobody had cut the hedges since before the war. Every gatepost we passed had a hole in it where the hinges had gone for arrowheads.
# know: stint :: Stint: the toll town to the south, where the bells are waiting. The first place anyone will ask to see the Lantern.
{ PLAN == "objected":
    Isolde drove, humming his first verse. I lay in the back under the canvas with him, {WENT_IN:coughing up the Greywater a little at a time|with my bad knee stuck out straight like a plank}. It was dark under there, and it smelled of the river and of him. I did not hold his hand.
- else:
    Isolde sat by the body with her satchel on her knees and wrote without looking up. {WENT_IN:I drove. I was coughing up the Greywater a little at a time, and every cough hurt somewhere new.|I drove, with my bad knee stuck out straight like a plank.}
}
{ TOLD_MARROW == "truth" && VERSION == "truth":
    Marrow walked behind the cart, where she could see my back.
- else:
    Marrow walked ahead and did not look back.
}
Vellmouth was eight days off by cart, and we had eight.
Somewhere ahead they would be ringing the bells for him. I caught myself hoping he would enjoy it.
# end: ch00
-> END
