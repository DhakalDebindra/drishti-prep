import { Mp3Encoder } from "@breezystack/lamejs";

// ─── TTS model IDs ────────────────────────────────────────────────────────
// Both 2.5 preview TTS models are scheduled for retirement (no exact date
// from Google as of June 2026, but the upstream `gemini-2.5-*` text family
// is set for shutdown on **October 16, 2026** and the preview TTS variants
// usually follow on a similar or shorter clock). Google's recommended
// replacement is `gemini-3.1-flash-tts-preview` for both tiers.
//
// IDs are env-overridable so the migration can happen without a redeploy
// once we've A/B tested Nepali quality on 3.1 Flash TTS. Defaults stay on
// the GA 2.5 family to avoid breaking anything before that test runs.
//
// Pro TTS — better quality but very low daily quota (50/day on free tier).
// Used for question audio where each clip is heard by many students.
const MODEL_PRO =
  process.env.GEMINI_MODEL_TTS_PRO || "gemini-2.5-pro-preview-tts";
// Flash TTS — much higher quotas, slightly less polished. Used for Shruti
// dictation where the same user may need 100+ chunks per session.
const MODEL_FLASH =
  process.env.GEMINI_MODEL_TTS_FLASH || "gemini-2.5-flash-preview-tts";
// Default for legacy callers.
const MODEL = MODEL_PRO;

// Gemini 2.5 Pro TTS paid tier allows ~30 RPM; 2 s between calls keeps us safely under.
const TTS_MIN_INTERVAL_MS = 2_000;
let _nextAllowedAt = 0;
let _ttsQueue = Promise.resolve();

function ttsThrottle(): Promise<void> {
  // Chain onto the existing queue so concurrent callers serialize rather than race.
  _ttsQueue = _ttsQueue.then(() => {
    const wait = _nextAllowedAt - Date.now();
    _nextAllowedAt = Math.max(Date.now(), _nextAllowedAt) + TTS_MIN_INTERVAL_MS;
    return wait > 0 ? new Promise((r) => setTimeout(r, wait)) : Promise.resolve();
  });
  return _ttsQueue;
}

const REQUEST_TIMEOUT_MS = 30_000;
const MAX_ATTEMPTS = 3;
const RETRY_DELAYS_MS = [1000, 3000, 8000];

// PCM L16 24kHz mono — the only format Gemini TTS currently emits.
const SAMPLE_RATE = 24_000;
const BITS_PER_SAMPLE = 16;
// 96 kbps is a noticeable jump in clarity over 64 with only ~50% size cost.
// 128 is overkill for mono speech (the high frequencies barely benefit).
const MP3_BITRATE = 96; // kbps

// Empirical thresholds: a usable Nepali utterance is at least ~300ms with
// non-trivial signal. Anything below has caused silent MP3 uploads in prod.
const MIN_PCM_BYTES = 4_000; // ~83ms at 24kHz/16bit mono
const MIN_RMS = 80; // out of 32767; pure silence is 0, room tone ~5–20

// Single voice for the whole platform — Kore was chosen for the most natural
// Nepali pronunciation and to keep students hearing one consistent tutor.
// Kept as a one-element union so the type still narrows and a future expansion
// (rotation, per-subject voices) only needs to add entries here.
export const TUTOR_VOICES = ["Kore"] as const;
export type TutorVoice = (typeof TUTOR_VOICES)[number];
export const DEFAULT_VOICE: TutorVoice = "Kore";

export type Segment = "stem" | "opt_a" | "opt_b" | "opt_c" | "opt_d" | "explanation";
export const SEGMENTS: Segment[] = ["stem", "opt_a", "opt_b", "opt_c", "opt_d", "explanation"];

export type SynthesizeResult = {
  mp3: Buffer;
  durationMs: number;
  latencyMs: number;
  // Approximate token usage (Gemini bills audio output by tokens; ~32 tokens/sec at 24kHz).
  approxTokens: number;
};

