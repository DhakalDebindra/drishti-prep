"use client";

import { Volume2, VolumeX, Headphones, AlertTriangle, Keyboard } from "lucide-react";
import type { TutorPlayer } from "@/hooks/useTutorPlayer";
import { getHotkey } from "@/lib/tutor-hotkeys";

type Props = {
  player: TutorPlayer;
  voice: string;
  // True when waiting for first user gesture before audio can play.
  awaitingFirstGesture: boolean;
  onStart: () => void;
  onShowHelp: () => void;
};

const SEGMENT_LABEL: Record<string, string> = {
  stem: "Reading question",
  opt_a: "Reading option A",
  opt_b: "Reading option B",
  opt_c: "Reading option C",
  opt_d: "Reading option D",
  explanation: "Reading explanation",
};

export function TutorVoicePanel({
  player,
  voice,
  awaitingFirstGesture,
  onStart,
  onShowHelp,
}: Props) {
  const { state } = player;
  const errored = state.kind === "error";
  const paused = state.kind === "playing" && state.paused;

  const statusText = (() => {
    if (errored) return state.message;
    if (state.kind === "playing") {
      return paused ? "Paused" : SEGMENT_LABEL[state.segment] ?? "Playing";
    }
    return "Ready";
  })();

  const startKey = getHotkey("start");
  const stemKey = getHotkey("stem");
  const optsKey = getHotkey("options");
  const explKey = getHotkey("explanation");
  const pauseKey = getHotkey("pause");
  const helpKey = getHotkey("help");

  return (
    <div
      className={`rounded-3xl border p-4 shadow-sm backdrop-blur-xl sm:p-5 ${
        errored
          ? "border-amber-200 bg-amber-50/90 dark:border-amber-900/50 dark:bg-amber-950/25"
          : "border-cyan-200 bg-cyan-50/80 dark:border-cyan-900/50 dark:bg-cyan-950/25"
      }`}
      role="region"
      aria-label="Shruti voice controls"
    >
      <div className="flex flex-wrap items-center gap-3">
        <div className="flex items-center gap-2 text-slate-800 dark:text-slate-100">
          {errored ? (
            <AlertTriangle className="h-5 w-5 text-amber-700" aria-hidden="true" />
          ) : (
            <Headphones className="h-5 w-5 text-cyan-700 dark:text-cyan-300" aria-hidden="true" />
          )}
          <span className="text-sm font-semibold">Shruti</span>
          <span className="text-xs text-slate-500 dark:text-slate-400">({voice})</span>
        </div>

        <span
          aria-live="polite"
          aria-atomic="true"
          className={`rounded-full px-2.5 py-1 text-xs font-medium ${
            errored
              ? "bg-amber-100 text-amber-900 dark:bg-amber-900/40 dark:text-amber-200"
              : "bg-white text-slate-700 dark:bg-slate-900 dark:text-slate-200"
          }`}
        >
          {statusText}
        </span>

        {errored && (
          <button
            type="button"
            onClick={player.replayCurrent}
            className="inline-flex items-center rounded-full border border-amber-200 bg-white px-3 py-1.5 text-sm font-medium text-amber-800 transition hover:bg-amber-100 focus:outline-none focus:ring-4 focus:ring-amber-300 dark:border-amber-900/50 dark:bg-slate-950 dark:text-amber-200 dark:hover:bg-amber-950/40"
          >
            Retry
          </button>
        )}

        <button
          type="button"
          onClick={onShowHelp}
          aria-keyshortcuts={helpKey.combo}
          className="inline-flex items-center gap-1.5 rounded-full border border-cyan-200 bg-white px-3 py-1.5 text-xs font-medium text-cyan-800 transition hover:bg-cyan-100 focus:outline-none focus:ring-4 focus:ring-cyan-300 dark:border-cyan-900/50 dark:bg-slate-950 dark:text-cyan-200 dark:hover:bg-cyan-950/40"
          title={`Show keyboard shortcuts (${helpKey.label})`}
        >
          <Keyboard className="h-3.5 w-3.5" aria-hidden="true" />
          Shortcuts
        </button>

        {awaitingFirstGesture ? (
          <button
            type="button"
            onClick={onStart}
            aria-keyshortcuts={startKey.combo}
            className="ml-auto inline-flex items-center gap-1.5 rounded-full bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground shadow-md shadow-primary/25 transition hover:bg-primary/90 focus:outline-none focus:ring-4 focus:ring-ring"
          >
            <Volume2 className="h-4 w-4" aria-hidden="true" />
            Start Shruti ({startKey.label})
          </button>
        ) : (
          <button
            type="button"
            onClick={player.mute}
            className="ml-auto inline-flex items-center gap-1.5 rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-medium text-slate-700 transition hover:bg-slate-100 focus:outline-none focus:ring-4 focus:ring-ring dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200 dark:hover:bg-slate-900"
            aria-label="Mute Shruti"
            aria-keyshortcuts="Escape"
          >
            <VolumeX className="h-4 w-4" aria-hidden="true" />
            Mute
          </button>
        )}
      </div>

      <p className="mt-3 text-xs leading-relaxed text-slate-600 dark:text-slate-300">
        <kbd className="font-mono">{startKey.label}</kbd> start / replay,{" "}
        <kbd className="font-mono">{stemKey.label}</kbd> question,{" "}
        <kbd className="font-mono">{optsKey.label}</kbd> options,{" "}
        <kbd className="font-mono">1-4</kbd> answer,{" "}
        <kbd className="font-mono">{explKey.label}</kbd> explanation,{" "}
        <kbd className="font-mono">{pauseKey.label}</kbd> pause,{" "}
        <kbd className="font-mono">{helpKey.label}</kbd> all shortcuts.
      </p>
    </div>
  );
}
