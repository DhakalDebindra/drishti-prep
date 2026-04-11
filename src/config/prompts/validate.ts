import { CoachFeedback, GKExplanation } from "./types";

/**
 * Clean common AI output issues (markdown fences, whitespace)
 */
function cleanJsonResponse(raw: string): string {
  let cleaned = raw.trim();
  // Remove markdown fences
  if (cleaned.startsWith("```")) {
    cleaned = cleaned.replace(/^```json\s*/i, "").replace(/^```\s*/i, "");
    cleaned = cleaned.replace(/```$/, "").trim();
  }
  // Find the first { and last }
  const first = cleaned.indexOf("{");
  const last = cleaned.lastIndexOf("}");
  if (first !== -1 && last !== -1 && last > first) {
    cleaned = cleaned.slice(first, last + 1);
  }

  // Remove trailing commas in objects and arrays to prevent JSON.parse errors
  cleaned = cleaned.replace(/,\s*([\]}])/g, "$1");

  return cleaned;
}

/**
 * Strict Parse for Coach Feedback
 */
export function parseCoachFeedback(raw: string): CoachFeedback {
  const cleaned = cleanJsonResponse(raw);
  const parsed = JSON.parse(cleaned);

  const strengths = (parsed.strengths || parsed.strength || "").trim();
  const weakZones = (parsed.weakZones || parsed.weak_zones || parsed.weak_points || []);

  if (!strengths) {
    throw new Error("Missing or invalid 'strengths' field");
  }
  if (!Array.isArray(weakZones)) {
    throw new Error("Missing or invalid 'weakZones' field");
  }

  return {
    strengths,
    weakZones: weakZones.map(String).slice(0, 3), // Ensure max 3 as per plan
  };
}

/**
 * Safe Parse for Coach Feedback
 */
export function safeParseCoachFeedback(raw: string): CoachFeedback | null {
  try {
    return parseCoachFeedback(raw);
  } catch (error) {
    console.error("[SafeParseCoachFeedback Error]:", error);
    return null;
  }
}

/**
 * Strict Parse for GK Explanation
 */
export function parseGKExplanation(raw: string): GKExplanation {
  const cleaned = cleanJsonResponse(raw);
  const parsed = JSON.parse(cleaned);

  const explanation = (parsed.general_explanation || parsed.explanation || "").trim();
  if (!explanation) {
    throw new Error("Missing or empty explanation field");
  }

  return {
    general_explanation: explanation,
  };
}

/**
 * Safe Parse for GK Explanation
 */
export function safeParseGKExplanation(raw: string): GKExplanation | null {
  try {
    return parseGKExplanation(raw);
  } catch (error) {
    console.error("[SafeParseGKExplanation Error]:", error);
    return null;
  }
}
