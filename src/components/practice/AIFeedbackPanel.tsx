"use client";

import React, { useEffect, useState } from "react";
import { Sparkles, BrainCircuit, AlertTriangle, Lightbulb } from "lucide-react";
import type { AIFeedback } from "@/types/practice";

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
        className="bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 md:p-8 animate-pulse text-center space-y-4"
      >
        <Sparkles className="w-8 h-8 text-blue-500 mx-auto animate-bounce" />
        <h3 className="text-lg font-medium text-slate-800 dark:text-slate-200">
          AI is analyzing your performance...
        </h3>
        <p className="text-sm text-slate-500 dark:text-slate-400">
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
        className="bg-red-50 dark:bg-red-900/10 border border-red-200 dark:border-red-900/20 rounded-2xl p-6 md:p-8 flex items-center justify-center text-red-600 dark:text-red-400"
      >
        <AlertTriangle className="w-5 h-5 mr-2" />
        <span>We couldn't generate AI feedback at this time. Please try again later.</span>
      </div>
    );
  }

  const parseWeakZones = (weakZones: Record<string, unknown> | null) => {
    if (!weakZones || typeof weakZones !== "object") return [];
    if (Array.isArray(weakZones)) return weakZones;
    return Object.keys(weakZones); // basic extraction depending on AI output shape
  };

  const weakZones = parseWeakZones(feedback.weak_zones);

  return (
    <div 
      aria-live="polite" 
      aria-atomic="true" 
      className="bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-slate-900 dark:to-indigo-950/20 border border-blue-100 dark:border-indigo-900/30 rounded-2xl p-6 md:p-8 shadow-sm"
    >
      <div className="flex items-start justify-between mb-6">
        <div className="flex items-center gap-3">
          <div className="p-2.5 bg-blue-100 dark:bg-blue-900/50 rounded-lg">
            <BrainCircuit className="w-6 h-6 text-blue-600 dark:text-blue-400" />
          </div>
          <div>
            <h2 className="text-xl font-bold text-slate-900 dark:text-white">
              AI Analysis & Insights
            </h2>
            <p className="text-sm text-slate-600 dark:text-slate-400">
              Powered by DrishtiPrep AI
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-6">
        {feedback.strengths && (
          <div className="p-4 bg-white/60 dark:bg-slate-800/60 rounded-xl backdrop-blur-sm border border-white dark:border-slate-700/50">
            <div className="flex items-center gap-2 text-indigo-700 dark:text-indigo-400 font-medium mb-3">
              <Lightbulb className="w-5 h-5" />
              <h3 className="text-lg font-bold">Overall Performance</h3>
            </div>
            <p className="text-slate-700 dark:text-slate-300 text-sm leading-relaxed whitespace-pre-wrap">
              {feedback.strengths}
            </p>
          </div>
        )}
 
        {weakZones.length > 0 && (
          <div>
            <div className="flex items-center gap-2 text-orange-700 dark:text-orange-400 font-medium mb-3">
              <Sparkles className="w-5 h-5" />
              <h3 className="text-lg font-bold">Recommended Focus Areas</h3>
            </div>
            <div className="space-y-3">
              {weakZones.map((zone, idx) => (
                <div
                  key={idx}
                  className="p-4 bg-orange-50 dark:bg-orange-900/10 text-slate-700 dark:text-slate-300 text-sm leading-relaxed rounded-xl border border-orange-100 dark:border-orange-900/20 flex gap-3"
                >
                  <span className="flex-shrink-0 w-6 h-6 flex items-center justify-center bg-orange-200 dark:bg-orange-900/40 text-orange-700 dark:text-orange-300 text-xs font-bold rounded-full">
                    {idx + 1}
                  </span>
                  <span>{typeof zone === "string" ? zone : JSON.stringify(zone)}</span>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
