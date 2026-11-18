// CHAPTER 1 — STINT (opening scenes only; not yet linked from the prologue)
// Beat sheet: story/BEATS.md. Drafting rules for this chapter are at the top of that sheet,
// amended after the first panel round (reports/readers/2026-11-18-ch01-opening.md):
// paragraphs end plainly, BUT Wren's sour, bodily, self-serving thought runs under every act,
// in contractions; the big moments are played live, not summarised.
// Built for reading by tools/make-chapter-transcripts.mjs until the per-chapter story test exists.

VAR ARMOUR = ""
VAR WAVED = false
VAR TOLL = ""

=== ch01 ===
# title: Chapter 1 :: Stint
-> s01_armour

// ---------------------------------------------------------------
= s01_armour
# scene: c1_s01_armour
# panel: road_beech_wood_noon
A mile short of Stint the road ran through a beech wood. The Marshal's riders had been through ahead of us and cut it to mud. Isolde had Marrow turn the cart in under the trees, where it couldn't be seen.
"He cannot arrive like that," she said. "That is a dead knight laid out for burial. I want a sick man in his shirt, under blankets, inside a covered cart. Wren knows the buckles."
I did know the buckles. There were thirty-one, and four laces, and a pin at the neck that stuck. I had done them up every morning for six years and I had hoped, as late as yesterday, never to do them again.
Isolde undid her own knot, with her back to me so I shouldn't see how. We opened the canvas. He had been in it since dawn, in his plate, and the flies had found the way in before we did. He had gone stiff.{SELF == "peace": I had to get the sword out from under his hands first.}
{SELF != "him":I was still wearing his gloves. I took them off to touch him.}
Marrow looked at the armor, and not at him. "Sixty pound of plate," she said. "That's a farm."
"It is sixty pounds of proof that he is not in bed," said Isolde. "It goes in the pond." There was a pond below the trees, black, with leaves lying on it.
"It's a farm," said Marrow.
Isolde wouldn't touch him. She stood by the horse with her sleeve over her nose and told me which arm first. Marrow would touch him, and did, and went on looking at the plate while she did it.
The neck and the shoulders and the breastplate were only buckles. Then there were his arms. A stiff arm won't come out of its armor and it won't go into a shirt sleeve, unless somebody takes it at the elbow and the wrist and leans. Marrow showed me where to lean. It made a noise like a green branch. I did the other one myself, because I didn't want her to, and it made the same noise{WENT_IN:, and my own elbow answered it}.
{ VERSION == "ambush":
    The hole she had put under his arm had gone black round the edge. Isolde had me bind it with a strip off his shirt, so there would be a bandage to show.
}
It had to be me. Nobody else knew he couldn't bear a tight collar. Six years, and what they had bought me was being the one person alive who knew how to dress him dead. I told myself that was a kind of service. It was also that if Marrow did it she would go through his shirt for coin, and I hadn't finished looking.
My hands smelled of him. I wiped them on the leaves, and then they smelled of him and leaves.
Then the armor lay in a heap with his badge on the breast of it, the lantern in blue enamel, and the three of us stood and looked at it. I had not eaten since yesterday noon, and I looked at it the way Marrow did.
* [Sink it in the pond]
    ~ ARMOUR = "ditch"
    I carried it down in four loads and waded in to my thighs to get it out past the weed{WENT_IN:, coughing|, on the bad knee}. The mud took hold of my boots. The breastplate went last, badge up, and I watched the blue go down until I couldn't see it. A farm. I'd never have had the nerve to sell it, and I hated him for a moment for owning something I had to drown.
    Marrow watched from the bank with her arms folded. She didn't say it a third time.
