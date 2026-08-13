import { createHmac, timingSafeEqual } from "node:crypto";

/**
 * The signing maths for lesson playback, with no environment access.
 *
 * Split out from speech-token.ts purely so it can be tested: that module is
 * marked `server-only`, which throws under a plain Node test runner. Keeping
 * the algorithm here means the security-relevant part — what counts as a valid
 * token — is covered by tests, while the module that reads secrets stays
 * server-bound.
 */

/** How long a token stays valid. Long enough to press Listen, short enough to matter. */
export const MAX_TOKEN_AGE_MS = 60 * 60 * 1000;

function digest(secret: string, text: string, userId: string, issuedAt: number): string {
  return createHmac("sha256", secret)
    .update(`${userId}\n${issuedAt}\n${text}`)
    .digest("hex");
}

/** Token for text we generated. Empty when there is no secret or no text. */
export function signWith(secret: string, text: string, userId: string): string {
  if (!secret || !text) return "";
  const issuedAt = Date.now();
  return `${issuedAt}.${digest(secret, text, userId, issuedAt)}`;
}

/** True only for text signed with this secret, for this learner, within the window. */
export function verifyWith(
  secret: string,
  text: string,
  userId: string,
  token: string
): boolean {
  if (!secret || !text || !token) return false;

  const [issuedRaw, provided] = token.split(".");
  const issuedAt = Number.parseInt(issuedRaw ?? "", 10);
  if (!Number.isFinite(issuedAt) || !provided) return false;
  if (Date.now() - issuedAt > MAX_TOKEN_AGE_MS) return false;

  const expected = digest(secret, text, userId, issuedAt);
  // Constant-time compare; a length mismatch would throw, so check that first.
  if (expected.length !== provided.length) return false;
  return timingSafeEqual(Buffer.from(expected), Buffer.from(provided));
}
