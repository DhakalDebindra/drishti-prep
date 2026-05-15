"use client";

import { useEffect } from "react";
import type { TutorPlayer } from "./useTutorPlayer";

type Callbacks = {
  onStart: () => void;
  onSelectOption: (letter: "A" | "B" | "C" | "D") => void;
  onNext: () => void;
  onPrev: () => void;
};

type Options = {
  // True once the tutor preference is on and audio is ready for this question.
  enabled: boolean;
  // True while waiting for the first user gesture (tutor not yet started).
  awaitingGesture: boolean;
};

/**
 * Keyboard bindings for Shruti (tutor-voice) mode.
 *
 * Every shortcut uses Alt+<key> so it never collides with screen-reader
 * single-letter quick-nav keys (NVDA / JAWS / VoiceOver). Number keys 1-4
 * select an answer and Escape stops audio.
 *
 *   Alt+S  start Shruti (first gesture)   Alt+P  pause / resume
 *   Alt+Q  replay the question / stem     Alt+R  replay last segment
 *   Alt+O  replay all options             Alt+N  next question
 *   Alt+E  play explanation               Alt+B  previous question
 *   1-4    select option A/B/C/D           Esc    stop audio
 *
 * Before the user starts Shruti, only Alt+S is live; the playback shortcuts
 * activate once started, at which point Alt+S becomes a no-op. Splitting the
 * "start" key (Alt+S) from the "play question" key (Alt+Q) removes the old
 * overload where one key meant both.
 *
 * The hook ignores keystrokes while an input/textarea is focused so it never
 * hijacks typing.
 */
export function useTutorHotkeys(
  player: TutorPlayer,
  { enabled, awaitingGesture }: Options,
  cb: Callbacks
) {
  useEffect(() => {
    if (!enabled) return;

    const handler = (e: KeyboardEvent) => {
      const target = e.target as HTMLElement | null;
      if (target) {
        const tag = target.tagName;
        if (tag === "INPUT" || tag === "TEXTAREA" || target.isContentEditable) {
          return;
        }
      }

      // Number keys 1-4 select an answer — no modifier, only once active.
      if (
        !awaitingGesture &&
        !e.altKey &&
        ["1", "2", "3", "4"].includes(e.key)
      ) {
        const letter = ["A", "B", "C", "D"][Number(e.key) - 1] as
          | "A"
          | "B"
          | "C"
          | "D";
        player.mute();
        cb.onSelectOption(letter);
        e.preventDefault();
        return;
      }

      // Escape stops audio (only meaningful once active).
      if (!awaitingGesture && e.key === "Escape") {
        player.mute();
        e.preventDefault();
        return;
      }

      if (!e.altKey) return;
      const key = e.key.toLowerCase();

      // Alt+S starts Shruti; live only while awaiting the first gesture.
      if (key === "s") {
        if (awaitingGesture) {
          cb.onStart();
          e.preventDefault();
        }
        return;
      }

      // All remaining shortcuts require Shruti to be active.
      if (awaitingGesture) return;

      switch (key) {
        case "q":
          player.playStem();
          break;
        case "o":
          player.playOptions();
          break;
        case "e":
          player.playExplanation();
          break;
        case "p":
          player.togglePause();
          break;
        case "r":
          player.replayCurrent();
          break;
        case "n":
          cb.onNext();
          break;
        case "b":
          cb.onPrev();
          break;
        default:
          return;
      }
      e.preventDefault();
    };

    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [player, enabled, awaitingGesture, cb]);
}
