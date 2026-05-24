// Glue: bind the pure DictationSession FSM to HardenedTTS + Web Speech +
// keyboard + manual buttons. React hook, browser-only.

"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import {
  DictationDocument,
  Sentence,
} from "./types";
import {
  DictationMode,
  DictationSession,
  Intent,
  PaceConfig,
  PACE_PRESETS,
  SessionEvent,
  createDictationSession,
} from "./createDictationSession";
import { HardenedTTS, spellSequence } from "./hardenedTts";
import { VoiceCapture } from "./voiceCapture";
import { logDebug, logWarn } from "./log";
import { prewarmAudio } from "./audioCache";

/**
 * Compute the writing pause that should follow a freshly-spoken chunk.
 *   - Sub-sentence chunks (word/phrase): fixed small pace.interWordPauseMs.
 *   - Sentence end: scale pace.interSentencePauseMs by the sentence's
 *     spokenWordCount relative to an 8-word reference. So a 16-word
 *     spoken sentence gets ~2× the base pause; a 3-word sentence gets
 *     ~0.4×. Clamped to [1s, 25s].
 */
function computeWritingPauseMs(args: {
  pace: PaceConfig;
  isSentenceEnd: boolean;
  sentence: Sentence | null;
}): number {
  const { pace, isSentenceEnd, sentence } = args;
  if (!isSentenceEnd) {
    return pace.interWordPauseMs;
  }

  // If the user is using the explicit exact-seconds slider (custom preset),
  // strictly respect their chosen gap duration without dynamically scaling it.
  if (pace.preset === "custom") {
    return pace.interSentencePauseMs;
  }

  // Scale by sentence length so a 20-word sentence gets ~2.5× the writing
  // time a 5-word sentence gets. The reference is calibrated for an
  // average ~8-word spoken sentence; clamp prevents extremes.
  const REFERENCE_WORDS = 8;
  const wc = Math.max(1, sentence?.spokenWordCount ?? REFERENCE_WORDS);
  const scale = wc / REFERENCE_WORDS;
  const scaled = Math.round(pace.interSentencePauseMs * scale);
  // Floor matches the active preset's base pause so even short sentences
  // give a meaningful writing window (a 2-word sentence on Slow still
  // gets ~3s, not the absolute 1s floor that felt rushed).
  const floor = Math.max(1500, Math.round(pace.interSentencePauseMs * 0.6));
  return Math.max(floor, Math.min(scaled, 30000));
}

/**
 * Play a Devanagari sentence as a single continuous Edge TTS take. No
 * client-side slicing — slicing was causing audible cuts that felt like
 * buffering. The session FSM auto-coerces Nepali content to sentence
 * mode, so "this chunk" is always a full sentence here.
 */
/**
 * Strip the "edge:" prefix from a voice URI, returning the underlying
 * Edge TTS voice name (e.g. "ne-NP-HemkalaNeural"). Returns undefined
 * for non-cloud voices.
 */
function extractEdgeVoiceName(voiceURI: string | null): string | undefined {
  if (!voiceURI || !voiceURI.startsWith("edge:")) return undefined;
  return voiceURI.slice("edge:".length);
}

/**
 * Look for a high-quality Nepali voice that's already installed on the
 * user's system. Returns null if none — caller should fall back to cloud.
 *
 * Priority order:
 *   1. Microsoft "Online (Natural)" Nepali voices — Hemkala, Sagar — best quality
 *   2. Any voice tagged "Neural" with lang starting "ne"
 *   3. Any Nepali voice at all
 */
function pickLocalNepaliNeuralVoice(voices: SpeechSynthesisVoice[]): SpeechSynthesisVoice | null {
  const nepali = voices.filter((v) => v.lang.toLowerCase().startsWith("ne"));
  if (nepali.length === 0) return null;
  // Tier 1: Microsoft Neural Nepali voices.
  const neural = nepali.find(
    (v) => /natural|neural|hemkala|sagar/i.test(v.name) && /online/i.test(v.name),
  );
  if (neural) return neural;
  // Tier 2: any voice with "neural" or "natural" in name.
  const goodish = nepali.find((v) => /natural|neural/i.test(v.name));
  if (goodish) return goodish;
  // Tier 3: don't return anything — basic SAPI Nepali voices are usually
  // worse than the cloud Edge TTS. Force cloud path.
  return null;
}

