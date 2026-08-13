import { AskSectionCopy } from "@/config/copy";

/**
 * Prompts for "Chat with DrishtiPrep AI".
 *
 * Kept beside the other prompt templates rather than next to the code that
 * calls them: prompt wording is content, gets tuned far more often than the
 * surrounding logic, and belongs where a maintainer looks for wording.
 */

export type LessonSectionKey = "intro" | "facts" | "exam" | "related";

/**
 * Who DrishtiPrep AI is.
 *
 * Shared by every prompt so the assistant is one character, not a different
 * one per code path.
 *
 * The brief matters more than it looks. A general chatbot answers a Lok Sewa
 * question adequately; a platform built only for Lok Sewa and TSC should answer
 * it better, and the way it earns that is by being an examiner as much as an
 * explainer — leading with the answer, naming the figure that gets asked,
 * separating the facts candidates confuse. It should never send a learner away
 * to rephrase a question a teacher would simply have answered.
 */
export const DRISHTIPREP_PERSONA =
  `तपाईं DrishtiPrep AI हुनुहुन्छ — लोक सेवा आयोग र शिक्षक सेवा आयोगको तयारी ` +
  `गराउने अनुभवी प्रशिक्षक। तपाईंले वर्षौंदेखि यी परीक्षाका प्रश्न र ढाँचा ` +
  `हेर्दै आउनुभएको छ।\n\n` +
  `तपाईंको शैली:\n` +
  `- सिधै उत्तर दिनुहोस्। भूमिका बाँध्नु पर्दैन।\n` +
  `- परीक्षामा सोधिने ठोस कुरा — मिति, सङ्ख्या, नाम, स्थान — पहिले राख्नुहोस्।\n` +
  `- विद्यार्थीले अक्सर झुक्किने कुरा भए छुट्याएर स्पष्ट पार्नुहोस्।\n` +
  `- छोटा, स्पष्ट वाक्य लेख्नुहोस्। विद्यार्थीको समयको कदर गर्नुहोस्।\n` +
  `- विद्यार्थीलाई प्रश्न फेरि सोध्न नलगाउनुहोस् — जति थाहा छ, त्यति उत्तर दिनुहोस्।`;

/**
 * Longest explanation passed through per question.
 *
 * Raised from 400. DrishtiPrep explanations carry the exact dates, figures and
 * place names a candidate is being examined on, and 400 characters was cutting
 * them off mid-fact — so the lesson came back fluent but empty, a paragraph of
 * generalities where the source had specifics.
 */
export const MAX_EXPLANATION_CHARS = 900;

/** The past-paper brief never varies: it is a correctness rule, not a style. */
const EXAM_BRIEF =
  "विगतका परीक्षामा सोधिएका प्रश्नका बुँदा। जुन सामग्रीमा 'परीक्षा सन्दर्भ' " +
  "स्पष्ट लेखिएको छ, ती मात्र प्रयोग गर्नुहोस् र परीक्षाको नाम तथा वर्ष उल्लेख " +
  "गर्नुहोस्। अरू सामग्रीलाई परीक्षामा सोधिएको भन्न मिल्दैन।";

/**
 * A prompt variant.
 *
 * Wording is the single biggest lever on answer quality and the easiest thing
 * to change on a hunch. Making variants data rather than edits means a change
 * can be measured against the live prompt on the same queries — see
 * `scripts/prompt-lab.ts` — instead of judged from one screenshot.
 */
export type PromptVariant = {
  id: string;
  label: string;
  /** What each permitted heading should contain, in Nepali. */
  sectionBrief: Record<string, string>;
  /** The numbered rules block. Rule order matters to the model; keep it stable. */
  rules: string[];
};

const GROUNDING_RULES = [
  "तल दिइएको सामग्रीमा भएको कुरा मात्र लेख्नुहोस्। आफ्नो सामान्य ज्ञान प्रयोग नगर्नुहोस्।",
  "सामग्रीमा नभएको मिति, सङ्ख्या वा नाम नलेख्नुहोस्।",
  "तल तोकिएका खण्डहरू मात्र लेख्नुहोस्। नयाँ खण्ड नथप्नुहोस्।",
  "कुनै खण्डका लागि सामग्री पर्याप्त छैन भने त्यो खण्ड नै छाड्नुहोस्।",
  "नेपालीमा मात्र लेख्नुहोस् — प्रश्न जुनसुकै भाषामा सोधिएको भए पनि।",
  "प्रयोग गरेका सामग्रीका नम्बरहरू used_doc_ids मा राख्नुहोस्।",
  "कुनै प्रश्न परीक्षामा सोधिएको थियो भन्ने दाबी नगर्नुहोस् — जहाँ 'परीक्षा सन्दर्भ' " +
    "स्पष्ट दिइएको छ, त्यहाँ मात्र त्यसो भन्न मिल्छ। सेटको नाम वा सङ्ग्रहको नाम " +
    "परीक्षाको प्रमाण होइन।",
];

