import { resolveGeminiApiKey } from "@/lib/env-keys";

const DEFAULT_LYRIA_MODEL = "lyria-3-clip-preview";
const REQUEST_TIMEOUT_MS = 120_000;

export type GeminiMusicOptions = {
  prompt: string;
  model?: string;
};

export async function generateGeminiInstrumentalClip(
  opts: GeminiMusicOptions,
): Promise<Buffer> {
  const key = resolveGeminiApiKey();
  if (!key) throw new Error("Missing GEMINI_API_KEY");

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);

  try {
    const res = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${opts.model ?? DEFAULT_LYRIA_MODEL}:generateContent?key=${key}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          contents: [{ parts: [{ text: opts.prompt }] }],
          generationConfig: {
            responseModalities: ["AUDIO"],
          },
        }),
        signal: controller.signal,
      },
    );

    if (!res.ok) {
      const body = await res.text().catch(() => "");
      throw new Error(`Gemini music HTTP ${res.status}: ${body.slice(0, 500)}`);
    }

    const json = (await res.json()) as {
      candidates?: Array<{
        content?: {
          parts?: Array<{
            inlineData?: {
              data?: string;
            };
          }>;
        };
      }>;
    };

    for (const part of json.candidates?.[0]?.content?.parts ?? []) {
      if (part.inlineData?.data) {
        return Buffer.from(part.inlineData.data, "base64");
      }
    }

    throw new Error("Gemini music response did not include audio inlineData");
  } catch (error) {
    if (error instanceof Error && error.name === "AbortError") {
      throw new Error(`Gemini music generation timed out after ${REQUEST_TIMEOUT_MS}ms`);
    }
    throw error;
  } finally {
    clearTimeout(timeout);
  }
}