* [Keep it in the cart, under him. It's his.]
    ~ ARMOUR = "cart"
    I laid it flat on the cart bed and we lifted him back on top of it, with a blanket between. It was sixty pounds more for one horse, and when the cart moved it knocked, plate on plate, at every rut.
    "Everybody'll hear that," said Marrow. "They'll think it's him moving. Could be good."
    "It is not good," said Isolde. She didn't tell me to take it out. I thought, it's his, he should have it. I also thought that nobody could sell it while he was lying on it, and that included her.
* [Let Marrow sell it in Stint, and take half]
    ~ ARMOUR = "sold"
    "Half," I said. It came out before I'd decided to say it.
    Marrow looked at me properly for the first time that day. "Half." She had a file in her pack. She sat down in the leaves with the breastplate across her knees and began to take the lantern off it. The enamel came away in blue flakes.
    She did all the big pieces. She was quick, and she missed a rivet on the left shoulder that had a small lantern stamped in its head. I saw it. I didn't say. Half of a farm was more money than I had ever stood near, and I didn't want to be the one who slowed her down.
    Isolde watched all of it, and wrote nothing.
- We put the canvas back up over the cart for a cover, and laid him under it in his shirt, on his back, with two blankets up to his chin.
Without the plate he wasn't very big. He had a grey chest and a soft belly, and his jaw was tied up with my neckcloth. He looked like somebody's father.
-> s02_bells

// ---------------------------------------------------------------
= s02_bells
# scene: c1_s02_bells
# panel: stint_bridge_dusk
They had every bell in Stint going, in no order. Under the bells there was another noise, and it was people.
The bridge beyond the north gate was lined on both sides. There were children up on the wall of it, and a man with a drum. When the cart came out from under the gate they saw his grey horse on its lead rein with the saddle empty, and the noise dropped. Then it came up louder. Somebody had worked out that he must be in the cart.
{PLAN == "objected":I was under the cover with him, where Isolde had put me, and I saw it through the gap in the canvas.|I had the reins, and my hands were wet on them.}
"One wave," said Isolde, not moving her mouth. "One, from inside the cart. Then you tell them he is resting. Can you do that, Wren?"
"Yes," I said. I thought I was going to be sick{LETTER == "wren" or LETTER == "hidden":, and the case under my shirt had slipped round to my back, where I couldn't get at it}.
Six men were drawn up at the far end of the bridge in his colors. I knew all six. The one in front was Corporal Dobb, who had been with him twenty years and had taught me how to clean a horse's bit. He was already walking toward us to take the bridle. He always took the bridle.
I couldn't see Marrow. She had got round behind the cart.
They had started to shout for him to sit up.
* [Put on his glove and put an arm out through the canvas]
    ~ WAVED = true
    {SELF == "him":The gloves were on his hands. I got one off him, which took longer than I had, and it was cold inside.|I pulled one of his gloves back on.}
    I knelt up beside him where nobody could see my face, and put my arm out through the gap, and moved it from side to side.
    I have never heard a noise like it. I knew it was for him. But it was my arm they were looking at, and nobody had ever shouted for any part of me before, and I left it out there. I left it out there for about as long as it takes to say a prayer.
    Then a child up on the wall said, quite clearly, in a gap, "That's not him. That's a little arm."
    People laughed. It was a friendly laugh. I got my arm in so fast I caught the canvas.
    Corporal Dobb didn't laugh. He had stopped with his hand halfway to the bridle.
* [Stand up and tell them he's sleeping. Two hundred people will go home.]
    {PLAN == "objected":I put my head and shoulders out through the gap|I stood up on the driving board{not WENT_IN:, on the bad knee}}. "He's sleeping," I said. Nobody heard. I said it again as loud as I could, and my voice went up and cracked{WENT_IN:, and then I coughed, so that it sounded as if I had it too}. "He's sleeping. He has a fever. He can't be woken."
    It went along the bridge from the front to the back. I watched it go. The drum stopped. The bells didn't, because nobody had told the bells.
    Something hit the side of the cart, hard, and rolled away. It was a turnip. I don't think it was thrown at him. Two hundred people had walked in from the farms to see the Lantern, and what they had got was me.
    Corporal Dobb stopped walking. He took his helmet off and held it in front of him in both hands, the way you do at a burying.
* [Say nothing. Isolde will have to do it.]
    I {PLAN == "objected":knelt there in the dark beside him|sat there} with my mouth open, and nothing came out of it.
    Isolde waited as long as she could. Then she stood up{PLAN != "objected":, with a hand on my shoulder to steady herself. She pressed down on it, hard}.
    "Good people of Stint," she said, and they went quiet for her as they would never have gone quiet for me. "The Lantern thanks you for your bells. He has taken a fever on the road, and he sleeps. His squire has the nursing of him, and his squire tells me he is not to be woken for a king. Ring for him again in the morning. Softer."
    Some of them laughed at softer, and one woman cried. I sat under it and thought, she has just told two hundred people that if he dies it was my nursing.
    {PLAN == "objected":She sat down and pulled the gap in the canvas shut, with me behind it.|She sat down and took the reins out of my hands.} She did it in front of his men.
    Corporal Dobb watched her do it. Then he looked at me, and I saw him put me somewhere lower than he'd had me before.
- He came on to the back of the cart. He had three fingers on his left hand, and that was the one he put flat on the canvas, where the feet were. He left it there.
"Fever," he said.
"Yes, Corporal."
"Since when?"
"This morning." It had been last night. I had to keep hold of that: this morning.
He nodded. "It's the marsh one, then. He's had it before. He wants his feet rubbed for it, or he gets the cramps. Have you rubbed his feet?"
"No, Corporal."
"No." He wasn't angry. He was only finding out how much there was to do. "Well. I'll sit with him tonight. I always have. He'll ask for me."
-> s03_toll

// ---------------------------------------------------------------
= s03_toll
# scene: c1_s03_toll
# panel: stint_tollhouse
The tollhouse was built into the bridge, halfway over, and the cart had to stop at it like any other cart.
The tollkeeper was a long man with a boil on the side of his neck that had come to a head. He had a book open on a slope and a pen behind his ear. He didn't look up at the cart, or the grey horse, or the blue cloth somebody had hung off his roof.
"Cart, fourpence," he said. "Whatever's in it. What is in it?"
"The Lantern," I said.
"I know who. I'm asking what. Sick or dead? Sick crosses free. Dead's sixpence a head, since the war. There was that many. I've to write the one or the other, and then you put your name."
I tried not to look at the boil. I looked at it.
"Sick," I said.
"Sick." He wrote it slowly, with his tongue in his cheek. One cart. One sick man. He turned the book round on the slope and held out the pen.
Marrow had come into the doorway behind me. I could hear her not saying anything.
* [Sign your name to it]
    ~ TOLL = "sick"
    I can write. I wrote my name. It was the first time I had written it in a book that somebody kept, and I had wanted that to be a different book. This one said that I, Wren, gave my word the man in the cart was sick, and it had the day on it.
    He blotted it. "You write a fair hand. Better than the sergeant."
    "Which sergeant?"
    "Marshal's. Reads it through every night. Likes to know who's crossed." He shut the book. I wanted to ask for the page back. I didn't know how you would ask.
* {RING} [Show him the signet. Cross in the Lantern's name.]
    ~ TOLL = "ring"
    I took the ring out of my shirt and held it where he could see. I didn't put it on. It would have gone round my thumb.
    He looked at it for a while. "That's his. I've seen it on him." He shut the book without writing in it. "Lantern crosses free, cart and all. Always has."
    I thought, that was easy. I was still thinking it when he leaned out of his window and said to somebody on the bridge, not loudly, "Squire's got his ring."
* [Pay for the cart and sign nothing. He'll write that down too.]
    ~ TOLL = "paid"
    "I'll pay for the cart," I said. "I'm not a surgeon. I can't give my word what he is."
    He looked at me. Then he wrote, and said it aloud as he wrote, so that I should know. "Squire. Would. Not. Say." He looked out at the sun on the water, and wrote the hour. I had thought I was being careful.
- { TOLL != "ring":
    { PURSE:
        I paid the fourpence out of the purse. He took it, and then he took hold of the purse itself by the strings and turned it to the light.
        "I've changed coin out of that," he said. "That's his."
        "He gave it me to pay with."
        # remember: purse_at_toll :: The tollkeeper remembers whose purse it was.
        "Did he?" He let go. He wasn't accusing me. He liked a thing written down right, and he was deciding how to write it.
    - else:
        I had no fourpence. I have never had fourpence. Marrow came off the doorpost and put four pennies on the slope, one at a time. "Four," she said to me. "{DEBT_MARROW:Price was doubled at the river. Now it's doubled and four.|That's the first.}"
    }
}
He put the pen back behind his ear and didn't go on to the next cart. There wasn't one. He scratched beside the boil.
"My girl's to be married tomorrow," he said. "Annis. He's had my ringers three days, practising for him. They're my ringers. I pay them. Would he spare them an hour in the morning, for the chapel? I'd not ask. Only he's a generous man. Everyone says it."
He was asking me. I looked round for somebody else he might be asking. There was only Marrow, and she was looking at me as well.
# end: ch01_preview
-> END
