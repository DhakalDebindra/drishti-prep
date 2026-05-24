// chunkDocument: turn normalized text into a DictationDocument.
// Deterministic. Gemini-assisted Nepali segmentation can replace the
// sentence-splitter step later via a transform; this is the regex baseline.

import {
  CHUNK_VERSION,
  DictationDocument,
  NORMALIZATION_VERSION,
  Paragraph,
  Sentence,
  SourceType,
  SpellToken,
} from "./types";
import { detectLanguage, hashText, normalizeText } from "./normalizeText";

const ABBREVIATIONS = new Set([
  "dr", "mr", "mrs", "ms", "prof", "sr", "jr",
  "vs", "etc", "e.g", "i.e",
  "b.s", "a.d", "b.c", "no", "fig", "sec", "art",
]);

const SOFT_SPLIT_THRESHOLD_WORDS = 25;
const HARD_SENTENCE_LIMIT_WORDS = 40;

export interface ChunkOptions {
  id: string;
  title: string;
  sourceType: SourceType;
  averageOcrConfidence?: number;
  geminiCleanedText?: string;
}

export interface ValidationIssue {
  code: string;
  message: string;
}

export interface ChunkResult {
  doc: DictationDocument;
  issues: ValidationIssue[];
}

export function chunkDocument(rawInput: string, opts: ChunkOptions): ChunkResult {
  const rawText = rawInput;
  const normalizedText = normalizeText(rawText);

  const paragraphsText = normalizedText
    .split(/\n{2,}/)
    .map((p) => p.replace(/\n/g, " ").trim())
    .filter(Boolean);

  const paragraphs: Paragraph[] = [];
  let globalIndex = 0;
  const sentenceCharRanges: Array<[number, number]> = [];
  let cursor = 0;

  for (let pIdx = 0; pIdx < paragraphsText.length; pIdx++) {
    const sentenceTexts = splitSentences(paragraphsText[pIdx]);
    const sentences: Sentence[] = sentenceTexts.map((text, localIndex) => {
      const { words, trailingPunct } = tokenizeWordsWithPunctuation(text);
      const start = normalizedText.indexOf(text, cursor);
      const end = start >= 0 ? start + text.length : cursor + text.length;
      if (start >= 0) cursor = end;
      sentenceCharRanges.push([start >= 0 ? start : -1, end]);
      const spokenText = expandNumbersAndAbbreviations(text);
      const spokenWordCount = spokenText.trim().split(/\s+/).filter(Boolean).length;
      return {
        globalIndex: globalIndex++,
        localIndex,
        paragraphIndex: pIdx,
        text,
        displayText: text,
        spokenText,
        spokenWordCount,
        words,
        trailingPunct,
        charCount: text.length,
      };
    });
    paragraphs.push({ index: pIdx, sentences });
  }

  const ttsReadyText = expandNumbersAndAbbreviations(normalizedText);
  const spellingTokens = buildSpellingTokens(paragraphs);
  const language = detectLanguage(normalizedText);
  const totalWords = paragraphs.reduce(
    (acc, p) => acc + p.sentences.reduce((a, s) => a + s.words.length, 0),
    0,
  );
  const totalSentences = globalIndex;

  // Medium pace = 120 wpm.
  const estimatedDurationSec = Math.round((totalWords / 120) * 60);

  const issues = validateChunking({
    rawText,
    normalizedText,
    paragraphsBefore: paragraphsText.length,
    paragraphs,
  });

  const doc: DictationDocument = {
    metadata: {
      id: opts.id,
      title: opts.title,
      sourceType: opts.sourceType,
      language,
      createdAt: new Date().toISOString(),
      estimatedDurationSec,
      averageOcrConfidence: opts.averageOcrConfidence,
      geminiCleaned: Boolean(opts.geminiCleanedText),
      preprocessing: {
        rawHash: hashText(rawText),
        normalizedHash: hashText(normalizedText),
        geminiHash: opts.geminiCleanedText ? hashText(opts.geminiCleanedText) : undefined,
        chunkVersion: CHUNK_VERSION,
        normalizationVersion: NORMALIZATION_VERSION,
      },
    },
    rawText,
    normalizedText,
    geminiCleanedText: opts.geminiCleanedText,
    ttsReadyText,
    chunks: { paragraphs },
    spellingTokens,
    progressMap: {
      totalSentences,
      totalWords,
      sentenceCharRanges,
    },
  };

  return { doc, issues };
}

// --- sentence splitting -----------------------------------------------------

