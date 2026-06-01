import { Prompts, QuestionSummaryItem, GKQuestion, safeParseGKExplanation, GKFacilitatorFewShot } from "@/config/prompts/index";
import { generateAiContentJSON } from "./ai-service";

export async function generateReviewFeedback(
  questionsSummary: QuestionSummaryItem[],
  scoreRaw: number,
  totalQuestions: number,
  scorePct: number
): Promise<{ data: string | null; model: string; latency_ms: number; error?: string }> {
  
  const prompt = Prompts["encouraging exam coach"](
    scoreRaw,
    totalQuestions,
    scorePct,
    questionsSummary
  );

  try {
    const result = await generateAiContentJSON(prompt);
    
    return {
      data: result.data,
      model: result.model,
      latency_ms: result.latency_ms,
    };
  } catch (error: any) {
    return {
      data: null,
      model: "error",
      latency_ms: 0,
      error: error.message || "AI generation failed",
    };
  }
}

// Flash-first with Pro escalation. ~70%+ of explanation generations come
// back clean from Flash (the few-shot examples carry most of the structural
// load); only when `safeParseGKExplanation` rejects do we re-try on Pro.
// This cuts the average per-call cost by roughly 4× without dropping the
// quality floor — Pro still answers the hard ones.
//
// Set GEMINI_EXPLANATION_FORCE_PRO=1 to bypass the Flash attempt entirely
// (useful when manually regenerating an explanation an editor flagged as
// weak from the question editor's "regenerate" button).
export async function generateExplanation(
  q: GKQuestion,
  opts: { forcePro?: boolean } = {},
): Promise<{ data: string | null; tier?: "flash" | "pro"; error?: string }> {
  const prompt = Prompts["loksewa gk facilitator"](q);
  const forcePro = opts.forcePro || process.env.GEMINI_EXPLANATION_FORCE_PRO === "1";

  if (!forcePro) {
    try {
      const flashResult = await generateAiContentJSON(prompt, true, "flash", GKFacilitatorFewShot);
      const parsed = safeParseGKExplanation(flashResult.data);
      if (parsed?.general_explanation) {
        return { data: parsed.general_explanation, tier: "flash" };
      }
      // Flash returned but failed schema validation — fall through to Pro.
    } catch {
      // Network/timeout/quota on Flash — try Pro before giving up.
    }
  }

  try {
    const proResult = await generateAiContentJSON(prompt, true, "pro", GKFacilitatorFewShot);
    const parsed = safeParseGKExplanation(proResult.data);
    return { data: parsed?.general_explanation || null, tier: "pro" };
  } catch (error: any) {
    return {
      data: null,
      tier: "pro",
      error: error.message || "AI generation failed",
    };
  }
}
