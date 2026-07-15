"use client";

import { useEffect, useRef } from "react";
import { formatHotkeyLabel, TUTOR_HOTKEYS } from "@/lib/tutor-hotkeys";

type Props = {
  open: boolean;
  onClose: () => void;
};

export function TutorHotkeyHelp({ open, onClose }: Props) {
  const dialogRef = useRef<HTMLDivElement | null>(null);

  // Close on Escape and trap focus inside the dialog while open.
  useEffect(() => {
    if (!open) return;
    const previouslyFocused = document.activeElement as HTMLElement | null;
    dialogRef.current?.focus();

    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        e.preventDefault();
        onClose();
      }
    };
    window.addEventListener("keydown", onKey);
    return () => {
      window.removeEventListener("keydown", onKey);
      previouslyFocused?.focus();
    };
  }, [open, onClose]);

  if (!open) return null;

  return (
    <div
      role="presentation"
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"
      onClick={onClose}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="tutor-hotkey-help-title"
        tabIndex={-1}
        ref={dialogRef}
        onClick={(e) => e.stopPropagation()}
        className="max-w-md w-full rounded-lg bg-white dark:bg-slate-900 shadow-xl p-6 outline-none focus:ring-4 focus:ring-blue-400"
      >
        <h2
          id="tutor-hotkey-help-title"
          className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-4"
        >
          Tutor voice shortcuts
        </h2>
        <dl className="space-y-2 text-sm">
          {TUTOR_HOTKEYS.map((h) => (
            <div key={h.action} className="flex items-center justify-between gap-4">
              <dt className="text-gray-700 dark:text-gray-300">{h.description}</dt>
              <dd>
                <kbd className="font-mono text-xs px-2 py-1 rounded bg-gray-100 dark:bg-slate-800 border border-gray-300 dark:border-slate-700">
                  {formatHotkeyLabel(h.label)}
                </kbd>
              </dd>
            </div>
          ))}
        </dl>
        <button
          type="button"
          onClick={onClose}
          className="mt-6 inline-flex rounded-md bg-blue-600 hover:bg-blue-700 text-white text-sm font-semibold px-4 py-2 focus:outline-none focus:ring-4 focus:ring-blue-400"
        >
          Close
        </button>
      </div>
    </div>
  );
}
