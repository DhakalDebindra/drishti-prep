// Microsoft Edge TTS — the unofficial endpoint that powers Edge browser's
// "Read aloud" feature. Free, no API key, very high-quality Neural voices.
//
// Why we use this instead of Gemini for Shruti:
//   - Free with no daily request quota (essential for 100+ chunk sessions)
//   - Neural Nepali voices (Hemkala / Sagar) are excellent quality
//   - No API key juggling, no billing risk
//
// Caveat: this uses an unofficial protocol Microsoft could change. We
// keep Gemini code paths intact as a paid fallback if Edge breaks.

import { MsEdgeTTS, OUTPUT_FORMAT } from "msedge-tts";

// Microsoft's neural voices for Nepali. Hemkala is the more polished
// reading voice; Sagar is the male alternative.
export const EDGE_NEPALI_VOICES = {
  female: "ne-NP-HemkalaNeural",
  male:   "ne-NP-SagarNeural",
} as const;
export type EdgeNepaliVoice = (typeof EDGE_NEPALI_VOICES)[keyof typeof EDGE_NEPALI_VOICES];
export const DEFAULT_EDGE_VOICE: EdgeNepaliVoice = EDGE_NEPALI_VOICES.female;

export interface WordBoundary {
  text: string;
  startMs: number;
  endMs: number;
}

export interface EdgeSynthesisResult {
  mp3: Buffer;
  durationMs: number;
  latencyMs: number;
  wordBoundaries: WordBoundary[];
}

/**
 * Synthesize a chunk of Nepali text via Microsoft Edge TTS, returning
 * MP3 bytes. If `wordGapMs > 0`, inserts SSML <break> tags between every
 * word so the resulting audio has audible silence at each word boundary
 * — without slowing the actual pronunciation rate. That's the
 * "patient human assistant" sound for Braille writers.
 */
export async function synthesizeWithEdge(
  text: string,
  voice: EdgeNepaliVoice = DEFAULT_EDGE_VOICE,
  options: { wordGapMs?: number } = {},
): Promise<EdgeSynthesisResult> {
  const tts = new MsEdgeTTS();
  await tts.setMetadata(voice, OUTPUT_FORMAT.AUDIO_24KHZ_48KBITRATE_MONO_MP3, {
    wordBoundaryEnabled: true,
  });

  const t0 = Date.now();
  // We no longer inject custom SSML <break> tags here because the Microsoft Edge TTS
  // WebSocket API silently fails (returning 0 audio bytes) if both `<break>` tags and
  // `wordBoundaryEnabled: true` are present. We will use `toStream` so the library 
  // correctly builds the SSML with `<prosody>`, full voice names, and `xmlns:mstts`.
  // Intra-sentence spacing will be handled via client-side playback slicing 
  // utilizing the exact `wordBoundaries` returned by this API.
  const stream = tts.toStream(text);
  const audioStream = stream.audioStream;
  const metadataStream = stream.metadataStream;

  const chunks: Buffer[] = [];
  const boundaries: WordBoundary[] = [];

  if (metadataStream) {
    metadataStream.on("data", (data: Buffer | string) => {
      try {
        const payload = JSON.parse(data.toString());
        if (Array.isArray(payload.Metadata)) {
          for (const meta of payload.Metadata) {
            if (meta.Type === "WordBoundary" && meta.Data && meta.Data.text) {
              boundaries.push({
                text: meta.Data.text.Text,
                startMs: meta.Data.Offset / 10000,
                endMs: (meta.Data.Offset + meta.Data.Duration) / 10000,
              });
            }
          }
        }
      } catch { /* ignore parse errors */ }
    });
  }

  await new Promise<void>((resolve, reject) => {
    audioStream.on("data", (chunk: Buffer) => chunks.push(chunk));
    audioStream.on("end", () => resolve());
    audioStream.on("error", (err: Error) => reject(err));
    setTimeout(() => reject(new Error("edge_tts_timeout")), 30_000);
  });

  const mp3 = Buffer.concat(chunks);
  if (mp3.length < 1_000) {
    throw new Error(`edge_tts_empty (got ${mp3.length} bytes)`);
  }
  return {
    mp3,
    durationMs: Math.round((mp3.length / 6000) * 1000),
    latencyMs: Date.now() - t0,
    wordBoundaries: boundaries,
  };
}


