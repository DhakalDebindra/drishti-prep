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
    return "Silent";
  })();

  const stemKey = getHotkey("stem");
  const optsKey = getHotkey("options");
  const explKey = getHotkey("explanation");
  const pauseKey = getHotkey("pause");
  const helpKey = getHotkey("help");

  return (
    <div
      className={`rounded-lg border p-4 flex flex-wrap items-center gap-3 ${
        errored
          ? "border-amber-300 bg-amber-50 dark:bg-amber-950/30 dark:border-amber-900"
          : "border-blue-200 bg-blue-50 dark:bg-blue-950/30 dark:border-blue-900"
      }`}
      role="region"
      aria-label="Shruti voice controls"
    >
      <div className="flex items-center gap-2 text-blue-800 dark:text-blue-300">
        {errored ? (
          <AlertTriangle className="w-5 h-5 text-amber-700" aria-hidden="true" />
        ) : (
          <Headphones className="w-5 h-5" aria-hidden="true" />
        )}
        <span className="font-semibold text-sm">Shruti</span>
        <span className="text-xs text-blue-700 dark:text-blue-400">({voice})</span>
      </div>

      <span
        aria-live="polite"
        aria-atomic="true"
        className={`text-xs px-2 py-1 rounded ${
          errored
            ? "text-amber-900 dark:text-amber-200 bg-amber-100 dark:bg-amber-900/40"
            : "text-blue-900 dark:text-blue-200 bg-blue-100 dark:bg-blue-900/40"
        }`}
      >
        {statusText}
      </span>

      {errored && (
        <button
          type="button"
          onClick={player.replayCurrent}
          className="rounded-md border border-amber-300 dark:border-amber-700 bg-white dark:bg-slate-900 hover:bg-amber-100 dark:hover:bg-amber-900/40 text-amber-800 dark:text-amber-200 text-sm font-medium px-3 py-1.5 focus:outline-none focus:ring-4 focus:ring-amber-400"
        >
          Retry
        </button>
      )}

      <button
        type="button"
        onClick={onShowHelp}
        aria-keyshortcuts={helpKey.combo}
        className="inline-flex items-center gap-1 rounded-md border border-blue-300 dark:border-blue-700 bg-white dark:bg-slate-900 hover:bg-blue-100 dark:hover:bg-blue-900/40 text-blue-800 dark:text-blue-200 text-xs font-medium px-2 py-1 focus:outline-none focus:ring-4 focus:ring-blue-400"
        title={`Show keyboard shortcuts (${helpKey.label})`}
      >
        <Keyboard className="w-3.5 h-3.5" aria-hidden="true" />
        Shortcuts
      </button>

      {awaitingFirstGesture ? (
        <button
          type="button"
          onClick={onStart}
          aria-keyshortcuts={stemKey.combo}
          className="ml-auto inline-flex items-center gap-1.5 rounded-md bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-3 py-1.5 focus:outline-none focus:ring-4 focus:ring-blue-400"
        >
          <Volume2 className="w-4 h-4" aria-hidden="true" />
          Start Shruti ({stemKey.label})
        </button>
      ) : (
        <button
          type="button"
          onClick={player.mute}
          className="ml-auto inline-flex items-center gap-1.5 rounded-md border border-blue-300 dark:border-blue-700 bg-white dark:bg-slate-900 hover:bg-blue-100 dark:hover:bg-blue-900/40 text-blue-800 dark:text-blue-200 text-sm font-medium px-3 py-1.5 focus:outline-none focus:ring-4 focus:ring-blue-400"
          aria-label="Mute Shruti"
          aria-keyshortcuts="Escape"
        >
          <VolumeX className="w-4 h-4" aria-hidden="true" />
          Mute
        </button>
      )}

      <p className="basis-full text-xs text-blue-800 dark:text-blue-300">
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
