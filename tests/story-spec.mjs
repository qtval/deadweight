// What the story is supposed to do. tools/test-story.mjs checks every path against this.
// Add a block per chapter as chapters are written.

export const spec = {
  // Scenes must be visited in this order on every path (skipping is allowed, going back is not).
  sceneOrder: ["s01_ford", "s02_water", "s03_bank", "s04_marrow", "s05_dawn", "s06_wrap", "s07_road"],

  // Every path must end at one of these `# end:` ids.
  endIds: ["ch00"],

  // Each `# remember: <id>` may only fire when its condition holds (checked at the moment it fires),
  // and must fire on at least one path. `when` gets the current ink variables.
  remember: {
    ford_bridle:              (v) => v.AT_FORD === "bridle",
    marrow_refused_then_lied: (v) => v.TOLD_MARROW === "truth" && v.VERSION !== "truth",
    marrow_story_dropped:     (v) => v.TOLD_MARROW === "ambush" && v.VERSION === "truth",
    drank_with_him:           (v) => v.DRANK === true,
    broken_nose:              (v) => v.WENT_IN === true,
    honest_twice:             (v) => v.TOLD_MARROW === "truth" && v.VERSION === "truth",
    light_purse:              (v) => v.PURSE === true,
    dry_to_the_knee:          (v) => v.VERSION === "hero" && !v.WENT_IN,
  },

  // Conditions every path must satisfy when it ends.
  endState: [
    ["the death has been told one way",      (v) => ["truth", "ambush", "hero"].includes(v.VERSION)],
    ["the letter ends up somewhere definite", (v) => ["isolde", "wren", "hidden"].includes(v.LETTER)],
    ["Wren has told themself why",             (v) => ["peace", "him", "wages"].includes(v.SELF)],
    ["Wren has answered Isolde's plan",        (v) => ["agreed", "bargained", "objected"].includes(v.PLAN)],
    ["Isolde owes a place only if Wren bargained", (v) => v.ISOLDE_OWES === (v.PLAN === "bargained")],
    ["the elbow question arises only on the true account after going in", (v) => (v.ELBOW !== "") === (v.VERSION === "truth" && v.WENT_IN === true)],
    ["Wren holds the signet only if Wren agreed", (v) => v.RING === (v.PLAN === "agreed")],
    ["a day has passed",                      (v) => v.DAYS_LEFT === 8],
    ["only a hidden letter can be secret",    (v) => v.LETTER !== "hidden" || v.VERSION !== ""],
    ["Marrow charges more only if she distrusts Wren", (v) => v.DEBT_MARROW === (v.TRUST_MARROW < 0)],
  ],

  // Outcomes that must all be reachable (cartesian product of these variable values).
  mustReach: { VERSION: ["truth", "ambush", "hero"], LETTER: ["isolde", "wren", "hidden"] },

  // Variables that may only ever move one way along a path.
  neverIncreases: ["DAYS_LEFT"],

  // Writing rules (docs/WRITING_GUIDE.md).
  choiceMaxWords: 12,
  maxNewProperNouns: { firstScene: 5, otherScenes: 2 },
  maxWordsBetweenChoices: 300,
  readingWpm: 200,

  // Routes written out as plain-text playthroughs for the blind reader panel (docs/TESTING.md, layer 3).
  // One reader per route. Choose routes that differ in tone: an honest one, a self-serving one, a mixed one.
  readerRoutes: {
    "reader-a-honest":      [1, 0, 0, 1, 1, 1, 0, 1, 1, 2, 1, 0],        // sober, bridle, goes in, leaves purse and letter, won't lie, truth, carries it, for him
    "reader-b-selfserving": [0, 2, 1, 0, 0, 0, 1, 2, 0, 1, 2, 2],      // drinks, silent, rope, takes purse and letter, ambush, denies letter, false hero, "river took it", wages
    "reader-c-mixed":       [0, 1, 0, 1, 0, 2, 0, 1, 1, 0, 0, 1],      // drinks, shouts, goes in, leaves purse, takes letter, decides at dawn, shows it, ambush, gives it, peace
  },

  // Voice rules (docs/WRITING_GUIDE.md). Checked on every line of every path.
  voice: {
    // The narrator is Wren, first person. These catch a slip back into third person.
    thirdPersonSlip: /\bWren (was|had|did|said|knew|felt|thought|looked|took|went|saw|could|would)\b/,
    // A refrain may appear at most this many times on any one path.
    refrains: { "squires carry things": 4 },
    // Tics the reader panel flagged (2026-11-18). Max uses on any one path; keeps the voice from performing.
    limits: [
      [/\bi would like to (say|tell)/g, 1],
      [/\b(a long time since|a good deal since|ought to have|than it should have|only \w+ that afterward|hadn't yet)\b/g, 2],
      [/\bas if\b/g, 3],
      [/\bi caught myself\b|\bi found (i|her|him|it)\b/g, 2],
      [/\blong (while|moment)\b/g, 1],
    ],
    // Never: borrowed mantras and names (do-not-copy list), the old project's names, and stock phrases.
    banned: [
      "say one thing", "back to the mud", "have to be realistic", "body found floating", "once you've got a task",
      "glokta", "logen", "ninefingers", "bloody-nine", "bayaz", "jezal", "luthar", "ferro", "dogman", "gurkish", "adua", "first of the magi", "named man", "named men",
      "garren vale", "red hollow", "carrion road", "ashen oath",
      "breath (i|he|she|they) (hadn't|didn't|had not|did not) (known|know|realised|realized)", "couldn't help but", "little did", "a testament to", "sent a shiver", "heart pounded", "time seemed to", "steeled (myself|himself|herself)",
    ],
  },
};
