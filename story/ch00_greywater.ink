// PROLOGUE — THE GREYWATER
// One night at a ford, and the dawn after.
// Dramatic question: how did the Lantern die — and who gets to say?
// Voice: Wren, first person, looking back. See docs/WRITING_GUIDE.md.

=== ch00 ===
# title: Prologue :: The Greywater
-> s01_ford

// ---------------------------------------------------------------
= s01_ford
# scene: s01_ford
# panel: greywater_ford_night
The Greywater was loud in the dark, fast and black and no deeper than a man's belt, and Sir Aubric Dane had decided to cross it drunk.
I was his squire. I'd been his squire six years, which is long enough to tell a thing he'd decided from a thing he could be talked out of. This was the first kind.
"By sunrise, Wren," he said, for the fourth time. "They'll ring every bell in the south for the Lantern. I'll not turn up at noon like a tinker with a cough."
# know: aubric :: Sir Aubric Dane, called the Lantern. The only knight anyone has a ballad about. Drunk tonight.
That morning he had earned his song. Ten years of war, and he'd talked the hill towns into signing a surrender in one afternoon.
Then they had poured him their wine, to show there were no hard feelings, and he had shown them there were none by drinking all of it.
He sat the grey like a statue of himself, in full armor, polished for the bells. I had done the polishing. Squires carry things, and clean them, and that is most of the job.
On the far bank a lantern moved. That was Marrow, the guide. She had waded over to test the bottom and shouted back one word, and the word was "Morning."
# know: marrow :: The road-guide. A deserter from the hill towns' side, paid in silver to know the fords. Said the river should wait for morning.
He held the wineskin down to me. "Drink, Wren. Tomorrow you're squire to the man who ended the war. You'll never pay for a cup again."
In six years he had never once paid me, either. But he said it so warmly that I only remembered that afterward. That was his gift. You warmed your hands at him and didn't count your fingers till later.
* [Drink with him]
    ~ DRANK = true
    I drank. It was good wine, sweet and strong, and I wanted very much to be the person he was talking to.
    "There," he said, pleased, as if he had taught me something.
* [Hand the skin back untouched]
    I handed it back. "One of us should be able to find the road," I said.
    "One of us is a horse," said Aubric, and slapped the grey's neck, and laughed at his own joke the way he always did, until you were laughing as well.
- He gathered the reins. Behind us the cart sat dark on the bank, with the chronicler asleep in it. There was nobody awake to stop him but me.
* [Take his bridle and hold him back]
    ~ AT_FORD = "bridle"
    I caught the bridle. The grey tossed its head. Aubric leaned down, breathing wine and polish, and unpicked my fingers one at a time, gently, the way you would take a knife from a child.
    "You're a good squire," he said. "But you are a squire."
* [Shout across to Marrow to stop him]
    ~ AT_FORD = "called"
    "Marrow!" The river ate most of it. Over the water the lantern stopped, then started back toward us, fast.
    Aubric laughed. "Calling the help to fetch the help. Economical."
* [Say nothing. He hates being corrected.]
    ~ AT_FORD = "silent"
    I said nothing. Corrected, he got twice as stubborn and three times as loud, and I was tired, and my feet were wet, and I wanted my bed.
    I have had a long time since to weigh that against a man's life.
- Then he put his heels to the grey and rode into the Greywater, sitting very straight, in case anyone was watching.
-> s02_water

// ---------------------------------------------------------------
= s02_water
# scene: s02_water
# panel: greywater_water_churn
The ford was waist-deep on a man and knee-deep on a horse. Halfway over, the grey put a hoof on a stone that wasn't there.
It went down on one shoulder. Aubric went off sideways, without a word, in sixty pounds of steel, and the water shut over all that polish like a lid on a pot.
I waited for him to stand up. That is the truth of it. The water came to his waist. Any moment he would rise up roaring and blame the horse, and I would spend tomorrow drying armor.
He didn't stand up. A gauntlet came out of the water, opened, closed on nothing, and went back in.
* [Go into the river after him]
    ~ WENT_IN = true
    I was in the river before I had decided to be. The cold hit like a door slammed in my face. The stones rolled under me, and I didn't find him so much as fall on him.
    He got a hand in my collar. I would like to say he was trying to climb. I think he was only holding on, the way he held on to everything, and it took the both of us under.
    I hit him. I am fairly sure of that. I hit the Lantern in the face with my elbow until he let go, and I came up, and breathed. By the time I had a strap in my fist and had started to pull, he had stopped helping.
