/**
 * Single source of truth for tutor-voice keyboard shortcuts.
 *
 * Why Alt+ prefix: screen readers (NVDA, JAWS, VoiceOver) reserve unmodified
 * single-letter keys (Q, O, E, R, Space) for their own quick-navigation. Using
 * Alt as a modifier sidesteps those conflicts while staying easy to chord
 * one-handed. Numbers 1-4 also take Alt — bare digits would be swallowed by
 * any focused form field and silently fail for keyboard-only users.
 *
 * `aria-keyshortcuts` consumes this list, and the on-screen help modal renders
 * from it too — keep the two in lockstep by importing rather than duplicating.
 *
 * Display labels are platform-aware: "Ctrl" on Mac, "Alt" elsewhere.
 */
import { isMac } from "./platform";

export type TutorAction =
  | "start"
  | "stem"
  | "options"
  | "explanation"
  | "pause"
  | "replay"
  | "mute"
  | "answer"
  | "next"
  | "prev"
  | "help";

export type Hotkey = {
  action: TutorAction;
  // ARIA-spec key combo string, used directly in aria-keyshortcuts.
  combo: string;
  // Human-readable label for the help modal / footer.
  label: string;
  description: string;
};

export const TUTOR_HOTKEYS: Hotkey[] = [
  { action: "start", combo: "Alt+S", label: "Alt + S", description: "Start / replay Shruti" },
  { action: "stem", combo: "Alt+Q", label: "Alt + Q", description: "Replay question" },
  { action: "options", combo: "Alt+O", label: "Alt + O", description: "Replay all options" },
  { action: "explanation", combo: "Alt+E", label: "Alt + E", description: "Play explanation" },
  { action: "answer", combo: "Alt+1 Alt+2 Alt+3 Alt+4", label: "Alt + 1–4", description: "Select option A/B/C/D" },
  { action: "pause", combo: "Alt+P", label: "Alt + P", description: "Pause / resume" },
  { action: "replay", combo: "Alt+R", label: "Alt + R", description: "Replay current segment" },
  { action: "mute", combo: "Escape", label: "Esc", description: "Stop audio" },
  { action: "next", combo: "Alt+N", label: "Alt + N", description: "Next question" },
  { action: "prev", combo: "Alt+M", label: "Alt + M", description: "Previous question" },
  { action: "help", combo: "Alt+/", label: "Alt + /", description: "Show shortcuts" },
];

export function getHotkey(action: TutorAction): Hotkey {
  const h = TUTOR_HOTKEYS.find((x) => x.action === action);
  if (!h) throw new Error(`No hotkey configured for action: ${action}`);
  return h;
}

/**
 * Test whether a keydown event matches one of our action bindings.
 * Returns the action if matched, else null. Centralised so the listener and
 * any future tests share one parser.
 */
export function matchTutorAction(e: KeyboardEvent): TutorAction | null {
  if (e.key === "Escape") return "mute";

  // Mac uses Ctrl as the modifier (reliable, no dead-key issues).
  // Other platforms use Alt (avoids screen-reader conflicts).
  if (isMac()) {
    if (!e.ctrlKey || e.altKey || e.metaKey) return null;
  } else {
    if (!e.altKey || e.ctrlKey || e.metaKey) return null;
  }
  // Use e.code (physical key position) rather than e.key so that modifier+
  // shortcuts work the same on both platforms.
  if (/^Digit[1-4]$/.test(e.code)) return "answer";
  switch (e.code) {
    case "KeyS":
      return "start";
    case "KeyQ":
      return "stem";
    case "KeyO":
      return "options";
    case "KeyE":
      return "explanation";
    case "KeyP":
      return "pause";
    case "KeyR":
      return "replay";
    case "KeyN":
      return "next";
    case "KeyM":
      return "prev";
    case "Slash":
      return "help";
    default:
      return null;
  }
}

/** Platform-aware modifier label — "Ctrl" on Mac, "Alt" elsewhere. */
export function modifierKey(): string {
  return isMac() ? "Ctrl" : "Alt";
}

/**
 * Replace the "Alt" modifier in any shortcut label or combo with the
 * platform-appropriate key name (e.g. "Alt + S" → "Ctrl + S" on Mac).
 * Strings without "Alt" pass through unchanged.
 */
export function formatHotkeyLabel(label: string): string {
  return label.replace("Alt", modifierKey());
}
