import "server-only";

import { createHmac, timingSafeEqual } from "node:crypto";

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
 */

/** How long a token stays valid. Long enough to press Listen, short enough to matter. */
const MAX_AGE_MS = 60 * 60 * 1000;

/**
 * Server-only signing key. Falls back to the service role key so this works
 * without new configuration — an HMAC never reveals its key, and both values
 * are already server-only secrets.
 */
function secret(): string {
  return (
    process.env.ASK_SPEAK_SECRET ||
    process.env.SUPABASE_SERVICE_ROLE_KEY ||
    ""
  );
}

function digest(text: string, userId: string, issuedAt: number): string {
  return createHmac("sha256", secret())
    .update(`${userId}\n${issuedAt}\n${text}`)
    .digest("hex");
}

/** Token for text we just generated. Empty string when signing is unavailable. */
export function signSpeech(text: string, userId: string): string {
  if (!secret() || !text) return "";
  const issuedAt = Date.now();
  return `${issuedAt}.${digest(text, userId, issuedAt)}`;
}

/** True only for text this server signed, for this learner, within the hour. */
export function verifySpeech(text: string, userId: string, token: string): boolean {
  if (!secret() || !text || !token) return false;

  const [issuedRaw, provided] = token.split(".");
  const issuedAt = Number.parseInt(issuedRaw ?? "", 10);
  if (!Number.isFinite(issuedAt) || !provided) return false;
  if (Date.now() - issuedAt > MAX_AGE_MS) return false;

  const expected = digest(text, userId, issuedAt);
  // Compare in constant time; a length mismatch would throw, so check first.
  if (expected.length !== provided.length) return false;
  return timingSafeEqual(Buffer.from(expected), Buffer.from(provided));
}
