const SOUND_EFFECTS_ENDPOINT = "https://api.elevenlabs.io/v1/sound-generation";
const DEFAULT_MODEL_ID = "eleven_text_to_sound_v2";
const REQUEST_TIMEOUT_MS = 60_000;

export type ElevenLabsSoundOptions = {
  text: string;
  durationSeconds?: number;
  loop?: boolean;
  modelId?: string;
  promptInfluence?: number;
};

export async function generateElevenLabsSound(
  opts: ElevenLabsSoundOptions,
): Promise<Buffer> {
  const apiKey = process.env.ELEVENLABS_API_KEY;
  if (!apiKey) throw new Error("Missing ELEVENLABS_API_KEY");

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);

  try {
    const res = await fetch(SOUND_EFFECTS_ENDPOINT, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "xi-api-key": apiKey,
      },
      body: JSON.stringify({
        text: opts.text,
        duration_seconds: opts.durationSeconds ?? null,
        loop: opts.loop ?? false,
        prompt_influence: opts.promptInfluence ?? 0.45,
        model_id: opts.modelId ?? DEFAULT_MODEL_ID,
      }),
      signal: controller.signal,
    });

    if (!res.ok) {
      const body = await res.text().catch(() => "");
      throw new Error(`ElevenLabs sound HTTP ${res.status}: ${body.slice(0, 500)}`);
    }

    const ab = await res.arrayBuffer();
    const audio = Buffer.from(ab);
    if (audio.length === 0) {
      throw new Error("ElevenLabs sound generation returned an empty audio payload");
    }
    return audio;
  } catch (error) {
    if (error instanceof Error && error.name === "AbortError") {
      throw new Error(`ElevenLabs sound generation timed out after ${REQUEST_TIMEOUT_MS}ms`);
    }
    throw error;
  } finally {
    clearTimeout(timeout);
  }
}
