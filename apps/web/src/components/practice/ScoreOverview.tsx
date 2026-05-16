"use client";

import React from "react";
import { CheckCircle2, XCircle, MinusCircle, Clock } from "lucide-react";

interface ScoreOverviewProps {
  scoreRaw: number;
  scorePct: number;
  totalQuestions: number;
  skippedCount: number;
  submittedAt?: string | null;
}

export function ScoreOverview({
  scoreRaw,
  scorePct,
  totalQuestions,
  skippedCount,
  submittedAt,
}: ScoreOverviewProps) {
  // Skipped questions are neither correct nor incorrect — exclude them so the
  // incorrect count isn't inflated.
  const incorrectQuestions = Math.max(0, totalQuestions - scoreRaw - skippedCount);

  const formattedDate = submittedAt
    ? new Date(submittedAt).toLocaleDateString("en-US", {
        month: "long",
        day: "numeric",
        year: "numeric",
        hour: "numeric",
        minute: "2-digit",
      })
    : "Recently";

  return (
    <section aria-labelledby="score-overview-heading" className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 md:p-8 flex flex-col md:flex-row items-center gap-8 shadow-sm">
      <div className="relative flex items-center justify-center w-40 h-40">
        <svg 
          className="w-full h-full transform -rotate-90" 
          viewBox="0 0 36 36"
          role="img"
          aria-label={`Score progress chart: ${Math.round(scorePct)} percent`}
        >
          <circle
            cx="18"
            cy="18"
            r="16"
            fill="none"
            className="stroke-slate-100 dark:stroke-slate-800"
            strokeWidth="3.5"
          />
          <circle
            cx="18"
            cy="18"
            r="16"
            fill="none"
            className="stroke-green-500"
            strokeWidth="3.5"
            strokeDasharray="100"
            strokeDashoffset={100 - scorePct}
            strokeLinecap="round"
          />
        </svg>
        <div className="absolute flex flex-col items-center justify-center">
          <span className="text-4xl font-bold text-slate-900 dark:text-white">
            {Math.round(scorePct)}%
          </span>
          <span className="text-xs text-slate-500 dark:text-slate-400 font-medium">
            Score
          </span>
        </div>
      </div>

      <div className="flex-1 space-y-6 w-full">
        <div>
          <h2 id="score-overview-heading" className="text-2xl font-bold text-slate-900 dark:text-white">
            Practice Set Completed
          </h2>
          <div className="flex items-center text-sm text-slate-500 dark:text-slate-400 mt-1 gap-2">
            <Clock className="w-4 h-4" />
            <span>Submitted on {formattedDate}</span>
          </div>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-4 border border-slate-100 dark:border-slate-700">
            <div className="text-slate-500 dark:text-slate-400 text-sm font-medium mb-1">
              Total Questions
            </div>
            <div className="text-2xl font-semibold text-slate-900 dark:text-white">
              {totalQuestions}
            </div>
          </div>
          <div className="bg-green-50 dark:bg-green-900/10 rounded-xl p-4 border border-green-100 dark:border-green-900/20">
            <div className="flex items-center gap-1.5 text-green-700 dark:text-green-400 text-sm font-medium mb-1">
              <CheckCircle2 className="w-4 h-4" />
              Correct
            </div>
            <div className="text-2xl font-semibold text-green-700 dark:text-green-400">
              {scoreRaw}
            </div>
          </div>
          <div className="bg-red-50 dark:bg-red-900/10 rounded-xl p-4 border border-red-100 dark:border-red-900/20">
            <div className="flex items-center gap-1.5 text-red-700 dark:text-red-400 text-sm font-medium mb-1">
              <XCircle className="w-4 h-4" />
              Incorrect
            </div>
            <div className="text-2xl font-semibold text-red-700 dark:text-red-400">
              {incorrectQuestions}
            </div>
          </div>
          <div className="bg-slate-50 dark:bg-slate-800/50 rounded-xl p-4 border border-slate-100 dark:border-slate-700">
            <div className="flex items-center gap-1.5 text-slate-600 dark:text-slate-400 text-sm font-medium mb-1">
              <MinusCircle className="w-4 h-4" />
              Skipped
            </div>
            <div className="text-2xl font-semibold text-slate-600 dark:text-slate-400">
              {skippedCount}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
