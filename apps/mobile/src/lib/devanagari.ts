/**
 * Devanagari numeral helpers (mobile).
 *
 * Many Android text-to-speech engines (the ones TalkBack drives) silently skip
 * Devanagari digits — ० १ २ ३ ४ ५ ६ ७ ८ ९ (U+0966–U+096F). A year like २०८२
 * is simply not announced, so a screen-reader user hears a gap where a number
 * should be. To bridge the gap we expose the ASCII-digit equivalent
 * (२०८२ → "2082") to assistive tech while keeping the Devanagari glyphs on
 * screen — in React Native that means setting `accessibilityLabel` to the
 * Latin-converted copy while the visible <Text> children stay Devanagari.
 *
 * Ported verbatim from the web app's pure helpers (apps/web/src/lib/devanagari.ts).
 * Kept as a local copy so the mobile dependency surface stays unchanged; can be
 * promoted to @repo/utils later if web + mobile want a single source of truth.
 */

const DEVANAGARI_DIGITS = '०१२३४५६७८९'

/** True if the string contains at least one Devanagari digit. */
export function hasDevanagariDigits(input: string): boolean {
  return /[०-९]/.test(input)
}

/**
 * Replace every Devanagari digit with its ASCII (0-9) equivalent. Non-digit
 * characters — including the Devanagari letters themselves — are left untouched.
 */
export function devanagariDigitsToLatin(input: string): string {
  return input.replace(/[०-९]/g, (d) => String(DEVANAGARI_DIGITS.indexOf(d)))
}

/**
 * Build a screen-reader-friendly version of a label: Devanagari digits become
 * Latin so Android TTS announces them. Safe to call on any string (no-op when
 * there are no Devanagari digits). Use when composing concatenated
 * `accessibilityLabel`s (e.g. "Option A: ...").
 */
export function toLatinNumerals(input: string): string {
  return hasDevanagariDigits(input) ? devanagariDigitsToLatin(input) : input
}
