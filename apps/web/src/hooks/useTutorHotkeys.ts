"use client";

import { useEffect } from "react";
import type { TutorPlayer } from "./useTutorPlayer";
import { matchTutorAction } from "@/lib/tutor-hotkeys";

type Callbacks = {
  onSelectOption: (letter: "A" | "B" | "C" | "D") => void;
  onNext: () => void;
  onPrev: () => void;
  onShowHelp: () => void;
};

/**
 * Keyboard bindings for tutor-voice mode. The combo definitions live in
 * `lib/tutor-hotkeys.ts` — this hook just dispatches matched actions. Alt+
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

      switch (action) {
        case "answer": {
          const letter = ["A", "B", "C", "D"][Number(e.key) - 1] as
            | "A"
            | "B"
            | "C"
            | "D";
          player.mute();
          cb.onSelectOption(letter);
          break;
        }
        case "stem":
          player.playStem();
          break;
        case "options":
          player.playOptions();
          break;
        case "explanation":
          player.playExplanation();
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
