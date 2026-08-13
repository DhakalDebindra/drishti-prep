// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/search-format.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import { plural, setsAndQuestions } from "../search/format";

describe("plural", () => {
  it("uses the singular for exactly one", () => {
    // Regression: the results page rendered "1 questions" on every narrow
    // query, and a screen reader read it aloud in full each time.
    assert.equal(plural(1, "question"), "1 question");
  });

  it("uses the plural for zero", () => {
    assert.equal(plural(0, "question"), "0 questions");
  });

  it("uses the plural for many", () => {
    assert.equal(plural(503, "question"), "503 questions");
  });

  it("accepts an explicit plural form", () => {
    assert.equal(plural(2, "match", "matches"), "2 matches");
    assert.equal(plural(1, "match", "matches"), "1 match");
  });

  it("pluralises multi-word nouns on the last word", () => {
    assert.equal(plural(1, "practice set"), "1 practice set");
    assert.equal(plural(3, "practice set"), "3 practice sets");
  });
});

describe("setsAndQuestions", () => {
  it("formats the common pair", () => {
    assert.equal(setsAndQuestions(14, 252), "14 sets · 252 questions");
  });

  it("handles the singular on both halves", () => {
    assert.equal(setsAndQuestions(1, 1), "1 set · 1 question");
  });
});
