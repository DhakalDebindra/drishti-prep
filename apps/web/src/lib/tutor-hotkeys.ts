/**
 * Single source of truth for tutor-voice keyboard shortcuts.
 *
 * Why Alt+ prefix: screen readers (NVDA, JAWS, VoiceOver) reserve unmodified
 * single-letter keys (Q, O, E, R, Space) for their own quick-navigation. Using
 * Alt as a modifier sidesteps those conflicts while staying easy to chord
 * one-handed. The number keys 1-4 stay unmodified because they have no SR
 * binding and matching the visual "A/B/C/D" with "1/2/3/4" is the most
 * frequent action.
 *
 * `aria-keyshortcuts` consumes this list, and the on-screen help modal renders
 * from it too — keep the two in lockstep by importing rather than duplicating.
 */
export type TutorAction =
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
  { action: "stem", combo: "Alt+S", label: "Alt + S", description: "Replay question" },
  { action: "options", combo: "Alt+O", label: "Alt + O", description: "Replay all options" },
  { action: "explanation", combo: "Alt+E", label: "Alt + E", description: "Play explanation" },
  { action: "answer", combo: "1 2 3 4", label: "1–4", description: "Select option A/B/C/D" },
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
  // Numeric answer: 1-4 with no modifiers.
  if (!e.altKey && !e.ctrlKey && !e.metaKey && /^[1-4]$/.test(e.key)) {
    return "answer";
  }
  if (e.key === "Escape") return "mute";

  if (!e.altKey || e.ctrlKey || e.metaKey) return null;
  switch (e.key.toLowerCase()) {
    case "s":
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
