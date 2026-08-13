import "server-only";

import { resolveGeminiApiKey } from "@/lib/env-keys";
import { signWith, verifyWith } from "@/lib/ask/speech-signature";

/**
 * Proof that a piece of text is a reply DrishtiPrep generated for this learner.
 *
 * The speak endpoint used to take a message id and read the text from
 * ask_messages, so a client could never ask us to synthesise arbitrary text.
 * Chat history is no longer stored, so that anchor is gone — and simply
 * accepting text from the request body would turn Listen into an open,
 * billable text-to-speech service for anyone with an account.
 *
 * Signing keeps the guarantee without keeping the data. The token binds the
 * exact text to one learner and one hour; anything else fails verification.
 * The maths lives in speech-signature.ts so it can be unit tested — this module
 * only resolves the secret.
 */

/**
 * Server-only signing key.
 *
 * The chain exists because the first version required ASK_SPEAK_SECRET or
 * SUPABASE_SERVICE_ROLE_KEY, neither of which was set in the production
 * runtime — so every reply shipped with a blank token and Listen sat on
 * "Preparing…" forever. The Gemini key is the last resort precisely because it
 * is the one secret guaranteed present wherever this feature can work at all:
 * if it is missing there is no answer to read aloud in the first place.
 *
 * Using an API key as HMAC input is safe — an HMAC never reveals its key — but
 * set ASK_SPEAK_SECRET to keep the purposes separate.
 */
function secret(): string {
  const key =
    process.env.ASK_SPEAK_SECRET ||
    process.env.SUPABASE_SERVICE_ROLE_KEY ||
    resolveGeminiApiKey();

  if (!key) {
    // Loud, because the symptom otherwise is a Listen button that never starts.
    console.error(
      "[ask] no signing secret available — set ASK_SPEAK_SECRET; Listen will be disabled"
    );
  }
  return key;
}

/** Token for text we just generated. Empty string when signing is unavailable. */
export function signSpeech(text: string, userId: string): string {
  return signWith(secret(), text, userId);
}

/** True only for text this server signed, for this learner, within the hour. */
export function verifySpeech(text: string, userId: string, token: string): boolean {
  return verifyWith(secret(), text, userId, token);
}
