import { devanagariDigitsToLatin } from "@/lib/devanagari";

/**
 * Measuring how informative a generated lesson is.
 *
 * "Detailed" and "flat" are the words we actually use about these answers, but
 * neither can be tuned against. These metrics turn them into numbers, so a
 * prompt change can be shown to help rather than assumed to.
 *
 * The central caution: FACT DENSITY ALONE IS A TRAP. A model told to include
 * more dates and figures can simply invent them, scoring beautifully while
 * getting worse. So density is always reported alongside grounding — what
 * share of those figures actually appear in the source material — and the
 * composite score multiplies the two. An answer full of numbers we never
 * supplied scores near zero, which is the correct verdict.
 */

/** Numbers in either script, including decimals and thousands separators. */
const NUMBER_PATTERN = /[०-९0-9][०-९0-9.,]*/g;

/**
 * Hedges and filler that pad an answer without teaching anything. Not banned —
 * some are legitimate — but a high rate is what "flat" sounds like.
 */
const VAGUE_PHRASES = [
  "महत्त्वपूर्ण छ",
  "महत्वपूर्ण छ",
  "विभिन्न",
  "धेरै किसिमका",
  "सामान्यतया",
  "प्रमुख रूपमा",
  "उल्लेखनीय",
  "विशेष महत्त्व",
  "आदि इत्यादि",
  "भूमिका खेल्छ",
];

const DEVANAGARI = /[ऀ-ॿ]/g;

/** Words, counted the same way for every variant so comparisons are fair. */
export function wordCount(text: string): number {
  return text.trim().split(/\s+/).filter(Boolean).length;
}

/**
 * Every number in the text, normalised to Latin digits so ९० and 90 compare
 * equal. Separators are stripped so २६,१०६ matches 26106.
 */
export function extractNumbers(text: string): string[] {
  const matches = text.match(NUMBER_PATTERN) ?? [];
  return matches
    .map((raw) => devanagariDigitsToLatin(raw).replace(/[.,]$/g, "").replace(/,/g, ""))
    .filter((value) => value.length > 0 && /\d/.test(value));
}

/** Concrete figures per 100 words. The headline "is it detailed" signal. */
export function factDensity(answer: string): number {
  const words = wordCount(answer);
  if (words === 0) return 0;
  return (extractNumbers(answer).length / words) * 100;
}

/**
 * Share of the answer's numbers that appear in the material it was given.
 *
 * This is the honesty check. 1.0 means every figure is traceable to a source
 * document; a drop means the model is producing numbers from its own weights,
 * which for exam candidates is the worst failure this feature can have.
 */
export function groundedNumberRate(answer: string, material: string): number {
  const answerNumbers = extractNumbers(answer);
  if (answerNumbers.length === 0) return 1; // nothing claimed, nothing to check
  const sourceNumbers = new Set(extractNumbers(material));
  const grounded = answerNumbers.filter((n) => sourceNumbers.has(n)).length;
  return grounded / answerNumbers.length;
}

/** Filler phrases per 100 words. Higher is blander. */
export function vagueRate(answer: string): number {
  const words = wordCount(answer);
  if (words === 0) return 0;
  const hits = VAGUE_PHRASES.reduce(
    (total, phrase) => total + answer.split(phrase).length - 1,
    0
  );
  return (hits / words) * 100;
}

/** Share of non-space characters in Devanagari. Catches drift into English. */
export function nepaliShare(answer: string): number {
  const meaningful = answer.replace(/\s/g, "").length;
  if (meaningful === 0) return 0;
  return (answer.match(DEVANAGARI) ?? []).length / meaningful;
}

/** Share of supplied documents the answer actually cited. */
export function citationRate(usedDocIds: number[], materialCount: number): number {
  if (materialCount === 0) return 0;
  const valid = new Set(
    usedDocIds.filter((id) => Number.isInteger(id) && id >= 1 && id <= materialCount)
  );
  return valid.size / materialCount;
}

export type LessonMetrics = {
  words: number;
  factDensity: number;
  groundedRate: number;
  vagueRate: number;
  nepaliShare: number;
  citationRate: number;
  /** Density discounted by grounding, minus filler. Higher is better. */
  score: number;
};

export function scoreLesson(args: {
  answer: string;
  material: string;
  usedDocIds: number[];
  materialCount: number;
}): LessonMetrics {
  const density = factDensity(args.answer);
  const grounded = groundedNumberRate(args.answer, args.material);
  const vague = vagueRate(args.answer);

  return {
    words: wordCount(args.answer),
    factDensity: density,
    groundedRate: grounded,
    vagueRate: vague,
    nepaliShare: nepaliShare(args.answer),
    citationRate: citationRate(args.usedDocIds, args.materialCount),
    // Grounding multiplies rather than adds: an ungrounded figure is not a
    // smaller benefit, it is a defect, and no amount of density redeems it.
    score: Math.max(0, density * grounded - vague),
  };
}
