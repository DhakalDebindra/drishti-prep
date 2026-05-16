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
 */
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

  if (!e.altKey || e.ctrlKey || e.metaKey) return null;
  // Alt + 1-4 selects an option. Alt-prefixed so a focused form field can't
  // swallow the digit, and so it stays free of the bare-number bindings some
  // page-level shortcut libraries grab.
  if (/^[1-4]$/.test(e.key)) return "answer";
  switch (e.key.toLowerCase()) {
    case "s":
      return "start";
    case "q":
      return "stem";
    case "o":
      return "options";
    case "e":
      return "explanation";
    case "p":
      return "pause";
    case "r":
      return "replay";
    case "n":
      return "next";
    case "m":
      return "prev";
    case "/":
    case "?":
      return "help";
    default:
      return null;
  }
}
