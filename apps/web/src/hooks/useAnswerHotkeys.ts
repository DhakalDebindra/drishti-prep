"use client";

import { useEffect } from "react";

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
      if (!e.altKey || e.ctrlKey || e.metaKey || e.shiftKey) return;
      if (!/^[1-4]$/.test(e.key)) return;

      const target = e.target as HTMLElement | null;
      if (target) {
        const tag = target.tagName;
        if (tag === "INPUT" || tag === "TEXTAREA" || target.isContentEditable) {
          return;
        }
      }

      const letter = (["A", "B", "C", "D"] as const)[Number(e.key) - 1];
      e.preventDefault();
      onSelect(letter);
    };

    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [enabled, onSelect]);
}