function splitSentences(paragraph: string): string[] {
  const trimmed = paragraph.trim();
  if (!trimmed) return [];

  // Split on runs of terminator characters (.?!।॥), KEEPING the terminator
  // tokens so each sentence carries its own punctuation. The previous
  // implementation used a regex that only matched terminator-trailed
  // segments; text without any terminator (or text whose final sentence
  // lacked one) silently collapsed to just the trailing word. That's the
  // bug behind "only the last word played, then end of document" on
  // Nepali text without a final danda.
  const tokens = trimmed.split(/([.?!।॥]+)/).filter((t) => t !== "");

  const out: string[] = [];
  let buffer = "";

  const flush = () => {
    const candidate = buffer.replace(/\s+/g, " ").trim();
    buffer = "";
    if (!candidate) return;
    if (countWords(candidate) > SOFT_SPLIT_THRESHOLD_WORDS) {
      out.push(...softSplitLong(candidate));
    } else {
      out.push(candidate);
    }
  };

  for (const t of tokens) {
    buffer += t;
    const isTerminator = /^[.?!।॥]+$/.test(t);
    if (!isTerminator) continue;

    const candidate = buffer.replace(/\s+/g, " ").trim();
    if (endsWithAbbreviation(candidate)) {
      // Don't end the sentence — keep buffering past abbreviations
      // like "Dr.", "B.S.", "etc.". Ensure a separator before the
      // next token so words stay distinct after collapse.
      if (!buffer.endsWith(" ")) buffer += " ";
      continue;
    }
    flush();
  }

  // Final tail — captures the trailing fragment of any input that did
  // not end with a terminator (very common in pasted Nepali snippets).
  flush();

  return out;
}

function endsWithAbbreviation(s: string): boolean {
  const m = s.match(/(\b[\w.]+)\.\s*$/);
  if (!m) return false;
  const word = m[1].toLowerCase().replace(/\.$/, "");
  if (ABBREVIATIONS.has(word)) return true;
  // Single-letter words ending with a dot are almost always initials
  // ("K. Adhikari") or parts of multi-letter abbreviations split mid-stream
  // by the sentence regex (the "B" half of "B.S."). Treating them as
  // abbreviations lets the buffer keep accumulating instead of producing a
  // spurious sentence break.
  if (/^[a-z]$/.test(word)) return true;
  return false;
}

function softSplitLong(sentence: string): string[] {
  // Soft-split on , ; — preserving punctuation.
  const parts = sentence.split(/([,;—])\s+/);
  const merged: string[] = [];
  for (let i = 0; i < parts.length; i += 2) {
    const chunk = (parts[i] + (parts[i + 1] ?? "")).trim();
    if (chunk) merged.push(chunk);
  }
  // Fall back if soft-split produced nothing useful.
  if (merged.length <= 1) return [sentence];
  return merged;
}

function countWords(s: string): number {
  return s.trim().split(/\s+/).filter(Boolean).length;
}

// --- tokenization -----------------------------------------------------------

