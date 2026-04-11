import { Prompts, QuestionSummaryItem } from "@/config/prompts/index";
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
