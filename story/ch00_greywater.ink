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
I was his squire. I had been his squire six years, which is long enough to know when he could be talked out of a thing. He could not.
"By sunrise, Wren," he said, again. "They'll ring every bell in Stint for the Lantern. I'll not turn up at noon like a tinker with a cough."
"Yes, Sir Aubric," I said. Piss on your bells, I thought. My feet were wet.
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
The songs called him the Lantern. Three days back, after ten years of war, he had talked the hill towns into signing a surrender in one afternoon. They had sent him off with two skins of their wine, and he had drunk most of both.
Stint was the toll town, a day south. He had sent his escort ahead that morning to get the ringers sober. That left him a squire, a guide, and a chronicler asleep in the cart.
He sat his grey horse in full armor, polished for the bells. I had done the polishing.
A light moved on the far bank, under the alders. That was Marrow, the guide. She had waded over to test the bottom and shouted back three words, and the words were "Wait for morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
He held the last of the wine down to me. "Drink, Wren. Tomorrow you're squire to the man who ended the war. You'll never pay for a cup again."
He had never once paid me, either. But he said it so warmly that I forgot to mind. You warmed your hands at him and didn't count your fingers till later.
* [Drink with him]
    ~ DRANK = true
    I drank. It was sweet and strong, and I had not eaten since noon, and I felt it in my legs at once.
    He watched me swallow. "There."
* [Hand the skin back untouched]
    I handed it back. "One of us should be able to find the road," I said.
    "One of us is a horse," said Aubric, and slapped the animal's neck, and laughed until I was laughing as well.