async function playDevanagariSentence(args: {
  tts: HardenedTTS;
  sentenceText: string;
  lang: string;
  rate: number;
  isParagraphStart: boolean;
  /** Optional Edge TTS voice name (e.g. "ne-NP-HemkalaNeural"). */
  edgeVoice?: string;
  /** Silence to insert between each word in the synthesized audio. */
  wordGapMs?: number;
  onEnd: () => void;
  onError: (reason: string) => void;
}): Promise<void> {
  const startPlayback = () => {
    args.tts.speak({
      text: args.sentenceText,
      rate: args.rate,
      lang: args.lang,
      cloud: {
        sentenceText: args.sentenceText,
        startSec: 0,
        endSec: 1e9,
        edgeVoice: args.edgeVoice,
        wordGapMs: args.wordGapMs,
      },
      onEnd: args.onEnd,
      onError: args.onError,
    });
  };

  if (args.isParagraphStart) {
    args.tts.speak({
      text: "New paragraph.",
      rate: 1.0,
      lang: "en-US",
      onEnd: startPlayback,
      onError: () => startPlayback(),
    });
  } else {
    startPlayback();
  }
}

export interface RuntimeState {
  status: "IDLE" | "PLAYING" | "PAUSED" | "WAITING_FOR_USER";
  globalSentenceIndex: number;
  totalSentences: number;
  pace: PaceConfig;
  mode: DictationMode;
  wordIndex: number;
  currentSentence: Sentence | null;
  currentChunkText: string | null;
  announcement: string;
  micEnabled: boolean;
  voiceSupported: boolean;
  ttsSupported: boolean;
  ttsError: string | null;
  autoAdvance: boolean;
  announcePunctuation: boolean;
  voices: ShrutiVoice[];
  selectedVoiceURI: string | null;
}

/**
 * Voice descriptor for the picker. Combines real browser voices with
 * virtual cloud voices that resolve to server-side Edge TTS. The picker
 * treats them uniformly; the runtime branches on `kind` at playback.
 */
export interface ShrutiVoice {
  voiceURI: string;
  name: string;
  lang: string;
  kind: "browser" | "edge-cloud";
  /** Display group used by the picker UI. */
  group: "English (browser)" | "Nepali (cloud)" | "Nepali (browser)" | "Other (browser)";
}

/** Edge-TTS Nepali voices, available everywhere via the server route. */
const EDGE_CLOUD_VOICES: ShrutiVoice[] = [
  {
    voiceURI: "edge:ne-NP-HemkalaNeural",
    name: "Hemkala (Nepali, Neural — Online)",
    lang: "ne-NP",
    kind: "edge-cloud",
    group: "Nepali (cloud)",
  },
  {
    voiceURI: "edge:ne-NP-SagarNeural",
    name: "Sagar (Nepali, Neural — Online)",
    lang: "ne-NP",
    kind: "edge-cloud",
    group: "Nepali (cloud)",
  },
];

function classifyBrowserVoice(v: SpeechSynthesisVoice): ShrutiVoice["group"] {
  const lang = v.lang.toLowerCase();
  if (lang.startsWith("en")) return "English (browser)";
  if (lang.startsWith("ne")) return "Nepali (browser)";
  return "Other (browser)";
}

function browserVoiceToShruti(v: SpeechSynthesisVoice): ShrutiVoice {
  return {
    voiceURI: v.voiceURI,
    name: v.name,
    lang: v.lang,
    kind: "browser",
    group: classifyBrowserVoice(v),
  };
}

