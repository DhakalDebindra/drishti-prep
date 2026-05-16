"use client";

import { useEffect } from "react";
import type { TutorPlayer } from "./useTutorPlayer";
import { matchTutorAction } from "@/lib/tutor-hotkeys";

type Callbacks = {
  onNext: () => void;
  onPrev: () => void;
  onShowHelp: () => void;
  // Starts Shruti mode (clears the awaiting-gesture state and plays). Lets the
  // Alt+S keypress itself serve as the required user gesture for autoplay.
  onStart: () => void;
  // True only once a real answer has been selected for the current question.
  // The explanation must not be read aloud before this is true.
  explanationUnlocked: boolean;
};

/**
 * Keyboard bindings for tutor-voice (Shruti) mode. The combo definitions live
 * in `lib/tutor-hotkeys.ts` — this hook just dispatches matched actions. Alt+
 * prefix is intentional: it avoids hijacking NVDA/JAWS/VoiceOver quick-nav.
 *
 * Ignored when an input/textarea is focused, so typing in the answer feedback
 * box (or any future free-form field) is never captured.
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
      }

      const action = matchTutorAction(e);
      if (!action) return;

      // "answer" is handled by useAnswerHotkeys (always-on, not gated by
      // tutor playback). Anything tutor-player-specific stays here.
      if (action === "answer") return;
      switch (action) {
        case "start":
          cb.onStart();
          break;
        case "stem":
          player.playStem();
          break;
        case "options":
          player.playOptions();
          break;
        case "explanation":
          // Gated: don't read the explanation aloud until the learner has
          // actually committed to an answer.
          if (cb.explanationUnlocked) player.playExplanation();
          break;
        case "pause":
          player.togglePause();
          break;
        case "replay":
          player.replayCurrent();
          break;
        case "mute":
          player.mute();
          break;
        case "next":
          cb.onNext();
          break;
        case "prev":
          cb.onPrev();
          break;
        case "help":
          cb.onShowHelp();
          break;
      }
      e.preventDefault();
    };

    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [player, enabled, cb]);
}
