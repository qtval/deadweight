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
I was his squire. I had been his squire six years, which is long enough to tell a thing he had decided from a thing he could be talked out of, and this was not the second kind.
"By sunrise, Wren," he said, again. "They'll ring every bell in Stint for the Lantern. I'll not turn up at noon like a tinker with a cough."
"Yes, Sir Aubric," I said. Piss on your bells, I thought. My feet were wet.
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
The Lantern was what the songs called him, and three days back he had earned it. Ten years of war, and he had talked the hill towns into signing a surrender in one afternoon. They had sent him off with two skins of their wine, and he had drunk most of both.
Stint was the toll town, a day south. He had sent his escort ahead that morning to get the ringers sober, so that he could arrive. That left him a squire, a guide, and a chronicler asleep in the cart.
He sat his grey horse in full armor, polished for the bells. I had done the polishing.
A light moved on the far bank, under the alders. That was Marrow, the guide. She had waded over to test the bottom and shouted back three words, and the words were "Wait for morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
He held the last of the wine down to me. "Drink, Wren. Tomorrow you're squire to the man who ended the war. You'll never pay for a cup again."
He had never once paid me, either. But he said it so warmly that I forgot to mind. You warmed your hands at him and didn't count your fingers till later.
* [Drink with him]
    ~ DRANK = true
    I drank. It was sweet and strong, and I had not eaten since noon, and I felt it in my legs at once.
    "There," he said.
* [Hand the skin back untouched]
    I handed it back. "One of us should be able to find the road," I said.
    "One of us is a horse," said Aubric, and slapped the animal's neck, and laughed until I was laughing as well.
- "I shall be modest," he said. "I've been practising. 'Good people, I did nothing. A little talking.' Then I look at my boots. Do I look at my boots, Wren, or is that too much?"
"The boots are good, Sir Aubric."
"Then somebody shouts 'The Lantern!' and I say 'No, no,' and wave. Like this." He waved, and nearly came off the horse. "The third verse of my song doesn't scan, mind. I must have that mended before the bells. And you'll be paid, Wren. Every penny, the day we ride in. And the room. A room in my house in the capital, with a door on it. Remind me of the door."
He had been promising me that room for four years. It had not had a door before.
He noticed my feet. I was wet to the shins and shaking, and drunk as he was, he saw it.
He pulled off his riding gloves, the good ones with the fleece inside, and dropped them into my hands. "Can't have you sneezing through my triumph. Your mother would never forgive me. How is her chest?"
My mother washed shirts for the army and had spoken to him once. He had asked after her chest every winter since. It would have been easier to hate him if he had forgotten. I put the gloves on. The bank was army-cart slop to the ankle, and it stank of dead reeds.
He gathered the reins. There was nobody awake to stop him but me.
And tomorrow he paid me. Six years, and a door. In six years I had not seen him pay anybody who had crossed him the night before.
* [Take his bridle and hold him back]
    ~ AT_FORD = "bridle"
    I caught the bridle. The horse tossed its head. Aubric leaned down, breathing wine, and unpicked my fingers one at a time, humming.
    "I talked ten years of war to death in an afternoon," he said. "I believe I can manage a stream. You're a good squire, Wren. But you are a squire." He had stopped humming. "We'll talk about that door another day."
* [Shout across to Marrow to stop him]
    ~ AT_FORD = "called"
    "Marrow!" Most of it was lost in the noise of the water. Over the river the light stopped, then began to move along the far bank, looking for the shallow way back.
    Aubric laughed. "She can't hear you," he said, "and I won't. Fetching a hill woman to manage me. I shall remember that when we settle up, Wren." He said it kindly.
* [Say nothing. Tomorrow he pays you.]
    ~ AT_FORD = "silent"
    I said nothing. Corrected, he got twice as stubborn and three times as loud, and I was tired, and I wanted my bed.
    "Good squire," he said.
- Then he put his heels to the horse and rode into the Greywater, sitting very straight, in case anyone was watching.
-> s02_water