* [Run for the rope on the cart]
    ~ WENT_IN = false
    There was a rope on the cart. I ran for it, because a squire who drowns beside his knight is no use to anyone, least of all the squire.
    I fell twice in the mud. I got a loop over the grey's saddle as it floundered out, and I hauled, and the grey did the rest. It dragged him ashore by one stirrup, face down, like a sack of wet washing.
- It took longer to get him onto the stones than it had taken him to die.
-> s03_bank

// ---------------------------------------------------------------
= s03_bank
# scene: s03_bank
# panel: greywater_bank_body
He lay on his back on the near bank with the river running out of him and his mouth open, as if he had thought of one more thing to say.
The last thing he had actually said to me, an hour back on the road, was that the third verse of his song didn't scan.
I knelt by him a while. I would like to tell you I wept. What I did was sums.
Six years' wages, which he had always been about to pay. A place in his household in Vellmouth, the capital, promised and never written down. A laundress's child who could read, squire to a dead man, a week's ride from anywhere.
His purse hung on his belt. It was not heavy. It never was. He gave silver to beggars where people could see, and owed it everywhere else.
* [Take what he owed you]
    ~ PURSE = true
    Six years. I took the purse. It didn't come to six weeks.
    I told myself that squires carry things, which was true, and was not why I did it.
* [Leave the dead man his purse]
    I left it. I'm not sure that was honesty. I think I couldn't stand to be paid at last and find out how little it came to.
- Then I thought about the letter, and the sums got worse.
It was on the same belt, in an oilskin case: the surrender, signed by the hill towns that morning. The King's council in Vellmouth had to countersign it inside nine days. If they didn't, it was only paper, and the war started again in the spring.
# know: letter :: The surrender: signed by the hill towns this morning. Must be countersigned in Vellmouth, the capital, within nine days, or the war starts again.
He had explained all this at every inn between the hills and here. He had loved explaining it.
The case was dry. Out on the water, Marrow's lantern was coming back, low and fast.
* [Take the case and hide it under your shirt]
    ~ LETTER = "wren"
    The buckle was stiff with cold. I got it open and pushed the case inside my shirt, flat against my ribs.
    It was the only thing on that bank worth more than I was. Now anyone who wanted it had to go through me. I hadn't yet thought about how easy that would be.
* [Leave it on his belt, where it belongs]
    ~ LETTER = "body"
    I left it. It was his. Everything on that bank was still his for a few minutes more, until somebody decided otherwise, and I have never been the one who decides.
- -> s04_marrow

// ---------------------------------------------------------------
= s04_marrow
# scene: s04_marrow
# panel: greywater_marrow_wading
Marrow came up out of the river with the lantern held high, and stopped when the light reached him.
She looked for a long while and said nothing. Then she said, "Well. Shit."
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
She crouched by the body without touching it and looked at me across the lantern. She wasn't frightened, quite. She was counting, the same as I had been. I liked her better for it and trusted her less.
"Here's how it goes," she said. "A Crown hero drowns at a ford. The guide who picked the ford deserted from the other side. Who hangs?"
I didn't answer. I was busy working out who hangs second.
"So he didn't drown," said Marrow. "Hill stragglers, in the dark. An arrow. He died with his sword out. Nobody hangs for that but stragglers, and they're hanging anyway."
* [Agree to her story: an ambush]
    ~ TOLD_MARROW = "ambush"
    ~ TRUST_MARROW += 1
    I nodded. Marrow let out a breath I hadn't known she was holding.
    "Good," she said. "You're quicker than he was." It is a strange thing to be proud of, and I was.
