"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Card } from "@/components/ui/card";
import {
  chunkDocument,
  DictationDocument,
  DictationMode,
  PACE_PRESETS,
  PaceConfig,
} from "@/features/shruti";
import { useDictationRuntime } from "@/features/shruti/useDictationRuntime";
import {
  ExtractionResult,
  extractImagesText,
  extractPdfPages,
  LIMITS,
} from "@/features/shruti/sourceExtractors";

const MODES: Array<{ value: DictationMode; label: string; hint: string }> = [
  { value: "word",     label: "Word by word", hint: "One word at a time — easiest for new learners" },
  { value: "phrase",   label: "Phrase",       hint: "Three words at a time" },
  { value: "sentence", label: "Sentence",     hint: "Full sentence — best for fluent writers" },
];

const PACE_ORDER: Array<keyof typeof PACE_PRESETS> = ["slow", "medium", "fast", "sprint"];

const SAMPLE = `Public Administration in Nepal has evolved through many phases. Dr. K. Adhikari notes that reform efforts in B.S. 2065 emphasized decentralization. However, capacity gaps persist at the local level.

The Constitution of 2015 established a federal structure with three tiers: federal, provincial, and local. This restructuring required new institutional arrangements, including civil service realignment, fiscal transfers, and inter-governmental coordination mechanisms.`;

