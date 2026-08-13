// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/ask-sections.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import {
  buildRelatedSection,
  filterToPermitted,
  hasPaperReference,
  modelSections,
  permittedSections,
  sectionsToPlainText,
} from "../ask/sections";
import type { AskMaterial, MaterialQuestion } from "../ask/types";

function question(overrides: Partial<MaterialQuestion> = {}): MaterialQuestion {
  return {
    id: "q1",
    content: "प्रश्न",
    explanation: "व्याख्या",
    is_past_paper: false,
    exam_year: null,
    paper_ref: null,
    set_id: "s1",
    set_title: "सेट",
    set_q_count: 20,
    topic_id: "t1",
    topic_name: "विषय",
    subtopic_name: null,
    subject_name_np: "विषय",
    module_name: "Everything GK",
    module_slug: "gk",
    subject_slug: "nepal-geography",
    topic_slug: "topic",
    subtopic_slug: null,
    ...overrides,
  };
}

function material(overrides: Partial<AskMaterial> = {}): AskMaterial {
  return {
    total_matched: 0,
    locked_count: 0,
    questions: [],
    locked_sets: [],
    topics: [],
    has_paper_ref: false,
    ...overrides,
  };
}

describe("hasPaperReference", () => {
  it("is true only for material the database confirmed as a past paper", () => {
    assert.equal(hasPaperReference({ is_past_paper: true }), true);
  });

  it("is false when the flag is absent or false", () => {
    assert.equal(hasPaperReference({ is_past_paper: false }), false);
    assert.equal(hasPaperReference({}), false);
  });

  it("does not treat a source as an exam", () => {
    // Regression, and the most consequential bug found in live use: the old
    // test was `exam_year !== null || paper_ref !== null`, and 1,537 questions
    // carry an EMPTY STRING paper_ref. So the exam section fired constantly and
    // told candidates that model-set and compilation questions had been asked
    // in the exam. Only 200 of 13,415 questions are genuinely past-paper.
    const modelSetQuestion = question({ is_past_paper: false, paper_ref: "" });
    assert.equal(hasPaperReference(modelSetQuestion), false);
  });
});

describe("permittedSections", () => {
  it("permits nothing when there is no readable material", () => {
    assert.deepEqual(permittedSections(material()), []);
  });

  it("permits only an introduction for a single question", () => {
    const m = material({ questions: [question()] });
    assert.deepEqual(permittedSections(m), ["intro"]);
  });

  it("permits a facts section once there are enough questions", () => {
    // Two is the threshold: the facts list is where concrete dates and figures
    // land, and withholding it made short answers read as a bland paragraph.
    const m = material({ questions: [question(), question()] });
    assert.deepEqual(permittedSections(m), ["intro", "facts"]);
  });

  it("withholds the exam section when no question carries a paper reference", () => {
    // The whole point: of 13,415 questions only 207 carry exam_year, so this is
    // the common case. Offering the heading anyway is what makes a model invent
    // exam facts for a candidate.
    const m = material({
      questions: [question(), question(), question()],
      has_paper_ref: false,
    });
    assert.ok(!permittedSections(m).includes("exam"));
  });

  it("permits the exam section only when the material really carries one", () => {
    const m = material({
      questions: [
        question({
          is_past_paper: true,
          exam_year: 2081,
          paper_ref: "शिक्षक सेवा आयोग — निमावि तह — २०८१",
        }),
        question(),
        question(),
      ],
      has_paper_ref: true,
    });
    assert.ok(permittedSections(m).includes("exam"));
  });

  it("is not fooled by a bare paper_ref with no confirmed past-paper flag", () => {
    // The 35 rows whose paper_ref holds explanation prose from a bad import
    // must never open the exam section.
    const m = material({
      questions: [
        question({ paper_ref: "सामवेद र अथर्ववेद।" }),
        question(),
        question(),
      ],
      has_paper_ref: true,
    });
    assert.ok(!permittedSections(m).includes("exam"));
  });

  it("does not trust the has_paper_ref flag alone", () => {
    // If the flag and the rows disagree, the rows win — the flag is a summary,
    // the rows are the evidence.
    const m = material({
      questions: [question(), question(), question()],
      has_paper_ref: true,
    });
    assert.ok(!permittedSections(m).includes("exam"));
  });

  it("permits related topics only with at least two distinct topics", () => {
    const one = material({
      questions: [question()],
      topics: [{ id: "t1", name: "क" }],
    });
    assert.ok(!permittedSections(one).includes("related"));

    const two = material({
      questions: [question()],
      topics: [
        { id: "t1", name: "क" },
        { id: "t2", name: "ख" },
      ],
    });
    assert.ok(permittedSections(two).includes("related"));
  });
});

describe("modelSections", () => {
  it("never asks the model to write the related-topics section", () => {
    // Topic names are facts about the catalogue. There is nothing for a model
    // to add and plenty for it to get wrong.
    assert.deepEqual(modelSections(["intro", "facts", "related"]), ["intro", "facts"]);
  });

  it("passes through the sections the model does write", () => {
    assert.deepEqual(modelSections(["intro", "facts", "exam"]), [
      "intro",
      "facts",
      "exam",
    ]);
  });
});

describe("filterToPermitted", () => {
  it("drops a section the model invented", () => {
    const sections = [
      { key: "intro" as const, title: "परिचय", body: "क" },
      { key: "exam" as const, title: "परीक्षामा सोधिएका प्रश्नहरू", bullets: ["ख"] },
    ];
    const kept = filterToPermitted(sections, ["intro"]);
    assert.deepEqual(kept.map((s) => s.key), ["intro"]);
  });

  it("drops a model-written related section even when related is permitted", () => {
    const sections = [{ key: "related" as const, title: "सम्बन्धित विषयहरू", bullets: ["क"] }];
    assert.deepEqual(filterToPermitted(sections, ["intro", "related"]), []);
  });

  it("keeps everything when all sections are permitted", () => {
    const sections = [
      { key: "intro" as const, title: "परिचय", body: "क" },
      { key: "facts" as const, title: "मुख्य तथ्यहरू", bullets: ["ख"] },
    ];
    assert.equal(filterToPermitted(sections, ["intro", "facts"]).length, 2);
  });
});

describe("buildRelatedSection", () => {
  it("returns null below the topic threshold", () => {
    assert.equal(buildRelatedSection(material({ topics: [{ id: "t", name: "क" }] })), null);
  });

  it("builds bullets from taxonomy names, capped at five", () => {
    const topics = Array.from({ length: 8 }, (_, i) => ({ id: `t${i}`, name: `विषय ${i}` }));
    const section = buildRelatedSection(material({ topics }));
    assert.equal(section?.bullets?.length, 5);
    assert.equal(section?.key, "related");
  });
});

describe("sectionsToPlainText", () => {
  it("joins headings and bodies for the Listen button", () => {
    const text = sectionsToPlainText([
      { key: "intro", title: "परिचय", body: "यो उत्तर हो।" },
      { key: "facts", title: "मुख्य तथ्यहरू", bullets: ["तथ्य एक", "तथ्य दुई"] },
    ]);
    assert.ok(text.includes("परिचय"));
    assert.ok(text.includes("यो उत्तर हो।"));
    assert.ok(text.includes("तथ्य एक"));
  });

  it("produces empty text for no sections", () => {
    assert.equal(sectionsToPlainText([]), "");
  });
});
