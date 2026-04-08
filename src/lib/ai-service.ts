import { GoogleGenerativeAI } from "@google/generative-ai";
import { SystemInstructions } from "@/config/prompts";

const AIConfig = {
  providers: {
    gemini: {
      model: "gemini-2.5-flash",
      responseMimeType: "application/json",
      temperature: 0.2,
    },
  },
};

const geminiApiKey =
  process.env.GEMINI_API_KEY ??
  process.env.DRISTI_API_KEY ??
  process.env.DristiApiKey ??
  "";

const genAI = new GoogleGenerativeAI(geminiApiKey);
const REQUEST_TIMEOUT_MS = 25_000;

export const withTimeout = <T>(promise: Promise<T>, ms: number) => {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("TIMEOUT")), ms);
    promise
      .then((res) => {
        clearTimeout(timer);
        resolve(res);
      })
      .catch((err) => {
        clearTimeout(timer);
        reject(err);
      });
  });
};

export async function generateAiContentJSON(
  prompt: string,
  useStrictNepali: boolean = false
): Promise<{ data: string; provider: string; model: string; latency_ms: number }> {
  if (!geminiApiKey) {
    throw new Error("Missing GEMINI_API_KEY");
  }

  const started = performance.now();

  const finalPrompt = useStrictNepali
    ? `${prompt}\n\n${SystemInstructions.strictNepaliJson}`
    : `${prompt}\n\n${SystemInstructions.defaultJson}`;

  const model = genAI.getGenerativeModel({
    model: AIConfig.providers.gemini.model,
    generationConfig: {
      responseMimeType: AIConfig.providers.gemini.responseMimeType,
      temperature: AIConfig.providers.gemini.temperature,
    },
  });

  const result = await withTimeout(model.generateContent(finalPrompt), REQUEST_TIMEOUT_MS);
  const latencyMs = Math.round(performance.now() - started);
  const text = result.response.text();

  return {
    data: text,
    provider: "google",
    model: AIConfig.providers.gemini.model,
    latency_ms: latencyMs,
  };
}
