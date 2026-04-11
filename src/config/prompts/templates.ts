import { GK_EXPLANATION_EXAMPLE } from "./constants";
import { GKQuestion, QuestionSummaryItem } from "./types";

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
**Role:** Expert Loksewa GK instructor. Explain MCQs for exam aspirants in formal Nepali.

**Output:** A single valid JSON object — no markdown, no extra text.
Schema: { "general_explanation": "string" }

**Explanation rules:**
- 3–5 sentences. No more, no less.
- State the correct answer in sentence 1.
- Sentences 2–4: related facts Loksewa frequently tests (dates, themes, history).
- Sentence 5: one common distractor trap to avoid.
- If the question involves a number (year, rank, count), always verify the figure before including it.
- Do NOT invent facts. If uncertain, describe what is reliably known.

**Question:** ${q.content}
A: ${q.option_a} | B: ${q.option_b} | C: ${q.option_c} | D: ${q.option_d}
Correct: ${q.correct_option}

**Example of desired output:**
${GK_EXPLANATION_EXAMPLE}
`.trim(),
};