function pcmToMp3(pcm: Buffer): Buffer {
  const encoder = new Mp3Encoder(1, SAMPLE_RATE, MP3_BITRATE);
  const samples = new Int16Array(pcm.buffer, pcm.byteOffset, pcm.length / 2);
  const chunks: Buffer[] = [];
  const frameSize = 1152; // MPEG standard samples-per-frame for layer III

  for (let i = 0; i < samples.length; i += frameSize) {
    const slice = samples.subarray(i, i + frameSize);
    const encoded = encoder.encodeBuffer(slice);
    if (encoded.length > 0) {
      chunks.push(Buffer.from(encoded.buffer, encoded.byteOffset, encoded.byteLength));
    }
  }

  const tail = encoder.flush();
  if (tail.length > 0) {
    chunks.push(Buffer.from(tail.buffer, tail.byteOffset, tail.byteLength));
  }

  return Buffer.concat(chunks);
}

function pcmRms(pcm: Buffer): number {
  const samples = new Int16Array(pcm.buffer, pcm.byteOffset, pcm.length / 2);
  if (samples.length === 0) return 0;
  // Sample up to 4096 evenly-spaced samples — enough for a stable RMS,
  // avoids walking ~2M samples per segment.
  const stride = Math.max(1, Math.floor(samples.length / 4096));
  let sumSq = 0;
  let n = 0;
  for (let i = 0; i < samples.length; i += stride) {
    sumSq += samples[i] * samples[i];
    n++;
  }
  return Math.sqrt(sumSq / n);
}

function sleep(ms: number): Promise<void> {
  return new Promise((r) => setTimeout(r, ms));
}

/**
 * Style-prompt preface that locks Gemini to native Nepali phonemes.
 *
 * Without this, short Devanagari strings (especially option readings like
 * "विकल्प ख। पानी।") get rendered with Hindi vowel quality — Gemini's
 * multilingual training tilts toward hi-IN on the shared script. Wrapping
 * the spoken text in a "Say:" frame both pins the locale and signals to
 * Gemini that the preface is meta, not content to read.
 */
function buildNepaliPrompt(text: string): string {
  return (
    "Read the following aloud as a fluent native Nepali speaker from Kathmandu, " +
    "using authentic Nepali (ne-NP) pronunciation. Do not use Hindi (hi-IN) " +
    "phonemes, intonation, or vowel quality. Maintain a calm, friendly teacher " +
    "tone at a moderate pace.\n" +
    `Say: ${text}`
  );
}

/**
 * Shruti-specific style prompt. Differs from the question-audio prompt by
 * being shorter, more deterministic, and emphasizing CONSISTENCY across
 * many utterances in one session. Gemini TTS re-rolls vocal
 * characteristics on each call; an explicit "maintain identical voice"
 * directive significantly reduces inter-chunk drift in pitch / tempo /
 * energy. The terser frame also leaves Gemini less interpretive room.
 */
function buildShrutiNepaliPrompt(text: string): string {
  return (
    "Voice: female Nepali teacher from Kathmandu, calm, even, neutral pitch. " +
    "Maintain identical voice characteristics, pitch, tempo, and energy across " +
    "every utterance — do not vary tone, do not add emotion, do not emphasize. " +
    "Use authentic Nepali (ne-NP) pronunciation only; never Hindi (hi-IN) " +
    "phonemes or intonation. Read at a steady moderate pace.\n" +
    `Say: ${text}`
  );
}

