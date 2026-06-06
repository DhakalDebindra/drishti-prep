// Verbal names for punctuation. Braille writers need to know what symbol
// to punch — TTS engines only insert silent pauses for these characters,
// so we substitute the spoken name into the utterance.

const PUNCT_NAMES: Record<string, string> = {
  ",": "comma",
  ".": "full stop",
  "?": "question mark",
  "!": "exclamation mark",
  ";": "semicolon",
  ":": "colon",
  "—": "dash",
  "–": "dash",
  "-": "hyphen",
  "(": "open bracket",
  ")": "close bracket",
  "[": "open square bracket",
  "]": "close square bracket",
  "{": "open brace",
  "}": "close brace",
  '"': "quote",
  "'": "apostrophe",
  "’": "apostrophe",
  "‘": "apostrophe",
  "“": "open quote",
  "”": "close quote",
  "/": "slash",
  "\\": "backslash",
  "&": "ampersand",
  "%": "percent",
  "@": "at",
  "#": "hash",
  "*": "asterisk",
  "।": "danda",
  "॥": "double danda",
};

/**
 * Convert a punctuation string (possibly multi-char like "?!") to its spoken
 * form. Returns an empty string when there is nothing to announce.
 */
export function punctuationToSpoken(punct: string): string {
  if (!punct) return "";
  const names: string[] = [];
  for (const ch of punct) {
    const name = PUNCT_NAMES[ch];
    if (name) names.push(name);
    // Unknown punctuation is silently dropped — we never want to spew
    // "unknown" for typographic noise.
  }
  return names.join(" ");
}

/**
 * Build a speakable string for a single word with optional trailing
 * punctuation. The pattern "word, <punct name>" reads naturally:
 *     "Constitution, full stop"
 *     "Hello, comma"
 *     "however, semicolon"
 */
export function speakableWord(word: string, trailing: string): string {
  const spoken = punctuationToSpoken(trailing);
  if (!spoken) return word;
  return `${word}, ${spoken}`;
}
