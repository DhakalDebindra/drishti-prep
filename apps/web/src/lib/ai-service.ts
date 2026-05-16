import { GoogleGenerativeAI } from "@google/generative-ai";
import { SystemInstructions } from "@/config/prompts/index";
import type { FewShotExample } from "@/config/prompts/index";

const AIConfig = {
  providers: {
    gemini: {
      flash: "gemini-2.5-flash",
      pro: "gemini-2.5-pro",
      responseMimeType: "application/json",
      temperature: 0.2,
    },
  },
};

const geminiApiKey =
  process.env.GEMINI_API_KEY ??
  process.env.DRISHTI_API_KEY ??
  process.env.DrishtiApiKey ??
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
  useStrictNepali: boolean = false,
  tier: "flash" | "pro" = "flash",
  examples: FewShotExample[] = []
): Promise<{ data: string; provider: string; model: string; latency_ms: number }> {
  if (!geminiApiKey) {
    throw new Error("Missing GEMINI_API_KEY");
  }

  const started = performance.now();

  const finalPrompt = useStrictNepali
    ? `${prompt}\n\n${SystemInstructions.strictNepaliJson}`
    : `${prompt}\n\n${SystemInstructions.defaultJson}`;

  const modelId = AIConfig.providers.gemini[tier];
  const model = genAI.getGenerativeModel({
    model: modelId,
    generationConfig: {
      responseMimeType: AIConfig.providers.gemini.responseMimeType,
      temperature: AIConfig.providers.gemini.temperature,
    },
  });

  const contents = [
    ...examples.flatMap((ex) => [
      { role: "user", parts: [{ text: ex.user }] },
      { role: "model", parts: [{ text: ex.model }] },
    ]),
    { role: "user", parts: [{ text: finalPrompt }] },
  ];

  const result = await withTimeout(
    model.generateContent({ contents }),
    REQUEST_TIMEOUT_MS
  );
  const latencyMs = Math.round(performance.now() - started);
  const text = result.response.text();

  return {
    data: text,
    provider: "google",
    model: modelId,
    latency_ms: latencyMs,
  };
}
