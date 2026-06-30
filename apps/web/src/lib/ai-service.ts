import { GoogleGenerativeAI, type ResponseSchema } from "@google/generative-ai";
import { SystemInstructions } from "@/config/prompts/index";
import type { FewShotExample } from "@/config/prompts/index";
import { resolveGeminiApiKey } from "@/lib/env-keys";

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

const geminiApiKey = resolveGeminiApiKey();

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

// Variant that enforces a `responseSchema` so the model is forced to emit a
// payload matching the declared shape. Used by Manana's script compiler.
// `systemInstruction` is passed separately from `userMessage` so the system
// instruction can be reused across calls and cached by the SDK.
export async function generateStructuredContent<T = unknown>(opts: {
  systemInstruction: string;
  userMessage: string;
  responseSchema: ResponseSchema;
  tier?: "flash" | "pro";
  temperature?: number;
  // Override the default 25s timeout. Long-form generators (Manana's 10–15 min
  // podcast script ≈ ~3000 output tokens) need 60–90s to be reliable on Flash.
  timeoutMs?: number;
}): Promise<{ data: T; raw: string; model: string; latency_ms: number }> {
  if (!geminiApiKey) {
    throw new Error("Missing GEMINI_API_KEY");
  }

  const started = performance.now();
  const modelId = AIConfig.providers.gemini[opts.tier ?? "flash"];

  const model = genAI.getGenerativeModel({
    model: modelId,
    systemInstruction: opts.systemInstruction,
    generationConfig: {
      responseMimeType: "application/json",
      responseSchema: opts.responseSchema,
      temperature: opts.temperature ?? AIConfig.providers.gemini.temperature,
    },
  });

  const result = await withTimeout(
    model.generateContent({
      contents: [{ role: "user", parts: [{ text: opts.userMessage }] }],
    }),
    opts.timeoutMs ?? REQUEST_TIMEOUT_MS,
  );
  const latencyMs = Math.round(performance.now() - started);
  const raw = result.response.text();

  let data: T;
  try {
    data = JSON.parse(raw) as T;
  } catch {
    throw new Error(`Structured response was not valid JSON: ${raw.slice(0, 200)}`);
  }

  return { data, raw, model: modelId, latency_ms: latencyMs };
}

// ─── Grounded prose generation (Google Search tool) ──────────────────────
//
// Used by Manana for the first pass of script generation: produce long-form
// Nepali prose with web search grounding so current-affairs claims can be
// verified against fresh results instead of relying on the model's training
// cutoff. The grounded prose is then reformatted into the structured
// MananaEpisodeScript schema by a second `generateStructuredContent` call —
// Gemini's structured-output mode and Google Search tool historically don't
// combine cleanly, so two passes is the safe architecture.
//
// Uses raw fetch because the v0.24 SDK only exposes `googleSearchRetrieval`
// (the legacy Gemini 1.5 field name); Gemini 2.5 requires `google_search`,
// which only the v1beta REST endpoint accepts.


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
    // Gemini 2.x search tool. Empty object is correct — tool config goes in
    // the dynamic_retrieval_config sub-object which we don't need here
    // (default behaviour: model decides when to search).
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
