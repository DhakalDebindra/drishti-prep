"use client";

import { useEffect } from "react";
import type { TutorPlayer } from "./useTutorPlayer";

type Callbacks = {
  onSelectOption: (letter: "A" | "B" | "C" | "D") => void;
  onNext: () => void;
  onPrev: () => void;
};

/**
 * Keyboard bindings for tutor-voice mode. Activates only when `enabled`.
 *
 * Convention:
 *   1-4    select option (also stops current audio and plays explanation if answered)
 *   Q      replay question stem
 *   O      replay all options in sequence
 *   E      replay explanation
 *   Space  pause / resume current segment
 *   R      replay current segment from the start
 *   Esc    mute and reset
 *   →      next question
 *   ←      previous question
 *
 * The hook ignores keystrokes when an input/textarea is focused so it never
 * hijacks typing. Arrow keys are NOT bound here when the focused element is a
 * radiogroup option (existing QuestionOptions handles those).
 */
export function useTutorHotkeys(
  player: TutorPlayer,
  enabled: boolean,
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
        // Don't fight QuestionOptions' arrow-key navigation inside the radiogroup
        if (
          target.getAttribute("role") === "radio" &&
          ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(e.key)
        ) {
          return;
        }
      }

      switch (e.key) {
        case "1":
        case "2":
        case "3":
        case "4": {
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
        case "q":
        case "Q":
          player.playStem();
          e.preventDefault();
          return;
        case "o":
        case "O":
          player.playOptions();
          e.preventDefault();
          return;
        case "e":
        case "E":
          player.playExplanation();
          e.preventDefault();
          return;
        case " ":
          player.togglePause();
          e.preventDefault();
          return;
        case "r":
        case "R":
          player.replayCurrent();
          e.preventDefault();
          return;
        case "Escape":
          player.mute();
          e.preventDefault();
          return;
        case "ArrowRight":
          if (
            !target ||
            target.tagName !== "BUTTON" ||
            target.getAttribute("role") !== "radio"
          ) {
            cb.onNext();
            e.preventDefault();
          }
          return;
        case "ArrowLeft":
          if (
            !target ||
            target.tagName !== "BUTTON" ||
            target.getAttribute("role") !== "radio"
          ) {
            cb.onPrev();
            e.preventDefault();
          }
          return;
      }
    };

    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [player, enabled, cb]);
}
