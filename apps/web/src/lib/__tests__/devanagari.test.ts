// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/devanagari.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import {
  devanagariDigitsToLatin,
  hasDevanagariDigits,
  segmentDevanagariNumerals,
} from "../devanagari";

describe("devanagariDigitsToLatin", () => {
  it("converts a Devanagari year to ASCII", () => {
    assert.equal(devanagariDigitsToLatin("२०८२"), "2082");
  });

  it("converts all ten digits", () => {
    assert.equal(devanagariDigitsToLatin("०१२३४५६७८९"), "0123456789");
  });

  it("leaves non-digits (letters, separators) untouched", () => {
    assert.equal(devanagariDigitsToLatin("वि.सं. २०८२ मा"), "वि.सं. 2082 मा");
    assert.equal(devanagariDigitsToLatin("२,०८२.५"), "2,082.5");
  });

  it("is a no-op for strings without Devanagari digits", () => {
    assert.equal(devanagariDigitsToLatin("Year 2082"), "Year 2082");
  });
});

describe("hasDevanagariDigits", () => {
  it("detects Devanagari digits", () => {
    assert.equal(hasDevanagariDigits("सन् २०८२"), true);
  });

  it("ignores Devanagari letters and ASCII digits", () => {
    assert.equal(hasDevanagariDigits("नेपाल 2082"), false);
  });
});

describe("segmentDevanagariNumerals", () => {
  it("returns a single text segment when there are no digits", () => {
    assert.deepEqual(segmentDevanagariNumerals("नेपाल"), [
      { kind: "text", text: "नेपाल" },
    ]);
  });

  it("splits surrounding text from a number run", () => {
    assert.deepEqual(segmentDevanagariNumerals("सन् २०८२ साल"), [
      { kind: "text", text: "सन् " },
      { kind: "number", text: "२०८२", latin: "2082" },
      { kind: "text", text: " साल" },
    ]);
  });

  it("keeps grouping/decimal separators inside one number segment", () => {
    assert.deepEqual(segmentDevanagariNumerals("२,०८२.५"), [
      { kind: "number", text: "२,०८२.५", latin: "2,082.5" },
    ]);
  });

  it("does not swallow trailing punctuation (danda / period)", () => {
    assert.deepEqual(segmentDevanagariNumerals("२०८२।"), [
      { kind: "number", text: "२०८२", latin: "2082" },
      { kind: "text", text: "।" },
    ]);
    assert.deepEqual(segmentDevanagariNumerals("२०८२."), [
      { kind: "number", text: "२०८२", latin: "2082" },
      { kind: "text", text: "." },
    ]);
  });

  it("handles multiple separate numbers", () => {
    assert.deepEqual(segmentDevanagariNumerals("१९९० देखि २०८२"), [
      { kind: "number", text: "१९९०", latin: "1990" },
      { kind: "text", text: " देखि " },
      { kind: "number", text: "२०८२", latin: "2082" },
    ]);
  });
});
