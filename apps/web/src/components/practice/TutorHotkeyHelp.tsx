"use client";

import { useEffect, useRef } from "react";
import { formatHotkeyLabel, TUTOR_HOTKEYS } from "@/lib/tutor-hotkeys";
import { Button } from "@/components/ui/button";

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
      className="fixed inset-0 z-[9999] flex items-center justify-center bg-foreground/50 p-4"
      onClick={onClose}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="tutor-hotkey-help-title"
        tabIndex={-1}
        ref={dialogRef}
        onClick={(e) => e.stopPropagation()}
        className="max-w-md w-full rounded-2xl border border-border bg-card shadow-xl p-6 outline-none focus:ring-4 focus:ring-ring"
      >
        <h2
          id="tutor-hotkey-help-title"
          className="text-lg font-semibold text-foreground mb-4"
        >
          Tutor voice shortcuts
        </h2>
        <dl className="space-y-2 text-sm">
          {TUTOR_HOTKEYS.map((h) => (
            <div key={h.action} className="flex items-center justify-between gap-4">
              <dt className="text-muted-foreground">{h.description}</dt>
              <dd>
                <kbd className="font-mono text-xs px-2 py-1 rounded bg-muted border border-border text-foreground">
                  {formatHotkeyLabel(h.label)}
                </kbd>
              </dd>
            </div>
          ))}
        </dl>
        <Button type="button" variant="default" className="mt-6" onClick={onClose}>
          Close
        </Button>
      </div>
    </div>
  );
}
