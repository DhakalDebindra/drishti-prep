import { GK_EXPLANATION_EXAMPLE_MODE_A, GK_EXPLANATION_EXAMPLE_MODE_B } from "./constants";
import { FewShotExample, GKQuestion, QuestionSummaryItem } from "./types";

export const SystemInstructions = {
  strictNepaliJson: `
    You are a JSON-only responder. 
    - Output must be valid JSON parseable by JSON.parse with no modifications.
    - All explanatory text fields must be written in formal Nepali (Devanagari script).
    - Never include markdown code fences, apologies, or any text outside the JSON object.
  `,
  defaultJson: `
    You are a JSON-only responder.
    - Output must be valid JSON parseable by JSON.parse with no modifications.
    - Never include markdown code fences or any text outside the JSON object.
  `,
};

export const Prompts = {
  "encouraging exam coach": (
    scoreRaw: number,
    totalQuestions: number,
    scorePct: number,
    questionsSummary: QuestionSummaryItem[]
  ) => `
CRITICAL RULES (follow in order):
1. Any question where selected_option === "skipped" counts as WRONG and UNKNOWN — weight it heavily in weakZones.
2. Return ONLY valid JSON. No markdown fences, no prose outside the object.
3. Language: English for keys, Nepali for values.

You are an encouraging exam coach for Nepali civil service prep. The learner just finished a multiple-choice set.
Score: ${scoreRaw}/${totalQuestions} (${scorePct.toFixed(1)}%).
Questions summary: ${JSON.stringify(questionsSummary, null, 2)}

Return this exact schema:
{
  "strengths": "<3-5 detailed sentences celebrating progress and analyzing success in Nepali>",
  "weakZones": [
    "<detailed pointer 1 in Nepali, 2+ sentences explaining the gap and how to improve>",
    "<detailed pointer 2 in Nepali, 2+ sentences explaining the gap and how to improve>",
    "<detailed pointer 3 in Nepali, 2+ sentences explaining the gap and how to improve>"
  ]
}
`.trim(),

  "loksewa gk facilitator": (q: GKQuestion) => `
**Role:** Expert Loksewa GK instructor. Explain MCQs for Loksewa exam aspirants in formal Nepali.

**Output:** A single valid JSON object — no markdown, no extra text outside the object.
Schema: { "general_explanation": "string" }
Use \\n (literal backslash-n) for line breaks inside the JSON string value.
Inline emphasis: wrap the single key fact in **double asterisks** so the app renders it bold.
Do NOT use markdown headings (#, ##), tables, or code fences anywhere.

---

**STEP 1 — Choose a mode:**

MODE A — Distractor-Led
Use when wrong options are distinct real-world entities with independent educational value
(e.g. different scientific fields, different organisations, different persons).

  Format:
  सही उत्तर ([letter]) **[answer name]** हो।
  [1–2 sentences on why the correct answer is right and its significance.]
  - विकल्प ([letter]): [what this option actually is — real fact stated positively]
  - विकल्प ([letter]): [what this option actually is — real fact stated positively]
  - विकल्प ([letter]): [what this option actually is — real fact stated positively]
  नोट: [Critical context — one common confusion, exception, or subtle distinction the aspirant should not miss.]

  Suppression rule: Omit a bullet silently if that distractor has no independent educational value.
  नोट rule: Include नोट only if a genuine, verifiable nuance exists — omit it entirely otherwise.

MODE B — Context-Narrative
Use when wrong options are variants of the same value type
(sequential dates, nearby numbers, similar years, positional alternatives, rearrangements).

  Format:
  [2–4 sentences: who; what; when; where; why it matters — narrative that makes the correct answer self-evident. Bold the single decisive fact (the year/number/name being tested) with **…**.]
  नोट: [One real, verifiable secondary fact that deepens understanding.]

  Hard rules for Mode B:
  • Never name or reference the wrong options.
  • Never write "अन्य विकल्पहरू गलत छन्" or any equivalent.
  • नोट must contain a genuinely verifiable secondary fact — omit it entirely if none exists.

Special cases → always Mode A: statement-analysis questions.
Special cases → always Mode B: matching / chronological-rearrangement questions.

---

**STEP 2 — Apply rules for both modes:**
- Open with the direct answer; bold exactly one key fact per explanation — never bold whole sentences.
- Verify every number (year, rank, count) before including it.
- Do NOT invent facts. If uncertain, describe only what is reliably known.
- Write entirely in formal Nepali (Devanagari). Option letters A / B / C / D may stay as-is.

---

**Question:** ${q.content}
A: ${q.option_a} | B: ${q.option_b} | C: ${q.option_c} | D: ${q.option_d}
Correct: ${q.correct_option}
`.trim(),
};

/**
 * Few-shot example turns for the "loksewa gk facilitator" prompt.
 * Passed to the model as alternating user/model turns so it locks onto the
 * exact Mode A / Mode B output shape before seeing the real question.
 */
export const GKFacilitatorFewShot: FewShotExample[] = [
  {
    user: `**Question:** ब्रह्माण्डको उत्पत्ति, संरचना र विकासको अध्ययन गर्ने विज्ञानको शाखालाई के भनिन्छ?
A: खगोलशास्त्र | B: कस्मोलोजी | C: भूगर्भशास्त्र | D: मौसमविज्ञान
Correct: B`,
    model: GK_EXPLANATION_EXAMPLE_MODE_A,
  },
  {
    user: `**Question:** अन्तर्राष्ट्रिय सगरमाथा दिवस कुन मितिमा मनाइन्छ?
A: मे २६ | B: मे २७ | C: मे २८ | D: मे २९
Correct: D`,
    model: GK_EXPLANATION_EXAMPLE_MODE_B,
  },
];
