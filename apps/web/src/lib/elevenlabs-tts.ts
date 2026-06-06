// ElevenLabs voice synthesis for Nepali Manana narration.
//
// Mirrors the contract of `synthesizeNepali` in tts-service.ts so the Manana
// pipeline can swap providers segment-for-segment. Currently only invoked by
// the `test:manana-elevenlabs` script for A/B quality comparison against
// Gemini TTS — not wired into the production worker yet.

const TTS_ENDPOINT_BASE = "https://api.elevenlabs.io/v1/text-to-speech";
// Sarah — warm, conversational female voice. Multilingual-v2 handles
// Devanagari acceptably (Hindi-leaning, same trade-off as Gemini's default).
// Override per-call via `ELEVENLABS_VOICE_ID` env var to audition others.
const DEFAULT_VOICE_ID = "EXAVITQu4vr4xnSDxMaL";
const DEFAULT_MODEL_ID = "eleven_multilingual_v2";
const OUTPUT_FORMAT = "mp3_44100_128";
const REQUEST_TIMEOUT_MS = 60_000;
const MAX_ATTEMPTS = 3;
const RETRY_DELAYS_MS = [1000, 3000, 8000];

// ElevenLabs concurrency is plan-dependent (Free 2, Starter 3, Creator 5).
// 1.5s between calls keeps us under Starter limits without dragging total
// render time too much.
const TTS_MIN_INTERVAL_MS = 1_500;
let _nextAllowedAt = 0;
let _ttsQueue: Promise<void> = Promise.resolve();

function ttsThrottle(): Promise<void> {
  _ttsQueue = _ttsQueue.then(() => {
    const wait = _nextAllowedAt - Date.now();
    _nextAllowedAt = Math.max(Date.now(), _nextAllowedAt) + TTS_MIN_INTERVAL_MS;
    return wait > 0 ? new Promise((r) => setTimeout(r, wait)) : Promise.resolve();
  });
  return _ttsQueue;
}

function sleep(ms: number): Promise<void> {
  return new Promise((r) => setTimeout(r, ms));
}

function isFatal(err: unknown): boolean {
  const msg = err instanceof Error ? err.message : String(err);
  return /\b(401|403|404|422)\b|invalid_api_key|voice_not_found|quota_exceeded/i.test(msg);
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
      },
    );
  });
}

export interface ElevenLabsTtsOptions {
  voiceId?: string;
  modelId?: string;
  /** 0.0–1.0. Lower = more expressive, Higher = more monotone/consistent. Default 0.5. */
  stability?: number;
  /** 0.0–1.0. How closely to mimic the original voice clone. Default 0.75. */
  similarityBoost?: number;
  /** 0.0–1.0. Style exaggeration. 0 keeps voice neutral — best for tutor tone. */
  style?: number;
  /** Boosts perceived similarity at small CPU cost. Default true. */
  useSpeakerBoost?: boolean;
}

export interface ElevenLabsTtsResult {
  mp3: Buffer;
  latencyMs: number;
  bytes: number;
}

export async function synthesizeNepaliElevenLabs(
  text: string,
  opts: ElevenLabsTtsOptions = {},
): Promise<ElevenLabsTtsResult> {
  const key = process.env.ELEVENLABS_API_KEY;
  if (!key) throw new Error("Missing ELEVENLABS_API_KEY");

  const voiceId = opts.voiceId ?? process.env.ELEVENLABS_VOICE_ID ?? DEFAULT_VOICE_ID;
  const modelId = opts.modelId ?? process.env.ELEVENLABS_VOICE_MODEL ?? DEFAULT_MODEL_ID;

  const endpoint = `${TTS_ENDPOINT_BASE}/${voiceId}?output_format=${OUTPUT_FORMAT}`;
  const body = {
    text,
    model_id: modelId,
    voice_settings: {
      stability: opts.stability ?? 0.5,
      similarity_boost: opts.similarityBoost ?? 0.75,
      style: opts.style ?? 0,
      use_speaker_boost: opts.useSpeakerBoost ?? true,
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
          headers: {
            "xi-api-key": key,
            "Content-Type": "application/json",
            accept: "audio/mpeg",
          },
          body: JSON.stringify(body),
        }),
        REQUEST_TIMEOUT_MS,
      );

      if (!res.ok) {
        const errText = await res.text().catch(() => "");
        throw new Error(`ElevenLabs TTS HTTP ${res.status}: ${errText.slice(0, 500)}`);
      }

      const ab = await res.arrayBuffer();
      const mp3 = Buffer.from(ab);
      // 44.1kHz 128kbps mono floor: a 200ms clip is ~3.2KB. Anything under
      // ~2KB is almost certainly an empty/error response framed as audio.
      if (mp3.length < 2_000) {
        throw new Error(`ElevenLabs TTS returned ${mp3.length}B MP3 — refusing as silent`);
      }

      const latencyMs = Math.round(performance.now() - t0);
      return { mp3, latencyMs, bytes: mp3.length };
    } catch (err) {
      lastErr = err;
      if (isFatal(err) || attempt === MAX_ATTEMPTS - 1) break;
      await sleep(RETRY_DELAYS_MS[attempt]);
    }
  }

  const msg = lastErr instanceof Error ? lastErr.message : String(lastErr);
  throw new Error(`ElevenLabs TTS failed after ${MAX_ATTEMPTS} attempts: ${msg}`);
}