export interface RuntimeApi {
  state: RuntimeState;
  start(): void;
  next(): void;
  repeat(): void;
  back(): void;
  pause(): void;
  resume(): void;
  spell(): void;
  where(): void;
  setPace(pace: PaceConfig): void;
  setMode(mode: DictationMode): void;
  setMicEnabled(on: boolean): void;
  resetMic(): void;
  setAutoAdvance(on: boolean): void;
  setAnnouncePunctuation(on: boolean): void;
  setVoiceURI(uri: string | null): void;
}

export function useDictationRuntime(
  doc: DictationDocument | null,
  initialPace: PaceConfig = PACE_PRESETS.medium,
  initialMode: DictationMode = "sentence",
): RuntimeApi {
  const ttsRef = useRef<HardenedTTS | null>(null);
  const sessionRef = useRef<DictationSession | null>(null);
  const voiceRef = useRef<VoiceCapture | null>(null);
  const spellCancelRef = useRef<(() => void) | null>(null);
  const interSentenceTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const dispatchRef = useRef<(intent: Intent) => void>(() => {});
  const micEnabledRef = useRef(false);
  const [micEpoch, setMicEpoch] = useState(0); // bump to force full mic recreate

  const [status, setStatus] = useState<RuntimeState["status"]>("IDLE");
  const [globalSentenceIndex, setGlobalSentenceIndex] = useState(0);
  const [wordIndex, setWordIndex] = useState(0);
  const [pace, setPaceState] = useState<PaceConfig>(initialPace);
  const [mode, setModeState] = useState<DictationMode>(initialMode);
  const [announcement, setAnnouncement] = useState("");
  const [micEnabled, setMicEnabled] = useState(false);
  const [autoAdvance, setAutoAdvance] = useState(false);
  const [announcePunctuation, setAnnouncePunctuationState] = useState(true);
  const [ttsError, setTtsError] = useState<string | null>(null);
  const [browserVoices, setBrowserVoices] = useState<SpeechSynthesisVoice[]>([]);
  const [selectedVoiceURI, setSelectedVoiceURIState] = useState<string | null>(null);

  // Merge browser-installed voices with our virtual cloud voices into one
  // picker list. Cloud voices come first so Hemkala/Sagar are obvious.
  const voices = useMemo<ShrutiVoice[]>(() => {
    return [
      ...EDGE_CLOUD_VOICES,
      ...browserVoices.map(browserVoiceToShruti),
    ];
  }, [browserVoices]);
  const lastChunkWasSentenceEnd = useRef(false);

  // Build/rebuild session when doc changes.
  useEffect(() => {
    if (!doc) {
      sessionRef.current = null;
      return;
    }
    sessionRef.current = createDictationSession({
      doc, pace: initialPace, mode: initialMode, announcePunctuation,
    });
    setGlobalSentenceIndex(0);
    setWordIndex(0);
    setStatus("IDLE");
  }, [doc, initialPace, initialMode, announcePunctuation]);

  // Lazy TTS init (browser only).
  useEffect(() => {
    if (typeof window === "undefined") return;
    const tts = new HardenedTTS();
    ttsRef.current = tts;
    // Subscribe to the OS's async voice list. On first arrival, auto-pick
    // the highest-quality voice for the current language so the user
    // doesn't get the default robotic SAPI / eSpeak voice.
    const STORAGE_KEY = "shruti:voiceURI";
    const stored = typeof localStorage !== "undefined" ? localStorage.getItem(STORAGE_KEY) : null;
    let autoPicked = false;
    const unsubscribe = tts.onVoicesChanged((vs) => {
      setBrowserVoices(vs);
      if (!autoPicked && vs.length > 0) {
        // Prefer stored preference if it still exists.
        const storedExists = stored && vs.some((v) => v.voiceURI === stored);
        if (storedExists) {
          setSelectedVoiceURIState(stored);
        } else {
          const best = tts.pickBestVoice("en-US");
          if (best) setSelectedVoiceURIState(best.voiceURI);
        }
        autoPicked = true;
      }
    });
    return () => {
      unsubscribe();
      tts.cancel();
      HardenedTTS.sweepBlobUrls();
    };
  }, []);

  const ttsSupported = useMemo(
    () => typeof window !== "undefined" && "speechSynthesis" in window,
    [],
  );
  const voiceSupported = useMemo(
    () =>
      typeof window !== "undefined" &&
      ("SpeechRecognition" in window || "webkitSpeechRecognition" in window),
    [],
  );

  const currentSentence = useMemo<Sentence | null>(() => {
    return sessionRef.current?.currentSentence() ?? null;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [globalSentenceIndex, doc]);

  const currentChunkText = useMemo<string | null>(() => {
    return sessionRef.current?.currentChunkText() ?? null;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [globalSentenceIndex, wordIndex, mode, doc]);

  const totalSentences = doc?.progressMap.totalSentences ?? 0;

  const handleEvents = useCallback(
    (events: SessionEvent[]) => {
      const tts = ttsRef.current;
      for (const ev of events) {
        switch (ev.type) {
          case "STOP_TTS": {
            spellCancelRef.current?.();
            spellCancelRef.current = null;
            if (interSentenceTimerRef.current) {
              clearTimeout(interSentenceTimerRef.current);
              interSentenceTimerRef.current = null;
            }
            tts?.cancel();
            break;
          }
          case "PERSIST": {
            setGlobalSentenceIndex(ev.state.globalSentenceIndex);
            setWordIndex(ev.state.wordIndex);
            setStatus(ev.state.status);
            // Synchronously gate voice — don't wait for the status effect.
            // PLAYING → mic-deaf, anything else → mic-accepting.
            const vc = voiceRef.current;
            if (vc && micEnabledRef.current) {
              vc.setListening(ev.state.status !== "PLAYING");
            }
            // Rolling pre-fetch N+1 and N+2
            if (doc && ev.state.status === "PLAYING") {
              const allSentences = doc.chunks.paragraphs.flatMap((p) => p.sentences);
              const prefetchTexts: string[] = [];
              const next1 = allSentences[ev.state.globalSentenceIndex + 1];
              const next2 = allSentences[ev.state.globalSentenceIndex + 2];
              const devanagariRegex = /[\u0900-\u097F]/;
              if (next1 && devanagariRegex.test(next1.text)) prefetchTexts.push(next1.text);
              if (next2 && devanagariRegex.test(next2.text)) prefetchTexts.push(next2.text);
              
              if (prefetchTexts.length > 0) {
                const edgeVoice = extractEdgeVoiceName(selectedVoiceURI);
                prewarmAudio({
                  texts: prefetchTexts,
                  voice: edgeVoice,
                  lang: "ne-NP",
                  wordGapMs: pace.intraSentenceWordGapMs,
                });
              }
            }
            break;
          }
          case "SPEAK": {
            if (!tts) break;
            const rateForWpm = pace.wpm / 150;
            lastChunkWasSentenceEnd.current = ev.isSentenceEnd;
            const speakText = ev.isParagraphStart
              ? `New paragraph. ${ev.text}`
              : ev.text;
            const lang = ev.isDevanagari ? "ne-NP" : "en-US";

            // Devanagari path: always play the WHOLE sentence as one
            // continuous Edge TTS take. The FSM is configured so Nepali
            // content stays in sentence mode (set in chunkDocument hook),
            // so the chunk text IS the sentence text — no slicing.
            if (ev.isDevanagari) {
              // Send the CHUNK text (word / phrase / sentence) — not the
              // full sentence. Each chunk gets its own Edge TTS call so
              // word mode produces real pauses between words and phrase
              // mode pauses between phrases, controlled by the pace
              // setting. The cache is keyed by chunk text so common
              // Nepali words across sentences hit the cache often.
              const chunkText = ev.text;

              // Voice routing for Devanagari content:
              //   - If the user explicitly picked an "edge:..." cloud voice,
              //     send it through the server with that voice name.
              //   - If they picked a browser Nepali voice, use it directly.
              //   - Otherwise auto-route: prefer a local Neural Nepali voice
              //     if one is installed, else default to cloud Edge TTS.
              const selected = voices.find((v) => v.voiceURI === selectedVoiceURI);
              const explicitCloud = selected?.kind === "edge-cloud";
              const explicitBrowserNepali =
                selected?.kind === "browser" && selected.lang.toLowerCase().startsWith("ne");
              const localNepaliVoice = pickLocalNepaliNeuralVoice(browserVoices);

              if (
                explicitBrowserNepali ||
                (!explicitCloud && localNepaliVoice)
              ) {
                const useVoice = explicitBrowserNepali
                  ? selected!.voiceURI
                  : localNepaliVoice!.voiceURI;
                tts.speak({
                  text: speakText,
                  rate: rateForWpm,
                  lang: "ne-NP",
                  voiceURI: useVoice,
                  onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
                  onError: (reason) => {
                    logWarn("local Nepali voice failed, going cloud:", reason);
                    void playDevanagariSentence({
                      tts, sentenceText: chunkText, lang, rate: rateForWpm,
                      isParagraphStart: false,
                      edgeVoice: extractEdgeVoiceName(selectedVoiceURI),
                      wordGapMs: pace.intraSentenceWordGapMs,
                      onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
                      onError: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
                    });
                  },
                });
                break;
              }

              void playDevanagariSentence({
                tts,
                sentenceText: chunkText,
                lang,
                rate: rateForWpm,
                isParagraphStart: ev.isParagraphStart,
                edgeVoice: extractEdgeVoiceName(selectedVoiceURI),
                wordGapMs: pace.intraSentenceWordGapMs,
                onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
                onError: (reason) => {
                  logWarn("cloud TTS failed, last-resort browser:", reason);
                  const fallbackVoice = tts.pickBestVoice("ne-NP")?.voiceURI;
                  tts.speak({
                    text: speakText,
                    rate: rateForWpm,
                    lang: "ne-NP",
                    voiceURI: fallbackVoice,
                    onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
                    onError: (r2) => {
                      setTtsError(r2);
                      dispatchRef.current({ type: "CHUNK_FINISHED" });
                    },
                  });
                },
              });
              break;
            }

            // English / Latin path — pick best browser voice. Cloud voices
            // (kind === "edge-cloud") don't apply here, so we ignore them
            // and reach for a real browser voice.
            let voiceURI: string | undefined = undefined;
            const englishSelected = voices.find(
              (v) => v.voiceURI === selectedVoiceURI && v.kind === "browser",
            );
            if (
              englishSelected &&
              englishSelected.lang.toLowerCase().startsWith(lang.split("-")[0].toLowerCase())
            ) {
              voiceURI = englishSelected.voiceURI;
            } else {
              voiceURI = tts.pickBestVoice(lang)?.voiceURI;
            }
            tts.speak({
              text: speakText,
              rate: rateForWpm,
              pitch: 1.0,
              voiceURI,
              lang,
              onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
              onError: (reason) => setTtsError(reason),
            });
            break;
          }
          case "SPELL": {
            if (!tts) {
              logWarn(" SPELL: no TTS available");
              dispatchRef.current({ type: "CHUNK_FINISHED" });
              break;
            }
            if (!ev.words.length) {
              logWarn(" SPELL: empty word list (cursor at end?)");
              dispatchRef.current({ type: "CHUNK_FINISHED" });
              break;
            }
            const lang = ev.words.some((w) => /\p{Script=Devanagari}/u.test(w))
              ? "ne-NP"
              : "en-US";
            const utteranceParts: string[] = ev.words.map((w) => {
              const tokens = doc?.spellingTokens[w] ?? [];
              const units = tokens.length ? tokens.map((t) => t.unit) : Array.from(w);
              return units.join(" ");
            });
            const utterance = utteranceParts.join(". ");
            logDebug("SPELL utterance:", JSON.stringify(utterance), "lang=", lang);
            spellCancelRef.current?.();
            spellCancelRef.current = null;
            const rate = Math.max(pace.wpm / 150, 0.9);
            tts.speak({
              text: utterance,
              rate,
              lang,
              onEnd: () => dispatchRef.current({ type: "CHUNK_FINISHED" }),
              onError: (reason) => {
                logWarn(" SPELL TTS error:", reason);
                dispatchRef.current({ type: "CHUNK_FINISHED" });
              },
            });
            break;
          }
          case "ANNOUNCE":
            // Re-arm by clearing first so identical messages still re-trigger
            // aria-live, then auto-clear shortly so the region doesn't sit
            // populated and tempt readers to re-narrate.
            setAnnouncement("");
            setTimeout(() => setAnnouncement(ev.text), 30);
            setTimeout(() => setAnnouncement(""), 4000);
            break;
          case "IGNORED":
            break;
        }
      }
      // Status may have changed from SPEAK (PLAYING) without a PERSIST event.
      const live = sessionRef.current?.getState();
      if (live) {
        setStatus(live.status);
        setGlobalSentenceIndex(live.globalSentenceIndex);
        setWordIndex(live.wordIndex);
      }
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [doc, pace.wpm, pace.interSentencePauseMs, pace.interWordPauseMs],
  );

  const dispatch = useCallback(
    (intent: Intent) => {
      const session = sessionRef.current;
      if (!session) return;
      const events = session.dispatch(intent);
      handleEvents(events);
    },
    [handleEvents],
  );

  // Keep a stable ref so long-lived listeners (TTS callbacks, recognition
  // handlers) don't capture a stale dispatch and don't trigger effect churn.
  useEffect(() => {
    dispatchRef.current = dispatch;
  }, [dispatch]);

  useEffect(() => {
    micEnabledRef.current = micEnabled;
  }, [micEnabled]);

  // Voice capture lifecycle: one MediaRecorder + AudioContext per mic-enabled
  // epoch. No SpeechRecognition = no browser-level "recording region"
  // announcement. The user gets one permission prompt and then complete
  // silence from the screen reader.
  useEffect(() => {
    if (!micEnabled || !voiceSupported) return;

    const vc = new VoiceCapture(
      {
        onTranscript: (alternatives) => {
          // Try each alternative in confidence order until one matches a
          // command. Chrome's top guess is often wrong on single-syllable
          // words (e.g. "necks"/"nest"/"neck" for "next"), but a lower-
          // ranked guess often matches.
          for (const alt of alternatives) {
            const intent = matchCommand(alt.text);
            if (intent) {
              logDebug("voice:", alt.text, `(conf ${alt.confidence.toFixed(2)})`, "→", intent.type);
              dispatchRef.current(intent);
              return;
            }
          }
          // Nothing matched — log only the top guess so the console isn't noisy.
          logDebug("voice:", alternatives[0]?.text, "→ no match", alternatives.length > 1 ? `(tried ${alternatives.length})` : "");
        },
        onError: (reason) => {
          logDebug("voice error:", reason);
        },
      },
    );
    voiceRef.current = vc;
    void vc.start();

    return () => {
      voiceRef.current = null;
      vc.stop();
    };
  }, [micEnabled, voiceSupported, micEpoch]);

  // Auto-advance ("hands-free") mode: when Shruti finishes a chunk and the
  // FSM hits WAITING_FOR_USER, schedule the next chunk after a writing
  // pause sized for what was JUST SPOKEN.
  //
  // Why this isn't a fixed value: a one-word sentence ("Yes.") and a
  // twenty-word sentence both ended with the user needing to write what
  // they just heard. A fixed 3-second pause is too short for the long
  // sentence and too long for the short one. We scale the pause by the
  // spokenWordCount of the sentence that just finished — based on
  // `ttsReadyText`-style expansion, so "B.S. 2065" (which expands to
  // "Bikram Sambat 2065" — 4 spoken words) gets the right time even
  // though the raw text is shorter.
  useEffect(() => {
    if (!autoAdvance) return;
    if (status !== "WAITING_FOR_USER") return;
    const ms = computeWritingPauseMs({
      pace,
      isSentenceEnd: lastChunkWasSentenceEnd.current,
      sentence: sessionRef.current?.currentSentence() ?? null,
    });
    const t = setTimeout(() => {
      dispatchRef.current({ type: "NEXT" });
    }, ms);
    return () => clearTimeout(t);
  }, [status, autoAdvance, pace.interSentencePauseMs, pace.interWordPauseMs, pace.wpm]);

  // Voice listening gate: keep recognizer alive but reject results
  // arriving while we're in PLAYING. Driven from BOTH a status effect
  // (for IDLE/PAUSED transitions) and synchronously inside handleEvents
  // (for SPEAK / STOP_TTS — those gate timing matters within the same
  // React tick so Shruti's TTS bleed-in doesn't slip through).
  useEffect(() => {
    const vc = voiceRef.current;
    if (!vc) return;
    const shouldListen =
      micEnabled && (status === "WAITING_FOR_USER" || status === "PAUSED" || status === "IDLE");
    vc.setListening(shouldListen);
  }, [status, micEnabled, micEpoch]);

  // Keyboard shortcuts (work on the dictation page only).
  //   Space            next chunk
  //   B                back chunk
  //   Shift+Space      next sentence
  //   Shift+B          previous sentence
  //   Ctrl/Cmd+Space   next paragraph
  //   Ctrl/Cmd+B       previous paragraph
  //   Home             go to start
  //   End              go to end
  //   R / S / P / W    repeat / spell / pause-or-resume / where
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      const target = e.target as HTMLElement | null;
      if (target && (target.tagName === "INPUT" || target.tagName === "TEXTAREA" || target.isContentEditable)) {
        return;
      }
      const ctrl = e.ctrlKey || e.metaKey;
      const shift = e.shiftKey;
      const key = e.key.toLowerCase();
      switch (key) {
        case " ":
          e.preventDefault();
          if (ctrl) dispatch({ type: "NEXT_PARAGRAPH" });
          else if (shift) dispatch({ type: "NEXT_SENTENCE" });
          else dispatch({ type: "NEXT" });
          break;
        case "b":
          if (ctrl) { e.preventDefault(); dispatch({ type: "PREV_PARAGRAPH" }); }
          else if (shift) dispatch({ type: "PREV_SENTENCE" });
          else dispatch({ type: "BACK" });
          break;
        case "home":
          e.preventDefault();
          dispatch({ type: "GO_TO_START" });
          break;
        case "end":
          e.preventDefault();
          dispatch({ type: "GO_TO_END" });
          break;
        case "r": dispatch({ type: "REPEAT" }); break;
        case "p": dispatch({ type: status === "PAUSED" ? "RESUME" : "PAUSE" }); break;
        case "s": dispatch({ type: "SPELL" }); break;
        case "w": dispatch({ type: "WHERE" }); break;
      }
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [dispatch, status]);

  const api: RuntimeApi = {
    state: {
      status,
      globalSentenceIndex,
      totalSentences,
      pace,
      mode,
      wordIndex,
      currentSentence,
      currentChunkText,
      announcement,
      micEnabled,
      ttsSupported,
      voiceSupported,
      ttsError,
      autoAdvance,
      announcePunctuation,
      voices,
      selectedVoiceURI,
    },
    start: () => dispatch({ type: "START" }),
    next: () => dispatch({ type: "NEXT" }),
    repeat: () => dispatch({ type: "REPEAT" }),
    back: () => dispatch({ type: "BACK" }),
    pause: () => dispatch({ type: "PAUSE" }),
    resume: () => dispatch({ type: "RESUME" }),
    spell: () => dispatch({ type: "SPELL" }),
    where: () => dispatch({ type: "WHERE" }),
    setPace: (p) => { setPaceState(p); dispatch({ type: "SET_PACE", pace: p }); },
    setMode: (m) => { setModeState(m); dispatch({ type: "SET_MODE", mode: m }); },
    setMicEnabled,
    resetMic: () => setMicEpoch((n) => n + 1),
    setAutoAdvance,
    setAnnouncePunctuation: (on: boolean) => {
      setAnnouncePunctuationState(on);
      dispatch({ type: "SET_ANNOUNCE_PUNCT", on });
    },
    setVoiceURI: (uri: string | null) => {
      setSelectedVoiceURIState(uri);
      if (typeof localStorage !== "undefined") {
        if (uri) localStorage.setItem("shruti:voiceURI", uri);
        else localStorage.removeItem("shruti:voiceURI");
      }
    },
  };
  return api;
}

// Command alias table: deterministic, no LLM.
// Each row gives the intent and a set of trigger phrases. We match by
// finding the EARLIEST occurrence of any phrase in the transcript, which
// is much more robust than first-row-wins: if Gemini returns "spell next",
// the spell command (which appears first in the text) wins — and that's
// what the user actually said.
// Web Speech returns free-form text. We map any keyword from this list to
// an intent. Earliest occurrence wins so "spell next" → SPELL (the user
// said spell first), and similar-sounding mis-transcriptions are covered
// (e.g. Chrome often hears "spell" as "smell"; "next" sometimes as "text").
// Order matters: more specific multi-word phrases must come FIRST so that
// "next sentence" wins over bare "next".
const COMMAND_KEYWORDS: Array<{ words: string[]; intent: Intent }> = [
  // Structural navigation — multi-word phrases that must be matched before
  // the single-word fallback variants below.
  { words: [
      "next paragraph", "skip paragraph", "next para",
    ], intent: { type: "NEXT_PARAGRAPH" } },
  { words: [
      "previous paragraph", "last paragraph", "back paragraph", "previous para",
    ], intent: { type: "PREV_PARAGRAPH" } },
  { words: [
      "next sentence", "skip sentence",
    ], intent: { type: "NEXT_SENTENCE" } },
  { words: [
      "previous sentence", "last sentence", "back sentence",
    ], intent: { type: "PREV_SENTENCE" } },
  { words: [
      "go to start", "start of document", "beginning", "go to beginning", "from the top",
    ], intent: { type: "GO_TO_START" } },
  { words: [
      "go to end", "end of document", "last word", "go to last",
    ], intent: { type: "GO_TO_END" } },
  // Single-token commands.
  { words: ["spell", "smell", "spelt", "spelling", "spell it", "spell that"], intent: { type: "SPELL" } },
  { words: ["repeat", "again", "really", "retreat", "repete", "repeat that", "say again"], intent: { type: "REPEAT" } },
  { words: ["back", "previous", "rewind", "go back", "last"],  intent: { type: "BACK" } },
  { words: ["where", "wear", "where am i", "position"],        intent: { type: "WHERE" } },
  { words: ["pause", "paws", "pose", "stop", "wait", "hold"],  intent: { type: "PAUSE" } },
  { words: ["resume", "play", "go on", "carry on"],            intent: { type: "RESUME" } },
  { words: [
      "next", "text", "rest", "necks", "nest", "neck", "checks",
      "nicks", "knicks", "necs", "naxt", "nax", "knecks",
      "continue", "advance",
    ], intent: { type: "NEXT" } },
];

// Pre-compute multi-word phrases vs single tokens for matching.
const COMMAND_PHRASES = COMMAND_KEYWORDS.flatMap((row) =>
  row.words.map((w) => ({ phrase: w, intent: row.intent })),
);

function matchCommand(transcript: string): Intent | null {
  const cleaned = transcript.toLowerCase().replace(/[^a-z\s]/g, " ").replace(/\s+/g, " ").trim();
  if (!cleaned) return null;
  // Exact phrase match first (covers "spell it", "go back", "where am i" etc.).
  for (const row of COMMAND_PHRASES) {
    if (cleaned === row.phrase) return row.intent;
  }
  // Substring phrase match — "okay next" / "uh next" → NEXT.
  for (const row of COMMAND_PHRASES) {
    if (row.phrase.includes(" ")) {
      if (cleaned.includes(row.phrase)) return row.intent;
    }
  }
  // Token-by-token: earliest matching single word in the transcript wins.
  const tokens = cleaned.split(/\s+/);
  for (const tok of tokens) {
    for (const row of COMMAND_KEYWORDS) {
      if (row.words.includes(tok)) return row.intent;
    }
  }
  return null;
}
