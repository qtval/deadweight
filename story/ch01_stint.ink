// CHAPTER 1 — STINT (opening scenes only; not yet linked from the prologue)
// Beat sheet: story/BEATS.md. Drafting rules for this chapter (reader panels, 2026-11-18/19):
// paragraphs end plainly; Wren's sour, bodily, self-serving thought runs under every act, in contractions;
// Wren believes their own excuses (no "I told myself"); one threat per scene lasts a page; the war is seen;
// Marrow and Isolde speak as story/CAST.md has them; the big moments are played live.
// Linked from the end of the prologue. The story test walks it once per distinct prologue end state (tools/test-story.mjs).

VAR ARMS = ""
VAR ARMOUR = ""
VAR WAVED = false
VAR DOBB = ""
VAR TOLL = ""
VAR RINGERS = ""
VAR SAID = ""
VAR STOPPED = ""
VAR LODGING = ""
VAR FOOT = ""
VAR SEARCH = ""

=== ch01 ===
# title: Chapter 1 :: Stint
-> s01_armour

// ---------------------------------------------------------------
= s01_armour
# scene: c1_s01_armour
# panel: road_beech_wood_noon
A mile short of Stint the road ran through a beech wood. The Marshal's riders had been through ahead of us and cut it to mud. There was a gibbet at the edge of the trees with nothing on it but the rope, and somebody had stolen the rope's end.
Marrow turned the cart in under the beeches, where it couldn't be seen from the road.
"He cannot arrive like that," said Isolde. "That is a dead knight laid out for burial. I want a sick man in his shirt, under blankets. Wren knows the buckles."
I did know the buckles. There were thirty-one, and four laces, and a pin at the neck that stuck. I had done them up every morning for six years.
Isolde untied the canvas. He had gone stiff in his plate.{SELF == "peace": I had to get the sword out from under his hands first.}
{SELF != "him":I was still wearing his gloves. I took them off to touch him.}
Marrow looked at the armor, and not at him. "Sixty pound of plate. That's a farm."
"It is sixty pounds of proof that he is not in bed," said Isolde. "It goes in the pond." There was a pond below the trees, black, with leaves lying on it.
Isolde wouldn't touch him. She stood by the horse with her sleeve over her nose and told me which arm first.
The neck and the shoulders and the breastplate were only buckles. Then there were his arms. A stiff arm won't go into a shirt sleeve unless somebody takes it at the elbow and the wrist and leans.
* [Let Marrow do it. You don't want to hear it go.]
    ~ ARMS = "marrow"
    Marrow leaned. It made a noise like a green branch. She did the other one as well, while I held his hand, and the whole time she was looking at me.
* [Do it yourself.]
    ~ ARMS = "wren"
    Marrow held his shoulders and I leaned. It made a noise like a green branch{WENT_IN:, and my own elbow answered it}. I did the other one too, so she wouldn't. Her knife was on her belt, at the height of my eyes, the whole time.
- 
{ WENT_IN:
    His nose had gone black down one side.
}
{ TOLD_MARROW == "truth":
    My ear had scabbed in the night. I kept touching it, and every time I did Marrow saw me do it.
}
{ VERSION == "ambush":
    The hole she had put under his arm had started to smell sweet. Isolde had me bind it with a strip off his shirt, so there would be a bandage to show.
}
The rest had to be me. I was the one who knew he couldn't bear a tight collar. And if Marrow had his arming coat off him she'd have gone through it for coin, and that wasn't right, not with him lying there. When she went to see to the horse I went through it myself, to be sure she hadn't. There was nothing.
{ DEED == "signed":
    My promise, the one with his name on it, crackled in my shirt every time I bent. I bent as little as I could.
}
Then the armor lay in a heap with his badge on the breast, the lantern in blue enamel. I had not eaten since yesterday noon, and I looked at it the way Marrow did.
* [Sink it in the pond]
    ~ ARMOUR = "ditch"
    I carried it down in four loads and waded in to my thighs{WENT_IN:, coughing|, on the bad knee}. The breastplate went last, badge up, and I watched the blue go down.
    Marrow watched the last of it go down. "That's a farm in a pond," she said. "I'll remember whose."
* [Keep it in the cart, under him. It's his.]
    ~ ARMOUR = "cart"
    I laid it flat on the cart bed, under where he would lie. When the cart moved it knocked, plate on plate, at every rut.
    "Everyone'll hear that," said Marrow. "Think it's him moving. Could be good."
    "It is not good," said Isolde. "Take it out."
    "No," I said. I had never said it to her. It was his. It couldn't be sold while he was lying on it, and that went for her too.
    "Then you will explain the knocking," said Isolde, "to everyone who asks."
* [Let Marrow sell it. Take half. You haven't eaten since the ford.]
    ~ ARMOUR = "sold"
    "Half," I said. It came out before I'd decided to say it.
    "Half," said Marrow, and looked at me properly. She sat in the leaves with a file and began taking the lantern off the breastplate. The enamel came away in blue flakes.
    She missed a rivet on the left shoulder with a small lantern stamped in its head. I saw it. Half a farm was more money than I had ever stood near, and she knew her business.
    "If one piece of that is found with his badge on it," said Isolde, "we hang. All three."
    "Won't be," said Marrow, and went on filing. A tinker came along the road while she worked, and she sold it to him in the trees, sack and all.
- We laid him back under the canvas in his shirt, with two blankets up to his chin.
Without the plate he wasn't very big. He had a grey chest and a soft belly. He looked like somebody's father.
-> s02_bells

// ---------------------------------------------------------------
= s02_bells
# scene: c1_s02_bells
# panel: stint_bridge_dusk
Every bell in Stint was going.
The road came out of the trees onto the bridge, and Stint was on the far bank. The bridge was lined on both sides. There were children up on the wall of it, and a woman holding up a baby to see. They saw his grey horse on its lead rein with the saddle empty, and the noise dropped, and came up louder.
{ARMOUR == "cart":The plate knocked under him at every board of the bridge, and a man by the wheel shouted, "He's moving!" and people cheered that too. }{PLAN == "objected":I was under the canvas with him, where Isolde had put me.|I had the reins, and my hands were wet on them.}
"One wave from inside the cart," said Isolde, not moving her mouth. "Then you tell them he is resting."
Six men in his colors were waiting at our end of the bridge. The one in front was Corporal Dobb, who had been with him twenty years. The back of his left hand was shiny from a burn at the siege. He came to meet us. He always took the bridle.
"Six of his," said Marrow, from behind the cart. "They look under there, I'm off. You're not."
* [Wave his glove from the canvas. Let them shout for you.]
    ~ WAVED = true
    {SELF == "him":The gloves were on his hands. I got one off him, which took longer than I had, and it was cold inside.|I pulled one of his gloves back on.}
    I knelt up beside him where my face wouldn't show, and put my arm out through the gap, and moved it from side to side.
    The noise was for him. But it was my arm they were looking at, and nobody had ever shouted for any part of me before, and I left it out there for about as long as it takes to say a prayer.
    Then a child up on the wall said, quite clearly, in a gap, "That's not him. That's a little arm."
    People laughed. It was a friendly laugh. I got my arm in so fast I caught the canvas.
* [Stand up and tell them he's sleeping]
    {PLAN == "objected":I put my head and shoulders out through the gap|I stood up on the driving board{not WENT_IN:, on the bad knee}}. "He's sleeping," I said. It didn't carry. I said it again as loud as I could, and my voice went up and cracked{WENT_IN:, and then I coughed, so that it sounded as if I had it too}. "He's sleeping. He has a fever. He can't be woken."
    It went along the bridge from the front to the back. I watched it go. The shouting stopped. The bells didn't, because nobody had told the bells.
    Something hit the side of the cart and rolled away. It was a turnip. Somebody had carried it six miles for his horse.
* [Let Isolde talk. She's better at it, and it'll be her lie.]
    I {PLAN == "objected":knelt there in the dark beside him|sat there} with my mouth open, and nothing came out of it.
    Isolde waited as long as she could. Then she stood up{PLAN != "objected":, with a hand on my shoulder to steady herself. She pressed down on it, hard}.
    "Good people of Stint," she said, and they went quiet for her as they would never have gone quiet for me. "The Lantern thanks you for your bells. He has taken a fever on the road, and he sleeps. His squire has the nursing of him. Ring for him again in the morning. Softer."
    Some of them laughed at softer, and one woman cried. Isolde had told two hundred people that if he died it was my nursing.
- Corporal Dobb came on to the back of the cart. He put his burned hand flat on the canvas, where the feet were.
"Fever," he said.
"Yes, Corporal."
"Since when?"
"This morning." It had been last night. I had to keep hold of that: this morning.
"Marsh one, then. He's had it before. He wants his feet rubbing for it, or he gets the cramps." He was already lifting the edge of the canvas. "Let's have them."
His hand went in under the blanket, looking for the feet, and the whole bridge watched it go. I watched his face, and I saw the moment he found one. It had been cold since last night.
"He's cold," said Dobb. He said it to me, not loud. His hand stayed where it was.
* [Knock his hand away. In front of his men.]
    ~ DOBB = "struck"
    I hit his hand. I hit it hard, on the burn, and he took it out from under the canvas and held it against his chest.
    "Don't touch him," I said. My voice had gone high. "He's not to be touched. That's what she said, the chronicler. Only me."
    Everybody on that end of the bridge had seen it. Dobb held the hand against his chest and didn't say anything. One of his men spat on the bridge, near my boot.
    "I'll sit with him tonight all the same," he said. "He'll ask for me."
* [Tell him it's catching. Let the bridge hear.]
    ~ DOBB = "catching"
    "It's catching," I said, loud. "Cold sweats. You've children here."
    The woman with the baby turned round into the crowd with it, and the crowd went back off the bridge after her.
    Dobb didn't move his hand. "Had the sweats at the siege," he said. "Can't have them twice." Then he took it out from under the blanket, slowly, and wiped it on his coat.
    Isolde took the reins out of my hands, in front of his men, and kept them.
    "I'll sit with him tonight," said Dobb. "Since I can't catch it."
* [Tell him Aubric asked not to see him like this]
    ~ DOBB = "refused"
    "He said not you, Corporal." I said it low, so only he would hear. "He said he didn't want you to see him like this. Not you."
    Dobb's hand came out from under the canvas as if it had been burned again.
    He wouldn't have wanted Dobb to see him like this. Anybody would say so.
    "He said that," said Dobb.
    "Yes, Corporal."
    He went back to his men and didn't look round again. He was rubbing his fingers together, as if there were still something on them.
- Behind me I heard Marrow put her knife away. I hadn't seen her take it out.
-> s03_toll

// ---------------------------------------------------------------
= s03_toll
# scene: c1_s03_toll
# panel: stint_tollhouse
Halfway over, the bridge narrowed to get round the tollhouse, and the cart had to stop at it like any other.
Four horses with the Marshal's grey cloth over their saddles stood at the rail. Their riders were inside on a bench, drinking the tollkeeper's jug. One of them had his boots up.
The tollkeeper was a long man with a boil on his neck that had come to a head. He had a book open on a slope and a pen behind his ear.
"Cart's fourpence," he said. "And what's in it?"
"The Lantern," I said.
"I know who. I'm asking what. Sick or dead? Sick's a penny more. Dead's sixpence a head, since the war. There was that many. I've to write the one or the other, and somebody puts their name."
"Sick," I said. It was cheaper.
"Sick." He wrote it slowly, breathing through his mouth. He turned the book round on the slope and held out the pen.
"Sergeant reads it every night," he said, and tipped his head at the bench.
The man with his boots up was Lidd, the sergeant, eating the tollkeeper's onions.
Dobb's men had followed. Marrow was in the doorway behind me.
* [Sign your own name. It's never been in a book.]
    ~ TOLL = "sick"
    I can write. I wrote my name. Now it was in a book that somebody kept, and I had wanted that to be a different book. This one said that I, Wren, gave my word the man in the cart was sick, and it had the day on it.
    He blotted it. "You write a fair hand. Better than the sergeant."
    Lidd laughed with his mouth full.
* [Sign his name. You do it better than he did.]
    ~ TOLL = "forged"
    I signed it Aubric Dane, with the loop he made when he was pleased. If he'd been well he'd have signed it himself. He was only sick.
    The tollkeeper turned the book round and read it. "Sick man signs a good hand."
    "He woke for it," I said. "Just for that."
    Lidd took his boots off the bench. He came over, not hurrying, and took my right hand by the wrist and turned it over, and looked at the ink on my fingers. Then he read the page upside down.
    "I've had letters from him," he said. "Lovely letters. He promised me a lieutenancy in one of them. In that hand." He didn't let go of my wrist. "Does he remember that, do you think? When he wakes?"
    "I'll ask him," I said.
    "Do." He let go.
* {RING} [Show him the signet. Cross in the Lantern's name.]
    ~ TOLL = "ring"
    I took the ring out of my shirt and held it where he could see. I didn't put it on. It would have gone round my thumb.
    He looked at it for a while. "That's his. I've seen it on him." He shut the book without writing in it. "Lantern crosses free, cart and all. Always has."
    He waved the cart on. Lidd said, from the bench, "Squire's got his ring."
* [Pay for the cart and sign nothing]
    ~ TOLL = "paid"
    "I'll pay for the cart," I said. "I'm no surgeon. I can't give my word what he is."
    He looked at me. Then he wrote, and said it aloud as he wrote, so that I should know. "Squire. Would. Not. Say." He looked out at the sun on the water, and wrote the hour.
    On the bench Lidd stopped chewing to listen.
- { TOLL != "ring":
    { PURSE:
        I paid the fivepence out of the purse. The tollkeeper took it, and then he took hold of the purse itself by the strings and turned it to the light.
        "I've changed coin out of that," he said. "That's his."
        "He gave it me to pay with."
        # remember: purse_at_toll :: The tollkeeper remembers whose purse it was.
        "Did he?" He let go. He liked a thing written down right, and he was deciding how to write it.
    - else:
        I had no fivepence. Marrow came off the doorpost and put five pennies on the slope, one at a time, out of the purse she'd cut off him. "Five," she said to me. "{DEBT_MARROW:Price was doubled at the river. Now it's doubled and five.|That's the first you owe me.}"
    }
}
The tollkeeper put the pen back behind his ear and didn't go on to the next cart. There wasn't one. He scratched beside the boil.
"My girl's to be married tomorrow," he said. "Annis. He's had my ringers three days, practising for him. They're my ringers. I pay them. Would he spare them an hour in the morning, for the chapel? I'd not ask. Only he's a generous man. Everyone says it."
He was asking me. I looked round for somebody else he might be asking. Marrow and the sergeant were both waiting to hear what the Lantern would say, and Dobb behind them.
* [Say yes, in his name. He'd have said yes.]
    ~ RINGERS = "yes"
    "He'll spare them," I said. "For Annis."
    The tollkeeper shut his eyes for a moment. "God keep him," he said. "Tell him that from me."
    I'd given away his bells. They weren't mine, and it felt wonderful.
* [Say he's too ill to be asked anything]
    ~ RINGERS = "no"
    "He's too ill to be asked," I said. "I'm sorry."
    "Course he is." The tollkeeper put the pen back behind his ear. "Course he is. I'd not have asked." He went back to his book, and didn't look up again.
- Lidd came and stood behind me, close enough that I could smell the tollkeeper's jug on him. "Marshal's in Stint tomorrow," he said. "He'll want to pay his respects. Make sure your master's awake."
I said I would.
-> s04_square

// ---------------------------------------------------------------
= s04_square
# scene: c1_s04_square
# panel: stint_square_bells
The square was under the bell tower, and the bells were right over us.
Eight of the Marshal's riders were drawn up across it. Lidd walked ahead of the cart, and when he got to them he turned round, and they all looked at us.
"The Marshal's surgeon is upstairs at his supper," said Lidd, and nodded at the inn. "Sent out to meet your master. Sent him the day before yesterday, before your master was ill. He'll bleed him at first light. Two pints for a fever, he says.{WAVED: He waved, I'm told. Then he can sit up for the bowl.}"
Lidd took a little book out of his coat, and a pencil. "How did he take sick, squire? And where? I like to have it right."
His pencil was over the page. Isolde was a yard from me, listening.
* [Tell it the way you all agreed it]
    ~ SAID = "public"
    "A fever, sergeant. {VERSION == "ambush":He took an arrow from robbers on the road, and it went bad.|{VERSION == "hero":He took a chill in a river, pulling me out.|It came on him on the road.}}"
    He wrote it all down, saying the words. {VERSION == "ambush":"Robbers. On the Marshal's road." He looked up. "Then the Marshal will want somebody hanged for it. He's particular about his road."|"A fever." He underlined it.}
* [Say less. "A fever. I'm not a surgeon."]
    ~ SAID = "less"
    "A fever. I'm not a surgeon."
    "No." He wrote. "Squire. Could. Not. Say." He showed me the page, as if I might want to check his spelling.
* [Say more. Give him a detail, to make it live.]
    ~ SAID = "more"
    "He was sick in his helmet," I said. "Twice, on the road. He made me promise not to tell anyone."
    Lidd read it back to me. I had made it up in the time it took to open my mouth, and now it was in his book, and it would have to stay true for seven days.
- Then he put the pencil away. "And the surrender. The Marshal would like it kept safe. I'll carry it."
{ LETTER == "wren":
    "It stays with him," I said. "Under his pillow."
}
{ LETTER == "hidden":
    "The river took it," I said. Isolde didn't look at me. She'd heard me say it before.
}
{ LETTER == "isolde":
    "How kind," said Isolde. "It stays in my satchel until the council has it. You may write that down."
    Lidd looked at my shirt anyway.
    -> s04_bills
}
"Does it," said Lidd. "Squire looks like a thief to me." He said it to his men, pleasantly. "Turn his shirt out."
Two of them took my arms. I pulled, once, and one of them put his knee in the back of mine, and I went down on the stones. A third knelt and started down my sides with flat hands. The case was under my shirt, against my belly.
* [Give them money. A thief would have some.]
    ~ SEARCH = "paid"
    {PURSE:
        ~ PURSE = false
        "In my shirt," I said into the stones. "The purse." I got it out myself and held it up. Lidd weighed it. "There," he said, pleased. "A thief, and his takings." He wrote it down and pocketed the purse. He'd found what he said he would. That was all he'd wanted.
    - else:
        "My boot," I said into the stones. "Four pennies." He pulled the boot off and shook them out. That was all I owned. "There," said Lidd. "A thief, and his takings." He wrote it down. He'd found what he said he would.
    }
    They let go of my arms.
* [Kick. Make them hold you instead of searching you.]
    ~ SEARCH = "kicked"
    I kicked. I caught somebody's shin, and they stopped searching and started kicking, a boot in the ribs, twice, and the second time something clicked. I couldn't get my breath.
    "Enough," said Lidd. "The Marshal will want him walking." They left me there.
- ~ STOPPED = "dobb"
Dobb picked me up off the stones, in front of all of them, and set me on my feet.
-> s04_bills

= s04_bills
{ TOLD_MARROW == "truth":
    Lidd touched my ear with one finger. "Who marked your ear, squire?"
    "The cart," I said. Lidd looked at Marrow.
}
{ TOLD_MARROW == "ambush":
    Lidd took Marrow's flask off her belt, drank, and gave it back. "Hill stuff," he said. "Thought so."
}
"Sergeant," said Isolde. "When the Marshal comes, I should like a quarter of an hour with him. Alone. A chronicler hears a great many things on the road." Lidd wrote that down too. She didn't look at me while he did it.
-> s04_dobb

= s04_dobb
Lidd's riders went in to their supper. Dobb walked me to the horse trough with his hand on my shoulder as if he were helping me. His men stood round us.
{ARMOUR == "sold":He had a shoulder piece under his arm. He set it on the edge of the trough, rivet up. "Tinker sold it the smith at the bridge end. Had it off a woman in the beech wood. Badge filed off. Missed one."}
"I had his foot, Wren," he said. "On the bridge."
I waited for him to say the rest of it. He didn't. He wanted me to.
{STOPPED == "dobb":"I picked you up in front of the Marshal's men," he said. "So you'll answer me."}
{DOBB == "struck":He held up the burned hand, where I'd hit it.}
{DOBB == "refused":"And he never said not me," said Dobb. "Not in twenty years."}
{DOBB == "catching":"I've had the cold sweats," said Dobb. "They're not that cold."}
"I've laid out more of his lads than you've met," he said. "I know cold."
So did I, now. I'd slept beside it last night. "He's my knight too," I said. Dobb waited for the rest of it.
Marrow sat on the tailboard with an apple, watching his back.
* [Say the cold comes before the sweat. Say it like a surgeon.]
    ~ FOOT = "fever"
    "It's the fever," I said. "The cold comes first, then the sweat. Ask anyone." I didn't know if it was true.
    "Ask anyone," said Dobb. He took my wrist and squeezed until the little bones moved against each other. "I'm asking you."
    I said it again, the same words. My eyes were running. He let go. I couldn't close that hand till dark.
* [Tell him to say it louder. Lidd's at the window.]
    ~ FOOT = "lidd"
    "Say it louder, Corporal," I said. "Lidd's at the window. Tell the Marshal's man the Lantern's cold, and see what he does with it."
    Dobb looked up at the inn. There was a face at the window, or there was the lamp. He took his hand off my shoulder.
    "I never said dead," he said. "I said cold." He said it loud enough for his men. One of them walked away across the square and didn't come back.
* [Say nothing. Let him decide what he felt.]
    ~ FOOT = "silent"
    I didn't say anything. I looked at him till he looked away first.
    "Right," said Dobb. "Then I don't know anything, do I. Not till you tell me." He picked up the trough's dipper and drank, and put it back. "I'll be asking again, Wren."
- {ARMOUR == "sold":He took the shoulder piece back under his arm. I watched it go.}
Marrow threw her apple core into the trough. "Corporal's a problem," she said. "Problems cost."
First light, Lidd had said, and two pints. I'd held the bowl for him at his last marsh fever. He'd filled it twice.
-> s05_friar

// ---------------------------------------------------------------
= s05_friar
# scene: c1_s05_friar
# panel: stint_chapel_door
The square emptied with the light.
An old friar came round to the downwind side of the cart and had my boot off before I'd agreed to it.
"Brother Tobin," he said, to my foot. "That's how toes go black." He rubbed it between his hands. Nobody had touched my feet since my mother. I'd have let him do the other one.
"He can't lie in a cart tonight," he said. "I have a chapel. Eleven under the roof, and it leaks. A saint under it one night, and I'd have pilgrims till the slates were paid for. No steel past the door. Not even a surgeon's."
A saint. Aubric would have liked that. He'd have liked the money better.
"Inn yard," said Dobb. "My lads round him."
"The chapel," said Isolde, before I could open my mouth. "A vigil in a chapel is a verse. An inn yard is a footnote."
"Tollkeeper's barn," said Marrow. "Fourpence, and the key's ours."
"Then you may sleep in it," said Isolde.
"Will."
* [The chapel. A bolt, no steel, and Tobin holds the key.]
    ~ LODGING = "chapel"
    "The chapel," I said. Let it be a verse.
    Tobin nodded as if I'd said grace. Dobb spat on the stones and went to tell his men. Within the hour two of Lidd's riders were standing outside the chapel door with their swords on, and I was lying across the step inside it, with the bolt above my head and the key in Tobin's belt.
* [The inn yard. Dobb and five swords round him.]
    ~ LODGING = "yard"
    "The yard," I said. "With Dobb." Isolde shut her book.
    "As you think best, child," said Tobin, and went to fetch vinegar anyway. Dobb put the cart against the stable wall and sat down on the tailboard, a foot from the canvas. "I'll not go under," he said. "Chronicler says it's catching."
* [The tollkeeper's barn. No eyes on him but yours.]
    ~ LODGING = "barn"
    "The barn," I said. "The tollkeeper's. Just me."
    It cost fourpence. {PURSE:I paid it out of the purse, and I saw the tollkeeper's boy see the purse.|Marrow paid it, and held up a fifth finger at me.} There'd be no one to sit with him there, and no one to turn him but me.
- Tobin was tying my boot up again, slowly, because his hands were old.
"And who is it turns him, child?" he said, without looking up. "A man in a fever wants turning, or he gets sores. Every few hours. You'll know that, being his squire."
I didn't know it. He knew I didn't.
# end: ch01_preview
-> END