- "I shall be modest," he said. "'Good people, I did nothing. A little talking.' Then I look at my boots. Do I look at my boots, or is that too much?"
"The boots are good, Sir Aubric."
"Then they shout 'The Lantern!' and I wave. Like this." He waved, and nearly came off the horse. "The third verse of my song doesn't scan, mind. I must have that mended before the bells. And you'll be paid. Every penny, the day we ride in. And the room. A room in my house in the capital, with a door on it. Remind me of the door. Bring me that paper of yours in Stint and I'll sign it."
He had been promising me that room four years. It had not had a door before.
I had it written out. I wrote all his letters, in his hand, and four winters running I had made a fair copy of that promise. I could do his name better than he could. While he lived that was no use. He would say he had never seen it.
He saw me shaking.
He pulled off his riding gloves, the good ones with the fleece inside, and dropped them into my hands. "Can't have you sneezing through my triumph. Your mother would never forgive me. How is her chest?"
My mother washed shirts for the army and had spoken to him once. He had asked after her chest every winter since. It would have been easier to hate him if he had forgotten. I put the gloves on.
He gathered the reins. Nobody was awake to stop him but me.
He was to sign my paper tomorrow. In six years I had not seen him sign a thing for anybody who had crossed him the night before.
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
The horse went in to its belly, snorting. Halfway over, it put a hoof in a hole.
It went down on one shoulder. Aubric went off sideways in sixty pounds of steel, and the river shut over him.
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
    There was a rope on the cart. I ran for it. A squire who drowns beside his knight is no use to anyone. Some part of me that had polished that armor every night thought: let it rust.
    I fell twice in the slop, the second time with my knee on a stone. I threw the rope from the bank and it fell short. I threw it again and it went over him and he didn't take it. I could hear him. It was a noise like a man trying to shout through a wet cloth, and his heels were going on the stones, and I stood on the bank coiling the rope a third time, neatly, the way he liked it coiled, because I didn't want to go any nearer to that noise.
    By the time I thought of the horse, the noise had stopped. I got a loop over the saddle as it floundered out, and it dragged him ashore by one stirrup, face down, with his mouth full of gravel.
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
- My paper wanted his name, and he was past signing. {AT_FORD == "bridle":He had been going to talk about it another day. }Without him I was a laundress's child who could read.
Then there was the letter.
It was on the same belt, in an oilskin case: the surrender. The hill towns had signed it for him, on his word that nobody would hang. Ten years of war ended on that page, if it reached Vellmouth, the capital, and it was hanging off a dead man.
# know: letter :: The surrender, signed by the hill towns on Aubric's word. The council in Vellmouth, the capital, must sign it too within nine days, and must not learn he is dead first, or the war starts again.
Out on the water, Marrow's light had turned.
The case was dry. Nobody leaves the one who carries that in a ditch. But I'd be a squire with his knight's letter in my shirt and no knight, and they hang thieves, and they don't take long over it.
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
Marrow came up out of the river with her lantern, and stopped when the light reached him.
She put her ear to his mouth and kept it there, too long. "Come on," she said, to him.
Then she sat up. "That's my fee gone."
{ AT_FORD == "called":
    "Heard you. Didn't run. Two of us, he'd not have listened."
    ~ TRUST_MARROW += 1
}
{ AT_FORD == "silent":
    "Saw you. Not a word out of you."
}
{ DRANK:
    # remember: drank_with_him :: Marrow remembers the wine on your breath.
    She leaned in and sniffed me. "Two drunks. One river."
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
"Here's how it goes," she said, and it came out of her all in one breath. "A Crown hero drowns at a ford and the guide that picked the ford used to fight for the hill towns and they'll not ask her twice, they'll not ask her once. Who hangs? Guide hangs."
I didn't answer. Two people had seen him drown, and she would be safer if it were one.
She got her breath. "So he didn't drown. Stragglers. Dark. An arrow, and his sword out. Stragglers hang for that. They're hanging anyway."
* [Agree. An ambush, and nobody here hangs.]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    "An ambush," I said. "I saw it."
    The knife came off my wrist. She looked at it, and put it away.
    "Good. Quicker than him." She unstoppered her flask and passed it over the body. It was hot all the way down.
* [Refuse, with her knife on your wrist]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," I said. "That's what happened."
    Marrow came round the body quicker than I could stand. She took my collar in her fist, where he had, and pulled my face down to his.
    "Look at him. That's what happened. Not what gets told."
    Then she cut me. She took the top of my left ear between her finger and thumb and put the knife through it, a notch, the way they mark a sheep. It was only hot, and then my neck was wet.
    "Say drowned, to anybody. I say the squire {WENT_IN:broke his nose|pushed him}. My word, yours. You're the one looks like he fought you."
    She let go. I stayed where she had put me, with my blood dripping on his breastplate.
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," I said. "I'll decide at dawn."
    "Dawn's the chronicler." Marrow jerked her head at the cart. "Decide before. She'll not ask what you saw. She'll tell you."
    She came round the body with a length of cord off the cart, and tied my left wrist to her right, with a knot I couldn't see. "So you don't decide somewhere else." Then she sat down against me with the knife across her knees. The cord was tight enough that my hand went cold.
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That dry?"
    It was. She kept her hands on her knees.
    "People I know on that paper."
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
    "Keep it there. Stop showing people. People I know on that paper."
* [Say you haven't seen it]
    ~ MARROW_KNOWS_LETTER = true
    ~ TRUST_MARROW -= 1
    "Haven't seen it," I said.
    Marrow took hold of my shirt and opened it, not roughly, the way you'd open a sack to see what was in it. She looked at the oilskin. She did the lacing up again and patted it flat.
    "Lie to the chronicler, that's free. Lie to me again, that's the letter and two fingers."
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
It got light without any sun in it. Mist stood on the water, and the first fly found him. Over the river stood a mill with no roof.
{ TOLD_MARROW:
- "ambush": I had sat by him all night{WENT_IN: in wet clothes}. Some time in the dark Marrow had thrown the horse blanket over me and called me an idiot for needing it.
- "truth": I had sat by him all night{WENT_IN: in wet clothes}, holding my ear. It had stopped bleeding and started to beat. Marrow had the horse blanket round her own shoulders, and I had stopped shivering, which I knew was bad.
- else: I had sat by him all night{WENT_IN: in wet clothes}, tied to Marrow by the wrist, with her knife across her knees. I couldn't feel that hand. She cut the cord when the cart creaked, and not before.
}
He had begun to smell, or I had.
Isolde Ferrant climbed down from the cart with ink on two fingers. She had slept through all of it.
She was the Crown's chronicler, sent to write his ballad, and she had written most of it before we set out.
She looked at the body. She sat down on the wet gravel in her good skirt, and got up again.
"Wake him," she said.
Marrow and I looked at each other.
"No. Don't— no." She did not finish it. "Did anyone else see?"
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
    "Thank you. Not hill men, though," said Isolde. "Robbers. Nobody's men. If the hill towns killed him the week they signed, there is no peace left to carry."
    {WENT_IN:She looked at his nose. "And they broke that for him. Good. It reads as a fight."}
    "You tell it nicely," she said. "It will do for the song." She did not say she believed it. I was pleased that she was pleased.
* [Tell her he died saving you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," I said. "He came in after me. He got me out. The river kept him."
    He would have gone in for a dog, if there was a crowd. So it was nearly true. And it turned six years of carrying out his pot into something, and I wanted that so badly my ears rang.
    "Oh, you little shit," said Marrow, softly.{TOLD_MARROW == "ambush": "We had a story."}
    { WENT_IN:
        Isolde looked me over. I was soaked to the collar and grey with cold. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        Isolde looked me over. I was mud to the knee and dry above it. She nodded anyway.
    }
    {WENT_IN:"And his nose?" she said.|"That is the third verse," she said. "That is the one that did not scan."}
    { WENT_IN:
        "Stones," said Marrow, looking at me.
        "Stones. Then that is the third verse."
    }
- -> s05_plan

= truth_elbow
* [Tell her about your elbow]
    ~ ELBOW = "told"
    "He had hold of me," I said. "I hit him. In the face. Then he stopped."
    Nobody spoke. Marrow looked at the sky.
    "He struck his face on the stones," said Isolde. "You will not say otherwise again, and I shall not write it down. That is a kindness. Remember whose."
    ~ ISOLDE_SAW_NOSE = true
* [Leave out your elbow]
    ~ ELBOW = "hidden"
    I left out my elbow, and kept that arm behind me.
- -> truth_told

= truth_told
Isolde shut her eyes. "In a ford. Drunk." She opened them. "Nobody will ever hear that."
{ TOLD_MARROW == "truth" && ELBOW != "told":
    "There's another true one," said Marrow. "Squire {WENT_IN:broke his nose for him|stood on the bank and watched}."
    "Then that is the true one," said Isolde. "Your name is in it, Wren. I shall keep it by me."
    ~ ISOLDE_SAW_NOSE = true
}
{ ELBOW == "hidden" && TOLD_MARROW != "truth":
    Then Isolde bent and looked at his nose, and at me, and asked nothing.
}
-> s05_plan

= s05_plan
Isolde looked at him. "Close his mouth. He looks surprised."
I pushed his jaw up. It came down again. I tied it shut with my neckcloth.
"The council's to sign it," said Isolde. "Under his name. They've nine days, and they won't— they will not sign under a dead man's name. A dead man can't be held to anything."
I had it, then. If the council heard he was dead, that paper was worth nothing, and in nine days the war came back.
"So we go back up. The hill towns sign again, for somebody living."
"Gate's shut," said Marrow. "Shut behind him."
"Then we bury him and say he's following."
"Nine days?"
"Then it's void, and Marshal Sayle has his war back."
# know: sayle :: Marshal Sayle, who has commanded the army for all ten years of the war. If the Lantern is known to be dead before the council signs, he will have the surrender thrown out.
Isolde said nothing for a while. When she spoke again she had her whole sentences back.
"Three of us know. I shall need the guide for the road." She was looking at me. "What would it cost, if the squire had gone into the river as well?"
Marrow had my hair in her fist and the knife under my jaw. "Ten."
"Six."
"Ten. Not you has to do it. And I'm sick after."
Isolde began to count silver onto his breastplate. The fourth rolled off into the gravel, and she went down on her knees after it. The edge moved whenever Marrow breathed. My bladder went.
* [Tell them you write his letters. You can sign for him.]
    ~ SOLD = "hand"
    "I write his letters," I said, all at once. "All of them, six years, I do his hand, I do his name. If he's sick they'll want a letter from him, the council, and I can write it, nobody else can, you can't, I've seen yours—"
    "Show me," said Isolde. She laid a page on his breastplate and put her pen in my hand. Marrow kept hold of my hair.
    I wrote his name. My hand shook, and it came out like a child's.
    "That is not his," said Isolde. "Five."
    I wrote it again, with the big loop. I wrote it a third time without being asked.
    Isolde looked at the page. "He never used a comma in his life until he had you. I did wonder. So that is what the squire is for."
    It was the one thing I had to sell, and I had given it away on my knees.
* [Tell them his men in Stint know your face]
    ~ SOLD = "face"
    "His men," I said, all at once. "In Stint. They know me, they'll ask where his squire is, they always ask me what he wants, they'll not ask you, they don't know you—"
    "What do they call you?" said Isolde. "His men."
    "The wick," I said.
    "Louder."
    "The wick. The Lantern's wick."
    "Again."
    I said it again. Marrow's fist was shaking in my hair. She was laughing.
    "Then they would ask for it," said Isolde. She put the coin in her hand back in her purse. "So that is what the squire is for."
* [Beg]
    ~ SOLD = "begged"
    "Please," I said. "Please. I'll say what you like. I never saw it, I was asleep, I'll go back to the tubs, please—"
    "Seven," said Isolde, and turned her purse out. Nothing else fell. She pulled a ring off her thumb and held it up.
    Marrow took the knife away to take it, and bit it. I knelt there and watched her bite it.
    "Plate." She threw it back. "Ten, I said. Don't work on account."
    I thanked her. I thanked both of them.
- Isolde picked the coins up again. Marrow let go of my hair, and wiped her hand.
I stayed where I was. I was crying, and nobody minded.
"So he is not dead," said Isolde. "He {VERSION == "ambush":took an arrow from robbers and has a fever of it|has a fever}. He rides in the cart to Vellmouth, and the council signs at the door of his sickroom, with a letter in his hand pushed under it. {SOLD == "hand":You will write that.|I write a fair hand.}"
{ SOLD != "hand":
    I wrote a better one. I kept that to myself. It was the one thing I had left to sell.
}
"His men in Stint will not take my word that he is alive in there," she said. "They will take yours. Well?"
I was still on my knees. A man with a fever can sign his name.
* [Say you'll do it]
    ~ PLAN = "agreed"
    ~ RING = true
    "I'll do it," I said. It came out too quick.
    "How good of you." She worked the signet off his finger and put it in my hand, still wet. "Then you speak for him. And if anybody asks afterwards who it was that said he was alive, we shall say it was you."
    His seal. I shut my hand on it before she could think again.
* [Ask what's in it for you]
    ~ PLAN = "bargained"
    ~ ISOLDE_OWES = true
    "What do I get?" I said. My teeth were knocking together.
    "Your neck," said Marrow. "Had it a minute ago for nothing."
    Isolde tore a strip from the foot of a page, wrote on her knee, and blew on it. "A place in a household in Vellmouth. Written down, this time."
    She knew about the promise. I had never told her about the promise. I took the paper anyway. That made two, hers and the one in my pack, and I did not tell her about the one in my pack.
* [Tell her it's madness]
    ~ PLAN = "objected"
    "It's madness," I said. Somebody ought to say so. "He's dead. Anyone who lifts that canvas—"
    "That is quite right, and I am obliged to you," said Isolde. "So when they lift it, we must be found under there with him. A squire, nursing his master. You will ride in the back, under the canvas, and hold his hand."
    I had my sick man who could sign, and I was going under a canvas with him.
- "He'll stink by day three," said Marrow.
"Heroes do. We shall burn something."
"And the guide that picked the ford?"
"She was never at a ford in her life," said Isolde. "We came round by the bridge."
"Bridge is two days east."
"Then we made excellent time."
Marrow moved to spit, and I had my arm up over my face before I knew it. Neither of them looked at me.
{ VERSION == "truth":
    "Say it for me, Wren. He has a fever."
    "He has a fever," I said.
    "Again, and to me, not to him."
    Five times. The last time she made me say it with my hand on him.
}
"He keeps his fever as far as Vellmouth," said Isolde. "Then he dies of it, in a bed, where I can write it down. I have been paid for a ballad with a triumph at the end of it, and I have spent the money. {VERSION == "truth":He dies of whatever I can rhyme.}{VERSION == "ambush":He dies of his wounds, in the capital, with the bells.}{VERSION == "hero":He dies of a chill he took pulling you out of a river. Some other river. You are in the song. Think of that.}"
{ VERSION == "hero":
    I did think of it.
}
{ VERSION == "ambush":
    "Arrow killed him, he'll want a hole," said Marrow.
    "Under the arm," said Isolde. "Hold him still."
    I held his shoulders and looked at the alders while Marrow did it. It made a noise like a boot coming out of mud.
}
"Now. The surrender," said Isolde. "Where is it?"
{ LETTER == "body": -> letter_on_body }
-> letter_with_wren

= letter_on_body
She knelt and unbuckled the case herself, and checked the seal.
* [Let her take it]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    She tucked it into her satchel, beside the ballad. I did not argue. She had got as far as seven.
    "Thank you, Wren," she said, as though I had given it to her.
    "You're welcome," I said.
    "That's your neck she's got in there," said Marrow, not quietly.
* [Hold out your hand. "I'm his squire. I carry it."]
    My voice went up at the end. Isolde looked at my hand. It wasn't steady. Then she looked at Marrow, who had a thumb in her belt beside the knife and was watching the case and not either of us.
    Isolde put the case in my hand.
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    "Of course," she said. "His squire."
- -> s06_wrap

= letter_with_wren
* [Give it to her]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    I took the case out of my shirt and held it out. She had got as far as seven. I would have given her my teeth. Isolde checked the seal, didn't open it, and put it in her satchel beside the ballad.
    "Thank you, Wren," she said. My ribs felt cold where it had been.
    "That's your neck you gave her," said Marrow, not quietly.
* [Keep it. "I'll carry it. I was his squire."]
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    My voice went up at the end. Isolde looked at the shape under my shirt, then at my face.
    "Of course," she said, and smiled. "His squire."
* [Tell her the river took it]
    ~ LETTER = "hidden"
    "The river," I said. "It must have come off in the water."
    Isolde went to the body and looked at his belt herself. The buckle was undone, not torn. She looked at it, and then at the river, and not at me.
    "Then we're carrying a dead man nine days," she said, "to tell the council the war's over, with nothing to show them. So we'll find it. Or something very like it. I've seen his hand often enough."
    She was clipping her words again. I knew what that was, now.
    Behind her, where only I could see, Marrow looked at my shirt and rubbed her finger and thumb together.
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
We wrapped him in the cart's canvas. It took all three of us to lift him. I took the head, so as to have him between me and Marrow.
I had to shift my grip twice for my {WENT_IN:elbow|knee}. He was heavier than his debts, and he leaked. My breeches had dried on me, and nobody had said anything about them.
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
    "Wouldn't lie for me," Marrow said, so only I would hear. "Lie for her, though."
    ~ TRUST_MARROW -= 1
- TOLD_MARROW == "truth" && VERSION == "truth":
    # remember: honest_twice :: Marrow remembers you wouldn't lie to save her neck.
    "Wouldn't lie for my neck," Marrow said. "Honest or stupid. Costs me the same. You walk in front."
- TOLD_MARROW == "ambush" && VERSION == "truth":
    "We had a story," Marrow said. "You dropped it in the river."
    # remember: marrow_story_dropped :: Marrow remembers you agreed to her story.
    She pulled the last knot tight enough to creak.
    ~ TRUST_MARROW -= 1
- TOLD_MARROW == "ambush" && VERSION == "hero":
    # remember: marrow_sold_story :: Marrow remembers you sold her story for a verse.
    "Sold my story for a verse," Marrow said.
    ~ TRUST_MARROW -= 1
- AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "Had his bridle," Marrow said, not looking up from the knots. "Saw you against the water. Should've hung on."
}
{ not PURSE:
    Marrow cut the purse off his belt with one pull of the knife, weighed it, and put it in her coat.
    # remember: left_purse :: Marrow remembers you left the purse.
    "You didn't want it. Six years, was it. One night, me."
}
{ PURSE:
    Marrow ran her thumb along his belt where the purse had hung, and looked at me. Then she unbuckled his spurs and put them in her coat.
    # remember: light_purse :: Marrow remembers the purse was gone.
    "Fair's fair," she said.
}
{ VERSION == "hero" && not WENT_IN:
    # remember: dry_to_the_knee :: Isolde remembers you were dry above the knee.
    Isolde, passing with the end of the rope, said only, "Fall in something before the next telling," and walked on.
}
{ TRUST_MARROW < 0:
    ~ DEBT_MARROW = true
    When it was done, Marrow wiped her hands on her coat. "Rest of the road's double."
- else:
    When it was done, Marrow wiped her hands on her coat and went to see to the horse without being asked.
}
Isolde tied the canvas down herself, with a knot I didn't know.
-> s07_road

// ---------------------------------------------------------------
= s07_road
# scene: s07_road
# panel: road_to_stint_morning
~ DAYS_LEFT = 8
~ PLACE = "The road to Stint"
By full light we were on the road south to Stint and his bells, with the Lantern under canvas in the back of the cart.
# know: stint :: Stint: the toll town to the south, where the bells are waiting. The first place anyone will ask to see the Lantern.
{ PLAN == "objected":
    Isolde drove, humming his first verse. I lay in the back under the canvas with him, {WENT_IN:coughing up the Greywater a little at a time|with my bad knee stuck out straight}. I did not hold his hand.
- else:
    Isolde sat by the body and wrote. {WENT_IN:I drove. I was coughing up the Greywater a little at a time, and every cough hurt somewhere new.|I drove, with my bad knee stuck out straight.} I kept my chin down. I could still feel where the edge had been.
}
{ TOLD_MARROW == "truth" && VERSION == "truth":
    Marrow walked behind the cart, where she could see my back. I felt her there all morning.
- else:
    Marrow walked ahead, where I could see her. I liked that better.
}
About noon she stopped over a lot of fresh hoofprints. "Marshal's riders. Same way as us."
The night had cost us a day. Vellmouth was eight off by cart, and we had eight.
Then Isolde went behind the hedge, and left her pen in the inkhorn on the tailboard, by my pack.
I had my promise out of the pack and unfolded. The room, the door, six years' wages, to his squire Wren. It wanted his name.{RING: His ring was no use without wax. A name only wants ink.}
He would have signed it. He had said so last night, with his own mouth. It wasn't forging. It was finishing his sentence.
* [Sign it now, in his hand]
    ~ DEED = "signed"
    I signed it on the tailboard, by his feet. Aubric Dane, with the big loop he made when he was pleased. It was the best one I ever did.
    I heard her skirt in the hedge and folded it wet.
    # remember: deed_signed :: Isolde remembers the ink on your thumb.
    "You have ink on your thumb, Wren," said Isolde, climbing up.
* [Not here. In Vellmouth, with his seal and a witness]
    ~ DEED = "waiting"
    I put it back. Not with her ink, and not on a cart. In Vellmouth, with his seal, and somebody respectable watching a sick man's hand move. I had waited four years. I could wait eight days.
- Somewhere ahead they would be ringing the bells for him. I caught myself hoping he would enjoy it. {DEED == "signed":He had signed a paper for me the day after he died, and it was drying against my ribs.|I needed him in a good temper. He had signing to do.}
# end: ch00
-> END
