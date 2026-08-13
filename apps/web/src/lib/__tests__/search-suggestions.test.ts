// Node-native test runner (node:test) — no extra dependency.
// Run: node --import tsx --test apps/web/src/lib/__tests__/search-suggestions.test.ts

import { strict as assert } from "node:assert";
import { describe, it } from "node:test";

import { isQuestionShaped, suggestedQuestions } from "../search/suggestions";
import type { SearchPayload, SearchQuestion, SearchSubject } from "../search/types";

function bankQuestion(content: string): SearchQuestion {
  return {
    id: content,
    content,
    option_a: "क",
    option_b: "ख",
    option_c: "ग",
    option_d: "घ",
    correct_option: "A",
    explanation: "व्याख्या",
    set_id: "s1",
    set_title: "सेट",
    topic_name: "विषय",
    subject_name_np: "विषय",
    locked: false,
  };
}

function payload(
  query: string,
  options: {
    subject?: Partial<SearchSubject>;
    broad?: boolean;
    questions?: string[];
  } = {}
): SearchPayload {
  const subject = options.subject
    ? ({
        id: "s1",
        name: "Nepal Geography",
        name_np: "नेपालको भूगोल",
        slug: "nepal-geography",
        syllabus_ref: "1.3",
        ...options.subject,
      } as SearchSubject)
    : null;

  const questions = (options.questions ?? []).map(bankQuestion);

  return {
    query,
    blank: false,
    breadth: options.broad ? "broad" : "narrow",
    results: {
      counts: {
        subjects: subject ? 1 : 0,
        topics: 0,
        sets: 0,
        questions: questions.length,
        locked_questions: 0,
      },
      locked_courses: [],
      subjects: subject ? [subject] : [],
      topics: [],
      sets: [],
      questions,
    },
    header: null,
  };
}

describe("isQuestionShaped", () => {
  it("recognises a trailing question mark", () => {
    assert.equal(isQuestionShaped("नेपालको पहिलो प्रधानमन्त्री को हुन्?"), true);
  });

  it("recognises a Nepali question word without punctuation", () => {
    assert.equal(isQuestionShaped("सगरमाथाको उचाइ कति"), true);
  });

  it("treats a plain noun phrase as not a question", () => {
    assert.equal(isQuestionShaped("नेपालको भूगोल"), false);
  });
});

describe("suggestedQuestions", () => {
  it("returns nothing for an empty query", () => {
    assert.deepEqual(suggestedQuestions(payload("")), []);
  });

  it("prefers real questions from the bank over templates", () => {
    // The point of the change: a real exam question is grounded, has a stored
    // explanation, and shows the learner what the bank actually holds.
    const suggestions = suggestedQuestions(
      payload("झरना", {
        subject: {},
        questions: [
          "नेपालको सबैभन्दा अग्लो झरना कुन हो?",
          "कुशापानी झरणा कुन जिल्लामा छ?",
        ],
      })
    );
    assert.equal(suggestions.length, 2);
    assert.ok(suggestions.every((s) => s.fromBank));
    assert.equal(suggestions[0].text, "नेपालको सबैभन्दा अग्लो झरना कुन हो?");
  });

  it("caps bank suggestions at three", () => {
    const suggestions = suggestedQuestions(
      payload("झरना", {
        questions: ["प्रश्न एक?", "प्रश्न दुई?", "प्रश्न तीन?", "प्रश्न चार?"],
      })
    );
    assert.equal(suggestions.length, 3);
  });

  it("skips a question too long to work as a prompt", () => {
    const long = `${"क".repeat(200)}?`;
    const suggestions = suggestedQuestions(
      payload("झरना", { questions: [long, "छोटो प्रश्न?"] })
    );
    assert.deepEqual(suggestions.map((s) => s.text), ["छोटो प्रश्न?"]);
  });

  it("uses only the first line of a multi-line stem", () => {
    const suggestions = suggestedQuestions(
      payload("झरना", { questions: ["पहिलो हरफ?\nदोस्रो हरफ"] })
    );
    assert.equal(suggestions[0].text, "पहिलो हरफ?");
  });

  it("falls back to templates when the taxonomy matched but no questions did", () => {
    // e.g. an English query matching a Nepali-titled subject.
    const suggestions = suggestedQuestions(
      payload("Nepal Geography", { subject: {}, broad: true })
    );
    assert.ok(suggestions.every((s) => !s.fromBank));
    assert.ok(suggestions.some((s) => s.text.includes("कहाँबाट सुरु")));
  });

  it("does not staple an instruction onto an existing question", () => {
    // Regression: with nothing matched at all, the template path used to build
    // "…को हुन्? बुझाउनुहोस्" — a question with an instruction glued on.
    const query = "नेपालको पहिलो प्रधानमन्त्री को हुन्?";
    const suggestions = suggestedQuestions(payload(query));
    assert.equal(suggestions[0].text, query);
    assert.ok(!suggestions.some((s) => s.text.includes("? बुझाउनुहोस्")));
  });

  it("never returns more than three suggestions", () => {
    for (const p of [
      payload("रामसार"),
      payload("नेपालको भूगोल", { subject: {}, broad: true }),
      payload("झरना", { questions: ["एक?", "दुई?", "तीन?", "चार?", "पाँच?"] }),
    ]) {
      assert.ok(suggestedQuestions(p).length <= 3);
    }
  });
});