/** The live prompt: grounded, and explicitly asked for concrete detail. */
export const DETAILED_VARIANT: PromptVariant = {
  id: "detailed",
  label: "Detailed (live)",
  sectionBrief: {
    intro:
      "३–५ वाक्यमा सोधिएको कुराको सिधा उत्तर। सामग्रीमा मिति, सङ्ख्या वा स्थान " +
      "छ भने पहिलो वाक्यमै समावेश गर्नुहोस्।",
    facts:
      "सामग्रीमा भएका ठोस तथ्यहरू ४–८ बुँदामा। प्रत्येक बुँदामा सम्भव भएसम्म " +
      "मिति, सङ्ख्या, स्थान वा नाम राख्नुहोस् — 'महत्त्वपूर्ण छ' जस्ता सामान्य " +
      "वाक्य नलेख्नुहोस्।",
    exam: EXAM_BRIEF,
  },
  rules: [
    GROUNDING_RULES[0],
    "सामग्रीमा भएका मिति, सन्, सङ्ख्या, स्थान र नाम नछुटाउनुहोस् — विद्यार्थीलाई " +
      "परीक्षामा यिनै सोधिन्छ। सकेसम्म धेरै ठोस तथ्य समेट्नुहोस्।",
    ...GROUNDING_RULES.slice(1),
  ],
};

/**
 * The original brief prompt, kept as the baseline. It is what produced the
 * "ours is flat, Gemini's is detailed" comparison, so any new variant should
 * have to beat it by a visible margin before replacing anything.
 */
export const TERSE_VARIANT: PromptVariant = {
  id: "terse",
  label: "Terse (original baseline)",
  sectionBrief: {
    intro: "२–४ वाक्यमा सोधिएको कुराको सिधा उत्तर र सन्दर्भ।",
    facts: "तल दिइएका सामग्रीमा भएका मुख्य तथ्यहरू, ३–६ बुँदामा।",
    exam: EXAM_BRIEF,
  },
  rules: GROUNDING_RULES,
};

/**
 * Detailed, plus an explicit shape for each bullet — the labelled style that
 * reads well in a reference answer ("हस्ताक्षर मिति: …"). Worth measuring:
 * structure may raise fact density, or may just add words.
 */
export const LABELLED_VARIANT: PromptVariant = {
  id: "labelled",
  label: "Detailed + labelled bullets",
  sectionBrief: {
    ...DETAILED_VARIANT.sectionBrief,
    facts:
      "सामग्रीमा भएका ठोस तथ्यहरू ४–८ बुँदामा। हरेक बुँदा 'शीर्षक: तथ्य' " +
      "ढाँचामा लेख्नुहोस् — जस्तै 'हस्ताक्षर मिति: सन् १९७१'। शीर्षकविहीन " +
      "सामान्य वाक्य नलेख्नुहोस्।",
  },
  rules: DETAILED_VARIANT.rules,
};

export const PROMPT_VARIANTS: PromptVariant[] = [
  DETAILED_VARIANT,
  TERSE_VARIANT,
  LABELLED_VARIANT,
];

/** Backwards-compatible export for callers that only need the live briefs. */
export const LessonSectionBrief: Record<string, string> =
  DETAILED_VARIANT.sectionBrief;

export type LessonQuestion = {
  content: string;
  explanation: string | null;
  set_title: string;
  is_past_paper: boolean;
  exam_year: number | null;
  paper_ref: string | null;
};

function trimExplanation(explanation: string): string {
  if (explanation.length <= MAX_EXPLANATION_CHARS) return explanation;
  return `${explanation.slice(0, MAX_EXPLANATION_CHARS).trimEnd()}…`;
}

/**
 * The grounded lesson prompt.
 *
 * Two properties matter more than the wording:
 *
 * 1. Only permitted headings appear. A heading the retrieval could not support
 *    is never named, so the model has no empty section to invent content for.
 *    That is the hallucination fix, and it is structural rather than a plea in
 *    the instructions.
 * 2. Material is numbered from 1 and the model must cite those numbers, which
 *    is what makes the grounding check possible — a citation to a number we
 *    never supplied is a fabrication, and detectable.
 */
export function buildLessonPrompt(
  query: string,
  questions: LessonQuestion[],
  sections: LessonSectionKey[],
  variant: PromptVariant = DETAILED_VARIANT
): string {
  const titles = AskSectionCopy;

  const headings = sections
    .map(
      (key, index) =>
        `${index + 1}. "${key}" (${titles[key]}) — ${variant.sectionBrief[key]}`
    )
    .join("\n");

  const rules = variant.rules
    .map((rule, index) => `${index + 1}. ${rule}`)
    .join("\n");

  const material = questions
    .map((question, index) => {
      const parts = [
        `[${index + 1}] सेट: ${question.set_title}`,
        `प्रश्न: ${question.content}`,
      ];
      if (question.explanation) {
        parts.push(`व्याख्या: ${trimExplanation(question.explanation)}`);
      }
      // Only genuine past papers carry a reference. A set title or compilation
      // name is not evidence that a question was ever asked in an exam.
      if (question.is_past_paper) {
        const ref = [question.paper_ref, question.exam_year]
          .filter(Boolean)
          .join(" ");
        parts.push(`परीक्षा सन्दर्भ: ${ref}`);
      }
      return parts.join("\n");
    })
    .join("\n\n");

  return `${DRISHTIPREP_PERSONA}

विद्यार्थीको प्रश्न: ${query}

नियमहरू:
${rules}

लेख्नुपर्ने खण्डहरू:
${headings}

सामग्री:
${material}

JSON ढाँचामा मात्र उत्तर दिनुहोस्:
{
  "sections": [
    { "key": "intro", "body": "..." },
    { "key": "facts", "bullets": ["...", "..."] }
  ],
  "used_doc_ids": [1, 2]
}`;
}

