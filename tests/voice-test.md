# Blind voice test

The test of `story/CAST.md`: can a reader who has heard each character speak a few times tell who is speaking, with no names attached? Run it whenever the cast sheet's voice rows change, and again on real chapter dialogue once chapter 1 exists.

## How to run

1. Start **three fresh reader agents** that have seen nothing of this project. Give each the reader sheet below, pasted into the prompt, and nothing else. They open no files.
2. Personas as in `tests/reader-panel.md`: A new player, B First Law reader, C fiction editor.
3. Score against the key. Record the table and the readers' comments in `reports/readers/<date>-voice.md`.
4. If it fails, change the sheet, write **new** test lines, and use **new** readers. At most three rounds.

## Rules for the test lines

- Ten lines, six speakers; some speak more than once.
- New lines, in situations the "hearing" lines do not cover.
- The same few plain situations are shared between speakers (being told to eat, the smell, asking to rest, being thanked), so the subject does not give the speaker away.
- No names, no forms of address ("squire", "child"), and no words of trade (ballad, verse, chapel, roof, fee, army, brewery).

## Pass rules

- Each reader gets at least 8 of 10.
- No line is missed by two or more readers.
- Any line a reader says "could be moved to another mouth" is rewritten in `story/CAST.md`, or kept with a reason in the report.

AI readers are good at this kind of matching, so 10 of 10 is the expected score for a sheet that works; a miss is information. The harder test is real dialogue in a real scene, and that comes with chapter 1.

## Reader sheet (round 1, 2026-11-18)

This is the sheet as it was run. Some hearing lines were replaced in `story/CAST.md` afterwards (see `reports/readers/2026-11-18-voice.md`); take the current sample lines from the cast sheet for the next run, and write new test lines.

```
You are a test reader. Persona: <PERSONA>.
Do not open, search or read any file. Do not look anything up. Everything you need is below.

Six people from a story set on a muddy road in a poor kingdom at the end of a war. You have heard each
of them speak three times, in other scenes:

W — a squire, young, low-born.
  "Yes, Sir Aubric. Both skins. I counted."
  "He's sleeping. He was asked for twice already."
  "I can carry it. It isn't far."
M — a road-guide, a deserter.
  "Horse is lame. That's a day. You've got eight. Now seven."
  "Lie better or lie less. Costs the same to me."
  "Rained on us for nothing. Rain's the only thing that does."
I — a chronicler from the capital.
  "How good of you to mention the rain. We shall say he asked to feel it on his face."
  "That is very nearly true, and I am grateful. Say it again without the 'nearly'."
  "You have been so brave about the horse. Now be brave about walking."
T — a wandering friar.
  "Sit, sit, the rain has been at you all day and you are no drier for standing up in it, and there is a corner of this cloak that is nearly clean. Are your feet wet through?"
  "A lie is a cold thing to carry on your own, child, and I have big pockets, bless them, they were made for bread. Will you not tell me?"
  "The poor horse, and he never complained, which is more than I can say for my knees. Shall we walk a little slower?"
C — a marshal, commander of an army.
  "It is raining on the Lantern's squire. Have him stood under something. I shall want him dry enough to be legible."
  "He says the horse is lame. Write that he says so. Write the hour. It would be a pity if he were to say something different tomorrow."
  "One understands he is not accustomed to lying. He will be given time to practise. Not a great deal of time. Shut that flap, would you."
H — a knight's wife, a brewer's daughter, who runs his estate.
  "How long has the horse been lame? Days, not 'a while'. Then it should have been sold at the first town. Who decided to keep it?"
  "You're wet. There's a fire in the kitchen and nobody in it. Go and stand there, and then tell me what you came to tell me."
  "Is that true? I'm not asking if it's what you were told to say. I'll ask once more, and then I'll believe whichever you pick."

Here are ten new lines with no names attached. Each is said to, or by, the squire. A speaker may appear
more than once, or not at all.

1. "When did you last eat? Not 'today'. When? Then sit there and finish that before you say another word to me."
2. "Eat it. Two pennies, and it won't keep. Nor will you."
3. "You are quite right, it is noticeable. How fortunate that sick men are known to smell, and that it is you who will say so."
4. "There now, it is only a smell, and a smell never broke a bone, and you have been breathing through your mouth all morning and it has dried you out like a crust. Will you take some water?"
5. "There is a smell. It will be seen to, or he will be moved downwind. One or the other, before I have finished this page."
6. "Stop here? Who pays for the day? Not me. Walk."
7. "He asks whether he may sit. He may. Note that he asked, and the hour, and have a second chair brought for whoever comes to fetch him."
8. "Of course you are tired. I should think less of you if you were not. We shall rest at the top of the hill, and you will be so good as to look fresh when we arrive."
9. "Thank the loaf, not me, I only carried it, and I ate the heel of it on the way, which a better man would not have. Is that boot still rubbing?"
10. "Yes. Thank you. Four miles. I can do four."

Answer in exactly this format:

PART 1 — For each line 1–10: the letter of the speaker, your confidence (high / medium / low), and
the few words that told you.
PART 2 — Which two speakers were hardest to tell apart, and why?
PART 3 — List any line, among the hearing lines or the ten, that could be moved to a different
speaker's mouth without anyone noticing. Or say "none".
PART 4 — For each of the six, one sentence: what do they sound like to you? Then: which one has the
weakest, least particular voice?
PART 5 — Persona question.
  If you are A: which of the six would you most want to sit beside at a fire, and which frightens you?
  If you are B: do any of the six sound like a specific character from Joe Abercrombie's First Law
  books (voice, verbal habit, or type)? Name each, or say "nothing".
  If you are C: which lines sound written rather than spoken, or machine-made? Which voice is a
  set of tics rather than a person?
```

## Key (round 1)

1 H · 2 M · 3 I · 4 T · 5 C · 6 M · 7 C · 8 I · 9 T · 10 W
