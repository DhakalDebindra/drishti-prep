"use client";

import { useState, useTransition } from "react";
import { Button } from "@/components/ui/button";
import { setTutorVoiceEnabled } from "./actions";

type Props = {
  initialEnabled: boolean;
};

export function TutorVoiceToggle({ initialEnabled }: Props) {
  const [enabled, setEnabled] = useState(initialEnabled);
  const [, startTransition] = useTransition();
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  function toggle() {
    const next = !enabled;
    setEnabled(next);
    setMessage(null);
    setError(null);
    startTransition(async () => {
      const res = await setTutorVoiceEnabled(next);
      if ("error" in res && res.error) {
        setError(res.error);
        setEnabled(!next); // revert
      } else {
        setMessage(
          next
            ? "Shruti enabled. It will activate on your next practice session."
            : "Shruti disabled."
        );
      }
    });
  }

  return (
    <div className="rounded-lg border border-slate-200 bg-white p-6 space-y-4">
      <div className="flex items-start justify-between gap-6">
        <div>
          <h2 className="text-lg font-semibold text-slate-900">
            Shruti — AI voice tutor (नेपाली)
          </h2>
          <p className="mt-1 text-sm text-slate-600 max-w-prose">
            Shruti reads questions, options, and explanations aloud in natural
            Nepali. When enabled, you can control playback with your keyboard
            during practice. Disable to keep using your screen reader as before.
          </p>
        </div>
        <Button
          variant={enabled ? "default" : "outline"}
          onClick={toggle}
          aria-pressed={enabled}
        >
          {enabled ? "On" : "Off"}
        </Button>
      </div>

      {enabled && (
        <div className="rounded-md bg-slate-50 px-4 py-3 text-sm text-slate-700">
          <p className="font-semibold mb-2">Keyboard shortcuts during practice:</p>
          <ul className="grid grid-cols-1 sm:grid-cols-2 gap-y-1 gap-x-6 list-none">
            <li>
              <kbd className="font-mono">Alt+S</kbd> — start Shruti
            </li>
            <li>
              <kbd className="font-mono">Alt+Q</kbd> — replay the question
            </li>
            <li>
              <kbd className="font-mono">Alt+O</kbd> — replay all four options
            </li>
            <li>
              <kbd className="font-mono">Alt+E</kbd> — replay explanation
            </li>
            <li>
              <kbd className="font-mono">1–4</kbd> — select option A–D
            </li>
            <li>
              <kbd className="font-mono">Alt+P</kbd> — pause / resume
            </li>
            <li>
              <kbd className="font-mono">Alt+R</kbd> — replay current part
            </li>
            <li>
              <kbd className="font-mono">Alt+N</kbd> / <kbd className="font-mono">Alt+B</kbd> — next / previous question
            </li>
            <li>
              <kbd className="font-mono">Esc</kbd> — stop audio
            </li>
          </ul>
        </div>
      )}

      {message && (
        <p
          role="status"
          aria-live="polite"
          className="rounded-md bg-emerald-50 px-3 py-2 text-sm text-emerald-700"
        >
          {message}
        </p>
      )}
      {error && (
        <p
          role="alert"
          aria-live="assertive"
          className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700"
        >
          {error}
        </p>
      )}
    </div>
  );
}
