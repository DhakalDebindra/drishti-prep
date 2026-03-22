import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey =
  process.env.GEMINI_API_KEY ??
  process.env.DRISTI_API_KEY ??
  process.env.DristiApiKey ??
  "";

// Initialize the Gemini API client
const genAI = new GoogleGenerativeAI(apiKey);

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
  if (!apiKey) {
    return {
      feedback: null,
      model: "gemini-2.0-flash",
      latency_ms: 0,
      error: "AI key not configured",
    };
  }

  const model = genAI.getGenerativeModel({
    model: "gemini-2.0-flash",
    generationConfig: {
      responseMimeType: "application/json",
      temperature: 0.2,
    },
  });

  const prompt = `You are an encouraging exam coach for Nepali civil service prep. The learner just finished a multiple-choice set.
Score: ${scoreRaw}/${totalQuestions} (${scorePct.toFixed(1)}%).
Questions summary (JSON): ${JSON.stringify(questionsSummary, null, 2)}

Return JSON exactly as follows:
{
  "strengths": "1-2 sentences celebrating what went well.",
  "weakZones": ["array of 1-3 short pointers on what to review (cite question_id when relevant)"],
  "explanations": {"question_id_1": "short plain-text explanation (2-3 sentences, screen-reader friendly)", "question_id_2": "..."}
}`;

  const started = performance.now();
  try {
    const result = await model.generateContent(prompt);
    const latency_ms = Math.round(performance.now() - started);
    const text = result.response.text();
    let parsed: GeminiFeedbackResponse | null = null;
    try {
      parsed = JSON.parse(text);
    } catch {
      parsed = null;
    }
    return {
      feedback: parsed,
      model: "gemini-2.0-flash",
      latency_ms,
    };
  } catch (error: any) {
    const latency_ms = Math.round(performance.now() - started);
    return {
      feedback: null,
      model: "gemini-2.0-flash",
      latency_ms,
      error: error.message || "AI generation failed",
    };
  }
}