// ---------------------------------------------------------------
= s02_water
# scene: s02_water
# panel: greywater_water_churn
The horse went in to its belly, snorting. Halfway over, it put a hoof on a stone that wasn't there.
It went down on one shoulder. Aubric went off sideways, without a word, in sixty pounds of steel, and went under.
I waited for him to stand up. The river came no higher than his belt. Any moment he would stand up roaring and blame the horse, and I would spend tomorrow drying armor.
A hand came out of the water, bare and white, opened, closed on nothing, and went back in.
* [Go into the river after him]
    ~ WENT_IN = true
    I went in. My legs were numb before I had gone three steps. I went down on my hands and came up with a mouthful of river that tasted of mud and horse, and I didn't find him so much as fall on him.
    He got a hand in my collar. He pulled me down onto his breastplate and held me under. I don't think he knew it was me. He was holding on to the nearest thing.
    I couldn't get his fingers open. My chest was going. So I hit him. I hit the Lantern in the face with my elbow, three times, four, and felt something in his nose give, and he let go.
    I came up and breathed and was sick down my own front. By the time I had a strap in my fist and had started to pull, he had stopped helping.
* [Stay on the bank. Run for the rope.]
    ~ WENT_IN = false
    There was a rope on the cart. I ran for it. I told myself a squire who drowns beside his knight is no use to anyone. Some part of me that had polished that armor every night thought: let it rust.
    I fell twice in the slop, the second time with my knee on a stone. I got a loop over the saddle as the horse floundered out, and hauled, and the horse did the rest. It dragged him ashore by one stirrup, face down.
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
Six years' wages, which he had always been about to pay. His purse hung on his belt. He gave silver to beggars where people could see, and owed it everywhere else. If I left it, it would be in somebody else's coat by morning.
* [Take what he owed you]
    ~ PURSE = true
    I pulled off the gloves he had given me to do it, and put them on again after. The purse didn't come to six weeks.
* [Leave the purse]
    I let it hang. I am not a thief. I weighed it in my hand first, only to be sure of that.
- There was more. The room with the door had never been written down. {AT_FORD == "bridle":He had been going to talk about it another day. }Without him I was a laundress's child who could read.
Then I thought about the letter, and the sums got worse.
It was on the same belt, in an oilskin case: the surrender. The hill towns had signed it for him, on his word that nobody would hang. The council in Vellmouth, the capital, had to sign under his name within the month, and the month had nine days left. If they heard he was dead first, they would not sign for a dead man's word, and the war would start again in the spring.
# know: letter :: The surrender, signed by the hill towns on Aubric's word. The council in Vellmouth, the capital, must sign it too within nine days, and must not learn he is dead first, or the war starts again.
Out on the water, Marrow's light had turned.
The case was dry. Somebody had to carry that for nine days, and the other two would have to keep whoever it was fed and breathing. But a squire caught with it, and no knight alive to carry it for, was a thief, and they hang those.
The light was nearly on me.
* [Take it. Whoever holds it gets kept alive.]
    ~ LETTER = "wren"
    The buckle was stiff with cold, and my hands were worse. I got it open and pushed the case inside my shirt, flat against my ribs.
* [Leave it on his belt, where it's nobody's neck]
    ~ LETTER = "body"
    I took my hand off it. Nobody had told me to carry that, and I was glad of it. I pulled his cloak half over the case so it wouldn't be the first thing she saw.
- -> s04_marrow

