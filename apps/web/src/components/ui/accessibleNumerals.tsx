import { Fragment, type ReactNode } from "react";
import { segmentDevanagariNumerals } from "@/lib/devanagari";

/**
 * Make Devanagari numerals readable by Android screen readers.
 *
 * Android TTS engines often skip Devanagari digits (० १ २ …) entirely, so a
 * mobile TalkBack user hears silence where a number like २०८२ should be. For
 * each run of Devanagari digits we render the glyphs visually but hidden from
 * assistive tech (`aria-hidden`), paired with a visually-hidden (`sr-only`)
 * ASCII-digit copy that the screen reader announces instead. Desktop screen
 * readers read the Devanagari fine, and there the swap is inaudible/invisible.
 *
 * Strings without Devanagari digits are returned unchanged (no extra DOM), so
 * this is safe to call on every piece of rendered text.
 */
export function accessibleNumerals(text: string): ReactNode {
  const segments = segmentDevanagariNumerals(text);

  // Fast path: nothing to wrap, hand the original string straight back.
  if (segments.length === 1 && segments[0].kind === "text") {
    return text;
  }

  return segments.map((segment, i) =>
    segment.kind === "text" ? (
      <Fragment key={i}>{segment.text}</Fragment>
    ) : (
      <Fragment key={i}>
        <span aria-hidden="true">{segment.text}</span>
        <span className="sr-only">{segment.latin}</span>
      </Fragment>
    )
  );
}
