/**
 * Devanagari numeral helpers.
 *
 * Many Android text-to-speech engines (the ones TalkBack drives) silently skip
 * Devanagari digits — ० १ २ ३ ४ ५ ६ ७ ८ ९ (U+0966–U+096F). A year like २०८२
 * is simply not announced, so a mobile screen-reader user hears a gap where a
 * number should be. Desktop screen readers read them fine. To bridge the gap we
 * expose the ASCII-digit equivalent (२०८२ → "2082") to assistive tech while
 * keeping the Devanagari glyphs on screen. ASCII digits are read by every TTS
 * engine, and because the surrounding text keeps its `lang="ne"`, a Nepali voice
 * still pronounces "2082" as a Nepali number.
 *
 * These functions are pure (no React) so they can be unit tested directly; the
 * rendering wrapper lives in `components/ui/accessibleNumerals`.
 */

const DEVANAGARI_DIGITS = "०१२३४५६७८९";

/** True if the string contains at least one Devanagari digit. */
export function hasDevanagariDigits(input: string): boolean {
  return /[०-९]/.test(input);
}

/**
 * Replace every Devanagari digit with its ASCII (0-9) equivalent. Non-digit
 * characters — including separators like `,` `.` and the Devanagari letters
 * themselves — are left untouched.
 */
export function devanagariDigitsToLatin(input: string): string {
  return input.replace(/[०-९]/g, (d) => String(DEVANAGARI_DIGITS.indexOf(d)));
}

export type NumeralSegment =
  | { kind: "text"; text: string }
  | { kind: "number"; text: string; latin: string };

// A maximal run of Devanagari digits, allowing interior grouping/decimal
// separators so numbers like "२,०८२" or "२.५" stay one segment. A trailing
// separator is NOT consumed (it must sit between two digits), so sentence
// punctuation after a number — "सन् २०८२।" or "साल २०८२." — stays in the text.
const NUMBER_RUN_RE = /[०-९]+(?:[.,][०-९]+)*/g;

/**
 * Split a string into alternating plain-text and Devanagari-number segments.
 * If there are no Devanagari digits the whole string comes back as a single
 * text segment, so callers can cheaply detect the no-op case.
 */
export function segmentDevanagariNumerals(input: string): NumeralSegment[] {
  if (!hasDevanagariDigits(input)) return [{ kind: "text", text: input }];

  const segments: NumeralSegment[] = [];
  const re = new RegExp(NUMBER_RUN_RE.source, "g");
  let lastIndex = 0;
  let match: RegExpExecArray | null;

  while ((match = re.exec(input)) !== null) {
    if (match.index > lastIndex) {
      segments.push({ kind: "text", text: input.slice(lastIndex, match.index) });
    }
    segments.push({
      kind: "number",
      text: match[0],
      latin: devanagariDigitsToLatin(match[0]),
    });
    lastIndex = match.index + match[0].length;
  }

  if (lastIndex < input.length) {
    segments.push({ kind: "text", text: input.slice(lastIndex) });
  }

  return segments;
}
