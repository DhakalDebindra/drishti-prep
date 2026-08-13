import "server-only";

import { generateAiContentJSON } from "@/lib/ai-service";
import { buildQueryRepairPrompt } from "@/config/prompts";

/**
 * Ask the model to rewrite a query that retrieval could not match.
 *
 * Only called on a miss, so the common case costs nothing. The returned terms
 * are fed back through the normal normaliser and retrieval path — this does not
 * bypass any of the grounding or access rules, it only changes the words we
 * search for.
 */
export async function repairQuery(query: string): Promise<string | null> {
  try {
    const result = await generateAiContentJSON(buildQueryRepairPrompt(query), true, "flash");
    const parsed = JSON.parse(result.data) as { terms?: unknown };

    const terms = Array.isArray(parsed.terms)
      ? parsed.terms
          .filter((term): term is string => typeof term === "string")
          .map((term) => term.trim())
          .filter(Boolean)
          .slice(0, 4)
      : [];

    if (terms.length === 0) return null;

    const repaired = terms.join(" ");
    // A rewrite identical to the input tells us nothing and would just repeat
    // the same failed search.
    return repaired.toLowerCase() === query.trim().toLowerCase() ? null : repaired;
  } catch (error) {
    console.error("[ask] query repair failed:", error);
    return null;
  }
}
