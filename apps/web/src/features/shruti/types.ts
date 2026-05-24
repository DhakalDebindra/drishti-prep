// Canonical document model for Shruti Dictation.
// All input sources (paste, PDF, image, library) converge to DictationDocument.

export type SourceType = "paste" | "pdf" | "image" | "library";
export type DocLanguage = "en" | "ne" | "mixed";

export interface PreprocessingMeta {
  rawHash: string;
  normalizedHash: string;
  geminiHash?: string;
  chunkVersion: number;
  normalizationVersion: number;
}

export interface DocumentMetadata {
  id: string;
  title: string;
  sourceType: SourceType;
  language: DocLanguage;
  createdAt: string;
  estimatedDurationSec: number;
  averageOcrConfidence?: number;
  geminiCleaned: boolean;
  preprocessing: PreprocessingMeta;
}

export interface SpellToken {
  unit: string;
  ttsHint?: string;
}

export interface Sentence {
  globalIndex: number;
  localIndex: number;
  paragraphIndex: number;
  text: string;            // visible/raw text for preview
  displayText: string;     // original-cased for preview pane
  /**
   * Text Shruti will actually SPEAK after number/abbreviation expansion.
   * Differs from `text` for sentences containing "B.S. 2065", "Dr.",
   * "e.g.", "etc." — these get expanded so the listener hears the full
   * spoken form, not letter-by-letter.
   *
   * All downstream timing calculations (auto-advance pause windows,
   * duration estimates) use this, not `text` — otherwise a four-word
   * raw sentence that expands to twelve spoken words gets an
   * inappropriately short writing pause.
   */
  spokenText: string;
  /** Word count of spokenText, pre-computed for cheap pause math. */
  spokenWordCount: number;
  words: string[];         // bare words (for spelling, indexing)
  /**
   * Punctuation that immediately followed each word in the source. Same
   * length as `words`. Empty string if no trailing punctuation.
   */
  trailingPunct: string[];
  charCount: number;
}

export interface Paragraph {
  index: number;
  sentences: Sentence[];
}

export interface DictationDocument {
  metadata: DocumentMetadata;
  rawText: string;
  normalizedText: string;
  geminiCleanedText?: string;
  ttsReadyText: string;
  chunks: { paragraphs: Paragraph[] };
  spellingTokens: Record<string, SpellToken[]>;
  progressMap: {
    totalSentences: number;
    totalWords: number;
    sentenceCharRanges: Array<[number, number]>;
  };
}

export const NORMALIZATION_VERSION = 1;
export const CHUNK_VERSION = 1;
