// HardenedTTS: a defensive wrapper around browser SpeechSynthesis.
//
// Browser TTS is notoriously unreliable. This wrapper handles:
//   * onstart never firing (2s watchdog → cancel + retry once)
//   * onend never firing (expectedDuration × 2 watchdog → cancel + retry once)
//   * Chrome killing long utterances mid-speech (pause/resume heartbeat ~10s)
//   * Voice list arriving asynchronously (voiceschanged subscription)
//
// Browser-only; safe to construct on the client.

export interface SpeakOptions {
  text: string;
  rate?: number;       // 0.5 – 2.0; default 1.0
  pitch?: number;      // default 1.0
  voiceURI?: string;   // optional preferred voice
  lang?: string;       // default "en-US"
  /**
   * Cloud audio playback for Devanagari content. When provided, instead
   * of using the browser SpeechSynthesis we play a slice of pre-fetched
   * audio: synthesize ONE sentence via Edge TTS (consistent voice), decode
   * once, then play `[startSec, endSec)` of it for the current chunk.
   *
   * `sentenceText` is the FULL sentence sent to Edge TTS (and cached as a
   * whole). `startSec` / `endSec` are the slice within that sentence to
   * play for this specific chunk; for sentence mode they cover the
   * whole audio.
   */
  cloud?: {
    sentenceText: string;
    startSec: number;
    endSec: number;
    cloudEndpoint?: string;
    /** Edge TTS voice name (e.g. "ne-NP-HemkalaNeural"). */
    edgeVoice?: string;
    /** Silence between words in the synthesized audio (SSML break). */
    wordGapMs?: number;
  };
  onStart?: () => void;
  onEnd?: () => void;
  onError?: (reason: string) => void;
}

const ONSTART_TIMEOUT_MS = 2000;
const HEARTBEAT_INTERVAL_MS = 10000;

const activeBlobUrls = new Set<string>();

export class HardenedTTS {
  private synth: SpeechSynthesis | null;
  private current: { utterance: SpeechSynthesisUtterance; opts: SpeakOptions; retries: number } | null = null;
  private currentCloudOpts: SpeakOptions | null = null;
  private currentCloudAbort: AbortController | null = null;
  private currentCloudAudio: HTMLAudioElement | null = null;
  private currentCloudUrl: string | null = null;
  private onstartTimer: ReturnType<typeof setTimeout> | null = null;
  private onendTimer: ReturnType<typeof setTimeout> | null = null;
  private heartbeatTimer: ReturnType<typeof setInterval> | null = null;
  private voicesCache: SpeechSynthesisVoice[] = [];

  constructor() {
    this.synth = typeof window !== "undefined" && "speechSynthesis" in window
      ? window.speechSynthesis
      : null;
    if (this.synth) {
      this.voicesCache = this.synth.getVoices();
      this.synth.addEventListener("voiceschanged", () => {
        this.voicesCache = this.synth!.getVoices();
      });
    }
  }

  static sweepBlobUrls() {
    for (const url of activeBlobUrls) {
      try { URL.revokeObjectURL(url); } catch { /* ignore */ }
    }
    activeBlobUrls.clear();
  }

  isSupported(): boolean {
    return this.synth !== null;
  }

  voices(): SpeechSynthesisVoice[] {
    return this.voicesCache;
  }

  /**
   * Subscribe to voice-list updates. The list arrives asynchronously on
   * Chrome — calling getVoices() too early returns an empty array. This
   * hook fires both immediately (with whatever we have) and on every
   * voiceschanged event, so UI pickers stay accurate.
   */
  onVoicesChanged(cb: (voices: SpeechSynthesisVoice[]) => void): () => void {
    if (!this.synth) return () => {};
    cb(this.voicesCache);
    const listener = () => {
      this.voicesCache = this.synth!.getVoices();
      cb(this.voicesCache);
    };
    this.synth.addEventListener("voiceschanged", listener);
    return () => this.synth?.removeEventListener("voiceschanged", listener);
  }

