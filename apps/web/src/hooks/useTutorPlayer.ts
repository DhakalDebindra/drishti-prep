"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { TutorAudioUrls } from "@repo/types";
import {
  getAudioObjectURL,
  peekAudioObjectURL,
  prefetchSegments,
} from "@/lib/tutor-audio-cache";

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

  // Bumped on every play start and on every hard stop. A play() interrupted
  // by a newer load or a pause() rejects asynchronously; comparing the token
  // lets that stale rejection be ignored instead of clobbering newer state.
  const playTokenRef = useRef(0);

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
    const token = ++playTokenRef.current;
    setState({ kind: "playing", segment: next, paused: false });

    const remoteUrl = urls[next];

    const start = (src: string) => {
      // A newer play() (or a stop) superseded this one while its blob was
      // still downloading — drop it silently.
      if (playTokenRef.current !== token) return;
      audio.src = src;
      audio.play().catch((err: unknown) => {
        if (playTokenRef.current !== token) return;
        const name = err instanceof Error ? err.name : "";
        // AbortError just means a newer load/pause interrupted this play. It
        // is expected on every navigation and segment change — never an error
        // worth showing the learner.
        if (name === "AbortError") return;
        setState({
          kind: "error",
          segment: next,
          message:
            name === "NotAllowedError"
              ? "Tap Start to enable audio"
              : "Playback blocked",
        });
      });
    };

    // Play straight from the in-memory blob cache when possible: this keeps
    // audio.play() inside the user-gesture tick (autoplay policy) and removes
    // the per-segment network fetch that caused buffering between segments.
    const cached = peekAudioObjectURL(remoteUrl);
    if (cached) {
      start(cached);
    } else {
      getAudioObjectURL(remoteUrl)
        .then(start)
        // Blob fetch failed (e.g. storage CORS) — fall back to streaming the
        // remote URL directly so playback still works, just uncached.
        .catch(() => start(remoteUrl));
    }
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
    // Invalidate any play() still in flight from the previous question.
    playTokenRef.current++;
    audio.pause();
    audio.currentTime = 0;
    queueRef.current = [];
    currentSegRef.current = null;
    lastSegmentRef.current = null;
    setState({ kind: "idle" });
    // Warm the blob cache for every segment so playback streams from memory.
    if (urls) prefetchSegments(urls);
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
      playTokenRef.current++;
      audio.pause();
      audio.currentTime = 0;
      queueRef.current = [];
      setState({ kind: "idle" });
    },
  };
}