/** How many alternatives a clarifying reply may offer. */
export const MAX_CLARIFY_OPTIONS = 3;

/**
 * Repair a query that retrieval could not match.
 *
 * Worth being clear about why this exists, because the intuition "the AI
 * understands spelling anyway" is half right. Retrieval runs BEFORE the model
 * and is plain SQL substring matching, so when a learner writes सिंसार and the
 * bank says सिमसार, the model is handed nothing and never gets the chance to be
 * clever. Its tolerance for spelling is real but unreachable at that stage.
 *
 * This closes the gap by putting the model in front of the second attempt: on a
 * miss, it rewrites the query into the standard exam terminology, and retrieval
 * runs once more. Hardcoded spelling swaps handle the common cases for free;
 * this handles everything else, and only costs a call when we already failed.
 */
export function buildQueryRepairPrompt(query: string): string {
  return `तपाईं लोक सेवा तयारीका पाठ्यसामग्री खोज्न मद्दत गर्ने सहायक हुनुहुन्छ।

विद्यार्थीले लेखेको: ${query}

यो शब्दावली प्रश्नबैंकमा भेटिएन — हिज्जे फरक परेको वा बोलचालको शब्द प्रयोग
भएको हुन सक्छ। यसलाई परीक्षामा प्रयोग हुने मानक नेपाली शब्दमा लेख्नुहोस्।

नियमहरू:
1. २–४ वटा मुख्य शब्द मात्र दिनुहोस् (terms)।
2. मानक हिज्जे प्रयोग गर्नुहोस् — जस्तै "सिंसार" → "सिमसार", "सूचि" → "सूची"।
3. पर्यायवाची शब्द पनि राख्न सकिन्छ — जस्तै "जंगल" → "वन"।
4. क्रिया वा प्रश्नवाचक शब्द नराख्नुहोस् (बुझाउनुहोस्, के, कति आदि)।
5. विषयवस्तु नै अस्पष्ट भए खाली सूची दिनुहोस्।

JSON ढाँचामा मात्र:
{ "terms": ["…", "…"] }`;
}

/**
 * The no-material prompt: answer anyway, from general knowledge.
 *
 * This used to offer the model a choice between answering and asking the
 * learner to clarify. Asking back turned out to be the wrong instinct almost
 * every time it fired: retrieval usually missed because of SPELLING, not
 * vagueness — "सिंसार" where the bank has "सिमसार" — so a perfectly answerable
 * question came back as a request to rephrase. A dedicated Lok Sewa platform
 * that does that is worse than a general chatbot, which would simply have
 * answered.
 *
 * So there is no clarify branch here any more. The assistant answers, and the
 * caller labels the reply as general knowledge rather than DrishtiPrep content.
 * (The `clarify` route still exists in the types and UI for a future case where
 * a question genuinely cannot be answered; nothing requests it today.)
 */
export function buildFallbackPrompt(query: string): string {
  return `${DRISHTIPREP_PERSONA}

विद्यार्थीको प्रश्न: ${query}

DrishtiPrep को आफ्नै सामग्रीमा यो प्रश्नको उत्तर भेटिएन। तैपनि विद्यार्थीलाई
आफ्नो सामान्य ज्ञानका आधारमा राम्रो उत्तर दिनुहोस्।

नियमहरू:
1. सिधै उत्तर दिनुहोस्। प्रश्न फेरि सोध्न नलगाउनुहोस्।
2. लोक सेवा/शिक्षक सेवाको दृष्टिकोणबाट उपयोगी हुने गरी लेख्नुहोस् — मिति,
   सङ्ख्या, नाम र स्थान समावेश गर्नुहोस्।
3. ४–६ वाक्यमा लेख्नुहोस्। आवश्यक भए बुँदा प्रयोग गर्नुहोस्।
4. निश्चित नभएको तथ्यमा "निश्चित छैन" भन्नुहोस् — अनुमानलाई तथ्य नबनाउनुहोस्।
5. नेपालीमा मात्र लेख्नुहोस्।
6. DrishtiPrep मा यो सामग्री छ भन्ने दाबी नगर्नुहोस्।

JSON ढाँचामा मात्र:
{ "kind": "outside", "answer": "…" }`;
}
