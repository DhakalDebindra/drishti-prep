import { SmallTalkCopy } from "@/config/copy";

/**
 * Cheap, model-free triage of what a learner just typed.
 *
 * Greetings and one-word pleasantries do not deserve a retrieval pass, a model
 * call, or a "we have no content on this" — all three read as broken. They
 * deserve one warm line and a nudge toward something askable.
 */

const GREETINGS = [
  "नमस्ते",
  "नमस्कार",
  "हेलो",
  "हाई",
  "स्वागत",
  "के छ",
  "कस्तो छ",
  "hi",
  "hello",
  "hey",
  "namaste",
  "namaskar",
  "good morning",
  "good evening",
  "good afternoon",
];

const THANKS = ["धन्यवाद", "थ्याङ्क", "thanks", "thank you", "ok", "ठिक छ", "हुन्छ"];

/** Strip punctuation and case so "Namaste!!" matches "namaste". */
function simplify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[!?.,;:।॥"'`()\[\]{}]/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

export type SmallTalk = "greeting" | "thanks" | null;

/**
 * Only classifies as small talk when that is essentially the whole message.
 * "नमस्ते, संविधान बुझाउनुहोस्" is a real question with a polite opener, and
 * must go down the normal path.
 */
export function detectSmallTalk(query: string): SmallTalk {
  const simplified = simplify(query);
  if (!simplified) return null;
  if (simplified.split(" ").length > 4) return null;

  if (GREETINGS.some((word) => simplified === word || simplified.startsWith(`${word} `))) {
    // A greeting followed by real words is a question, not a greeting.
    const remainder = GREETINGS.reduce(
      (rest, word) => (rest.startsWith(word) ? rest.slice(word.length).trim() : rest),
      simplified
    );
    return remainder.length === 0 ? "greeting" : null;
  }

  if (THANKS.some((word) => simplified === word)) return "thanks";

  return null;
}

/**
 * Wording lives in the copy file so it can be edited without touching this
 * detection logic. See config/copy/user/ask-small-talk.ts.
 */
export const SMALL_TALK_REPLY: Record<Exclude<SmallTalk, null>, string> =
  SmallTalkCopy;
