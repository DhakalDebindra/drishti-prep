import { GoogleGenerativeAI } from "@google/generative-ai";
import { SystemInstructions } from "@/config/prompts/index";
import type { FewShotExample } from "@/config/prompts/index";

export type GroundingChunk = {
  web?: { uri?: string; title?: string };
};

export type GroundedProseResult = {
  text: string;
  latencyMs: number;
  groundingChunks: GroundingChunk[];
  model: string;
};

// Model IDs are env-overridable so we can A/B newer Gemini releases
// (e.g. swap `flash` to `gemini-2.5-flash-lite` for cost, or `pro` to
// `gemini-3.1-pro-preview` for a quality experiment) without a redeploy.
// Defaults stay on the GA 2.5 family for stability.
//
// DEPRECATION SCHEDULE (per https://ai.google.dev/gemini-api/docs/deprecations):
//   • gemini-2.5-flash       → shutdown Oct 16, 2026 → replace with gemini-3.5-flash
//   • gemini-2.5-pro         → shutdown Oct 16, 2026 → replace with gemini-3.1-pro-preview
//   • gemini-2.5-flash-lite  → shutdown Oct 16, 2026 → replace with gemini-3.1-flash-lite
// Plan: benchmark Nepali output quality on the 3.x replacements before
// flipping defaults. Until then, override via env at the platform level
// when you want to test individual paths.
const AIConfig = {
  providers: {
    gemini: {
      flash: process.env.GEMINI_MODEL_FLASH || "gemini-2.5-flash",
      pro: process.env.GEMINI_MODEL_PRO || "gemini-2.5-pro",
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

// Grounded prose generation with Google Search tool. Used when the answer
// hinges on facts that may be newer than the model's training cutoff
// (current officials, latest sports results, recent statistics, post-2024
// events). The model decides when to search; results are cited back via
// `groundingChunks` if you want to surface sources.
//
// Uses raw fetch because the v0.24 SDK only exposes the legacy
// `googleSearchRetrieval` field name from Gemini 1.5; Gemini 2.5 requires
// `google_search`, which only the v1beta REST endpoint accepts.
export async function generateGroundedProse(opts: {
  systemInstruction: string;
  userMessage: string;
  /** Defaults to 90s. Grounded calls are slower because Gemini executes
   *  searches mid-generation. */
  timeoutMs?: number;
  /** Defaults to 0.3 — slight creativity for natural prose, but tight
   *  enough that the grounded facts stay deterministic. */
  temperature?: number;
  /** Override model id; defaults to gemini-2.5-flash. */
  modelId?: string;
}): Promise<GroundedProseResult> {
  if (!geminiApiKey) {
    throw new Error("Missing GEMINI_API_KEY");
  }

  const started = performance.now();
  const modelId = opts.modelId ?? AIConfig.providers.gemini.flash;
  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${modelId}:generateContent?key=${geminiApiKey}`;

  const body = {
    systemInstruction: { parts: [{ text: opts.systemInstruction }] },
    contents: [{ role: "user", parts: [{ text: opts.userMessage }] }],
    tools: [{ google_search: {} }],
    generationConfig: {
      temperature: opts.temperature ?? 0.3,
    },
  };

  const res = await withTimeout(
    fetch(endpoint, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),
    opts.timeoutMs ?? 90_000,
  );

  if (!res.ok) {
    const errText = await res.text().catch(() => "");
    throw new Error(`Gemini grounded prose HTTP ${res.status}: ${errText.slice(0, 500)}`);
  }

  type Resp = {
    candidates?: Array<{
      content?: { parts?: Array<{ text?: string }> };
      groundingMetadata?: { groundingChunks?: GroundingChunk[] };
    }>;
  };
  const json = (await res.json()) as Resp;
  const candidate = json.candidates?.[0];
  const text = (candidate?.content?.parts ?? [])
    .map((p) => p.text ?? "")
    .join("")
    .trim();

  if (!text) {
    throw new Error("Gemini grounded prose returned empty text");
  }

  return {
    text,
    latencyMs: Math.round(performance.now() - started),
    groundingChunks: candidate?.groundingMetadata?.groundingChunks ?? [],
    model: modelId,
  };
}
