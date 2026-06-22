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
          throw new Error("Failed to generate AI feedback");
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
        className="rounded-[2rem] border border-white/70 bg-white/85 p-6 text-center shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8"
      >
        <div className="mx-auto mb-4 flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-50 text-emerald-600 dark:bg-emerald-950/30 dark:text-emerald-300">
          <Sparkles className="h-5 w-5 animate-pulse" />
        </div>
        <h3 className="text-lg font-semibold text-slate-950 dark:text-white">
          AI is analyzing your performance...
        </h3>
        <p className="mt-2 text-sm leading-relaxed text-slate-600 dark:text-slate-300">
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
        className="rounded-[2rem] border border-rose-200 bg-rose-50 p-6 text-rose-900 shadow-sm dark:border-rose-900/50 dark:bg-rose-950/30 dark:text-rose-200 md:p-8"
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
      className="rounded-[2rem] border border-white/70 bg-white/85 p-6 shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8"
    >
      <div className="mb-6 flex items-start justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="rounded-2xl bg-emerald-50 p-3 text-emerald-700 dark:bg-emerald-950/30 dark:text-emerald-300">
            <BrainCircuit className="h-6 w-6" />
          </div>
          <div>
            <h2 className="text-xl font-bold tracking-tight text-slate-950 dark:text-white">
              AI Analysis & Insights
            </h2>
            <p className="text-sm text-slate-600 dark:text-slate-300">
              Powered by DrishtiPrep AI
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-6">
        {feedback.strengths && (
          <div className="rounded-[1.5rem] border border-slate-200 bg-slate-50/80 p-5 dark:border-slate-800 dark:bg-slate-900/60">
            <div className="mb-3 flex items-center gap-2 text-emerald-700 dark:text-emerald-300">
              <Lightbulb className="h-5 w-5" />
              <h3 className="text-lg font-bold">Overall Performance</h3>
            </div>
            <div className="text-sm leading-relaxed text-slate-700 dark:text-slate-300">
              <RichText>{feedback.strengths}</RichText>
            </div>
          </div>
        )}

        {weakZones.length > 0 && (
          <div>
            <div className="mb-3 flex items-center gap-2 text-cyan-700 dark:text-cyan-300">
              <Sparkles className="h-5 w-5" />
              <h3 className="text-lg font-bold">Recommended Focus Areas</h3>
            </div>
            <div className="space-y-3">
              {weakZones.map((zone, idx) => (
                <div
                  key={idx}
                  className="flex gap-3 rounded-[1.4rem] border border-cyan-200 bg-cyan-50/70 p-4 text-sm leading-relaxed text-slate-700 dark:border-cyan-900/40 dark:bg-cyan-950/20 dark:text-slate-200"
                >
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-cyan-200 text-xs font-bold text-cyan-900 dark:bg-cyan-900/50 dark:text-cyan-100">
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