  /**
   * Pick the highest-quality voice available for a given language tag.
   * Prefers "neural"/"natural"/"online" voices (e.g. "Microsoft Aria
   * Online (Natural)", "Google US English") over the default robotic
   * eSpeak / SAPI voices that ship with most OSes.
   */
  pickBestVoice(lang: string): SpeechSynthesisVoice | null {
    return pickBestVoiceFrom(this.voicesCache, lang);
  }

  speak(opts: SpeakOptions): void {
    // Cloud path first — Edge-synthesized sentence-level audio with
    // client-side slicing for sub-sentence chunks.
    if (opts.cloud) {
      this.cancel();
      void this.speakCloudSegment(opts);
      return;
    }
    if (!this.synth) {
      opts.onError?.("speech_synthesis_unsupported");
      return;
    }
    this.cancel();

    const utterance = new SpeechSynthesisUtterance(opts.text);
    utterance.rate = clamp(opts.rate ?? 1.0, 0.5, 2.0);
    utterance.pitch = opts.pitch ?? 1.0;
    utterance.lang = opts.lang ?? "en-US";

    if (opts.voiceURI) {
      const v = this.voicesCache.find((v) => v.voiceURI === opts.voiceURI);
      if (v) utterance.voice = v;
    }

    this.current = { utterance, opts, retries: 0 };

    const expectedDurationMs = estimateDurationMs(opts.text, utterance.rate);

    this.onstartTimer = setTimeout(() => this.onStallBeforeStart(), ONSTART_TIMEOUT_MS);

    utterance.onstart = () => {
      if (this.onstartTimer) {
        clearTimeout(this.onstartTimer);
        this.onstartTimer = null;
      }
      this.armEndWatchdog(expectedDurationMs * 2);
      this.startHeartbeat();
      opts.onStart?.();
    };

    utterance.onend = () => {
      this.clearTimers();
      const finished = this.current;
      this.current = null;
      if (finished) finished.opts.onEnd?.();
    };

    utterance.onerror = (e: SpeechSynthesisErrorEvent) => {
      // "interrupted"/"canceled" fire on intentional cancel(); ignore.
      if (e.error === "interrupted" || e.error === "canceled") return;
      this.handleError(e.error || "unknown");
    };

    try {
      this.synth.speak(utterance);
    } catch (err) {
      this.handleError(err instanceof Error ? err.message : "speak_threw");
    }
  }

  pause(): void {
    if (this.synth && this.synth.speaking) this.synth.pause();
  }

  resume(): void {
    if (this.synth && this.synth.paused) this.synth.resume();
  }

  cancel(): void {
    this.clearTimers();
    if (this.synth) {
      try { this.synth.cancel(); } catch { /* ignore */ }
    }
    this.current = null;
    if (this.currentCloudAbort) {
      try { this.currentCloudAbort.abort(); } catch { /* ignore */ }
      this.currentCloudAbort = null;
    }
    if (this.currentCloudAudio) {
      try {
        this.currentCloudAudio.pause();
        this.currentCloudAudio.src = "";
      } catch { /* ignore */ }
      this.currentCloudAudio = null;
    }
    if (this.currentCloudUrl) {
      try { URL.revokeObjectURL(this.currentCloudUrl); } catch { /* ignore */ }
      activeBlobUrls.delete(this.currentCloudUrl);
      this.currentCloudUrl = null;
    }
    this.currentCloudOpts = null;
  }

  // --- cloud path: sentence-level synthesis, streaming playback -----------