// Errors that should NOT be retried — auth/quota won't recover within the retry window.
function isFatal(err: unknown): boolean {
  const msg = err instanceof Error ? err.message : String(err);
  return /\b(401|403|429)\b|API key|quota|PERMISSION_DENIED|INVALID_ARGUMENT/i.test(msg);
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
 * Synthesize a chunk of Nepali text to an MP3 buffer using Gemini TTS.
 *
 * Uses the REST API directly because the legacy `@google/generative-ai` SDK
 * (v0.24, still installed) does not expose the `responseModalities: ['AUDIO']`
 * field required for audio output. Switching SDKs only for this one call would
 * pull a large new dep; the REST shape is small enough to inline.
 */
export interface SynthesizeOptions {
  /**
   * When true, uses the consistency-anchored prompt (terser, explicit
   * "maintain identical voice" directive) and locks `temperature: 0`.
   * Use for multi-utterance dictation sessions where chunk-to-chunk
   * vocal drift is the bigger problem than expressiveness.
   */
  consistencyMode?: boolean;
  /**
   * Override the underlying TTS model. Defaults to the Pro variant for
   * back-compat with the question-audio pipeline; pass "flash" to use
   * the Flash TTS variant which has substantially higher daily and
   * per-minute quotas — required for Shruti's longer sessions.
   */
  modelTier?: "pro" | "flash";
}

export async function synthesizeNepali(
  text: string,
  voice: TutorVoice,
  opts: SynthesizeOptions = {}
): Promise<SynthesizeResult> {
  const key =
    process.env.GEMINI_API_KEY ??
    process.env.DRISHTI_API_KEY ??
    process.env.DrishtiApiKey;
  if (!key) throw new Error("Missing GEMINI_API_KEY");

  // Gemini's multilingual voice drifts into Hindi phonemes on short
  // Devanagari inputs because Hindi dominates its training data for that
  // script. The "Say:" pattern is documented as a style-prompt convention
  // — Gemini speaks only the text after "Say:" while the preface conditions
  // the accent. Anchoring to native Nepali pronunciation here eliminates the
  // hi-IN-flavoured option readings reported in prod.
  const styled = opts.consistencyMode
    ? buildShrutiNepaliPrompt(text)
    : buildNepaliPrompt(text);

  const modelId = opts.modelTier === "flash" ? MODEL_FLASH : MODEL;
  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${modelId}:generateContent?key=${key}`;
  const body = {
    contents: [{ parts: [{ text: styled }] }],
    generationConfig: {
      responseModalities: ["AUDIO"],
      // Temperature 0 sharply reduces vocal drift between calls. The
      // question-audio path uses the model's default; Shruti needs the
      // tighter pin so a 100-chunk dictation session sounds like one
      // continuous reader, not 100 slightly different ones.
      temperature: opts.consistencyMode ? 0 : undefined,
      speechConfig: {
        voiceConfig: { prebuiltVoiceConfig: { voiceName: voice } },
      },
    },
  };

  await ttsThrottle();

  let lastErr: unknown;
  const t0 = performance.now();

  for (let attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
    try {
      const res = await withTimeout(
        fetch(endpoint, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(body),
        }),
        REQUEST_TIMEOUT_MS
      );

      if (!res.ok) {
        const errText = await res.text().catch(() => "");
        throw new Error(`Gemini TTS HTTP ${res.status}: ${errText.slice(0, 500)}`);
      }

      const json = (await res.json()) as {
        candidates?: Array<{ content?: { parts?: Array<{ inlineData?: { data?: string } }> } }>;
      };
      const b64 = json.candidates?.[0]?.content?.parts?.[0]?.inlineData?.data;
      if (!b64) {
        throw new Error("Gemini TTS response missing inlineData (empty payload)");
      }

      const pcm = Buffer.from(b64, "base64");
      if (pcm.length < MIN_PCM_BYTES) {
        throw new Error(
          `Gemini TTS returned ${pcm.length}B PCM (< ${MIN_PCM_BYTES}B floor) — likely silent`
        );
      }
      const rms = pcmRms(pcm);
      if (rms < MIN_RMS) {
        throw new Error(
          `Gemini TTS PCM looks silent (RMS ${rms.toFixed(1)} < ${MIN_RMS})`
        );
      }

      const durationMs = Math.round(
        (pcm.length / ((SAMPLE_RATE * BITS_PER_SAMPLE) / 8)) * 1000
      );
      const approxTokens = Math.round((durationMs / 1000) * 32);
      const mp3 = pcmToMp3(pcm);

      // An MP3 frame is at least ~100 bytes; a 300ms 64kbps file is ≥2KB.
      if (mp3.length < 2_000) {
        throw new Error(`MP3 encoded to ${mp3.length}B — refusing to upload`);
      }

      const latencyMs = Math.round(performance.now() - t0);
      return { mp3, durationMs, latencyMs, approxTokens };
    } catch (err) {
      lastErr = err;
      if (isFatal(err) || attempt === MAX_ATTEMPTS - 1) break;
      await sleep(RETRY_DELAYS_MS[attempt]);
    }
  }

  const msg = lastErr instanceof Error ? lastErr.message : String(lastErr);
  throw new Error(`Gemini TTS failed after ${MAX_ATTEMPTS} attempts: ${msg}`);
}

/**
 * Voice assignment for a question. Currently constant (single platform voice),
 * but kept as a function so future rotation logic plugs in here without
 * touching callers.
 */
// eslint-disable-next-line @typescript-eslint/no-unused-vars
export function voiceFor(_questionId: string): TutorVoice {
  return DEFAULT_VOICE;
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
  return `q/${questionId}/v${audioVersion}/${segment}.mp3`;
}
