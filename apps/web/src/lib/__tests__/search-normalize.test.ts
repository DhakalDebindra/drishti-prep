// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/search-normalize.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import {
  baseLength,
  escapeLikePattern,
  normaliseQuery,
  tokenVariants,
} from "../search/normalize";

describe("baseLength", () => {
  it("ignores Devanagari vowel signs", () => {
    // नदी is न + द + ी — three code points, two base characters.
    assert.equal(baseLength("नदी"), 2);
    // ताल is त + ा + ल — the ा is a vowel sign, not a letter.
    assert.equal(baseLength("ताल"), 2);
  });

  it("counts plain Latin characters as-is", () => {
    assert.equal(baseLength("nepal"), 5);
  });

  it("returns 0 for a string of only combining marks", () => {
    assert.equal(baseLength("ीु"), 0);
  });
});

describe("escapeLikePattern", () => {
  it("escapes LIKE wildcards so they match literally", () => {
    assert.equal(escapeLikePattern("100%"), "100\\%");
    assert.equal(escapeLikePattern("a_b"), "a\\_b");
  });

  it("escapes backslashes before the wildcards it adds", () => {
    assert.equal(escapeLikePattern("a\\b"), "a\\\\b");
    assert.equal(escapeLikePattern("\\%"), "\\\\\\%");
  });

  it("leaves ordinary Nepali text untouched", () => {
    assert.equal(escapeLikePattern("संविधान"), "संविधान");
  });
});

describe("tokenVariants", () => {
  it("keeps the word as typed as the first spelling", () => {
    assert.equal(tokenVariants("संविधानको")[0], "संविधानको");
  });

  it("strips a genitive suffix", () => {
    assert.deepEqual(tokenVariants("नेपालको"), ["नेपालको", "नेपाल"]);
  });

  it("strips a locative suffix", () => {
    // Inclusion, not equality: spelling variants are also generated, and that
    // list grows as new confusions are found.
    const variants = tokenVariants("संविधानमा");
    assert.ok(variants.includes("संविधानमा"));
    assert.ok(variants.includes("संविधान"));
  });

  it("unwinds a stacked plural + case suffix, keeping the middle form", () => {
    // तालहरूमा → तालहरू → ताल; the database may store any of the three.
    const variants = tokenVariants("तालहरूमा");
    for (const form of ["तालहरूमा", "तालहरू", "ताल"]) {
      assert.ok(variants.includes(form), `missing ${form}`);
    }
  });

  it("prefers the longest matching suffix at each step", () => {
    const variants = tokenVariants("प्रश्नहरूको");
    for (const form of ["प्रश्नहरूको", "प्रश्नहरू", "प्रश्न"]) {
      assert.ok(variants.includes(form), `missing ${form}`);
    }
  });

  it("leaves a word alone when it has no known suffix", () => {
    // The word itself is always first; anything after it is a spelling variant,
    // never a stem, because there is no suffix to remove.
    assert.equal(tokenVariants("भूगोल")[0], "भूगोल");
    assert.equal(tokenVariants("रामसार")[0], "रामसार");
  });

  it("does not strip की, which would manufacture non-words", () => {
    // Regression: stripping की turned भौतिकी into भौति, which matches भौतिक
    // ("physical") across 59 questions — so a physics search returned
    // classroom-management and physical-geography sets.
    assert.ok(!tokenVariants("भौतिकी").includes("भौति"));
  });

  it("refuses to strip down to a fragment", () => {
    // Stripping को from बोको would leave बो — a two-code-point stub that
    // matches a large slice of the corpus. The guard keeps the word whole.
    const variants = tokenVariants("जलमा");
    assert.ok(variants.includes("जलमा"));
    assert.ok(!variants.some((v) => baseLength(v) < 2));
  });

  it("never produces duplicate spellings", () => {
    for (const word of ["नेपालको", "तालहरूमा", "भूगोल"]) {
      const variants = tokenVariants(word);
      assert.equal(new Set(variants).size, variants.length);
    }
  });
});

describe("normaliseQuery", () => {
  it("returns no tokens for blank input", () => {
    assert.deepEqual(normaliseQuery("").tokens, []);
    assert.deepEqual(normaliseQuery("   ").tokens, []);
  });

  it("splits a two-word Nepali query into two tokens", () => {
    const { tokens } = normaliseQuery("नेपालको भूगोल");
    assert.equal(tokens.length, 2);
    assert.deepEqual(tokens[0], ["नेपालको", "नेपाल"]);
    assert.deepEqual(tokens[1], ["भूगोल"]);
  });

  it("drops stopwords so the AND gate only requires real terms", () => {
    const { tokens } = normaliseQuery("नेपालको भूगोल के हो");
    assert.equal(tokens.length, 2);
    assert.deepEqual(tokens.map((t) => t[0]), ["नेपालको", "भूगोल"]);
  });

  it("drops definitional phrasing so 'X भनेको के हो?' searches for X", () => {
    // Regression: भनेको was required to appear in the question text, so
    // "रामसार क्षेत्र भनेको के हो?" matched nothing despite 33 रामसार questions.
    const { tokens } = normaliseQuery("रामसार क्षेत्र भनेको के हो?");
    assert.deepEqual(tokens.map((t) => t[0]), ["रामसार", "क्षेत्र"]);
  });

  it("drops English stopwords in mixed-script queries", () => {
    const { tokens } = normaliseQuery("what is the संविधान");
    assert.deepEqual(tokens.map((t) => t[0]), ["संविधान"]);
  });

  it("splits on the Devanagari danda and punctuation", () => {
    const { tokens } = normaliseQuery("सगरमाथाको उचाइ कति हो?");
    assert.deepEqual(tokens.map((t) => t[0]), ["सगरमाथाको", "उचाइ"]);
  });

  it("falls back to the raw words when everything is a stopword", () => {
    // Better to search badly than to return nothing at all.
    const { tokens } = normaliseQuery("कहाँ कति");
    assert.ok(tokens.length > 0);
  });

  it("caps the token count so one query cannot AND forever", () => {
    const { tokens } = normaliseQuery(
      "संविधान भूगोल इतिहास अर्थतन्त्र विज्ञान संस्कृति प्रविधि वातावरण"
    );
    assert.ok(tokens.length <= 6);
  });

  it("truncates an over-long query instead of passing it through", () => {
    const { raw } = normaliseQuery("क".repeat(500));
    assert.ok(raw.length <= 200);
  });

  it("escapes wildcards inside tokens", () => {
    const { tokens } = normaliseQuery("100% पास");
    assert.ok(tokens.some((variants) => variants[0].includes("\\%")));
  });

  it("preserves the raw query for display", () => {
    assert.equal(normaliseQuery("  नेपालको भूगोल  ").raw, "नेपालको भूगोल");
  });
});
