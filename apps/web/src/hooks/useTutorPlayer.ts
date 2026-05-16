"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { TutorAudioUrls } from "@repo/types";

export type Segment = keyof TutorAudioUrls; // 'stem'|'opt_a'|'opt_b'|'opt_c'|'opt_d'|'explanation'
export type PlayerState =
  | { kind: "idle" }
  | { kind: "playing"; segment: Segment; paused: boolean }
  | { kind: "error"; segment: Segment | null; message: string };

// If a segment loads but its decoded duration is below this, treat it as
// a broken / silent MP3 (the bug that made students hear nothing).
const MIN_AUDIO_DURATION_S = 0.25;

export type TutorPlayer = {
  state: PlayerState;
  playFullSequence: () => void; // stem + 4 options
  playStem: () => void;
  playOptions: () => void;
  playOption: (letter: "A" | "B" | "C" | "D") => void;
  playExplanation: () => void;
  togglePause: () => void;
  replayCurrent: () => void;
  mute: () => void;
};

/**
 * Headless audio orchestrator for tutor-voice playback.
 *
 * Owns a single <audio> element and a queue of segments. Segments play in
 * sequence; the next one starts on the `ended` event. Any imperative method
 * (`playStem`, `playOption`, …) replaces the current queue, so users can
 * interrupt mid-sentence by pressing a number key.
 *
 * `playFullSequence` is the default flow after question entry: it plays the
 * stem followed by all four options, then falls silent so the user can answer.
 */
export function useTutorPlayer(urls: TutorAudioUrls | null): TutorPlayer {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const queueRef = useRef<Segment[]>([]);
  const [state, setState] = useState<PlayerState>({ kind: "idle" });

  // Lazily create the audio element (avoids SSR pitfalls)
  useEffect(() => {
    if (typeof window === "undefined") return;
    const audio = new Audio();
    audio.preload = "auto";
    audioRef.current = audio;
    return () => {
      audio.pause();
      audio.src = "";
      audioRef.current = null;
    };
  }, []);

  const currentSegRef = useRef<Segment | null>(null);
  // The most recently played segment — unlike `currentSegRef` this is NOT
  // cleared when the queue drains, so `replayCurrent` can still replay the
  // last thing heard after a sequence has finished and the player is idle.
  const lastSegmentRef = useRef<Segment | null>(null);

  const playNext = useCallback(() => {
    const audio = audioRef.current;
    if (!audio || !urls) return;
    const next = queueRef.current.shift();
    if (!next) {
      currentSegRef.current = null;
      setState({ kind: "idle" });
      return;
    }
    currentSegRef.current = next;
    lastSegmentRef.current = next;
    audio.src = urls[next];
    setState({ kind: "playing", segment: next, paused: false });
    audio.play().catch((err) => {
      // Autoplay blocked (no user gesture) vs real decode failure — both end
      // up here. Surface as error so the UI can prompt the user to interact.
      setState({
        kind: "error",
        segment: next,
        message: err?.message?.includes("user") ? "Tap Start to enable audio" : "Playback blocked",
      });
    });
  }, [urls]);

  // Wire ended / error / metadata listeners once the audio element is created.
  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    const onEnded = () => playNext();
    const onError = () => {
      const code = audio.error?.code;
      const map: Record<number, string> = {
        1: "Playback aborted",
        2: "Network error fetching audio",
        3: "Audio decode failed",
        4: "Audio format not supported",
      };
      setState({
        kind: "error",
        segment: currentSegRef.current,
        message: map[code ?? 0] ?? "Audio failed to load",
      });
    };
    const onLoadedMeta = () => {
      // Detects 0-byte / header-only MP3s that "play successfully" but emit
      // no sound. Bail out so the UI can show a real error.
      if (
        isFinite(audio.duration) &&
        audio.duration > 0 &&
        audio.duration < MIN_AUDIO_DURATION_S
      ) {
        audio.pause();
        setState({
          kind: "error",
          segment: currentSegRef.current,
          message: `Audio is empty (${audio.duration.toFixed(2)}s)`,
        });
      }
    };
    audio.addEventListener("ended", onEnded);
    audio.addEventListener("error", onError);
    audio.addEventListener("loadedmetadata", onLoadedMeta);
    return () => {
      audio.removeEventListener("ended", onEnded);
      audio.removeEventListener("error", onError);
      audio.removeEventListener("loadedmetadata", onLoadedMeta);
    };
  }, [playNext]);

  // Reset queue and state whenever the question's URLs change
  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.pause();
    audio.currentTime = 0;
    queueRef.current = [];
    currentSegRef.current = null;
    lastSegmentRef.current = null;
    setState({ kind: "idle" });
  }, [urls]);

  const playQueue = useCallback(
    (segments: Segment[]) => {
      if (!urls) return;
      queueRef.current = [...segments];
      playNext();
    },
    [urls, playNext]
  );

  return {
    state,
    playFullSequence: () =>
      playQueue(["stem", "opt_a", "opt_b", "opt_c", "opt_d"]),
    playStem: () => playQueue(["stem"]),
    playOptions: () => playQueue(["opt_a", "opt_b", "opt_c", "opt_d"]),
    playOption: (letter) =>
      playQueue([`opt_${letter.toLowerCase()}` as Segment]),
    playExplanation: () => playQueue(["explanation"]),
    togglePause: () => {
      const audio = audioRef.current;
      if (!audio) return;
      if (audio.paused) {
        audio.play().catch(() => {});
        setState((s) =>
          s.kind === "playing" ? { ...s, paused: false } : s
        );
      } else {
        audio.pause();
        setState((s) => (s.kind === "playing" ? { ...s, paused: true } : s));
      }
    },
    replayCurrent: () => {
      const audio = audioRef.current;
      if (!audio) return;
      if (state.kind === "playing") {
        audio.currentTime = 0;
        audio.play().catch(() => {});
      } else if (state.kind === "error" && state.segment) {
        // Re-attempt after a transient failure.
        queueRef.current = [state.segment];
        playNext();
      } else if (state.kind === "idle" && lastSegmentRef.current) {
        // Sequence already finished — replay the last segment that was heard
        // rather than silently doing nothing.
        queueRef.current = [lastSegmentRef.current];
        playNext();
      }
    },
    mute: () => {
      const audio = audioRef.current;
      if (!audio) return;
      audio.pause();
      audio.currentTime = 0;
      queueRef.current = [];
      setState({ kind: "idle" });
    },
  };
}
