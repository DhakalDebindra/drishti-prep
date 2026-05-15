"use client";

import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import { Headphones, Loader2 } from "lucide-react";
import toast from "react-hot-toast";

type Status =
  | { kind: "loading" }
  | { kind: "not_generated" }
  | { kind: "ready"; voice: string }
  | { kind: "error" };

type Props = {
  questionId: string;
  /**
   * Initial state from the parent. If provided, we skip the GET round-trip and
   * trust these values until the user generates. The audio_ready trigger on
   * `questions` clears `audio_ready` whenever spoken text changes, so when
   * `audio_ready` arrives as false here it means EITHER the question has
   * never been generated OR text was edited since last generation — both
   * resolve to a single "needs generation" action from the admin's POV.
   */
  initialReady?: boolean | null;
  initialVoice?: string | null;
};

export function GenerateAudioButton({
  questionId,
  initialReady,
  initialVoice,
}: Props) {
  const [status, setStatus] = useState<Status>(() => {
    if (initialReady === true && initialVoice) {
      return { kind: "ready", voice: initialVoice };
    }
    if (initialReady === false) {
      return { kind: "not_generated" };
    }
    return { kind: "loading" };
  });
  const [isGenerating, setIsGenerating] = useState(false);

  useEffect(() => {
    if (status.kind !== "loading") return;
    let cancelled = false;
    fetch(`/api/questions/${questionId}/audio`)
      .then((r) => r.json())
      .then((j) => {
        if (cancelled) return;
        if (j.ready) {
          setStatus({ kind: "ready", voice: j.voice });
        } else {
          setStatus({ kind: "not_generated" });
        }
      })
      .catch(() => {
        if (cancelled) return;
        setStatus({ kind: "error" });
      });
    return () => {
      cancelled = true;
    };
  }, [questionId, status.kind]);

  async function handleGenerate() {
    setIsGenerating(true);
    try {
      const res = await fetch(`/api/admin/questions/${questionId}/audio`, {
        method: "POST",
      });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body.error || `HTTP ${res.status}`);
      }
      const json = await res.json();
      setStatus({ kind: "ready", voice: json.voice });
      const generated = json.generated_count ?? 0;
      const skipped = json.skipped_count ?? 0;
      toast.success(
        generated === 0
          ? "Audio already up to date."
          : `Audio generated (${generated} segment${generated === 1 ? "" : "s"}${
              skipped > 0 ? `, ${skipped} already existed` : ""
            }).`
      );
    } catch (err: any) {
      toast.error(err.message || "Audio generation failed.");
    } finally {
      setIsGenerating(false);
    }
  }

  const isReady = status.kind === "ready";
  const buttonLabel = isReady ? "Regenerate audio" : "Generate audio";

  return (
    <div className="flex flex-wrap items-center gap-3 text-sm">
      <div className="flex items-center gap-2 text-slate-600">
        <Headphones className="w-4 h-4" aria-hidden="true" />
        <span className="font-medium">Shruti audio:</span>
        {status.kind === "loading" && (
          <span className="text-slate-400">checking…</span>
        )}
        {status.kind === "not_generated" && (
          <span className="text-amber-700">not generated</span>
        )}
        {status.kind === "ready" && (
          <span className="text-emerald-700">
            ready (voice: <span className="font-mono">{status.voice}</span>)
          </span>
        )}
        {status.kind === "error" && (
          <span className="text-red-700">could not load status</span>
        )}
      </div>

      <Button
        type="button"
        variant="outline"
        size="sm"
        className="gap-1.5 border-blue-200 text-blue-700 hover:bg-blue-50 disabled:opacity-50"
        onClick={handleGenerate}
        disabled={isGenerating || status.kind === "loading"}
        aria-label={
          isReady
            ? `Regenerate Nepali audio for this question`
            : `Generate Nepali audio for this question`
        }
      >
        {isGenerating ? (
          <>
            <Loader2 className="w-3.5 h-3.5 animate-spin" />
            Generating… (~90s)
          </>
        ) : (
          <>
            <Headphones className="w-3.5 h-3.5" />
            {buttonLabel}
          </>
        )}
      </Button>
    </div>
  );
}