function tokenizeWords(sentence: string): string[] {
  // Words = runs of letters/digits across Latin + Devanagari, preserving case.
  // We optionally allow internal punctuation (hyphens, dots, commas, @, etc.) 
  // as long as the word both starts and ends with an alphanumeric character.
  // This keeps "1.1.1.1", "10,000", and "user@domain.com" together.
  const matches = sentence.match(/[\p{L}\p{N}](?:[\p{L}\p{M}\p{N}'’\-.,@&/]*[\p{L}\p{M}\p{N}])?/gu);
  return matches ?? [];
}

// Pull each word out together with whatever punctuation followed it in the
// source. Braille writers need this so they know to punch a comma, full
// stop, semicolon, etc. between words.
const WORD_WITH_PUNCT_RX = /([\p{L}\p{N}](?:[\p{L}\p{M}\p{N}'’\-.,@&/]*[\p{L}\p{M}\p{N}])?)([^\p{L}\p{N}\s]*)/gu;
function tokenizeWordsWithPunctuation(sentence: string): {
  words: string[];
  trailingPunct: string[];
} {
  const words: string[] = [];
  const trailingPunct: string[] = [];
  WORD_WITH_PUNCT_RX.lastIndex = 0;
  let match: RegExpExecArray | null;
  while ((match = WORD_WITH_PUNCT_RX.exec(sentence)) !== null) {
    const word = match[1];
    if (!word) continue;
    words.push(word);
    // Keep only punctuation chars from the trail; strip spaces and anything
    // attached we don't care about.
    const trail = (match[2] ?? "").replace(/\s+/g, "");
    trailingPunct.push(trail);
  }
  return { words, trailingPunct };
}

// --- spelling tokens --------------------------------------------------------

function buildSpellingTokens(paragraphs: Paragraph[]): Record<string, SpellToken[]> {
  const out: Record<string, SpellToken[]> = {};
  for (const p of paragraphs) {
    for (const s of p.sentences) {
      for (const w of s.words) {
        if (out[w]) continue;
        out[w] = spellWord(w);
      }
    }
  }
  return out;
}

function spellWord(word: string): SpellToken[] {
  if (/\p{Script=Devanagari}/u.test(word)) {
    // Devanagari: split into aksharas. A cluster = base + (vowel signs / virama /
    // nukta / candrabindu / anusvara / visarga). Range U+0900–U+097F:
    //   vowel signs: U+093A–U+094F (includes ा े ी ु ू ो ौ ै ॅ ॆ ॉ ॊ ्)
    //   nukta U+093C, candrabindu U+0901, anusvara U+0902, visarga U+0903
    const combining = /[ऺ-ॏ़ँंः॑-॔ॢॣ]/;
    const tokens: SpellToken[] = [];
    let i = 0;
    while (i < word.length) {
      let j = i + 1;
      while (j < word.length && combining.test(word[j])) j++;
      tokens.push({ unit: word.slice(i, j) });
      i = j;
    }
    return tokens;
  }
  return Array.from(word).map((ch) => ({ unit: ch }));
}

// --- number / abbreviation expansion ---------------------------------------

export function expandNumbersAndAbbreviations(text: string): string {
  let s = text;
  // Tolerate any whitespace between letters of the abbreviation — the
  // sentence chunker re-joins through a space when buffering, so "B.S."
  // in the source can arrive here as "B. S." after the chunker round-trip.
  s = s.replace(/\bB\.\s*S\.\s*(\d{4})/g, "Bikram Sambat $1");
  s = s.replace(/\bA\.\s*D\.\s*(\d{4})/g, "Anno Domini $1");
  s = s.replace(/\bB\.\s*C\.\s*(\d{4})/g, "Before Christ $1");
  s = s.replace(/\be\.\s*g\./gi, "for example");
  s = s.replace(/\bi\.\s*e\./gi, "that is");
  s = s.replace(/\betc\./gi, "etcetera");
  // Note: Devanagari digits and standalone numerals are intentionally left
  // unexpanded — Gemini Nepali TTS pronounces them naturally as words
  // ("२०७२" → "दुई हजार बहत्तर"). Pre-expansion would over-anglicize them.
  return s;
}

// --- validation gate --------------------------------------------------------

interface ValidationInput {
  rawText: string;
  normalizedText: string;
  paragraphsBefore: number;
  paragraphs: Paragraph[];
}

export function validateChunking(input: ValidationInput): ValidationIssue[] {
  const issues: ValidationIssue[] = [];

  const allSentences = input.paragraphs.flatMap((p) => p.sentences);

  if (input.normalizedText.length > 0 && allSentences.length === 0) {
    issues.push({ code: "no_sentences", message: "Chunker produced zero sentences." });
  }

  for (const s of allSentences) {
    if (!s.text.trim()) {
      issues.push({ code: "empty_sentence", message: `Empty sentence at global ${s.globalIndex}` });
    }
    if (s.words.length > HARD_SENTENCE_LIMIT_WORDS) {
      issues.push({
        code: "oversize_sentence",
        message: `Sentence ${s.globalIndex} has ${s.words.length} words (>${HARD_SENTENCE_LIMIT_WORDS}).`,
      });
    }
  }

  const reassembledLen = allSentences.reduce((a, s) => a + s.text.length, 0);
  const normalizedLen = input.normalizedText.replace(/\s+/g, "").length;
  const reassembledStripped = allSentences
    .map((s) => s.text.replace(/\s+/g, ""))
    .join("").length;
  if (normalizedLen > 0) {
    const drift = Math.abs(reassembledStripped - normalizedLen) / normalizedLen;
    if (drift > 0.02) {
      issues.push({
        code: "char_drift",
        message: `Character preservation drift ${(drift * 100).toFixed(2)}% exceeds 2%.`,
      });
    }
  }

  if (input.paragraphs.length !== input.paragraphsBefore) {
    issues.push({
      code: "paragraph_count_mismatch",
      message: `Paragraph count changed: ${input.paragraphsBefore} → ${input.paragraphs.length}`,
    });
  }

  // Suppress unused-variable warning for reassembledLen while keeping it for diagnostics.
  void reassembledLen;

  return issues;
}
