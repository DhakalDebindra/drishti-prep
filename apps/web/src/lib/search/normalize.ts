/**
 * Query normalisation for learner-facing search.
 *
 * Nepali marks case and number with suffixes, so the word a learner types and
 * the word stored in a question are often different surface forms of the same
 * thing: संविधान / संविधानको / संविधानहरूमा. Substring matching already covers
 * one direction (searching संविधान finds संविधानको, because the stem is a
 * prefix of the inflected form) but not the other — so we trim the suffixes off
 * the query and search for every form we derived.
 *
 * The output shape is deliberate. Each token becomes a LIST of spellings:
 *
 *   "नेपालको भूगोल"  ->  [["नेपालको", "नेपाल"], ["भूगोल"]]
 *
 * search_content() then matches OR within a token and AND across tokens. That
 * distinction is the whole ballgame: with a flat OR over every spelling,
 * "नेपाल" — a word in nearly every row on a Nepali exam platform — matched 155
 * sets for "नेपालको भूगोल", including history-of-education material.
 */

/**
 * Suffixes stripped from query tokens, longest first so the longest match at
 * each step wins.
 *
 * Deliberately only single suffixes — no compound entries like "हरूमा". Peeling
 * one at a time lets the loop below unwind stacked suffixes while keeping every
 * intermediate form: तालहरूमा → तालहरू → ताल. Stripping "हरूमा" in one step
 * would jump straight to ताल and lose तालहरू, which is a form the database
 * genuinely stores.
 */
const SUFFIXES = [
  // "…बारे" and "…सम्बन्धी" attach straight onto the noun in how learners
  // write — "संविधानबारे" — and no exam question is phrased that way, so
  // without trimming them the query cannot match anything at all.
  "सम्बन्धी",
  "सम्बन्धि",
  "मार्फत",
  "बारेमा",
  "भन्दा",
  "मध्ये",
  "सम्म",
  "देखि",
  "बारे",
  "लाई",
  "बाट",
  "सँग",
  "सित",
  "हरू",
  "को",
  "का",
  "मा",
  "ले",
];

/*
 * "की" is deliberately absent. It is a real genitive suffix, but it also ends
 * ordinary words — and stripping it turns भौतिकी into भौति, which is not a word
 * and which substring-matches भौतिक ("physical") in 59 questions. A search for
 * भौतिकी, a subject we do not cover, came back with classroom-management sets.
 * The recall it would add is not worth that.
 */

/**
 * Words that carry no search signal. Dropping them keeps the AND gate honest:
 * "नेपालको भूगोल के हो" should search नेपाल + भूगोल, not also require के and हो.
 */
const STOPWORDS = new Set([
  // Nepali function words and question words
  "र", "अनि", "तथा", "वा", "हो", "हुन्", "हुन", "छ", "छन्", "थियो", "थिए",
  "के", "कुन", "कति", "कस्तो", "कहाँ", "कहिले", "किन", "कसरी", "कसले",
  "यो", "त्यो", "यी", "ती", "नै", "पनि", "लागि", "बारे", "बारेमा",
  "सम्बन्धी", "सम्बन्धित", "सम्बन्धमा", "विषयमा",
  // Instruction words. A learner talking to an AI writes "… को अध्यापन
  // गराउनुहोस्"; exam questions never contain those words, so ANDing them
  // guaranteed zero results. This is what made
  // "सबैभन्दा ठुलो र सानोको अध्यापन गराउनुहोस्" return nothing at all.
  "भन्नुहोस्", "बताउनुहोस्", "दिनुहोस्", "गर्नुहोस्", "बुझाउनुहोस्",
  "गराउनुहोस्", "सिकाउनुहोस्", "देखाउनुहोस्", "लेख्नुहोस्", "सुनाउनुहोस्",
  "पढाउनुहोस्", "अध्यापन", "सिकाऊ", "बुझाऊ", "भन", "हेर्नुहोस्",
  "कृपया", "मलाई", "हामीलाई", "तपाईं", "तपाईंले",
  // Definitional phrasing. A learner asking "X भनेको के हो?" is asking about X;
  // requiring भनेको to also appear in the question text found nothing, because
  // exam questions are not phrased that way. This cost a real query: रामसार
  // क्षेत्र भनेको के हो? returned zero despite 33 रामसार questions existing.
  "भनेको", "भनेर", "भन्ने", "भन्नाले", "हुन्छ", "गरिन्छ", "रहेको", "रहेका",
  // "give me all the information about X" phrasing. These words are how a
  // learner asks, never how an exam question is written, so ANDing them
  // guarantees a miss — "…सम्बन्धि सम्पूर्ण जानकारी" found nothing at all.
  "सम्पूर्ण", "सम्पुर्ण", "जानकारी", "जानकारि", "विवरण", "बारे", "सम्बन्धि",
  "सूचना", "बताउनु", "लेख्नु", "सबै",
  // English function words, for mixed-script queries
  "the", "of", "in", "on", "at", "a", "an", "is", "are", "was", "were",
  "what", "which", "how", "when", "why", "who", "and", "or", "for", "about",
  "me", "my", "tell", "explain", "show",
]);

/** Devanagari combining marks — vowel signs, virama, anusvara, nukta. */
const COMBINING_MARKS = /[ऀ-ःऺ-ॏ॑-ॗॢॣ]/g;

