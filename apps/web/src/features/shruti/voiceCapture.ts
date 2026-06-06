// Voice capture for Shruti commands using the browser's native
// SpeechRecognition API.
//
// Why this and not Gemini-over-MediaRecorder?
//   - Instant: results arrive in ~150ms, no network round trip.
//   - Reliable: classification of short single-word commands works much
//     better than Gemini Flash's audio classifier (which drifts and biases
//     toward defaults).
//   - Free: no per-call cost, no quota, no 503s during peak hours.
//
// Why this design and not the earlier SpeechRecognition attempts?
//   - The recognizer is started ONCE when the user enables the mic and
//     stays alive for the whole session. We never stop/start it per
//     command — every start() call is what triggers the screen-reader
//     "recording region" announcement on some platforms.
//   - We don't gate the recognizer; we gate its OUTPUT. While Shruti is
//     speaking, we just ignore results. The mic stays armed in the
//     background.
//   - In continuous mode Chrome silently ends sessions sometimes. We
//     restart only on actual `onend`, with a small delay, and only if
//     the user still has the mic enabled.

export interface VoiceCaptureCallbacks {
  /**
   * Fires once per final recognition result. Receives up to N alternative
   * transcripts ranked by confidence (highest first). Caller decides which
   * one (if any) matches a known command.
   */
  onTranscript: (alternatives: Array<{ text: string; confidence: number }>) => void;
  onError?: (reason: string) => void;
  onReady?: () => void;
}

export interface VoiceCaptureOptions {
  lang?: string; // default "en-US"
}

type RecognizerLike = {
  lang: string;
  interimResults: boolean;
  continuous: boolean;
  maxAlternatives?: number;
  onresult: (e: SpeechRecognitionResultEventLike) => void;
  onend: () => void;
  onerror: (e: { error: string }) => void;
  onstart?: () => void;
  start: () => void;
  stop: () => void;
  abort?: () => void;
};

interface SpeechRecognitionResultEventLike {
  resultIndex: number;
  results: ArrayLike<
    ArrayLike<{ transcript: string; confidence: number }> & { isFinal?: boolean }
  >;
}

export class VoiceCapture {
  private recog: RecognizerLike | null = null;
  private callbacks: VoiceCaptureCallbacks;
  private lang: string;
  private destroyed = false;
  private running = false;
  private acceptResults = false; // whether onresult is currently allowed to fire callbacks
  private restartTimer: ReturnType<typeof setTimeout> | null = null;
  private watchdog: ReturnType<typeof setInterval> | null = null;
  private lastEventAt = Date.now();

  constructor(callbacks: VoiceCaptureCallbacks, opts: VoiceCaptureOptions = {}) {
    this.callbacks = callbacks;
    this.lang = opts.lang ?? "en-US";
  }

  async start(): Promise<void> {
    if (typeof window === "undefined") return;
    const w = window as unknown as {
      SpeechRecognition?: new () => RecognizerLike;
      webkitSpeechRecognition?: new () => RecognizerLike;
    };
    const SR = w.SpeechRecognition ?? w.webkitSpeechRecognition;
    if (!SR) {
      this.callbacks.onError?.("speech_recognition_unsupported");
      return;
    }

    const recog = new SR();
    recog.lang = this.lang;
    recog.continuous = true;
    recog.interimResults = false;
    // Ask Chrome for multiple guesses. Often the top guess is wrong
    // ("necks" for "next") but a lower-ranked one matches a real command.
    if ("maxAlternatives" in recog) recog.maxAlternatives = 5;

    recog.onstart = () => {
      this.running = true;
      this.lastEventAt = Date.now();
      this.callbacks.onReady?.();
    };

    recog.onresult = (e) => {
      this.lastEventAt = Date.now();
      if (!this.acceptResults) return;
      for (let i = e.resultIndex; i < e.results.length; i++) {
        const r = e.results[i];
        if (r.isFinal === false) continue;
        const alts: Array<{ text: string; confidence: number }> = [];
        // Iterate the result's alternatives array.
        const count = (r as ArrayLike<unknown>).length;
        for (let k = 0; k < count; k++) {
          const alt = (r as ArrayLike<{ transcript: string; confidence: number }>)[k];
          if (!alt) continue;
          const text = (alt.transcript ?? "").trim().toLowerCase();
          if (!text) continue;
          alts.push({ text, confidence: alt.confidence ?? 1 });
        }
        if (alts.length === 0) continue;
        this.callbacks.onTranscript(alts);
      }
    };

    recog.onerror = (e) => {
      this.lastEventAt = Date.now();
      // "no-speech" / "audio-capture" are normal; the session will end and
      // onend will restart it. "not-allowed" means the user revoked
      // permission — terminal.
      if (e.error === "not-allowed" || e.error === "service-not-allowed") {
        this.callbacks.onError?.(e.error);
        this.destroyed = true;
      }
    };

    recog.onend = () => {
      this.running = false;
      if (this.destroyed) return;
      // Restart silently. Delay so Chrome's internal state settles.
      if (this.restartTimer) clearTimeout(this.restartTimer);
      this.restartTimer = setTimeout(() => {
        if (this.destroyed) return;
        try { recog.start(); } catch { /* already started */ }
      }, 200);
    };

    this.recog = recog;
    try {
      recog.start();
    } catch (err) {
      const msg = err instanceof Error ? err.message : "start_failed";
      this.callbacks.onError?.(msg);
    }

    // Watchdog: if we haven't heard any event for 20s, Chrome has
    // silently stalled. Force a restart cycle.
    this.watchdog = setInterval(() => {
      if (this.destroyed || !this.recog) return;
      if (Date.now() - this.lastEventAt > 20_000) {
        this.lastEventAt = Date.now();
        try { (this.recog.abort ?? this.recog.stop).call(this.recog); } catch { /* ignore */ }
        // onend will fire and restart.
      }
    }, 5_000);
  }

  /**
   * Gate whether incoming results are forwarded to the callback.
   * The recognizer itself keeps running — only the output is gated, so
   * we never trigger a start/stop cycle (which is what causes screen
   * readers to re-announce the "recording region" landmark).
   */
  setListening(on: boolean) {
    this.acceptResults = on;
  }

  stop() {
    this.destroyed = true;
    if (this.restartTimer) { clearTimeout(this.restartTimer); this.restartTimer = null; }
    if (this.watchdog) { clearInterval(this.watchdog); this.watchdog = null; }
    if (this.recog) {
      try { (this.recog.abort ?? this.recog.stop).call(this.recog); } catch { /* ignore */ }
    }
    this.recog = null;
    this.running = false;
    this.acceptResults = false;
  }
}
