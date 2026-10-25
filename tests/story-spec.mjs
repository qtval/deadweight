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
    dry_to_the_knee:          (v) => v.VERSION === "hero" && !v.WENT_IN,
  },

  // Conditions every path must satisfy when it ends.
  endState: [
    ["the death has been told one way",      (v) => ["truth", "ambush", "hero"].includes(v.VERSION)],
    ["the letter ends up somewhere definite", (v) => ["isolde", "wren", "hidden"].includes(v.LETTER)],
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
  maxWordsBetweenChoices: 260,
  readingWpm: 200,
};
