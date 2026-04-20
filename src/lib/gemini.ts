import { Prompts, QuestionSummaryItem, GKQuestion, safeParseGKExplanation } from "@/config/prompts/index";
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

export async function generateExplanation(
  q: GKQuestion
): Promise<{ data: string | null; error?: string }> {
  const prompt = Prompts["loksewa gk facilitator"](q);

  try {
    const result = await generateAiContentJSON(prompt);
    const parsed = safeParseGKExplanation(result.data);
    
    return {
      data: parsed?.general_explanation || null,
    };
  } catch (error: any) {
    return {
      data: null,
      error: error.message || "AI generation failed",
    };
  }
}
