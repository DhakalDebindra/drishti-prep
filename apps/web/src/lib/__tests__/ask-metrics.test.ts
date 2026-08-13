// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/ask-metrics.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import {
  citationRate,
  extractNumbers,
  factDensity,
  groundedNumberRate,
  nepaliShare,
  scoreLesson,
  vagueRate,
  wordCount,
} from "../ask/metrics";

describe("extractNumbers", () => {
  it("normalises Devanagari digits to Latin so ९० equals 90", () => {
    assert.deepEqual(extractNumbers("क्षेत्रफल ९० हेक्टर"), ["90"]);
  });

  it("strips thousands separators so २६,१०६ matches 26106", () => {
    assert.deepEqual(extractNumbers("कुल २६,१०६ हेक्टर"), ["26106"]);
  });

  it("finds several numbers in one sentence", () => {
    assert.deepEqual(
      extractNumbers("सन् १९७१ मा हस्ताक्षर, नेपाल १९८७ मा सदस्य"),
      ["1971", "1987"]
    );
  });

  it("returns nothing for prose with no figures", () => {
    assert.deepEqual(extractNumbers("यो विषय महत्त्वपूर्ण छ"), []);
  });

  it("does not treat a trailing full stop as part of the number", () => {
    assert.deepEqual(extractNumbers("जम्मा ४."), ["4"]);
  });
});

describe("factDensity", () => {
  it("is zero for an answer with no figures", () => {
    assert.equal(factDensity("यो विषय धेरै रोचक छ"), 0);
  });

  it("rises with the number of concrete figures", () => {
    const flat = factDensity("रामसार सूची सिमसार क्षेत्रको सूची हो");
    const detailed = factDensity(
      "रामसार सूची सन् १९७१ मा बनेको, नेपाल १९८७ मा सदस्य, हाल १० क्षेत्र"
    );
    assert.ok(detailed > flat);
  });

  it("is zero for empty input rather than dividing by zero", () => {
    assert.equal(factDensity(""), 0);
  });
});

describe("groundedNumberRate", () => {
  it("is 1 when every figure appears in the material", () => {
    const rate = groundedNumberRate("सन् १९७१ मा", "महासन्धि सन् १९७१ मा भएको");
    assert.equal(rate, 1);
  });

  it("falls when the model invents a figure", () => {
    // The failure this metric exists to catch: a fluent answer full of
    // plausible numbers that were never in the source.
    const rate = groundedNumberRate(
      "सन् १९७१ र सन् १९९९ मा",
      "महासन्धि सन् १९७१ मा भएको"
    );
    assert.equal(rate, 0.5);
  });

  it("is 1 when the answer claims no figures at all", () => {
    // Nothing asserted means nothing to be wrong about; the flatness shows up
    // in factDensity instead, which is the right place for it.
    assert.equal(groundedNumberRate("कुनै सङ्ख्या छैन", "सन् १९७१"), 1);
  });

  it("matches across scripts", () => {
    assert.equal(groundedNumberRate("९० हेक्टर", "area is 90 hectares"), 1);
  });
});

describe("vagueRate", () => {
  it("is zero for an answer with no filler", () => {
    assert.equal(vagueRate("नेपाल सन् १९८७ मा सदस्य भयो"), 0);
  });

  it("rises with hedging phrases", () => {
    assert.ok(vagueRate("यो विषय महत्त्वपूर्ण छ र विभिन्न पक्ष छन्") > 0);
  });
});

describe("nepaliShare", () => {
  it("is near 1 for Nepali prose", () => {
    assert.ok(nepaliShare("नेपालको भूगोल") > 0.9);
  });

  it("is 0 for English", () => {
    assert.equal(nepaliShare("Nepal geography"), 0);
  });

  it("is 0 for empty input", () => {
    assert.equal(nepaliShare("   "), 0);
  });
});

describe("citationRate", () => {
  it("counts distinct valid citations against the material size", () => {
    assert.equal(citationRate([1, 2, 3, 3], 6), 0.5);
  });

  it("ignores citations outside the supplied range", () => {
    assert.equal(citationRate([1, 99], 4), 0.25);
  });

  it("is 0 when no material was supplied", () => {
    assert.equal(citationRate([1], 0), 0);
  });
});

describe("scoreLesson", () => {
  it("ranks a grounded detailed answer above a flat one", () => {
    const material = "रामसार सन् १९७१ मा। नेपाल १९८७ मा सदस्य। १० क्षेत्र सूचीकृत।";

    const flat = scoreLesson({
      answer: "रामसार सूची सिमसार क्षेत्रको सूची हो र यो महत्त्वपूर्ण छ",
      material,
      usedDocIds: [1],
      materialCount: 4,
    });

    const detailed = scoreLesson({
      answer: "रामसार सन् १९७१ मा बनेको, नेपाल १९८७ मा सदस्य, हाल १० क्षेत्र सूचीकृत",
      material,
      usedDocIds: [1, 2, 3],
      materialCount: 4,
    });

    assert.ok(detailed.score > flat.score);
  });

  it("ranks an invented-figure answer below a grounded one", () => {
    // The reason grounding multiplies instead of adding: density earned by
    // fabrication must not beat honest detail.
    const material = "रामसार सन् १९७१ मा।";

    const grounded = scoreLesson({
      answer: "रामसार सन् १९७१ मा बनेको हो",
      material,
      usedDocIds: [1],
      materialCount: 2,
    });

    const fabricated = scoreLesson({
      answer: "रामसार सन् १९५५, १९६६, १९७७ र १९८८ मा बनेको हो",
      material,
      usedDocIds: [1],
      materialCount: 2,
    });

    assert.ok(fabricated.factDensity > grounded.factDensity);
    assert.ok(fabricated.score < grounded.score);
  });

  it("never returns a negative score", () => {
    const result = scoreLesson({
      answer: "यो महत्त्वपूर्ण छ विभिन्न सामान्यतया उल्लेखनीय",
      material: "कुनै सङ्ख्या छैन",
      usedDocIds: [],
      materialCount: 3,
    });
    assert.ok(result.score >= 0);
  });
});

describe("wordCount", () => {
  it("counts whitespace-separated words", () => {
    assert.equal(wordCount("नेपालको भूगोल राम्रो छ"), 4);
  });

  it("is 0 for blank input", () => {
    assert.equal(wordCount("   "), 0);
  });
});
