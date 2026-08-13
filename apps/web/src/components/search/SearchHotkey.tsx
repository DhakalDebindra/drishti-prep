"use client";

import { useRouter } from "next/navigation";
import { useEffect } from "react";

/**
 * Ctrl/Cmd+K opens search from anywhere.
 *
 * A modifier combination on purpose. Screen readers in browse mode claim the
 * unmodified letter keys for quick navigation (h for headings, b for buttons,
 * and so on), so a bare "/" or single-letter shortcut would either be swallowed
 * or would fight the learner's own navigation. Ctrl/Cmd+K is untouched by
 * browse mode and is the shortcut people already expect for search.
 */
export function SearchHotkey() {
  const router = useRouter();

  useEffect(() => {
    function onKeyDown(event: KeyboardEvent) {
      if (event.key !== "k" && event.key !== "K") return;
      if (!event.metaKey && !event.ctrlKey) return;

      // Never steal the keystroke from someone mid-sentence in a field.
      const target = event.target as HTMLElement | null;
      const tag = target?.tagName;
      if (
        tag === "INPUT" ||
        tag === "TEXTAREA" ||
        tag === "SELECT" ||
        target?.isContentEditable
      ) {
        return;
      }

      event.preventDefault();
      router.push("/search");
    }

    document.addEventListener("keydown", onKeyDown);
    return () => document.removeEventListener("keydown", onKeyDown);
  }, [router]);

  return null;
}