  /**
   * Play the cloud-synthesized sentence via HTMLAudioElement + Blob URL.
   * No AudioBuffer decoding — the browser streams from the blob, keeping
   * memory at ~MP3 size (~80KB/sentence) instead of decoded PCM
   * (~500KB/sentence). For long Loksewa sessions this is the difference
   * between stable and OOM.
   */
  private async speakCloudSegment(opts: SpeakOptions): Promise<void> {
    if (!opts.cloud) {
      opts.onError?.("cloud_opts_missing");
      return;
    }
    this.currentCloudOpts = opts;
    const abort = new AbortController();
    this.currentCloudAbort = abort;

    try {
      // Fetch from IndexedDB cache (instant if pre-synthesized) or network.
      const { fetchOrCacheAudio } = await import("./audioCache");
      const result = await fetchOrCacheAudio({
        text: opts.cloud.sentenceText,
        lang: opts.lang,
        endpoint: opts.cloud.cloudEndpoint,
        voice: opts.cloud.edgeVoice,
        wordGapMs: opts.cloud.wordGapMs,
      });
      if (abort.signal.aborted) return;
      if (this.currentCloudOpts !== opts) return;
      if (!result?.blob) {
        opts.onError?.("cloud_audio_unavailable");
        return;
      }

      const url = URL.createObjectURL(result.blob);
      activeBlobUrls.add(url);
      const audio = new Audio(url);
      // Pace control through playbackRate, with preservesPitch keeping
      // Hemkala's voice at her natural pitch even when the rate changes.
      // This is the difference between "tape sped up" (chipmunk) and
      // "speaker talking faster" (natural). All modern browsers support
      // preservesPitch — the vendor-prefixed variants are belt-and-braces.
      type PitchAudio = HTMLAudioElement & {
        preservesPitch?: boolean;
        mozPreservesPitch?: boolean;
        webkitPreservesPitch?: boolean;
      };
      (audio as PitchAudio).preservesPitch = true;
      (audio as PitchAudio).mozPreservesPitch = true;
      (audio as PitchAudio).webkitPreservesPitch = true;
      audio.playbackRate = opts.rate ?? 1.0;
      audio.preload = "auto";
      this.currentCloudUrl = url;

      audio.onended = () => {
        if (abort.signal.aborted) return;
        if (this.currentCloudAbort === abort) {
          this.currentCloudAudio = null;
          this.currentCloudOpts = null;
        }
        opts.onEnd?.();
      };
      audio.onerror = () => {
        if (abort.signal.aborted) return;
        if (this.currentCloudAbort === abort) {
          this.currentCloudAudio = null;
          this.currentCloudOpts = null;
        }
        opts.onError?.("cloud_audio_error");
      };

      try {
        await audio.play();
        if (abort.signal.aborted) {
          audio.pause();
          audio.src = "";
          return;
        }
        this.currentCloudAudio = audio;
      } catch (err) {
        if (!abort.signal.aborted) {
          const msg = err instanceof Error ? err.message : "play_failed";
          opts.onError?.(msg);
        }
      }
    } catch (err) {
      if ((err as { name?: string })?.name === "AbortError" || abort.signal.aborted) return;
      const msg = err instanceof Error ? err.message : "cloud_tts_failed";
      opts.onError?.(msg);
    }
  }

  // --- internals -----------------------------------------------------------

  private clearTimers() {
    if (this.onstartTimer) { clearTimeout(this.onstartTimer); this.onstartTimer = null; }
    if (this.onendTimer) { clearTimeout(this.onendTimer); this.onendTimer = null; }
    if (this.heartbeatTimer) { clearInterval(this.heartbeatTimer); this.heartbeatTimer = null; }
  }

  private armEndWatchdog(ms: number) {
    if (this.onendTimer) clearTimeout(this.onendTimer);
    this.onendTimer = setTimeout(() => this.onStallDuringSpeech(), Math.max(ms, 5000));
  }

  private startHeartbeat() {
    if (this.heartbeatTimer) clearInterval(this.heartbeatTimer);
    // Chrome workaround: long utterances get silently killed unless we
    // pause/resume periodically. No-op on engines that don't need it.
    this.heartbeatTimer = setInterval(() => {
      if (!this.synth || !this.current) return;
      if (this.synth.speaking && !this.synth.paused) {
        try {
          this.synth.pause();
          this.synth.resume();
        } catch { /* ignore */ }
      }
    }, HEARTBEAT_INTERVAL_MS);
  }

  private onStallBeforeStart() {
    if (!this.current || !this.synth) return;
    if (this.current.retries < 1) {
      this.current.retries += 1;
      const opts = this.current.opts;
      try { this.synth.cancel(); } catch { /* ignore */ }
      // Re-issue once.
      this.speak(opts);
      return;
    }
    this.handleError("onstart_timeout");
  }

  private onStallDuringSpeech() {
    if (!this.current || !this.synth) return;
    if (this.current.retries < 1) {
      this.current.retries += 1;
      const opts = this.current.opts;
      try { this.synth.cancel(); } catch { /* ignore */ }
      this.speak(opts);
      return;
    }
    this.handleError("onend_timeout");
  }

