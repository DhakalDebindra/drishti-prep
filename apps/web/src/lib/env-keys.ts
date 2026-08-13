/**
 * Gemini API keys, in the order they should be tried.
 *
 * The default key is on the free tier: 20 generate_content requests per day per
 * model. That is exhausted by a single afternoon of testing, after which every
 * lesson fails with a 429 — so a second key is the difference between a feature
 * that works and one that works until lunchtime.
 *
 * Add GEMINI_API_KEY_FALLBACK (or the legacy DRISHTI_API_KEY) with a billed key
 * and the AI layer will fail over to it automatically on quota errors.
 */
export function resolveGeminiApiKeys(): string[] {
  const candidates = [
    process.env.GEMINI_API_KEY,
    process.env.GEMINI_API_KEY_FALLBACK,
    process.env.DRISHTI_API_KEY,
    process.env.DrishtiApiKey,
  ];

  const seen = new Set<string>();
  const keys: string[] = [];
  for (const candidate of candidates) {
    const key = candidate?.trim();
    if (!key || seen.has(key)) continue;
    seen.add(key);
    keys.push(key);
  }
  return keys;
}

/**
 * The primary key. Kept for callers that only need one and do not implement
 * failover (TTS, batch scripts).
 */
export function resolveGeminiApiKey(): string {
  return resolveGeminiApiKeys()[0] ?? "";
}
