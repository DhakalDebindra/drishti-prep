import { normalizeJson } from "./normalizeJson";

export const parseExplanation = (raw: string): { text: string; parseError: boolean } => {
  const cleaned = normalizeJson(raw);
  if (!cleaned) return { text: raw?.trim() ?? "", parseError: true };
  try {
    const parsed = JSON.parse(cleaned);
    const text =
      (parsed.general_explanation || parsed.explanation || "").trim();
    if (text) return { text, parseError: false };
  } catch {
    // fall through
  }
  return { text: cleaned.trim() || raw.trim(), parseError: true };
};