export default function ShrutiDictationPage() {
  const [text, setText] = useState<string>(SAMPLE);
  const [pace, setPace] = useState<PaceConfig>(PACE_PRESETS.medium);
  const [mode, setMode] = useState<DictationMode>("word");
  const [doc, setDoc] = useState<DictationDocument | null>(null);
  const [issues, setIssues] = useState<string[]>([]);
  // Auto-advance explicit pause durations (in seconds).
  const [autoWordGapSec, setAutoWordGapSec] = useState<number>(3);
  const [autoSentenceGapSec, setAutoSentenceGapSec] = useState<number>(6);

  // Derive the effective pace when auto-advance is on. We inherit the reading
  // speed (wpm) and natural pauses from the user's base pace selection, but
  // strictly override the writing pauses with their explicit slider choices.
  const effectivePace = useMemo<PaceConfig>(() => {
    return {
      preset: "custom",
      wpm: pace.wpm,
      intraSentenceWordGapMs: pace.intraSentenceWordGapMs,
      interWordPauseMs: autoWordGapSec * 1000,
      interSentencePauseMs: autoSentenceGapSec * 1000,
    };
  }, [pace, autoWordGapSec, autoSentenceGapSec]);

  const runtime = useDictationRuntime(doc, pace, mode);

  // Synchronize the pace into the runtime. When auto-advance is on, we use
  // the slider-derived `effectivePace`. Otherwise, we use the user's selected base `pace`.
  useEffect(() => {
    if (runtime.state.autoAdvance) {
      runtime.setPace(effectivePace);
    } else {
      // Revert to base pace if auto-advance is turned off
      runtime.setPace(pace);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [runtime.state.autoAdvance, effectivePace, pace]);

  // Hydration gate: capability checks read `window`, which differs between
  // server and client. Render that UI only after first client paint.
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  const canStart = useMemo(() => text.trim().length > 0, [text]);

  // Pre-synthesis state. The active prepare's AbortController lives in a
  // ref so changes to source text / pace / voice / new uploads can cancel
  // it without re-running the whole prepare function.
  const [synthProgress, setSynthProgress] = useState<{ done: number; total: number } | null>(null);
  const [prepareNotice, setPrepareNotice] = useState<string | null>(null);
  const synthAbortRef = useRef<AbortController | null>(null);

  /** Cancel any in-flight prepare. Safe to call when nothing is running. */
  const cancelPrepare = (reason: string | null = null) => {
    if (synthAbortRef.current) {
      synthAbortRef.current.abort();
      synthAbortRef.current = null;
      if (reason) setPrepareNotice(reason);
    }
    setSynthProgress(null);
  };

  const prepare = async () => {
    // Cancel any prior prepare first so we don't have two queues fighting
    // for the same hot LRU / Edge TTS rate limit.
    cancelPrepare();
    setPrepareNotice(null);

    const { doc: built, issues: found } = chunkDocument(text, {
      id: crypto.randomUUID(),
      title: "Untitled passage",
      sourceType: "paste",
    });
    setIssues(found.map((i) => i.message));

    const isDevanagari = /\p{Script=Devanagari}/u.test(built.normalizedText);

    if (!isDevanagari) {
      setDoc(built);
      return;
    }

    // Pre-synth list depends on the active mode — synthesize at the
    // granularity the user will play at, so the cache is warm for the
    // actual chunks rather than wasting on sentence audio that will
    // never be played in word mode.
    const allSentences = built.chunks.paragraphs.flatMap((p) => p.sentences);
    let targets: string[];
    if (mode === "word") {
      // Unique words only — many sentences share common Nepali words.
      const unique = new Set<string>();
      for (const s of allSentences) for (const w of s.words) unique.add(w);
      targets = Array.from(unique);
    } else if (mode === "phrase") {
      const PHRASE = 3;
      const phrases = new Set<string>();
      for (const s of allSentences) {
        for (let i = 0; i < s.words.length; i += PHRASE) {
          phrases.add(s.words.slice(i, i + PHRASE).join(" "));
        }
      }
      targets = Array.from(phrases);
    } else {
      targets = allSentences.map((s) => s.text);
    }
    const sentences = targets;
    const ac = new AbortController();
    synthAbortRef.current = ac;
    setSynthProgress({ done: 0, total: sentences.length });
    
    // Transition to the Dictation Player immediately! We do not want to block
    // the user for 60+ seconds while every single word is pre-fetched from 
    // the TTS API. The background pre-fetcher will continue warming the cache.
    setDoc(built);

    const edgeVoice = runtime.state.selectedVoiceURI && runtime.state.selectedVoiceURI.startsWith("edge:")
      ? runtime.state.selectedVoiceURI.slice("edge:".length)
      : undefined;

    const { presynthesizeAll } = await import("@/features/shruti/audioCache");
    try {
      // Fire-and-forget background pre-synthesis
      await presynthesizeAll(sentences, {
        concurrency: 1, // Keep concurrency low to avoid Microsoft Edge TTS Quota errors
        voice: edgeVoice,
        lang: "ne-NP",
        wordGapMs: pace.intraSentenceWordGapMs,
        signal: ac.signal,
        onProgress: (done, total) => {
          if (ac.signal.aborted) return;
          setSynthProgress({ done, total });
        },
        onQuotaError: (err) => {
          const scope = err.scope === "daily"
            ? "Daily Edge TTS rate limit reached."
            : "Edge TTS rate limit hit.";
          const retry = err.retryAfter ? ` Try again in ${err.retryAfter}.` : "";
          setPrepareNotice(`${scope}${retry} Playback will fall back to your browser's built-in Nepali voice (lower quality).`);
        },
      });
    } finally {
      if (synthAbortRef.current === ac) {
        synthAbortRef.current = null;
        setSynthProgress(null);
      }
    }
  };

  // Cancel pending prepare when any setting that would invalidate the
  // synthesis changes: source text, selected voice, pace, mode. The user
  // is then prompted to click Prepare again with the new settings.
  useEffect(() => {
    if (synthAbortRef.current) {
      cancelPrepare("Settings changed — preparation cancelled. Click Prepare to retry.");
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [text, mode, runtime.state.selectedVoiceURI, pace.preset, pace.wpm]);

  // Cleanup on unmount.
  useEffect(() => {
    return () => synthAbortRef.current?.abort();
  }, []);

  const startNow = async () => {
    if (!doc) {
      await prepare();
    }
    // prepare() updates doc state asynchronously; defer start one tick so
    // useDictationRuntime sees the new doc.
    setTimeout(() => runtime.start(), 0);
  };

  // Primary action button morphs by FSM status:
  //   no doc                       → "Prepare & Start"
  //   IDLE with doc                → "Start"
  //   PLAYING / WAITING_FOR_USER   → "Stop"  (halts dictation, returns to IDLE)
  //   PAUSED                       → "Resume"
  // "Restart from beginning" is shown as a separate secondary button once
  // dictation has started, so the user always has a clear path to either
  // stop or restart without overloading the primary action.
  const status = runtime.state.status;
  const hasStarted = doc !== null && status !== "IDLE";
  let primaryLabel: string;
  let primaryAction: () => void;
  let primaryVariant: "default" | "outline" = "default";
  if (!doc) {
    primaryLabel = "Prepare & Start";
    primaryAction = startNow;
  } else if (status === "PAUSED") {
    primaryLabel = "Resume";
    primaryAction = runtime.resume;
  } else if (hasStarted) {
    primaryLabel = "Stop";
    primaryAction = runtime.pause;
    primaryVariant = "outline";
  } else {
    primaryLabel = "Start";
    primaryAction = startNow;
  }

  const restartFromBeginning = () => {
    prepare();
    setTimeout(() => runtime.start(), 0);
  };

  const activeModeHint = MODES.find((m) => m.value === mode)?.hint ?? "";
  const activePaceConfig = pace;
  const autoAdvanceApplies = mode === "word" || mode === "phrase";

  // Detect Devanagari in the current source text. Word and phrase modes
  // ARE supported now — each chunk gets its own Edge TTS call. The
  // mode dropdown stays freely usable for Nepali.
  const isDevanagariSource = useMemo(
    () => /\p{Script=Devanagari}/u.test(text),
    [text],
  );

  // Auto-advance is now allowed in all modes (sentence mode + auto-advance is
  // the primary Nepali workflow). No coercion needed.

  // ─── Source upload state ──────────────────────────────────────────────
  type SourceTab = "paste" | "pdf" | "image";
  const [sourceTab, setSourceTab] = useState<SourceTab>("paste");
  const [extraction, setExtraction] = useState<ExtractionResult | null>(null);
  const [selectedPageIdx, setSelectedPageIdx] = useState<number>(0);
  const [extracting, setExtracting] = useState(false);
  const [extractError, setExtractError] = useState<string | null>(null);

  const onPdfChosen = async (file: File) => {
    // New source upload supersedes any pending prepare.
    cancelPrepare("New PDF loaded — preparation cancelled. Click Prepare to retry.");
    setExtractError(null);
    setExtracting(true);
    try {
      const result = await extractPdfPages(file);
      setExtraction(result);
      setSelectedPageIdx(0);
      const first = result.pages[0];
      if (first) setText(first.text);
    } catch (err) {
      setExtractError(err instanceof Error ? err.message : "pdf_extract_failed");
    } finally {
      setExtracting(false);
    }
  };

  const onImagesChosen = async (files: File[]) => {
    cancelPrepare("New images loaded — preparation cancelled. Click Prepare to retry.");
    setExtractError(null);
    setExtracting(true);
    try {
      const result = await extractImagesText(files);
      setExtraction(result);
      setSelectedPageIdx(0);
      const first = result.pages[0];
      if (first) setText(first.text);
    } catch (err) {
      setExtractError(err instanceof Error ? err.message : "image_extract_failed");
    } finally {
      setExtracting(false);
    }
  };

  const onPageSelect = (idx: number) => {
    if (!extraction) return;
    setSelectedPageIdx(idx);
    const page = extraction.pages[idx];
    if (page) setText(page.text);
  };

  return (
    <div className="mx-auto w-full max-w-3xl px-3 sm:px-4 py-6 sm:py-8 space-y-5 sm:space-y-6">
      <header>
        <h1 id="main-heading" className="text-2xl sm:text-3xl font-semibold tracking-tight">
          Shruti Dictation
        </h1>
        <p className="text-sm sm:text-base text-slate-600 dark:text-slate-400 mt-1">
          Shruti reads. You write. Hands-free Braille practice with paced audio.
        </p>
      </header>

      {mounted && !runtime.state.ttsSupported && (
        <Card className="p-4 border-amber-400 bg-amber-50 dark:bg-amber-950/30">
          <p className="text-sm">
            <strong>Your browser does not support speech synthesis.</strong> Shruti needs the
            Web Speech API to read English text aloud. Please use a recent version of Chrome,
            Edge, or Safari. Nepali content can still play through the server-side neural
            voice even without browser TTS.
          </p>
        </Card>
      )}

      {mounted && runtime.state.ttsError && (
        <Card className="p-3 border-red-300 bg-red-50 dark:bg-red-950/30">
          <p className="text-sm">
            <strong>TTS error:</strong> {runtime.state.ttsError}.
            Try clicking <em>Restart</em> or refreshing the page.
          </p>
        </Card>
      )}

      {/* ─── 1. Source text ──────────────────────────────────────────── */}
      <section aria-labelledby="src-heading" className="space-y-3">
        <h2 id="src-heading" className="text-lg font-medium">1. Your text</h2>

        {/* Source tabs */}
        <div
          className="flex space-x-2 border-b border-slate-200 dark:border-slate-800 mb-6"
          role="tablist"
        >
          {[
            { id: "paste", label: "Paste text" },
            { id: "pdf",   label: "Upload PDF" },
            { id: "image", label: "Upload images" },
          ].map((t) => {
            const active = sourceTab === t.id;
            return (
              <button
                key={t.id}
                role="tab"
                aria-selected={active}
                onClick={() => setSourceTab(t.id as SourceTab)}
                className={
                  "shrink-0 px-4 py-2.5 text-sm font-semibold border-b-2 -mb-px transition-all duration-200 " +
                  (active
                    ? "border-emerald-500 text-emerald-700 dark:text-emerald-400"
                    : "border-transparent text-slate-500 hover:text-slate-800 hover:border-slate-300 dark:text-slate-400 dark:hover:text-slate-200 dark:hover:border-slate-600")
                }
              >
                {t.label}
              </button>
            );
          })}
        </div>

        {sourceTab === "pdf" && (
          <div className="space-y-3 rounded-2xl border border-slate-200 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900/50 p-6 transition-all">
            <label className="block text-sm cursor-pointer group">
              <span className="block font-semibold text-slate-900 dark:text-slate-100 mb-1 group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">Upload a PDF Document</span>
              <span className="block text-xs text-slate-500 dark:text-slate-400 mb-4 leading-relaxed">
                Up to {LIMITS.MAX_PDF_PAGES} pages will be extracted locally. Your file is never uploaded to a server.
              </span>
              <div className="flex items-center justify-center w-full p-8 border-2 border-dashed border-slate-300 dark:border-slate-700 rounded-xl group-hover:border-emerald-400 dark:group-hover:border-emerald-600 transition-colors bg-slate-50 dark:bg-slate-950/50">
                <input
                  type="file"
                  accept="application/pdf"
                  onChange={(e) => {
                    const f = e.target.files?.[0];
                    if (f) void onPdfChosen(f);
                  }}
                  className="text-sm text-slate-600 dark:text-slate-400 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-emerald-50 file:text-emerald-700 hover:file:bg-emerald-100 dark:file:bg-emerald-900/30 dark:file:text-emerald-400 dark:hover:file:bg-emerald-900/50 transition-all cursor-pointer"
                />
              </div>
            </label>
          </div>
        )}

        {sourceTab === "image" && (
          <div className="space-y-3 rounded-2xl border border-slate-200 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900/50 p-6 transition-all">
            <label className="block text-sm cursor-pointer group">
              <span className="block font-semibold text-slate-900 dark:text-slate-100 mb-1 group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">Upload Note Images</span>
              <span className="block text-xs text-slate-500 dark:text-slate-400 mb-4 leading-relaxed">
                Up to {LIMITS.MAX_IMAGES} images (PNG, JPG, HEIC). Processed via Gemini OCR for handwriting support.
              </span>
              <div className="flex items-center justify-center w-full p-8 border-2 border-dashed border-slate-300 dark:border-slate-700 rounded-xl group-hover:border-emerald-400 dark:group-hover:border-emerald-600 transition-colors bg-slate-50 dark:bg-slate-950/50">
                <input
                  type="file"
                  accept="image/*"
                  multiple
                  onChange={(e) => {
                    const files = Array.from(e.target.files ?? []);
                    if (files.length > 0) void onImagesChosen(files);
                  }}
                  className="text-sm text-slate-600 dark:text-slate-400 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-emerald-50 file:text-emerald-700 hover:file:bg-emerald-100 dark:file:bg-emerald-900/30 dark:file:text-emerald-400 dark:hover:file:bg-emerald-900/50 transition-all cursor-pointer"
                />
              </div>
            </label>
          </div>
        )}

        {extracting && (
          <div className="flex items-center gap-2 text-sm text-emerald-700 dark:text-emerald-300 bg-emerald-50 dark:bg-emerald-950/30 p-3 rounded-lg border border-emerald-200 dark:border-emerald-800">
            <span className="inline-block h-3 w-3 animate-pulse rounded-full bg-emerald-500 shrink-0" />
            <span>
              {sourceTab === "pdf"
                ? "Processing PDF... This may take up to 30 seconds if it is a scanned document."
                : "Extracting text... this can take a few seconds."}
            </span>
          </div>
        )}

        {extractError && (
          <div className="rounded-lg border border-red-300 bg-red-50 dark:bg-red-950/30 p-3 text-sm">
            <p className="font-medium text-red-800 dark:text-red-300">Could not extract text:</p>
            <p className="mt-1 text-red-700 dark:text-red-400">{extractError}</p>
          </div>
        )}

        {extraction && extraction.pages.length > 0 && (
          <div className="space-y-2">
            {extraction.source === "pdf" && (
              <div className="rounded border border-amber-300 bg-amber-50 dark:bg-amber-950/30 p-2 text-xs text-amber-800 dark:text-amber-300">
                <strong>Please review the extracted text before starting.</strong>{" "}
                PDFs with multi-column layouts, footnotes, or scanned pages may have
                jumbled word order. The editbox is editable — fix any issues there
                first.
              </div>
            )}
            {extraction.truncated && (
              <p className="text-xs text-amber-700 dark:text-amber-400">
                File had more pages — only the first {extraction.source === "pdf" ? LIMITS.MAX_PDF_PAGES : LIMITS.MAX_IMAGES} were extracted.
              </p>
            )}
            <label htmlFor="page-select" className="block text-sm font-medium">
              Select page to read
            </label>
            <select
              id="page-select"
              value={selectedPageIdx}
              onChange={(e) => onPageSelect(Number(e.target.value))}
              className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
            >
              {extraction.pages.map((p, i) => (
                <option key={i} value={i}>
                  {p.label}{p.text.trim() ? "" : " (empty)"}
                </option>
              ))}
            </select>
          </div>
        )}

        <textarea
          className="w-full h-80 rounded-xl border border-slate-300 bg-white px-5 py-4 text-sm leading-relaxed text-slate-900 shadow-inner focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-100 resize-y transition-all tracking-wide"
          placeholder="Type or paste text here (Nepali or English) to begin dictation..."
          value={text}
          onChange={(e) => setText(e.target.value)}
          disabled={runtime.state.status !== "IDLE"}
        />
        {!text.trim() && (
          <p className="text-sm text-slate-500">
            Add some text above to begin — paste a passage, upload a PDF, or upload images of your notes.
          </p>
        )}
        {issues.length > 0 && (
          <details className="text-sm text-amber-700 dark:text-amber-400">
            <summary className="cursor-pointer font-medium">
              {issues.length} formatting note{issues.length > 1 ? "s" : ""} (review before starting)
            </summary>
            <ul className="mt-2 list-disc pl-5 space-y-1">
              {issues.map((m, i) => <li key={i}>{m}</li>)}
            </ul>
          </details>
        )}
      </section>

      {/* ─── 2. Reading settings (unified panel) ─────────────────────── */}
      <section aria-labelledby="settings-heading" className="space-y-3">
        <h2 id="settings-heading" className="text-lg font-medium">2. Reading settings</h2>
        <Card className="p-4 sm:p-5 space-y-5">
          {/* Mode, Voice, Pace: native selects (best screen-reader support).
              Hidden entirely when auto-advance is on — the slider below
              replaces them. */}
          {!runtime.state.autoAdvance && (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <div className="space-y-1.5">
              <label htmlFor="mode-select" className="block text-sm font-medium">
                Reading mode
              </label>
              <select
                id="mode-select"
                value={mode}
                onChange={(e) => {
                  const v = e.target.value as DictationMode;
                  setMode(v);
                  runtime.setMode(v);
                }}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
                aria-describedby="mode-hint"
              >
                {MODES.map((m) => (
                  <option key={m.value} value={m.value}>
                    {m.label}
                  </option>
                ))}
              </select>
              <p id="mode-hint" className="text-xs text-slate-600 dark:text-slate-400">
                {activeModeHint}
              </p>
            </div>

            <div className="space-y-1.5">
              <label htmlFor="voice-select" className="block text-sm font-medium">
                Voice
              </label>
              <select
                id="voice-select"
                value={runtime.state.selectedVoiceURI ?? ""}
                onChange={(e) => runtime.setVoiceURI(e.target.value || null)}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
                aria-describedby="voice-hint"
                disabled={runtime.state.voices.length === 0}
              >
                {runtime.state.voices.length === 0 && (
                  <option value="">Loading voices…</option>
                )}
                {/* Group voices by category — cloud Nepali (Hemkala/Sagar)
                    first so they're easy to find, then browser voices by
                    language. Surfacing the cloud voices explicitly lets the
                    user override which Nepali voice they hear without
                    having to install anything locally. */}
                {(["Nepali (cloud)", "Nepali (browser)", "English (browser)", "Other (browser)"] as const).map((group) => {
                  const voicesInGroup = runtime.state.voices.filter((v) => v.group === group);
                  if (voicesInGroup.length === 0) return null;
                  return (
                    <optgroup key={group} label={group}>
                      {voicesInGroup.map((v) => (
                        <option key={v.voiceURI} value={v.voiceURI}>
                          {v.name}
                        </option>
                      ))}
                    </optgroup>
                  );
                })}
              </select>
              <p id="voice-hint" className="text-xs text-slate-600 dark:text-slate-400">
                <strong>Nepali (cloud)</strong> voices stream from Microsoft Edge TTS — free, no
                install. <strong>Browser</strong> voices use whatever your OS provides. Voices
                marked <em>Natural</em>, <em>Neural</em>, or <em>Enhanced</em> sound most human.
              </p>
            </div>

            <div className="space-y-1.5">
              <label htmlFor="pace-select" className="block text-sm font-medium">
                Pace
              </label>
              <select
                id="pace-select"
                value={pace.preset}
                onChange={(e) => {
                  const next = PACE_PRESETS[e.target.value as keyof typeof PACE_PRESETS];
                  setPace(next);
                  runtime.setPace(next);
                }}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
                aria-describedby="pace-hint"
              >
                {PACE_ORDER.map((key) => {
                  const p = PACE_PRESETS[key];
                  return (
                    <option key={key} value={key}>
                      {p.preset.charAt(0).toUpperCase() + p.preset.slice(1)} — {p.wpm} words / min
                    </option>
                  );
                })}
              </select>
              <p id="pace-hint" className="text-xs text-slate-600 dark:text-slate-400">
                Speech: natural pace, natural pitch (always).
                Inside a sentence: <strong>{Math.round(activePaceConfig.intraSentenceWordGapMs)}ms</strong> silence
                between each word. Writing pause:
                {" "}{Math.round(activePaceConfig.interWordPauseMs / 100) / 10}s between chunks,
                {" "}{Math.round(activePaceConfig.interSentencePauseMs / 100) / 10}s between sentences.
              </p>
            </div>
          </div>
          )}

          {/* Toggles, grouped */}
          <fieldset className="space-y-4 border-t pt-6 border-slate-200 dark:border-slate-800">
            <legend className="text-sm font-semibold px-1 text-slate-900 dark:text-slate-100 mb-2">Reading options</legend>

            <div className="space-y-3">
              <label className="flex items-start gap-3 text-sm cursor-pointer group">
                <input
                  type="checkbox"
                  checked={runtime.state.autoAdvance}
                  onChange={(e) => runtime.setAutoAdvance(e.target.checked)}
                  className="mt-0.5 h-4 w-4 rounded border-slate-300 text-emerald-600 focus:ring-emerald-600 transition-all cursor-pointer"
                />
                <span className="leading-tight">
                  <span className="font-medium block text-slate-900 dark:text-slate-100 group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">Hands-free auto-advance</span>
                  <span className="text-xs text-slate-500 dark:text-slate-400">
                    Shruti reads each {mode} continuously and waits a set duration
                    for you to write. Say <em>pause</em> to stop or <em>repeat</em> to re-hear.
                  </span>
                </span>
              </label>

              {/* Auto-mode explicit pause sliders — shown ONLY when auto-advance is on. */}
              {runtime.state.autoAdvance && (
                <div className="ml-7 space-y-5 rounded-xl border border-emerald-200/60 bg-gradient-to-b from-emerald-50/50 to-emerald-100/30 dark:border-emerald-900/50 dark:from-emerald-950/20 dark:to-emerald-900/10 p-4 shadow-sm backdrop-blur-sm transition-all animate-in fade-in slide-in-from-top-2 duration-300">
                  <p className="text-sm font-semibold text-emerald-900 dark:text-emerald-100 flex items-center gap-2">
                    <svg className="w-4 h-4 text-emerald-500" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2.5} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    Writing Pauses
                  </p>
                  
                  {mode !== "sentence" && (
                    <div className="space-y-2 group/slider">
                      <label htmlFor="auto-word-gap" className="flex justify-between text-xs font-medium text-emerald-800 dark:text-emerald-200">
                        <span>After every {mode}</span>
                        <span className="bg-emerald-100 dark:bg-emerald-900/50 px-2 py-0.5 rounded-full">{autoWordGapSec}s</span>
                      </label>
                      <input
                        id="auto-word-gap"
                        type="range"
                        min={1}
                        max={15}
                        step={1}
                        value={autoWordGapSec}
                        onChange={(e) => setAutoWordGapSec(Number(e.target.value))}
                        className="w-full accent-emerald-500 hover:accent-emerald-400 transition-all cursor-pointer"
                      />
                    </div>
                  )}

                  <div className="space-y-2 group/slider">
                    <label htmlFor="auto-sentence-gap" className="flex justify-between text-xs font-medium text-emerald-800 dark:text-emerald-200">
                      <span>After a full sentence</span>
                      <span className="bg-emerald-100 dark:bg-emerald-900/50 px-2 py-0.5 rounded-full">{autoSentenceGapSec}s</span>
                    </label>
                    <input
                      id="auto-sentence-gap"
                      type="range"
                      min={1}
                      max={30}
                      step={1}
                      value={autoSentenceGapSec}
                      onChange={(e) => setAutoSentenceGapSec(Number(e.target.value))}
                      className="w-full accent-emerald-500 hover:accent-emerald-400 transition-all cursor-pointer"
                    />
                  </div>
                  
                  <p className="text-xs text-emerald-700/80 dark:text-emerald-400/80 leading-relaxed border-t border-emerald-200/50 dark:border-emerald-800/50 pt-3">
                    Adjust the silent gaps so you have exactly enough time to finish writing before the next audio plays.
                  </p>
                </div>
              )}
            </div>

            <label className="flex items-start gap-3 text-sm cursor-pointer">
              <input
                type="checkbox"
                checked={runtime.state.announcePunctuation}
                onChange={(e) => runtime.setAnnouncePunctuation(e.target.checked)}
                className="mt-0.5 h-4 w-4"
              />
              <span className="leading-tight">
                <span className="font-medium block">Announce punctuation</span>
                <span className="text-xs text-slate-600 dark:text-slate-400">
                  Shruti speaks <em>comma</em>, <em>full stop</em>, <em>question mark</em>, etc.
                  and says <em>“New paragraph”</em> at paragraph boundaries.
                </span>
              </span>
            </label>

            {mounted && runtime.state.voiceSupported && (
              <label className="flex items-start gap-3 text-sm cursor-pointer">
                <input
                  type="checkbox"
                  checked={runtime.state.micEnabled}
                  onChange={(e) => runtime.setMicEnabled(e.target.checked)}
                  className="mt-0.5 h-4 w-4"
                />
                <span className="leading-tight">
                  <span className="font-medium block">Voice commands</span>
                  <span className="text-xs text-slate-600 dark:text-slate-400">
                    Hands-free control: say <em>next</em>, <em>repeat</em>, <em>spell</em>, <em>pause</em>,
                    or <em>where am I</em>.
                  </span>
                </span>
              </label>
            )}
          </fieldset>

          {/* Voice helper region */}
          {mounted && runtime.state.voiceSupported && runtime.state.micEnabled && (
            <div className="border-t pt-4 space-y-3">
              <details className="text-sm rounded border border-amber-300 bg-amber-50 dark:bg-amber-950/30 p-3">
                <summary className="cursor-pointer font-medium">
                  Silence your screen reader before using voice commands
                </summary>
                <p className="mt-2">
                  Shruti speaks with its own voice. To avoid two voices at once, silence
                  your screen reader temporarily — it will still respond to commands:
                </p>
                <ul className="mt-2 list-disc pl-5 space-y-1">
                  <li><strong>NVDA</strong> — <kbd>NVDA</kbd>+<kbd>S</kbd> to cycle speech / beeps / off</li>
                  <li><strong>JAWS</strong> — <kbd>Insert</kbd>+<kbd>Spacebar</kbd>, then <kbd>S</kbd></li>
                  <li><strong>Narrator</strong> — <kbd>Caps Lock</kbd>+<kbd>V</kbd> to mute</li>
                  <li><strong>VoiceOver (macOS)</strong> — <kbd>VO</kbd>+<kbd>S</kbd> to mute</li>
                  <li><strong>TalkBack</strong> — swipe down then right → <em>Pause feedback</em></li>
                </ul>
              </details>
              <Button
                variant="outline"
                size="sm"
                onClick={runtime.resetMic}
                aria-label="Reset microphone if voice commands stop responding"
              >
                Reset microphone
              </Button>
            </div>
          )}
        </Card>
      </section>

      {/* ─── 3. Controls ─────────────────────────────────────────────── */}
      <section aria-labelledby="controls-heading" className="space-y-3">
        <h2 id="controls-heading" className="text-lg font-medium">3. Start dictation</h2>
        <div className="flex flex-col sm:flex-row gap-3 pt-4">
          <Button
            onClick={
              runtime.state.status === "IDLE"
                ? prepare
                : runtime.state.status === "PLAYING"
                  ? runtime.pause
                  : runtime.resume
            }
            disabled={!canStart && runtime.state.status === "IDLE"}
            size="lg"
            className={
              "flex-1 text-base font-semibold transition-all duration-300 shadow-md hover:shadow-lg active:scale-[0.98] " +
              (runtime.state.status === "PLAYING"
                ? "bg-amber-500 hover:bg-amber-600 text-white border-transparent"
                : runtime.state.status === "WAITING_FOR_USER" || runtime.state.status === "PAUSED"
                  ? "bg-blue-600 hover:bg-blue-700 text-white border-transparent"
                  : "bg-emerald-600 hover:bg-emerald-700 text-white border-transparent")
            }
          >
            {runtime.state.status === "PLAYING" ? (
              "Pause"
            ) : runtime.state.status === "WAITING_FOR_USER" || runtime.state.status === "PAUSED" ? (
              "Resume"
            ) : extracting ? (
              "Loading source..."
            ) : synthProgress && doc ? (
              <span className="flex items-center gap-2">
                {primaryLabel}
                <span className="inline-block h-2 w-2 animate-pulse rounded-full bg-white ml-1" title={`Background caching: ${synthProgress.done}/${synthProgress.total}`} />
              </span>
            ) : synthProgress && !doc ? (
              <span className="flex items-center gap-2">
                <span className="inline-block h-2 w-2 animate-pulse rounded-full bg-white" />
                Preparing dictation… {synthProgress.done}/{synthProgress.total}
              </span>
            ) : (
              primaryLabel
            )}
          </Button>
          {synthProgress && (
            <Button
              onClick={() => cancelPrepare("Preparation cancelled.")}
              variant="outline"
              size="lg"
              className="text-slate-600 hover:text-slate-900 border-slate-300 hover:bg-slate-50 transition-colors shadow-sm"
              aria-label="Cancel preparation"
            >
              Cancel
            </Button>
          )}
        </div>
        {prepareNotice && (
          <p className="text-sm text-amber-700 dark:text-amber-400" role="status">
            {prepareNotice}
          </p>
        )}
        <div className="grid grid-cols-2 sm:flex sm:flex-wrap gap-2 pt-2">
          <Button onClick={runtime.next} variant="outline" size="lg" className="hover:bg-emerald-50 hover:text-emerald-700 hover:border-emerald-300 dark:hover:bg-emerald-900/30 dark:hover:text-emerald-300 dark:hover:border-emerald-700 transition-all shadow-sm active:scale-95" aria-label="Next chunk (Space)">Next</Button>
          <Button onClick={runtime.repeat} variant="outline" size="lg" className="hover:bg-emerald-50 hover:text-emerald-700 hover:border-emerald-300 dark:hover:bg-emerald-900/30 dark:hover:text-emerald-300 dark:hover:border-emerald-700 transition-all shadow-sm active:scale-95" aria-label="Repeat (R)">Repeat</Button>
          <Button onClick={runtime.back} variant="outline" size="lg" className="hover:bg-emerald-50 hover:text-emerald-700 hover:border-emerald-300 dark:hover:bg-emerald-900/30 dark:hover:text-emerald-300 dark:hover:border-emerald-700 transition-all shadow-sm active:scale-95" aria-label="Back (B)">Back</Button>
          <Button onClick={runtime.spell} variant="outline" size="lg" className="hover:bg-slate-50 hover:text-slate-900 dark:hover:bg-slate-800 dark:hover:text-slate-100 transition-all shadow-sm active:scale-95" aria-label="Spell (S)">Spell</Button>
          <Button onClick={runtime.where} variant="outline" size="lg" className="hover:bg-slate-50 hover:text-slate-900 dark:hover:bg-slate-800 dark:hover:text-slate-100 transition-all shadow-sm active:scale-95" aria-label="Where am I (W)">Where?</Button>
          {hasStarted && (
            <Button
              onClick={restartFromBeginning}
              variant="outline"
              size="lg"
              className="sm:ml-auto text-red-600 hover:text-red-700 hover:bg-red-50 hover:border-red-200 dark:text-red-400 dark:hover:bg-red-900/30 dark:hover:border-red-800 transition-all shadow-sm active:scale-95"
              aria-label="Restart from beginning"
            >
              Restart
            </Button>
          )}
        </div>

        <div className="grid gap-2 sm:grid-cols-2">
          <details className="text-xs text-slate-500">
            <summary className="cursor-pointer font-medium">Keyboard shortcuts</summary>
            <ul className="mt-2 space-y-1 pl-2">
              <li><kbd>Space</kbd> next chunk · <kbd>B</kbd> back chunk</li>
              <li><kbd>Shift</kbd>+<kbd>Space</kbd> next sentence · <kbd>Shift</kbd>+<kbd>B</kbd> previous sentence</li>
              <li><kbd>Ctrl</kbd>+<kbd>Space</kbd> next paragraph · <kbd>Ctrl</kbd>+<kbd>B</kbd> previous paragraph</li>
              <li><kbd>Home</kbd> go to start · <kbd>End</kbd> go to end</li>
              <li><kbd>R</kbd> repeat · <kbd>S</kbd> spell · <kbd>P</kbd> pause/resume · <kbd>W</kbd> where am I</li>
            </ul>
          </details>
          <details className="text-xs text-slate-500">
            <summary className="cursor-pointer font-medium">Voice commands</summary>
            <ul className="mt-2 space-y-1 pl-2">
              <li>"next" / "continue" / "go on"</li>
              <li>"repeat" / "again" / "say that again"</li>
              <li>"back" / "previous"</li>
              <li>"spell" / "spell it"</li>
              <li>"pause" / "stop"  ·  "resume" / "go on"</li>
              <li>"next sentence" · "previous sentence"</li>
              <li>"next paragraph" · "previous paragraph"</li>
              <li>"go to start" · "go to end"</li>
              <li>"where am I"</li>
            </ul>
          </details>
        </div>
      </section>

      {/* ─── Status panel (visual only, aria-hidden) ─────────────────── */}
      <Card className="p-4" aria-hidden="true">
        <div className="space-y-2">
          <div className="text-sm text-slate-500 flex items-center gap-2">
            <span>Status</span>
            {runtime.state.micEnabled && (
              <span
                className={
                  runtime.state.status === "WAITING_FOR_USER" || runtime.state.status === "PAUSED"
                    ? "text-emerald-600"
                    : "text-slate-400"
                }
              >
                🎤
              </span>
            )}
          </div>
          <div className="font-medium">{runtime.state.status}</div>
          {runtime.state.currentSentence && (
            <div className="text-sm">
              Sentence {runtime.state.globalSentenceIndex + 1} of {runtime.state.totalSentences}
              {runtime.state.mode !== "sentence" && (
                <> · word {runtime.state.wordIndex + 1} of {runtime.state.currentSentence.words.length}</>
              )}
            </div>
          )}
          {runtime.state.currentChunkText && (
            <blockquote className="border-l-4 border-emerald-500 pl-3 text-lg font-medium text-slate-900 dark:text-slate-100">
              {runtime.state.currentChunkText}
            </blockquote>
          )}
          {runtime.state.mode !== "sentence" && runtime.state.currentSentence && (
            <details className="text-sm text-slate-500">
              <summary>Full sentence context</summary>
              <p className="mt-1">{runtime.state.currentSentence.text}</p>
            </details>
          )}
          {runtime.state.ttsError && (
            <p className="text-sm text-red-600">TTS error: {runtime.state.ttsError}</p>
          )}
        </div>
      </Card>

      {/* Aria-live region — ONLY source of screen-reader announcements. */}
      <div
        role="status"
        aria-live="polite"
        aria-atomic="true"
        className="sr-only"
      >
        {runtime.state.announcement}
      </div>
    </div>
  );
}
