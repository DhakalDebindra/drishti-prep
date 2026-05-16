"use client";

import { Volume2, VolumeX, Headphones } from "lucide-react";
import type { TutorPlayer } from "@/hooks/useTutorPlayer";

type Props = {
  player: TutorPlayer;
  voice: string;
  // True when waiting for first user gesture before audio can play.
  awaitingFirstGesture: boolean;
  onStart: () => void;
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
}: Props) {
  const segmentLabel =
    player.state.kind === "playing"
      ? SEGMENT_LABEL[player.state.segment] ?? "Playing"
      : "Silent";
  const paused =
    player.state.kind === "playing" && player.state.paused;

  return (
    <div
      className="rounded-lg border border-blue-200 bg-blue-50 dark:bg-blue-950/30 dark:border-blue-900 p-4 flex flex-wrap items-center gap-3"
      role="region"
      aria-label="Shruti voice controls"
    >
      <div className="flex items-center gap-2 text-blue-800 dark:text-blue-300">
        <Headphones className="w-5 h-5" aria-hidden="true" />
        <span className="font-semibold text-sm">Shruti</span>
        <span className="text-xs text-blue-700 dark:text-blue-400">({voice})</span>
      </div>

      <span
        aria-live="polite"
        aria-atomic="true"
        className="text-xs text-blue-900 dark:text-blue-200 px-2 py-1 bg-blue-100 dark:bg-blue-900/40 rounded"
      >
        {paused ? "Paused" : segmentLabel}
      </span>

      {awaitingFirstGesture ? (
        <button
          type="button"
          onClick={onStart}
          className="ml-auto inline-flex items-center gap-1.5 rounded-md bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-3 py-1.5 focus:outline-none focus:ring-4 focus:ring-blue-400"
        >
          <Volume2 className="w-4 h-4" aria-hidden="true" />
          Start Shruti (Alt+S)
        </button>
      ) : (
        <button
          type="button"
          onClick={player.mute}
          className="ml-auto inline-flex items-center gap-1.5 rounded-md border border-blue-300 dark:border-blue-700 bg-white dark:bg-slate-900 hover:bg-blue-100 dark:hover:bg-blue-900/40 text-blue-800 dark:text-blue-200 text-sm font-medium px-3 py-1.5 focus:outline-none focus:ring-4 focus:ring-blue-400"
          aria-label="Mute Shruti voice"
        >
          <VolumeX className="w-4 h-4" aria-hidden="true" />
          Mute
        </button>
      )}

      <p className="basis-full text-xs text-blue-800 dark:text-blue-300">
        Press <kbd className="font-mono">Alt+S</kbd> to replay all,{" "}
        <kbd className="font-mono">Alt+Q</kbd> for the question,{" "}
        <kbd className="font-mono">Alt+O</kbd> for options,{" "}
        <kbd className="font-mono">Alt+R</kbd> to replay,{" "}
        <kbd className="font-mono">1-4</kbd> to answer,{" "}
        <kbd className="font-mono">Alt+E</kbd> for explanation,{" "}
        <kbd className="font-mono">Space</kbd> to pause.
      </p>
    </div>
  );
}
