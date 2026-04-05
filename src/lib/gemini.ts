import { Prompts } from "@/config/prompts";
import { generateAiContentJSON } from "./ai-service";

export type GeminiFeedbackResponse = {
  strengths: string | null;
  weakZones: Record<string, unknown> | string[] | null;
  explanations: Record<string, string> | null;
};

export async function generateReviewFeedback(
  questionsSummary: any,
  scoreRaw: number,
  totalQuestions: number,
  scorePct: number
): Promise<{ feedback: GeminiFeedbackResponse | null; model: string; latency_ms: number; error?: string }> {
  
  const prompt = Prompts["encouraging exam coach"](
    scoreRaw,
    totalQuestions,
    scorePct,
    questionsSummary
  );

  try {
    const result = await generateAiContentJSON(prompt);
    
    let parsed: GeminiFeedbackResponse | null = null;
    try {
      parsed = JSON.parse(result.data);
    } catch {
      parsed = null;
    }
    return {
      feedback: parsed,
      model: result.model,
      latency_ms: result.latency_ms,
    };
  } catch (error: any) {
    return {
      feedback: null,
      model: "error",
      latency_ms: 0,
      error: error.message || "AI generation failed",
    };
  }
}
