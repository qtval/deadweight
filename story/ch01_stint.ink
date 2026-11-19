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
Isolde untied the canvas, with her back to me, so I wouldn't learn her knot. He had gone stiff in his plate.{SELF == "peace": I had to get the sword out from under his hands first.}
{SELF != "him":I was still wearing his gloves. I took them off to touch him.}
Marrow looked at the armor, and not at him. "Sixty pound of plate. That's a farm."
"It is sixty pounds of proof that he is not in bed," said Isolde. "It goes in the pond." There was a pond below the trees, black, with leaves lying on it.
Isolde wouldn't touch him. She stood by the horse with her sleeve over her nose and told me which arm first. Marrow would touch him, and did, and went on looking at the plate while she did it.
The neck and the shoulders and the breastplate were only buckles. Then there were his arms. A stiff arm won't go into a shirt sleeve unless somebody takes it at the elbow and the wrist and leans.
* [Let Marrow do it. It's her trade, and your hands stay clean.]
    ~ ARMS = "marrow"
    Marrow leaned. It made a noise like a green branch. She did the other one as well, while I held his hand, and the whole time she was looking at me and not at him.
* [Do it yourself. He was your knight.]
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
The rest had to be me. Nobody else knew he couldn't bear a tight collar. And if Marrow had his arming coat off him she'd have gone through it for coin, and that wasn't right, not with him lying there. When she went to see to the horse I went through it myself, to be sure she hadn't. There was nothing.
{ DEED == "signed":
    My promise, the one with his name on it, crackled in my shirt every time I bent. I bent as little as I could.
}
Then the armor lay in a heap with his badge on the breast, the lantern in blue enamel. I had not eaten since yesterday noon, and I looked at it the way Marrow did.
* [Sink it in the pond]
    ~ ARMOUR = "ditch"
    I carried it down in four loads and waded in to my thighs{WENT_IN:, coughing|, on the bad knee}. The breastplate went last, badge up, and I watched the blue go down.
    When I came up the bank Marrow took me by the collar, the way she'd had my hair at dawn, and walked me back against a tree.
    "Farm," she said. "I say a thing's a farm, you listen." She held me there long enough for me to think of the knife.
* [Keep it in the cart, under him. It's his.]
    ~ ARMOUR = "cart"
    I laid it flat on the cart bed, under where he would lie. When the cart moved it knocked, plate on plate, at every rut.
    "Everyone'll hear that," said Marrow. "Think it's him moving. Could be good."
    "It is not good," said Isolde. "Take it out."
    "No," I said. I had never said it to her. It was his. Nobody could sell it while he was lying on it, and that went for her too.
    "Then you will explain the knocking," said Isolde, "to everyone who asks."
* [Let Marrow sell it. Take half. You haven't eaten since the ford.]
    ~ ARMOUR = "sold"
    "Half," I said. It came out before I'd decided to say it.
    "Half," said Marrow, and looked at me properly for the first time that day. She sat down in the leaves with a file and the breastplate across her knees and began to take the lantern off it. The enamel came away in blue flakes.
    She was quick, and she missed a rivet on the left shoulder that had a small lantern stamped in its head. I saw it. Half of a farm was more money than I had ever stood near, and she knew her business better than I did.
    "If one piece of that is found with his badge on it," said Isolde, "we hang. All three."
    "Won't be," said Marrow, and went on filing.
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
Six men in his colors were waiting at our end of the bridge, before the tollhouse. The one in front was Corporal Dobb, who had been with him twenty years. The back of his left hand was shiny from a burn at the siege. He came to meet us. He always took the bridle.
"Six of his," said Marrow, from behind the cart. "They look under there, I'm off. You're not."
* [Wave his glove from the canvas. Let them shout for you.]
    ~ WAVED = true
    {SELF == "him":The gloves were on his hands. I got one off him, which took longer than I had, and it was cold inside.|I pulled one of his gloves back on.}
    I knelt up beside him where nobody could see my face, and put my arm out through the gap, and moved it from side to side.
    I have never heard a noise like it. It was for him. But it was my arm they were looking at, and nobody had ever shouted for any part of me before, and I left it out there for about as long as it takes to say a prayer.
    Then a child up on the wall said, quite clearly, in a gap, "That's not him. That's a little arm."
    People laughed. It was a friendly laugh. I got my arm in so fast I caught the canvas.
* [Stand up and tell them he's sleeping]
    {PLAN == "objected":I put my head and shoulders out through the gap|I stood up on the driving board{not WENT_IN:, on the bad knee}}. "He's sleeping," I said. Nobody heard. I said it again as loud as I could, and my voice went up and cracked{WENT_IN:, and then I coughed, so that it sounded as if I had it too}. "He's sleeping. He has a fever. He can't be woken."
    It went along the bridge from the front to the back. I watched it go. The shouting stopped. The bells didn't, because nobody had told the bells.
    Something hit the side of the cart, hard, and rolled away. It was a turnip. Two hundred people had walked in from the farms to see the Lantern, and what they had got was me.
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
His hand went in under the blanket, looking for the feet, and the whole bridge watched it go. In a moment he would have hold of a foot that had been cold since last night. I watched his face. I couldn't tell if he had found it.
* [Knock his hand away. In front of his men.]
    ~ DOBB = "struck"
    I hit his hand. I hit it hard, on the burn, and he took it out from under the canvas and held it against his chest.
    "Don't touch him," I said. My voice had gone high. "Nobody touches him. That's what she said, the chronicler. Nobody but me."
    His men had seen it. Everybody on that end of the bridge had seen it. Dobb held the hand against his chest and didn't say anything. One of his men spat on the bridge, near my boot.
    "I'll sit with him tonight all the same," he said. "He'll ask for me."
* [Tell him it's catching. Let the bridge hear.]
    ~ DOBB = "catching"
    "It's catching," I said, loud. "The sweating sort. You've children here."
    The woman with the baby heard it first. She turned round with it into the crowd, and the crowd went back off the bridge after her. The children came down off the wall.
    Dobb didn't move his hand. "Had the sweats at the siege," he said. "Can't have them twice." Then he took it out from under the blanket, slowly, because his men were looking at him, and wiped it on his coat.
    "Thank you, Wren," said Isolde, very quietly. "They had come to sing."
    "I'll sit with him tonight," said Dobb. "Since I can't catch it."
* [Tell him Aubric asked not to see him like this]
    ~ DOBB = "refused"
    "He said not you, Corporal." I said it low, so only he would hear. "He said he didn't want you to see him like this. Not you."
    Dobb's hand came out from under the canvas as if it had been burned again.
    He wouldn't have wanted Dobb to see him like this. Anybody would say so.
    "He said that," said Dobb.
    "Yes, Corporal."
    He went back to his men and didn't look round again. Behind me Marrow let out her breath. "That's one won't come near," she said.
- -> s03_toll

// ---------------------------------------------------------------
= s03_toll
# scene: c1_s03_toll
# panel: stint_tollhouse
The tollhouse stood halfway over the bridge, and the cart had to stop at it like any other.
Four horses stood at the rail outside it, with the Marshal's grey cloth over the saddles. Their riders were inside, at a bench against the wall, drinking out of the tollkeeper's jug. One of them had his boots up.
The tollkeeper was a long man with a boil on the side of his neck that had come to a head. He had a book open on a slope and a pen behind his ear.
"Cart's fourpence," he said. "And what's in it?"
"The Lantern," I said.
"I know who. I'm asking what. Sick or dead? Sick's a penny more. Dead's sixpence a head, since the war. There was that many. I've to write the one or the other, and somebody puts their name."
"Sick," I said.
"Sick." He wrote it slowly, breathing through his mouth. He turned the book round on the slope and held out the pen.
"Sergeant reads it every night," he said, and tipped his head at the bench.
The man with his boots up was the sergeant, picking his teeth with a straw.
Dobb and his men had followed the cart, close enough to hear. Marrow had come into the doorway behind me. Isolde stayed in the cart, where she could see the sergeant's face and he couldn't see hers.
* [Sign your own name. It's never been in a book.]
    ~ TOLL = "sick"
    I can write. I wrote my name. It was the first time I had written it in a book that somebody kept, and I had wanted that to be a different book. This one said that I, Wren, gave my word the man in the cart was sick, and it had the day on it.
    He blotted it. "You write a fair hand. Better than the sergeant."
    The sergeant laughed, through the straw.
* [Sign his name. You do it better than he did.]
    ~ TOLL = "forged"
    I signed it Aubric Dane, with the loop he made when he was pleased. If he'd been well he'd have signed it himself. He was only sick.
    The tollkeeper turned the book round and read it. "Sick man signs a good hand."
    "He woke for it," I said. "Just for that."
    The sergeant took his boots off the bench. He came over, not hurrying, and took my right hand by the wrist and turned it over, and looked at the ink on my fingers. Then he read the page upside down.
    "I've had letters from him," he said. "Lovely letters. He promised me a lieutenancy in one of them. In that hand." He didn't let go of my wrist. "Does he remember that, do you think? When he wakes?"
    "I'll ask him," I said.
    "Do." He let go.
* {RING} [Show him the signet. Cross in the Lantern's name.]
    ~ TOLL = "ring"
    I took the ring out of my shirt and held it where he could see. I didn't put it on. It would have gone round my thumb.
    He looked at it for a while. "That's his. I've seen it on him." He shut the book without writing in it. "Lantern crosses free, cart and all. Always has."
    It was easy. I was still thinking how easy when the sergeant said, from the bench, not loudly, "Squire's got his ring."
* [Pay for the cart and sign nothing]
    ~ TOLL = "paid"
    "I'll pay for the cart," I said. "I'm no surgeon. I can't give my word what he is."
    He looked at me. Then he wrote, and said it aloud as he wrote, so that I should know. "Squire. Would. Not. Say." He looked out at the sun on the water, and wrote the hour.
    On the bench the sergeant took the straw out of his mouth to listen, and put it back.
- { TOLL != "ring":
    { PURSE:
        I paid the fivepence out of the purse. The tollkeeper took it, and then he took hold of the purse itself by the strings and turned it to the light.
        "I've changed coin out of that," he said. "That's his."
        "He gave it me to pay with."
        # remember: purse_at_toll :: The tollkeeper remembers whose purse it was.
        "Did he?" He let go. He liked a thing written down right, and he was deciding how to write it.
    - else:
        I had no fivepence. I have never had fivepence. Marrow came off the doorpost and put five pennies on the slope, one at a time, out of the purse she'd cut off him. "Five," she said to me. "{DEBT_MARROW:Price was doubled at the river. Now it's doubled and five.|That's the first you owe me.}"
    }
}
He put the pen back behind his ear and didn't go on to the next cart. There wasn't one. He scratched beside the boil.
"My girl's to be married tomorrow," he said. "Annis. He's had my ringers three days, practising for him. They're my ringers. I pay them. Would he spare them an hour in the morning, for the chapel? I'd not ask. Only he's a generous man. Everyone says it."
He was asking me. I looked round for somebody else he might be asking. Marrow and the sergeant were both waiting to hear what the Lantern would say, and Dobb behind them.
* [Say yes, in his name. He'd have said yes.]
    ~ RINGERS = "yes"
    "He'll spare them," I said. "For Annis."
    The tollkeeper shut his eyes for a moment. "God keep him," he said. "Tell him that from me."
    "That's his bells, given away," said Marrow, in the doorway, "by his squire."
* [Say he's too ill to be asked anything]
    ~ RINGERS = "no"
    "He's too ill to be asked," I said. "I'm sorry."
    "Course he is." The tollkeeper put the pen back behind his ear. "Course he is. I'd not have asked." He went back to his book, and didn't look up again.
- The sergeant put a hand on the back of my neck, friendly, the way you'd hold a pup to look at its teeth. "Marshal's in Stint tomorrow," he said. "He'll want to pay his respects. Make sure your master's awake."
-> s04_square

// ---------------------------------------------------------------
= s04_square
# scene: c1_s04_square
# panel: stint_square_bells
The square was under the bell tower, and the bells were right over us.
Eight of the Marshal's riders were drawn up across it. The sergeant from the tollhouse walked ahead of the cart, and when he got to them he turned round, and they all looked at us. His name was Lidd.
At a table outside the inn a man in a black coat was eating a pie with his fingers. A surgeon's bag sat by his plate.
"Master Venn," said Lidd. "Surgeon. The Marshal sent him out to meet your master. Thoughtful. Sent him the day before yesterday."
The day before yesterday he hadn't been sick.
Marrow had got down behind the horse. Lidd looked over it anyway. "Marrow," he said. "Still guiding." She didn't answer. He wrote something in a little book.
{ARMOUR == "sold":Marrow had sold the plate to a smith by the gate while we waited at the toll. Now the smith had a shoulder piece out on his stall, and Dobb had stopped there. He was turning it over in his hands. The rivet with the lantern on it was facing up. My stomach went to water.}
{WAVED:"He waved, I'm told," said Lidd. "Then he can sit up for a surgeon."}
"How did he take sick, squire? And where? I like to have it right."
His pencil was over the page. Isolde was standing a yard from me, and whatever I said now, she would have to live with.
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
"Does it," said Lidd. "Squire looks like a thief to me." He said it to his men, pleasantly. "Turn him out."
Two of them took my arms. A third put his hands flat on my ribs and went down my sides, slowly, the way you feel a horse's legs. He was one hand short of the case.
I looked round.
* [Look at Dobb]
    ~ STOPPED = "dobb"
    Dobb came across the square and put his burned hand on the rider's wrist. "That's the Lantern's squire."
    Lidd hit him in the mouth, not hard, the way you'd tap a door. Dobb's lip split. He didn't let go of the wrist, and in the end the rider let go of me.
* [Look at Marrow]
    ~ STOPPED = "marrow"
    Marrow came round the horse into the open, where Lidd could see her properly. "Sergeant. You still owe me for the back road round the wood."
    Lidd smiled at her, and waved his man off me. Marrow didn't look at me. She'd spent something on me, and I didn't know what.
* [Look at Isolde]
    ~ STOPPED = "isolde"
    "The squire carries the Lantern's linen," said Isolde, "which he has been sick in. Would the sergeant like to search it? Or wash it?"
    His men laughed. The hands came off me. I knew she'd put it on my account.
- -> s04_bills

= s04_bills
{ TOLL == "ring":
    "And the ring you showed at the toll," said Lidd, and held his hand out. He tried it on his little finger, and gave it back warm.
}
{ TOLD_MARROW == "truth":
    "Who marked your ear, squire?" He touched it, with one finger.
    "The cart," I said. Lidd looked at Marrow.
}
{ TOLD_MARROW == "ambush":
    He took Marrow's flask off her belt as he passed, and drank, and gave it back. "Hill stuff," he said. "Thought so."
}
Master Venn wiped his fingers. "Where am I to see him?"
"Tomorrow," said Isolde. "He is sleeping."
Venn sat back and finished his pie. He didn't ask what was wrong with him.
-> s05_friar

// ---------------------------------------------------------------
= s05_friar
# scene: c1_s05_friar
# panel: stint_chapel_door
The square emptied with the light.
A friar came round to the downwind side of the cart. He was old, with his habit patched at the knees. He knelt down and had my boot off before I'd agreed to it.
"Brother Tobin," he said, to my foot. "That's how a toe goes black." He rubbed it hard between his hands.
{RINGERS == "yes":"You gave Annis her bells," he said. "I trained those ringers."}
"He can't lie in a cart tonight," he said. "I have a chapel. Eleven under the roof, cripples from both sides and four children. No steel past the door. Not even a surgeon's."
"Inn yard," said Dobb. "My lads round him."
"Or the barn behind my house," said the tollkeeper, who had come down to lock the toll box. "Fourpence, and nobody's business."
Isolde said nothing. She was watching Tobin's hands on my foot.
* [The chapel. A bolt, no steel, and Tobin holds the key.]
    ~ LODGING = "chapel"
    "The chapel," I said.
    Tobin nodded as if I'd said grace. Dobb spat on the stones and went to tell his men. Within the hour two of Lidd's riders were standing at the chapel door, and I was lying across the step inside it, with the bolt above my head and the key in Tobin's belt.
* [The inn yard. Dobb and five swords round him.]
    ~ LODGING = "yard"
    "The yard," I said. "With Dobb."
    "As you think best, child," said Tobin, and went to fetch vinegar anyway. Dobb put the cart against the stable wall and sat down on the tailboard, a foot from the canvas. "I'll not go under," he said. "Chronicler says it's catching." He said it as if he were saying it to himself, so he'd remember.
* [The tollkeeper's barn. Nobody's eyes on him but yours.]
    ~ LODGING = "barn"
    "The barn," I said. "The tollkeeper's. Nobody touches him but me."
    It cost fourpence. {PURSE:I paid it out of the purse, and I saw the tollkeeper's boy see the purse.|Marrow paid it, and held up a fifth finger at me.} Nobody would sit with him there. That meant nobody would turn him but me.
- Tobin was tying my boot up again, slowly, because his hands were old.
"And who is it turns him, child?" he said, without looking up. "A man in a fever wants turning, or he gets sores. Every few hours. You'll know that, being his squire."
I didn't know it. He knew I didn't.
# end: ch01_preview
-> END
