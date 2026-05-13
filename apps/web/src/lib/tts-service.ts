import { createHash } from "node:crypto";

const MODEL = "gemini-2.5-flash-preview-tts";
const REQUEST_TIMEOUT_MS = 30_000;

// PCM L16 24kHz mono — the only format Gemini TTS currently emits.
const SAMPLE_RATE = 24_000;
const NUM_CHANNELS = 1;
const BITS_PER_SAMPLE = 16;

export const TUTOR_VOICES = ["Kore", "Orus", "Sulafat"] as const;
export type TutorVoice = (typeof TUTOR_VOICES)[number];

export type Segment = "stem" | "opt_a" | "opt_b" | "opt_c" | "opt_d" | "explanation";
export const SEGMENTS: Segment[] = ["stem", "opt_a", "opt_b", "opt_c", "opt_d", "explanation"];

export type SynthesizeResult = {
  wav: Buffer;
  durationMs: number;
  latencyMs: number;
  // Approximate token usage (Gemini bills audio output by tokens; ~32 tokens/sec at 24kHz).
  approxTokens: number;
};

function wavHeader(dataLen: number): Buffer {
  const byteRate = (SAMPLE_RATE * NUM_CHANNELS * BITS_PER_SAMPLE) / 8;
  const blockAlign = (NUM_CHANNELS * BITS_PER_SAMPLE) / 8;
  const b = Buffer.alloc(44);
  b.write("RIFF", 0);
  b.writeUInt32LE(36 + dataLen, 4);
  b.write("WAVE", 8);
  b.write("fmt ", 12);
  b.writeUInt32LE(16, 16);
  b.writeUInt16LE(1, 20);
  b.writeUInt16LE(NUM_CHANNELS, 22);
  b.writeUInt32LE(SAMPLE_RATE, 24);
  b.writeUInt32LE(byteRate, 28);
  b.writeUInt16LE(blockAlign, 32);
  b.writeUInt16LE(BITS_PER_SAMPLE, 34);
  b.write("data", 36);
  b.writeUInt32LE(dataLen, 40);
  return b;
}

function withTimeout<T>(p: Promise<T>, ms: number): Promise<T> {
  return new Promise((resolve, reject) => {
    const t = setTimeout(() => reject(new Error("TIMEOUT")), ms);
    p.then(
      (v) => {
        clearTimeout(t);
        resolve(v);
      },
      (e) => {
        clearTimeout(t);
        reject(e);
      }
    );
  });
}

/**
 * Synthesize a chunk of Nepali text to a WAV buffer using Gemini TTS.
 *
 * Uses the REST API directly because the legacy `@google/generative-ai` SDK
 * (v0.24, still installed) does not expose the `responseModalities: ['AUDIO']`
 * field required for audio output. Switching SDKs only for this one call would
 * pull a large new dep; the REST shape is small enough to inline.
 */
export async function synthesizeNepali(
  text: string,
  voice: TutorVoice
): Promise<SynthesizeResult> {
  const key =
    process.env.GEMINI_API_KEY ??
    process.env.DRISHTI_API_KEY ??
    process.env.DrishtiApiKey;
  if (!key) throw new Error("Missing GEMINI_API_KEY");

  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent?key=${key}`;
  const body = {
    contents: [{ parts: [{ text }] }],
    generationConfig: {
      responseModalities: ["AUDIO"],
      speechConfig: {
        voiceConfig: { prebuiltVoiceConfig: { voiceName: voice } },
      },
    },
  };

  const t0 = performance.now();
  const res = await withTimeout(
    fetch(endpoint, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    }),
    REQUEST_TIMEOUT_MS
  );
  const latencyMs = Math.round(performance.now() - t0);

  if (!res.ok) {
    const errText = await res.text().catch(() => "");
    throw new Error(`Gemini TTS HTTP ${res.status}: ${errText.slice(0, 500)}`);
  }

  const json = (await res.json()) as {
    candidates?: Array<{ content?: { parts?: Array<{ inlineData?: { data?: string } }> } }>;
  };
  const b64 = json.candidates?.[0]?.content?.parts?.[0]?.inlineData?.data;
  if (!b64) {
    throw new Error("Gemini TTS response missing inlineData");
  }

  const pcm = Buffer.from(b64, "base64");
  const wav = Buffer.concat([wavHeader(pcm.length), pcm]);
  const durationMs = Math.round(
    (pcm.length / ((SAMPLE_RATE * NUM_CHANNELS * BITS_PER_SAMPLE) / 8)) * 1000
  );
  const approxTokens = Math.round((durationMs / 1000) * 32);

  return { wav, durationMs, latencyMs, approxTokens };
}

/**
 * Deterministic voice assignment from question.id.
 * Same question → same voice forever, so users build familiarity with each
 * tutor across attempts. Hash distribution across 3 voices should be ~even
 * over thousands of questions.
 */
export function voiceFor(questionId: string): TutorVoice {
  const h = createHash("sha1").update(questionId).digest();
  const idx = h[0] % TUTOR_VOICES.length;
  return TUTOR_VOICES[idx];
}

/**
 * Cost in micro-USD given an approximate token count.
 * Gemini 2.5 Flash TTS output: $10 / 1M tokens (preview pricing, May 2026).
 */
export function tokensToMicroUsd(tokens: number): number {
  return Math.round((tokens * 10) / 1); // 10 USD/M = 10 micro-USD/token
}

/**
 * Produce the spoken script for a given segment.
 *
 * Option labels are read aloud as Nepali letters क/ख/ग/घ (the convention in
 * Nepali exam papers) even though the UI displays A/B/C/D. Question/option
 * announcements use plain Devanagari punctuation (।) so the TTS pacing is
 * natural.
 */
export function scriptFor(
  segment: Segment,
  q: {
    content: string;
    option_a: string;
    option_b: string;
    option_c: string;
    option_d: string;
    explanation: string | null;
    correct_option: string;
  }
): string {
  switch (segment) {
    case "stem":
      return q.content;
    case "opt_a":
      return `विकल्प क। ${q.option_a}।`;
    case "opt_b":
      return `विकल्प ख। ${q.option_b}।`;
    case "opt_c":
      return `विकल्प ग। ${q.option_c}।`;
    case "opt_d":
      return `विकल्प घ। ${q.option_d}।`;
    case "explanation":
      return q.explanation ?? "व्याख्या उपलब्ध छैन।";
  }
}

export function storagePathFor(
  questionId: string,
  audioVersion: number,
  segment: Segment
): string {
  return `q/${questionId}/v${audioVersion}/${segment}.wav`;
}