  private handleError(reason: string) {
    this.clearTimers();
    const opts = this.current?.opts;
    this.current = null;
    opts?.onError?.(reason);
  }
}

function clamp(n: number, lo: number, hi: number): number {
  return Math.max(lo, Math.min(hi, n));
}

// Rough duration estimate: assume ~3 chars/word, base 150 wpm at rate=1.
function estimateDurationMs(text: string, rate: number): number {
  const words = Math.max(1, text.trim().split(/\s+/).length);
  const wpm = 150 * rate;
  return Math.round((words / wpm) * 60000);
}

/**
 * Rank an OS voice by how natural it sounds. Higher = better.
 * The naming conventions across Windows / Mac / Chrome are messy, so we
 * use keyword heuristics that have held up across many user systems.
 */
function voiceQualityScore(v: SpeechSynthesisVoice): number {
  const name = v.name.toLowerCase();
  let score = 0;
  // Windows 11 neural voices ("Microsoft Aria Online (Natural) - English (United States)").
  if (/online \(natural\)/i.test(v.name)) score += 100;
  if (/neural/i.test(name)) score += 80;
  if (/natural/i.test(name)) score += 60;
  // macOS enhanced voices (Samantha (Enhanced), Karen (Enhanced), Daniel (Enhanced)).
  if (/enhanced/i.test(name)) score += 70;
  if (/premium/i.test(name)) score += 65;
  // Google's cloud voices show up in Chrome on most platforms.
  if (name.startsWith("google ")) score += 50;
  // Specific high-quality voices known to be good.
  if (/(aria|jenny|guy|ava|eric|libby|emma)/i.test(name)) score += 30;
  if (/samantha|karen|daniel|moira|tessa/i.test(name)) score += 25;
  // Microsoft default SAPI voices (David, Mark, Zira) are the robotic ones.
  if (/microsoft (david|mark|zira|hazel|susan)\b/i.test(name) && !/online|natural/i.test(name)) {
    score -= 40;
  }
  // eSpeak is the most robotic of all.
  if (/espeak|festival/i.test(name)) score -= 100;
  // Default voice gets a small bump only if nothing better scored.
  if (v.default) score += 1;
  // Local voices score slightly higher than network ones for latency,
  // *unless* the network one is clearly higher quality (which the keyword
  // bumps above already capture).
  if (v.localService) score += 5;
  return score;
}

export function pickBestVoiceFrom(
  voices: SpeechSynthesisVoice[],
  lang: string,
): SpeechSynthesisVoice | null {
  if (!voices.length) return null;
  const langPrefix = lang.split("-")[0].toLowerCase();
  // First, voices that match the full BCP-47 tag (en-US).
  const exactLang = voices.filter((v) => v.lang.toLowerCase() === lang.toLowerCase());
  // Then voices matching just the language part (en-*).
  const sameLang = voices.filter((v) => v.lang.toLowerCase().startsWith(langPrefix));

  const ranked = (exactLang.length ? exactLang : sameLang)
    .slice()
    .sort((a, b) => voiceQualityScore(b) - voiceQualityScore(a));
  return ranked[0] ?? voices[0] ?? null;
}

// Helper for the spelling engine: speak a sequence of units with a gap between
// each. Returns a cancel function.
export function spellSequence(
  tts: HardenedTTS,
  units: string[],
  opts: { gapMs?: number; rate?: number; lang?: string; onDone?: () => void } = {},
): () => void {
  const gapMs = opts.gapMs ?? 500;
  let i = 0;
  let cancelled = false;
  const next = () => {
    if (cancelled) return;
    if (i >= units.length) { opts.onDone?.(); return; }
    const unit = units[i++];
    // Empty units are inter-word pauses — just wait extra gapMs and continue.
    if (!unit) { setTimeout(next, gapMs * 2); return; }
    tts.speak({
      text: unit,
      rate: opts.rate ?? 0.85,
      lang: opts.lang ?? "en-US",
      onEnd: () => setTimeout(next, gapMs),
      onError: () => setTimeout(next, gapMs),
    });
  };
  next();
  return () => { cancelled = true; tts.cancel(); };
}
