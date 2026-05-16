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

/**
 * Headless audio orchestrator for Shruti tutor-voice playback.
 *
 * Owns a single <audio> element and a queue of segments. Segments play in
 * sequence; the next one starts on the `ended` event. Any imperative method
 * (`playStem`, `playOption`, …) replaces the current queue, so users can
 * interrupt mid-sentence by pressing a number key.
 *
 * `playFullSequence` is the default flow after question entry: it plays the
 * stem followed by all four options, then falls silent so the user can answer.
 *
 * The returned object is referentially stable across renders (only changing
 * when playback `state` changes), so consumers can safely list it in effect
 * dependency arrays without retriggering on every render.
 */
export function useTutorPlayer(urls: TutorAudioUrls | null): TutorPlayer {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const queueRef = useRef<Segment[]>([]);
  const urlsRef = useRef(urls);
  // The most recently played segment — lets `replayCurrent` work even after
  // the queue has drained and the player has fallen back to idle.
  const lastSegmentRef = useRef<Segment | null>(null);
  const [state, setState] = useState<PlayerState>({ kind: "idle" });
  const stateRef = useRef(state);

  urlsRef.current = urls;
  stateRef.current = state;

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
    const u = urlsRef.current;
    if (!audio || !u) return;
    const next = queueRef.current.shift();
    if (!next) {
      setState({ kind: "idle" });
      return;
    }
    lastSegmentRef.current = next;
    audio.src = u[next];
    setState({ kind: "playing", segment: next, paused: false });
    audio.play().catch(() => {
      // Autoplay was blocked (no user gesture yet). Reset to idle; caller
      // should ensure first play happens off a user interaction.
      setState({ kind: "idle" });
    });
  }, []);

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
    lastSegmentRef.current = null;
    setState({ kind: "idle" });
  }, [urls]);

  return useMemo<TutorPlayer>(() => {
    const playQueue = (segments: Segment[]) => {
      if (!urlsRef.current) return;
      queueRef.current = [...segments];
      playNext();
    };
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
          setState((s) => (s.kind === "playing" ? { ...s, paused: false } : s));
        } else {
          audio.pause();
          setState((s) => (s.kind === "playing" ? { ...s, paused: true } : s));
        }
      },
      replayCurrent: () => {
        const audio = audioRef.current;
        if (!audio) return;
        // Mid-segment: restart the segment that's currently playing.
        if (stateRef.current.kind === "playing") {
          audio.currentTime = 0;
          audio.play().catch(() => {});
          return;
        }
        // Idle (sequence finished): replay the last segment that was heard.
        const last = lastSegmentRef.current;
        if (last) playQueue([last]);
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
  }, [state, playNext]);
}
