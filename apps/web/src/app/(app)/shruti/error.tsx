"use client";

// Route-scoped error boundary for Shruti Dictation.
// Catches anything thrown during render of the page or its children
// (e.g. a runtime crash in the FSM, a bad cache state, a SpeechSynthesis
// engine misbehaving) and shows a graceful recovery UI instead of the
// default Next.js error overlay.
//
// Always reachable from inside the (app) layout, so the navbar is still
// rendered around it.

import { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";

interface Props {
  error: Error & { digest?: string };
  reset: () => void;
}

export default function ShrutiErrorBoundary({ error, reset }: Props) {
  useEffect(() => {
    if (typeof console !== "undefined") {
      console.error("[Shruti] route error:", error);
    }
  }, [error]);

  return (
    <div className="mx-auto max-w-2xl px-4 py-8 space-y-4">
      <h1 className="text-2xl font-semibold tracking-tight">
        Shruti hit an unexpected error
      </h1>
      <Card className="p-4 border-red-300 bg-red-50 dark:bg-red-950/30 space-y-3">
        <p className="text-sm">
          Something went wrong inside the dictation app. Your text isn't lost — the
          editor will restore it on reload. If the problem persists, try clearing
          the browser cache for this site.
        </p>
        {error.message && (
          <details className="text-xs">
            <summary className="cursor-pointer text-slate-600 dark:text-slate-400">
              Technical details
            </summary>
            <pre className="mt-2 whitespace-pre-wrap break-words text-slate-700 dark:text-slate-300">
              {error.message}
              {error.digest ? `\n\nDigest: ${error.digest}` : ""}
            </pre>
          </details>
        )}
        <div className="flex gap-2">
          <Button onClick={reset} size="lg">
            Try again
          </Button>
          <Button
            variant="outline"
            size="lg"
            onClick={() => {
              if (typeof window !== "undefined") window.location.reload();
            }}
          >
            Reload page
          </Button>
        </div>
      </Card>
    </div>
  );
}
