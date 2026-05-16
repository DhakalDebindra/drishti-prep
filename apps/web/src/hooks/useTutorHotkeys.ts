"use client";

import { useEffect } from "react";
import type { TutorPlayer } from "./useTutorPlayer";

type Callbacks = {
  onSelectOption: (letter: "A" | "B" | "C" | "D") => void;
  onNext: () => void;
  onPrev: () => void;
  // Marks Shruti mode as started (clears the awaiting-gesture state). Called on
  // any tutor keypress so the very first hotkey doubles as the start gesture.
  onActivate: () => void;
  // True only once a real answer has been selected for the current question.
  // The explanation must not be read aloud before this is true.
  explanationUnlocked: boolean;
};

/**
 * Keyboard bindings for Shruti tutor-voice mode. Activates only when `enabled`.
 *
 * Convention:
 *   1-4      select option (also stops current audio and plays explanation if answered)
 *   Alt+S    start / replay the full Shruti sequence (stem + options)
 *   Alt+Q    replay question stem
 *   Alt+O    replay all options in sequence
 *   Alt+E    replay explanation (only after an answer is selected)
 *   Alt+R    replay the current / last-heard segment
 *   Space    pause / resume current segment
 *   Esc      mute and reset
 *   →        next question
 *   ←        previous question
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

      // Number keys 1-4 select an answer (no modifier required).
      if (e.key === "1" || e.key === "2" || e.key === "3" || e.key === "4") {
        const letter = ["A", "B", "C", "D"][Number(e.key) - 1] as
          | "A"
          | "B"
          | "C"
          | "D";
        cb.onActivate();
        player.mute();
        cb.onSelectOption(letter);
        e.preventDefault();
        return;
      }

      // Alt-modified letter shortcuts drive tutor playback.
      if (e.altKey) {
        switch (e.key.toLowerCase()) {
          case "s": // start / replay the full Shruti sequence
            cb.onActivate();
            player.playFullSequence();
            e.preventDefault();
            return;
          case "q": // replay question stem
            cb.onActivate();
            player.playStem();
            e.preventDefault();
            return;
          case "o": // replay all options
            cb.onActivate();
            player.playOptions();
            e.preventDefault();
            return;
          case "e": // replay explanation — gated until an answer is selected
            cb.onActivate();
            if (cb.explanationUnlocked) player.playExplanation();
            e.preventDefault();
            return;
          case "r": // replay the current / last-heard segment
            cb.onActivate();
            player.replayCurrent();
            e.preventDefault();
            return;
        }
      }

      switch (e.key) {
        case " ":
          player.togglePause();
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
