export function resolveGeminiApiKey(): string {
  return (
    process.env.GEMINI_API_KEY ??
    process.env.DRISHTI_API_KEY ??
    process.env.DrishtiApiKey ??
    ""
  );
}
