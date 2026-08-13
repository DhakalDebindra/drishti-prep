import { SuggestionCopy } from "@/config/copy";
import type { SearchPayload } from "@/lib/search/types";

/**
 * Suggested questions for the chat entry point.
 *
 * These are real questions from the bank, not templates.
 *
 * The templated version ("<subject> बुझाउनुहोस्") was useless for GK: it asked
 * the AI to summarise a whole subject, which is the one thing a grounded tutor
 * is worst at and a candidate least needs. A real exam question is better on
 * every count — it is precisely the kind of thing the learner is studying, we
 * already hold its explanation, so the answer is guaranteed to be grounded, and
 * it shows the learner what the bank actually contains.
 *
 * Templates remain only as a fallback for queries that matched the taxonomy but
 * no question text — an English query like "Nepal Geography", say.
 */

/** How many suggestions the entry point shows. */
const MAX_SUGGESTIONS = 3;

/** Longer than this is a paragraph to read aloud, not a prompt to choose. */
const MAX_SUGGESTION_LENGTH = 110;

export type Suggestion = {
  text: string;
  /** True when this came from a real question rather than a template. */
  fromBank: boolean;
};

/** Question stems, cleaned up enough to work as a chat prompt. */
function questionSuggestions(payload: SearchPayload): Suggestion[] {
  return payload.results.questions
    .map((question) => question.content.split(/\r?\n/, 1)[0].trim())
    .filter((text) => text.length > 0 && text.length <= MAX_SUGGESTION_LENGTH)
    .slice(0, MAX_SUGGESTIONS)
    .map((text) => ({ text, fromBank: true }));
}

/** Nepali and English markers that a query is already a full question. */
const QUESTION_WORDS = [
  "के", "को", "कति", "कहाँ", "कहिले", "किन", "कसरी", "कसले", "कुन",
  "what", "which", "who", "when", "where", "why", "how",
];

/**
 * A query that is already a question must never be wrapped in a template.
 * Doing so produced "नेपालको पहिलो प्रधानमन्त्री को हुन्? बुझाउनुहोस्" — a
 * question with an instruction stapled to the end.
 */
export function isQuestionShaped(query: string): boolean {
  const trimmed = query.trim();
  if (!trimmed) return false;
  if (trimmed.endsWith("?") || trimmed.endsWith("？")) return true;
  return trimmed
    .toLowerCase()
    .split(/\s+/)
    .some((word) => QUESTION_WORDS.includes(word));
}

function templateSuggestions(payload: SearchPayload): Suggestion[] {
  const subject = payload.results.subjects[0];
  const subjectLabel = subject?.name_np || subject?.name || null;

  // With no subject to name and a question already asked, the only sensible
  // suggestion is the learner's own question.
  if (!subjectLabel) {
    const query = payload.query.trim();
    if (!query) return [];
    if (isQuestionShaped(query)) {
      return [
        { text: query, fromBank: false },
        { text: SuggestionCopy.examAsksGeneric, fromBank: false },
      ];
    }
  }

  const label = subjectLabel || payload.query;
  const base = [SuggestionCopy.explain(label), SuggestionCopy.examAsks(label)];
  const last =
    payload.breadth === "broad"
      ? SuggestionCopy.whereToStart
      : SuggestionCopy.related(label);

  return [...base, last].map((text) => ({ text, fromBank: false }));
}

export function suggestedQuestions(payload: SearchPayload): Suggestion[] {
  if (!payload.query.trim()) return [];

  const fromBank = questionSuggestions(payload);
  if (fromBank.length > 0) return fromBank;

  return templateSuggestions(payload).slice(0, MAX_SUGGESTIONS);
}