/** Characters that separate words, including the Devanagari danda. */
const SEPARATORS = /[\s,;:!?।॥"'`()[\]{}<>\/\\|+*=~@#$^&]+/;

/** Longest query we will process, in characters. Anything beyond is noise. */
const MAX_QUERY_LENGTH = 200;

/** Most tokens we will AND together. More than this and recall collapses. */
const MAX_TOKENS = 6;

/**
 * Shortest acceptable stem, counted in base characters (combining marks
 * excluded, since ी and ु are not standalone letters). Below this a "stem" is
 * a fragment that matches half the database.
 */
const MIN_STEM_LENGTH = 2;

/** Base-character count, ignoring Devanagari combining marks. */
export function baseLength(word: string): number {
  return word.replace(COMBINING_MARKS, "").length;
}

/**
 * Escape LIKE wildcards so a learner typing "100%" searches for the literal
 * string rather than matching every row. The backslash must go first, or it
 * would escape the escapes we just added.
 */
export function escapeLikePattern(value: string): string {
  return value.replace(/\\/g, "\\\\").replace(/[%_]/g, "\\$&");
}

/**
 * All spellings of one token: the word as typed, plus each stem produced by
 * peeling suffixes off it. Peeling repeats so stacked suffixes unwind —
 * तालहरूमा → तालहरू → ताल — and every intermediate form is kept, because the
 * database may store any of them.
 */
export function tokenVariants(word: string): string[] {
  const variants = [word];
  let current = word;

  // Alternate spellings of the word as typed, before any suffix trimming.
  for (const variant of spellingVariants(word)) {
    if (!variants.includes(variant)) variants.push(variant);
  }

  // Two rounds covers plural + case, which is as deep as Nepali stacks these
  // in practice. A `while (true)` here would happily strip मा off नमामा.
  for (let round = 0; round < 2; round += 1) {
    const suffix = SUFFIXES.find(
      (candidate) =>
        current.length > candidate.length &&
        current.endsWith(candidate) &&
        baseLength(current.slice(0, -candidate.length)) >= MIN_STEM_LENGTH
    );
    if (!suffix) break;
    current = current.slice(0, -suffix.length);
    if (!variants.includes(current)) variants.push(current);
    // The stem has its own spelling variants — तालहरूमा → ताल → तााल is wrong,
    // but सूचिहरू → सूचि → सूची is exactly the case we need.
    for (const variant of spellingVariants(current)) {
      if (!variants.includes(variant)) variants.push(variant);
    }
  }

  return variants.slice(0, MAX_VARIANTS);
}

/**
 * Spelling variants Nepali learners produce constantly.
 *
 * These are not typos so much as unsettled orthography — both forms are written
 * in real life, and a learner typing by ear picks whichever they know. Exact
 * substring matching treats them as different words, which has cost real
 * queries: "सूचि" found 2 rows where "सूची" has 186, and "सिंसार" found none
 * where "सिमसार" has plenty. Both fell through to general knowledge instead of
 * the bank's own material.
 *
 * Each rule is applied in both directions, so it does not matter which form the
 * learner or the content author used.
 */
const SPELLING_SWAPS: [RegExp, string][] = [
  // Anusvara vs the explicit nasal consonant: सिंसार ↔ सिमसार.
  [/ं/g, "म"],
  [/म(?=[सशषहवय])/g, "ं"],
  // Conjunct nasals commonly written either way: निकुञ्ज ↔ निकुन्ज.
  [/ञ्ज/g, "न्ज"],
  [/न्ज/g, "ञ्ज"],
  [/ञ्च/g, "न्च"],
  [/न्च/g, "ञ्च"],
  // Vowel length, which is the commonest variation of all and almost always
  // word-final: सूचि ↔ सूची, बुझ्नु ↔ बूझ्नु.
  [/ि$/, "ी"],
  [/ी$/, "ि"],
  [/ु$/, "ू"],
  [/ू$/, "ु"],
];

/** Most spellings we will try per token, to bound the query cost. */
const MAX_VARIANTS = 6;

/** Alternate spellings of one word, deduped and capped. */
function spellingVariants(word: string): string[] {
  const found: string[] = [];
  for (const [pattern, replacement] of SPELLING_SWAPS) {
    const swapped = word.replace(pattern, replacement);
    if (swapped !== word && !found.includes(swapped)) found.push(swapped);
  }
  return found;
}

export type NormalisedQuery = {
  /** The query as the learner typed it, trimmed. Shown back to them. */
  raw: string;
  /** Tokens, each a list of spellings. Empty when the query has no signal. */
  tokens: string[][];
};

/**
 * Turn raw learner input into tokens ready for search_content().
 *
 * Returns empty tokens for input that cannot usefully be searched (blank, or
 * nothing but stopwords and punctuation) so the caller can show the "type
 * something" state instead of running a query that matches everything.
 */
export function normaliseQuery(input: string): NormalisedQuery {
  const raw = (input ?? "").trim().slice(0, MAX_QUERY_LENGTH);
  if (!raw) return { raw: "", tokens: [] };

  const words = raw
    .split(SEPARATORS)
    .map((word) => word.trim())
    .filter(Boolean);

  const meaningful = words.filter(
    (word) => !STOPWORDS.has(word.toLowerCase()) && baseLength(word) >= MIN_STEM_LENGTH
  );

  // A query made entirely of stopwords ("के हो?") still deserves an attempt —
  // fall back to the raw words rather than silently returning nothing.
  const chosen = (meaningful.length > 0 ? meaningful : words)
    .filter((word) => baseLength(word) >= MIN_STEM_LENGTH)
    .slice(0, MAX_TOKENS);

  const tokens = chosen.map((word) =>
    tokenVariants(word).map(escapeLikePattern)
  );

  return { raw, tokens };
}
