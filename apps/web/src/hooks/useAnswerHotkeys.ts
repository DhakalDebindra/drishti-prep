"use client";

import { useEffect } from "react";
import { isMac } from "@/lib/platform";

/**
 * Alt+1 / Alt+2 / Alt+3 / Alt+4 → select option A/B/C/D.
 *
 * Independent of tutor mode: keyboard-only users need a way to pick an option
 * without tabbing through every preceding focusable element, whether or not
 * the tutor voice is enabled. Alt prefix avoids being swallowed by any
 * focused form field and keeps clear of SR quick-nav.
 */
export function useAnswerHotkeys(
  enabled: boolean,
  onSelect: (letter: "A" | "B" | "C" | "D") => void
) {
  useEffect(() => {
    if (!enabled) return;

    const handler = (e: KeyboardEvent) => {
      // Mac uses Ctrl as the modifier, other platforms use Alt.
      if (isMac()) {
        if (!e.ctrlKey || e.altKey || e.metaKey || e.shiftKey) return;
      } else {
        if (!e.altKey || e.ctrlKey || e.metaKey || e.shiftKey) return;
      }
      // Use e.code (e.g. "Digit1") so the shortcut is layout-independent.
      if (!/^Digit[1-4]$/.test(e.code)) return;

      const target = e.target as HTMLElement | null;
      if (target) {
        const tag = target.tagName;
        if (tag === "INPUT" || tag === "TEXTAREA" || target.isContentEditable) {
          return;
        }
      }

      const letter = (["A", "B", "C", "D"] as const)[Number(e.code[5]) - 1];
      e.preventDefault();
      onSelect(letter);
    };

    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [enabled, onSelect]);
}