// ---------------------------------------------------------------
= s04_marrow
# scene: s04_marrow
# panel: greywater_marrow_wading
Marrow came up out of the river with her lantern held high, and stopped when the light reached him.
She looked at him. "That's my fee gone," she said.
{ AT_FORD == "called":
    "Heard you call," she said. "Didn't run. He wasn't going to listen to two of us either."
    ~ TRUST_MARROW += 1
}
{ AT_FORD == "silent":
    "Watched from over there," she said. "You never said a word."
}
{ DRANK:
    # remember: drank_with_him :: Marrow remembers the wine on your breath.
    She leaned in and sniffed, and it wasn't him she was sniffing. "Two drunks and a river," she said. "Lovely."
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
She crouched across the body from me. There was a short knife on her belt. I had watched her gut a hare with it at noon. Now it was in her hand.
She reached over him and took my wrist, and laid the flat of the blade on the inside of it, above the glove. She didn't press. Her hand was shaking worse than mine.
"Here's how it goes," she said. "A Crown hero drowns at a ford. His escort's a day ahead, polishing bells. The guide who picked the ford used to fight for the hill towns. Who hangs?"
I didn't answer. Two people had seen him drown, and she would be safer if it were one.
"So he didn't drown," said Marrow. "Hill stragglers, in the dark. An arrow. He died with his sword out. Nobody hangs for that but stragglers, and they're hanging anyway."
* [Agree. An ambush, and nobody here hangs.]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    "An ambush," I said. "I saw it."
    The knife came off my wrist. She looked at it, and put it away.
    "Good," she said. "You're quicker than he was." She unstoppered her flask and passed it over the body. It wasn't wine. It was hot all the way down.
* [Refuse, with her knife on your wrist]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," I said. "That's what happened."
    Marrow came round the body quicker than I could stand. She took my collar in her fist, where he had, and pulled my face down to his.
    "Look at him. That's what happened. It isn't what's going to have happened."
    Then she cut me. She took the top of my left ear between her finger and thumb and put the knife through it, a notch, the way they mark a sheep. It was only hot, and then my neck was wet.
    "Say he drowned, to anybody," she said, "and I say the squire {WENT_IN:broke his nose|pushed him}. My word and yours. And you're the one with a cut on you."
    She let go. I stayed where she had put me, with my blood dripping on his breastplate.
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," I said. "I'll decide at dawn."
    "Dawn's when the chronicler wakes up." Marrow jerked her head at the cart. "Decide before. Her kind don't ask what you saw. They tell you."
    She came round the body and sat down against me, shoulder to shoulder, with the knife out across her knees. I didn't know if that was to keep me warm or to keep me there. I sat very still, in case it mattered which.
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That dry?"
    It was. She kept her hands on her knees.
    "There's people I know on that paper," she said.
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
    "Lie to the chronicler all you want," she said. "Lie to me again and it costs you that paper and two fingers."
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
It got light without any sun in it. Mist stood on the water, and the first fly found him.
{ TOLD_MARROW:
- "ambush": I had sat by him all night{WENT_IN: in wet clothes}. Some time in the dark Marrow had thrown the horse blanket over me and called me an idiot for needing it.
- "truth": I had sat by him all night{WENT_IN: in wet clothes}, holding my ear. It had stopped bleeding and started to beat. Marrow had the horse blanket round her own shoulders, and I had stopped shivering, which I knew was bad.
- else: I had sat by him all night{WENT_IN: in wet clothes}, with Marrow against me and the knife across her knees. It was the only warm side I had.
}
He had begun to smell, or I had. There was piss in it, his or mine.
Isolde Ferrant climbed down from the cart with ink on two fingers. She had slept through all of it.
She was the Crown's chronicler, sent along to write the Lantern's ballad, and she had written most of it before we set out. She used my name the way you use a dog's, just before you want it to fetch.
She looked at the body. She sat down on the wet gravel in her good skirt, all at once, and got up again.
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
    "Not hill men, though," said Isolde. "Robbers. Nobody's men. If the hill towns killed him the same week they signed, there is no peace left to carry."
    {WENT_IN:She looked at his nose. "And they broke that for him. Good. It looks like a fight."}
    "You tell it nicely, Wren," she said. "It will do for the song." She did not say she believed it, and she did not ask me anything else. I was pleased that she was pleased.
* [Tell her he died saving you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," I said. "He came in after me. He got me out. The river kept him."
    He would have, if he had been sober, and if he had noticed, and if there had been people there to see. He would have gone in for a dog, if there was a crowd. So it was nearly true. And it turned six years of carrying out his pot into something, and I wanted that so badly my ears rang.
    "Oh, you little shit," said Marrow, softly.{TOLD_MARROW == "ambush": "We had a story."}
    { WENT_IN:
        Isolde looked me over. I was soaked to the collar and grey with cold. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        Isolde looked me over. I was mud to the knee and dry above it. The corner of her mouth moved. She nodded anyway.
    }
    {WENT_IN:"And his nose?" she said.|"That is the third verse," she said. "That is the one that did not scan."}
    { WENT_IN:
        "Stones," said Marrow, looking at me.
        "Stones. Then that is the third verse. That is the one that did not scan."
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
Isolde shut her eyes. "In a ford. Drunk."
"And the guide, in this true one?" said Marrow.
"Nobody will ever hear it," said Isolde. "Say this for me, Wren. He has a fever."
"He has a fever," I said.
"Again, and look at me, not at him."
Five times, the last one touching him.
{ TOLD_MARROW == "truth" && ELBOW != "told":
    "There's another true one," said Marrow. "Squire {WENT_IN:broke his nose for him|stood on the bank and watched him go}. Look at that ear."
    Isolde looked at my ear{WENT_IN:, and at his nose}. "Then that is the one I shall write," she said, "if I am ever made to write a true one. Your name is in it, Wren. I shall keep it by me."
    ~ ISOLDE_SAW_NOSE = true
}
{ ELBOW == "hidden" && TOLD_MARROW != "truth":
    Then Isolde bent and looked at his nose, and at me, and asked nothing.
}
-> s05_plan

= s05_plan
"Close his mouth, Wren," said Isolde. "He looks surprised."
I pushed his jaw up. It came down again. I tied it shut with my neckcloth.
"And what becomes of that paper," said Isolde, "if he is dead?"
"The Marshal," said Marrow. "The Marshal becomes of it."
"Marshal Sayle has had ten years' living out of this war, and he has friends on the council," said Isolde. "He will call that paper a dead man's promise, and be so very sorry. So he is not dead yet. He {VERSION == "ambush":took an arrow from robbers and has a fever of it|has a fever}, and he rides in the cart until the council has signed."
# know: sayle :: Marshal Sayle, who has commanded the army for all ten years of the war. If the Lantern is known to be dead before the council signs, he will have the surrender thrown out. He knows you can read.
I had stood in front of Sayle once, holding a cloak. "Your squire reads," he had said, to Aubric, not to me. "I should see to that." I had read every letter Aubric ever got, and some were about Sayle. I had never found out what seeing to it meant.
"His own escort is in Stint, and the Marshal's riders are on this road," Isolde said. "None of them will take my word that he is alive in there, Wren. They will take his squire's. You carry out his pot. You say that he is sleeping. Well?"
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
    "Quite right. I had not thought of that, and I am obliged to you." Isolde smiled at me. "So when they lift it, they must find somebody under there with him. A squire, nursing his master. You will ride in the back, Wren, under the canvas, and hold his hand."
    Marrow made a noise into her sleeve.
    I looked for something else to say, and there wasn't anything.
- "Ride the paper south," said Marrow. "Leave him here."
"The council will not sign for a rider. They will sign for him, or for the door of his sickroom."
They went on like that across him. Nobody asked me. I watched the fly walk up his cheek and thought that I was the one who would be sitting next to him.
"He'll stink by the third day," said Marrow.
"Heroes do. We shall burn something."
"And the guide who picked the ford?"
"Is paid for a quiet road," said Isolde, "and was never at a ford in her life. We came round by the bridge."
"The bridge is two days east."
"Then we made excellent time."
"He keeps his fever until the council has signed," Isolde said to me. "Then he dies of it, in Vellmouth, in a bed, where I can write it down. I have been paid for a ballad with a triumph at the end of it, and I have spent the money. {VERSION == "truth":He dies of whatever I can rhyme.}{VERSION == "ambush":He dies of his wounds, in the capital, with the bells.}{VERSION == "hero":He dies of a chill he took pulling you out of a river. Some other river. You are in the song, Wren. Think of that.}"
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
    "You're welcome," I said. I watched her do up the satchel strap, two buckles. Whoever held that case was worth nine days. I had let it go by without putting my hand out.
    "That's your neck she's got in there," said Marrow, not quietly.
* [Hold out your hand. "I'm his squire. I carry it."]
    Isolde looked at my hand. It wasn't steady. She thought about refusing. Then she looked at Marrow, who had a thumb in her belt beside the knife and was watching the case and not either of us.
    Isolde put the case in my hand.
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
    I had been worth nine days with that against my skin. I watched her do up the satchel strap, two buckles, and tried to think what I was worth now. A pot-carrier. A voice to say he was sleeping.
    "That's your neck you just gave her," said Marrow, not quietly.
* [Keep it. "I'll carry it. I was his squire."]
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    Isolde looked at the shape under my shirt, then at my face.
    "Of course," she said, and smiled. "His squire."
* [Tell her the river took it]
    ~ LETTER = "hidden"
    "The river," I said. "It must have come off in the water."
    Isolde put her hand flat on her satchel. She went to the body and looked at his belt herself. The buckle was undone, not torn. She looked at it for a while, and then at the river, and not at me.
    "Then we're carrying a dead man nine days," she said, "to tell the council the war is over, with nothing to show them. So we'll find it. Or something very like it. I've seen his hand often enough."
    It was the first time I had heard her clip a word.
    Behind her, where only I could see, Marrow held out her hand, palm up, and closed it slowly. She had me, and she wanted me to know it.
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
We wrapped him in the cart's canvas. It took all three of us to lift him. Marrow did the feet.
I had the head, and had to shift my grip twice for my {WENT_IN:elbow|knee}. Squires carry things. I had carried his shield and his debts, and now I carried him. He was heavier, and he leaked.
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
- TOLD_MARROW == "ambush" && VERSION == "hero":
    # remember: marrow_sold_story :: Marrow remembers you sold her story for a verse.
    "You sold my story to get in a song," Marrow said, low. "I'll remember that."
    ~ TRUST_MARROW -= 1
- AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "You had hold of his bridle," Marrow said, not looking up from the knots. "I saw you against the water. Should've hung on."
}
{ not PURSE:
    Marrow cut the purse off his belt with one pull of the knife, weighed it, and put it in her coat.
    # remember: left_purse :: Marrow remembers you left the purse for her.
    "You didn't want it," she said. "Six years, was it? I've carried him one night."
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
    When it was done, Marrow wiped her hands on her coat. "My price for the rest of the road just doubled," she said.
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
By full light we were on the road south to Stint and his bells, with the Lantern under canvas in the back of the cart. Nobody had cut the hedges since before the war. Every gatepost we passed had a hole in it where the hinges had gone for arrowheads.
# know: stint :: Stint: the toll town to the south, where the bells are waiting. The first place anyone will ask to see the Lantern.
{ PLAN == "objected":
    Isolde drove, humming his first verse. I lay in the back under the canvas with him, {WENT_IN:coughing up the Greywater a little at a time|with my bad knee stuck out straight}. It was dark under there, and it smelled of the river and of him. I did not hold his hand.
- else:
    Isolde sat by the body with her satchel on her knees and wrote without looking up. {WENT_IN:I drove. I was coughing up the Greywater a little at a time, and every cough hurt somewhere new.|I drove, with my bad knee stuck out straight.}
}
{ TOLD_MARROW == "truth" && VERSION == "truth":
    Marrow walked behind the cart, where she could see my back.
- else:
    Marrow walked ahead.
}
About noon she stopped and looked at the road, where a lot of horses had gone by not long before. "Marshal's riders," she said. "Going where we're going."
Vellmouth was eight days off by cart, and we had eight.
Somewhere ahead they would be ringing the bells for him. I caught myself hoping he would enjoy it.
# end: ch00
-> END
