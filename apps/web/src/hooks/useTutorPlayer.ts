"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import type { TutorAudioUrls } from "@repo/types";

export type Segment = keyof TutorAudioUrls; // 'stem'|'opt_a'|'opt_b'|'opt_c'|'opt_d'|'explanation'
export type PlayerState =
  | { kind: "idle" }
  | { kind: "playing"; segment: Segment; paused: boolean };

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

const FULL_SEQUENCE: Segment[] = ["stem", "opt_a", "opt_b", "opt_c", "opt_d"];

/**
 * Headless audio orchestrator for tutor-voice playback.
 *
 * Owns a single <audio> element and a queue of segments. Segments play in
 * sequence; the next one starts on the `ended` event. Any imperative method
 * (`playStem`, `playOption`, …) replaces the current queue, so users can
 * interrupt mid-sentence by pressing a number key.
 *
 * Every method is stable across renders (`useCallback`), and the returned
 * object only changes identity when `state` changes. Callers can therefore
 * depend on `player` in effects without triggering a render loop.
 */
export function useTutorPlayer(urls: TutorAudioUrls | null): TutorPlayer {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const queueRef = useRef<Segment[]>([]);
  // The last queue that was played in full — used by `replayCurrent` so that
  // replay still works after the sequence has finished and state is idle.
  const lastQueueRef = useRef<Segment[]>([]);
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

  const playNext = useCallback(() => {
    const audio = audioRef.current;
    if (!audio || !urls) return;
    const next = queueRef.current.shift();
    if (!next) {
      setState({ kind: "idle" });
      return;
    }
    audio.src = urls[next];
    setState({ kind: "playing", segment: next, paused: false });
    audio.play().catch(() => {
      // Autoplay was blocked (no user gesture yet). Reset to idle; the first
      // play must originate from a user interaction (see `handleStartTutor`).
      setState({ kind: "idle" });
    });
  }, [urls]);

  // Wire 'ended' once the audio element is created
  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    const onEnded = () => playNext();
    audio.addEventListener("ended", onEnded);
    return () => audio.removeEventListener("ended", onEnded);
  }, [playNext]);

  // Reset queue and state whenever the question's URLs change
  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.pause();
    audio.currentTime = 0;
    queueRef.current = [];
    lastQueueRef.current = [];
    setState({ kind: "idle" });
  }, [urls]);

  const playQueue = useCallback(
    (segments: Segment[]) => {
      if (!urls || segments.length === 0) return;
      queueRef.current = [...segments];
      lastQueueRef.current = [...segments];
      playNext();
    },
    [urls, playNext]
  );

  const playFullSequence = useCallback(
    () => playQueue(FULL_SEQUENCE),
    [playQueue]
  );
  const playStem = useCallback(() => playQueue(["stem"]), [playQueue]);
  const playOptions = useCallback(
    () => playQueue(["opt_a", "opt_b", "opt_c", "opt_d"]),
    [playQueue]
  );
  const playOption = useCallback(
    (letter: "A" | "B" | "C" | "D") =>
      playQueue([`opt_${letter.toLowerCase()}` as Segment]),
    [playQueue]
  );
  const playExplanation = useCallback(
    () => playQueue(["explanation"]),
    [playQueue]
  );

  const togglePause = useCallback(() => {
    const audio = audioRef.current;
    if (!audio) return;
    if (audio.paused) {
      audio.play().catch(() => {});
      setState((s) => (s.kind === "playing" ? { ...s, paused: false } : s));
    } else {
      audio.pause();
      setState((s) => (s.kind === "playing" ? { ...s, paused: true } : s));
    }
  }, []);

  const replayCurrent = useCallback(() => {
    const audio = audioRef.current;
    if (!audio || !urls) return;
    // While a segment is still playing, restart it from the beginning.
    if (state.kind === "playing") {
      audio.currentTime = 0;
      audio.play().catch(() => {});
      return;
    }
    // Once playback has finished (state is idle), replay the last queue. This
    // is what makes the replay shortcut work consistently after the question
    // has finished reading. Cold start falls back to the full sequence.
    const replay =
      lastQueueRef.current.length > 0 ? lastQueueRef.current : FULL_SEQUENCE;
    queueRef.current = [...replay];
    lastQueueRef.current = [...replay];
    playNext();
  }, [urls, state.kind, playNext]);

  const mute = useCallback(() => {
    const audio = audioRef.current;
    if (!audio) return;
    audio.pause();
    audio.currentTime = 0;
    queueRef.current = [];
    setState({ kind: "idle" });
  }, []);

  return useMemo(
    () => ({
      state,
      playFullSequence,
      playStem,
      playOptions,
      playOption,
      playExplanation,
      togglePause,
      replayCurrent,
      mute,
    }),
    [
      state,
      playFullSequence,
      playStem,
      playOptions,
      playOption,
      playExplanation,
      togglePause,
      replayCurrent,
      mute,
    ]
  );
}
