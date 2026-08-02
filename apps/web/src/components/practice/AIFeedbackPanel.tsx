"use client";

import React, { useEffect, useState } from "react";
import { Sparkles, BrainCircuit, AlertTriangle, Lightbulb } from "lucide-react";
import type { AIFeedback } from "@repo/types";
import { RichText } from "@/components/ui/RichText";

export function AIFeedbackPanel({ attemptId }: { attemptId: string }) {
  const [feedback, setFeedback] = useState<AIFeedback | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchFeedback() {
      try {
        const response = await fetch(`/api/attempts/${attemptId}/feedback`);
        if (!response.ok) {
          throw new Error("We could not generate feedback for this attempt.");
        }
        const data = await response.json();
        setFeedback(data);
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    fetchFeedback();
  }, [attemptId]);

  if (loading) {
    return (
      <div
        aria-live="polite"
        aria-atomic="true"
        className="rounded-3xl border border-border bg-card p-6 text-center shadow-sm md:p-8"
      >
        <div className="mx-auto mb-4 flex h-12 w-12 items-center justify-center rounded-2xl bg-primary/10 text-primary">
          <Sparkles className="h-5 w-5 animate-pulse" />
        </div>
        <h3 className="text-lg font-semibold text-foreground">
          AI is analyzing your performance...
        </h3>
        <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
          Looking for patterns in your correct and incorrect answers to build personalized feedback.
        </p>
      </div>
    );
  }

  if (error || !feedback) {
    return (
      <div
        aria-live="assertive"
        aria-atomic="true"
        role="alert"
        className="rounded-3xl border border-destructive/30 bg-destructive/10 p-6 text-destructive shadow-sm md:p-8"
      >
        <div className="flex items-center gap-2">
          <AlertTriangle className="h-5 w-5" />
          <span className="font-semibold">We couldn&apos;t generate AI feedback right now.</span>
        </div>
        <p className="mt-2 text-sm leading-relaxed opacity-90">
          Please try again later.
        </p>
      </div>
    );
  }

  const parseWeakZones = (weakZones: Record<string, unknown> | null) => {
    if (!weakZones || typeof weakZones !== "object") return [];
    if (Array.isArray(weakZones)) return weakZones;
    return Object.keys(weakZones);
  };

  const weakZones = parseWeakZones(feedback.weak_zones);

  return (
    <div
      aria-live="polite"
      aria-atomic="true"
      className="rounded-3xl border border-border bg-card p-6 shadow-sm md:p-8"
    >
      <div className="mb-6 flex items-start justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="rounded-2xl bg-primary/10 p-3 text-primary">
            <BrainCircuit className="h-6 w-6" />
          </div>
          <div>
            <h2 className="text-xl font-bold tracking-tight text-foreground">
              AI Analysis & Insights
            </h2>
            <p className="text-sm text-muted-foreground">
              Powered by DrishtiPrep AI
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-6">
        {feedback.strengths && (
          <div className="rounded-2xl border border-border bg-muted/40 p-5">
            <div className="mb-3 flex items-center gap-2 text-success">
              <Lightbulb className="h-5 w-5" />
              <h3 className="text-lg font-bold">Overall performance</h3>
            </div>
            <div className="text-sm leading-relaxed text-foreground">
              <RichText>{feedback.strengths}</RichText>
            </div>
          </div>
        )}

        {weakZones.length > 0 && (
          <div>
            <div className="mb-3 flex items-center gap-2 text-primary">
              <Sparkles className="h-5 w-5" />
              <h3 className="text-lg font-bold">What to focus on next</h3>
            </div>
            <div className="space-y-3">
              {weakZones.map((zone, idx) => (
                <div
                  key={idx}
                  className="flex gap-3 rounded-2xl border border-primary/30 bg-primary/5 p-4 text-sm leading-relaxed text-foreground"
                >
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-primary/20 text-xs font-bold text-primary">
                    {idx + 1}
                  </span>
                  <div className="flex-1">
                    <RichText>{typeof zone === "string" ? zone : JSON.stringify(zone)}</RichText>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