* [Tell her you won't lie about how he died]
    ~ TOLD_MARROW = "truth"
    ~ TRUST_MARROW -= 1
    "He drowned," I said. "That's what happened."
    Marrow looked at the river, then at me, like someone measuring a distance for a rope.
    "It's what happened," she agreed. "It just isn't what's going to have happened."
* [Tell her you'll decide by dawn]
    ~ TOLD_MARROW = "wait"
    "Dawn," I said. "I'll decide at dawn."
    "Dawn's when she wakes up." Marrow jerked her head at the cart. "Decide before. Her kind don't ask what you saw. They tell you."
- { LETTER == "body":
    Her eyes went to the oilskin case on his belt. "That still dry?"
    It was. She nodded slowly, and didn't reach for it. I noticed that. I noticed, too, how much she wanted to.
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
    I opened my shirt far enough to show the oilskin. Marrow looked at it, then at me, and I watched her think again about what I was.
    "Keep it there," she said. "And stop showing people."
* [Say you haven't seen it]
    "Haven't seen it," I said.
    She held the lantern on my face a moment longer than she needed to. Then she lowered it. "River, then," she said, the way you would to a child who says the dog ate the cheese.
- -> s05_dawn

// ---------------------------------------------------------------
= s05_dawn
# scene: s05_dawn
# panel: greywater_dawn_cart
# know: isolde :: Isolde Ferrant, the Crown's chronicler. Sent to write the ballad of the Lantern's peace.
Dawn came up grey and mean. Isolde Ferrant climbed down from the cart with a blanket round her shoulders and ink on two fingers.
She was the chronicler the Crown had sent along to write the Lantern's ballad. She had written most of it before we set out, which saved time.
She had always been kind to me. She knew my name, and asked after my feet, and in all that time I had never worked out what it was for.
She looked at the body for a long moment, the way she would look at a page with a blot on it.
"Did anyone else see?" she said.
Not *how*. Not *is he dead*. I have thought about that a good deal since.
"Just us," said Marrow.
Isolde nodded, and turned to me with a small sad smile, as if we were both about to do something hard and she was sorry it had to be me. "Wren. Tell me how he died."
* [Tell her the truth: he drowned, drunk]
    ~ VERSION = "truth"
    I told it straight: the wine, the polish, the stone that wasn't there, the water to his waist.
    Isolde shut her eyes. "In a ford," she said. "Drunk. A child could have crossed it."
    "A child would've waited for morning," said Marrow.
* [Tell her Marrow's story: an ambush]
    ~ VERSION = "ambush"
    ~ LEGEND += 1
    I told it the way Marrow had built it: the dark, the bows, the Lantern turning his horse to face them. It came out easily. That worried me less than it should have.
    Isolde's eyes went bright and quick. "Did he say anything?"
    "Something about bells," said Marrow, without a blink.
* [Tell her he went into the river after you]
    ~ VERSION = "hero"
    ~ LEGEND += 2
    "I fell in," I said. "He came in after me. He got me out. The river kept him."
    I don't know where it came from. I think I wanted, just once, to have been worth it.
    Isolde looked me over, top to toe.
    { WENT_IN:
        I was soaked to the collar and still shaking. She nodded.
    - else:
        ~ TRUST_ISOLDE -= 1
        I was wet to the knee and no higher. The corner of her mouth moved. She nodded anyway, and I understood that she would sooner have a good lie than an honest squire.
    }
    "That's the third verse," she said softly. "That's the one that didn't scan."
- -> s05_plan

= s05_plan
Isolde sat down on the cart step and pulled the blanket tight. When she spoke again it was in her working voice, the one with no warmth in it at all. I found I preferred it.
"Here is our difficulty," she said. "There are men at court who have grown fat on this war. When they hear the envoy is dead, they'll say the surrender died with him. Unsigned by the Crown, carried by nobody. And they'll be right for exactly as long as it takes them to say so."
"So?" said Marrow.
"So he isn't dead." Isolde looked at the body, fondly. "He's wounded. A fever. He rides to Vellmouth in the cart, under canvas, and nobody sees him till the King's ink is dry. Nine days."
"He'll stink by the fourth," said Marrow.
"Heroes do," said Isolde. "We'll say it's the wound."
{ VERSION == "truth":
    "And after?" I said.
    "After, he can die of whatever we like."
}
{ VERSION == "ambush":
    "And after, he dies of his wounds," she said. "Bravely. In the capital. With the bells."
}
{ VERSION == "hero":
    "And after, he dies of the river," she said. "And you're in the song, Wren. Think of that."
    I did think of it. That was the trouble.
}
"Now. The surrender." She held out an inky hand to nobody in particular. "Where is it?"
{ LETTER == "body": -> letter_on_body }
-> letter_with_wren

= letter_on_body
Before I could move she had knelt and unbuckled the case herself. She checked the seal and didn't open it.
* [Let her take it]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    She tucked it into her satchel, beside the ballad.
    "Thank you, Wren," she said, as though I had given it to her. I very nearly told her she was welcome.
* [Hold out your hand. "I'm his squire. I carry it."]
    Isolde looked at my hand. I watched her think about refusing, and then watched her add up what refusing would cost her with Marrow standing there.
    She put the case in it.
    ~ LETTER = "wren"
    ~ TRUST_ISOLDE -= 1
    "Of course," she said, and smiled. "His squire." I would have felt better if she had argued.
- -> s06_wrap

= letter_with_wren
* [Give it to her]
    ~ LETTER = "isolde"
    ~ TRUST_ISOLDE += 1
    I took the case out of my wet shirt and held it out. It was the only thing I had that anybody wanted, and I gave it away for a smile.
    Isolde checked the seal, didn't open it, and put it in her satchel beside the ballad. "Thank you, Wren," she said.
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
    }
    "Then we are carrying a dead man nine days," Isolde said at last, "to tell the King the war is over, with nothing to show him."
    She stood up and shook out the blanket.
    "So we'll find it," she said. "Or something very like it."
- -> s06_wrap

// ---------------------------------------------------------------
= s06_wrap
# scene: s06_wrap
# panel: greywater_wrapping
We wrapped him in the cart's canvas. It took all three of us to lift him. Marrow did the feet.
I had the head. Squires carry things. I had carried his shield, his debts and his excuses to innkeepers, and now I carried him. He was heavier than all of it, and easier company.
{ AT_FORD == "bridle":
    # remember: ford_bridle :: Marrow remembers you took his bridle.
    "You were the only one who tried," Marrow said, not looking up from the knots. "With the bridle. I saw."
    ~ TRUST_MARROW += 1
}
{ PURSE:
    # remember: light_purse :: Marrow remembers the purse was gone.
    Marrow ran her thumb along his belt where the purse had hung. She looked at me and didn't say a thing. Then she unbuckled his spurs and put them in her coat.
    "Fair's fair," she said.
}
{ TOLD_MARROW == "truth" && VERSION != "truth":
    # remember: marrow_refused_then_lied :: Marrow remembers you wouldn't lie for her.
    "You wouldn't lie for me," Marrow said quietly, so only I would hear. "But you'll lie for her."
    ~ TRUST_MARROW -= 1
}
{ TOLD_MARROW == "ambush" && VERSION == "truth":
    # remember: marrow_story_dropped :: Marrow remembers you agreed to her story.
    "We had a story," Marrow said, low. "You dropped it in the river with him."
    She pulled the last knot tight enough to creak.
    ~ TRUST_MARROW -= 1
}
{ VERSION == "hero" && not WENT_IN:
    # remember: dry_to_the_knee :: Isolde remembers you were dry to the knee.
    Isolde, passing with the end of the rope, said only, "You'll want to get wet before the next telling," and walked on.
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
By full light we were on the road to Stint, the toll town a day to the south, with the Lantern under canvas in the back of the cart.
# know: stint :: Stint: a toll town a day's ride south. The first place anyone will see the Lantern.
The grey walked behind on a lead rein. Its empty saddle shone. I had polished that, too.
Isolde sat by the body with her satchel on her knees and wrote for an hour without looking up. Marrow walked ahead and did not look back.
I drove. The reins were still damp. Eight days to Vellmouth, with a dead man, a deserter and a woman who wrote things down, and I could not have told you which of the three I trusted least.
Somewhere ahead, in Stint, they would be ringing the bells for him. I caught myself hoping he would enjoy it.
# end: ch00
-> END
