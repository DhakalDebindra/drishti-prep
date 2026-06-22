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
    <section
      aria-labelledby="score-overview-heading"
      className="rounded-[2rem] border border-slate-200 bg-white/90 p-6 shadow-sm backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 md:p-8"
    >
      <div className="flex flex-col gap-8 md:flex-row md:items-center">
        <div className="relative flex h-40 w-40 items-center justify-center self-center md:self-auto">
          <svg
            className="h-full w-full -rotate-90 transform"
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
              className="stroke-emerald-500"
              strokeWidth="3.5"
              strokeDasharray="100"
              strokeDashoffset={100 - scorePct}
              strokeLinecap="round"
            />
          </svg>
          <div className="absolute flex flex-col items-center justify-center">
            <span className="text-4xl font-bold text-slate-950 dark:text-white">
              {Math.round(scorePct)}%
            </span>
            <span className="text-xs font-medium text-slate-500 dark:text-slate-400">
              Score
            </span>
          </div>
        </div>

        <div className="flex-1 space-y-6 w-full">
          <div>
            <h2 id="score-overview-heading" className="text-2xl font-bold tracking-tight text-slate-950 dark:text-white">
              Practice set completed
            </h2>
            <div className="mt-1 flex items-center gap-2 text-sm text-slate-500 dark:text-slate-400">
              <Clock className="h-4 w-4" />
              <span>Submitted on {formattedDate}</span>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4 md:grid-cols-4">
            <div className="rounded-2xl border border-slate-200 bg-slate-50 p-4 dark:border-slate-800 dark:bg-slate-900/60">
              <div className="text-sm font-medium text-slate-500 dark:text-slate-400">
                Total Questions
              </div>
              <div className="mt-1 text-2xl font-semibold text-slate-950 dark:text-white">
                {totalQuestions}
              </div>
            </div>
            <div className="rounded-2xl border border-emerald-200 bg-emerald-50 p-4 dark:border-emerald-900/40 dark:bg-emerald-950/30">
              <div className="mb-1 flex items-center gap-1.5 text-sm font-medium text-emerald-800 dark:text-emerald-300">
                <CheckCircle2 className="h-4 w-4" />
                Correct
              </div>
              <div className="text-2xl font-semibold text-emerald-800 dark:text-emerald-300">
                {scoreRaw}
              </div>
            </div>
            <div className="rounded-2xl border border-rose-200 bg-rose-50 p-4 dark:border-rose-900/40 dark:bg-rose-950/30">
              <div className="mb-1 flex items-center gap-1.5 text-sm font-medium text-rose-800 dark:text-rose-300">
                <XCircle className="h-4 w-4" />
                Incorrect
              </div>
              <div className="text-2xl font-semibold text-rose-800 dark:text-rose-300">
                {incorrectQuestions}
              </div>
            </div>
            <div className="rounded-2xl border border-slate-200 bg-slate-50 p-4 dark:border-slate-800 dark:bg-slate-900/60">
              <div className="mb-1 flex items-center gap-1.5 text-sm font-medium text-slate-500 dark:text-slate-400">
                <MinusCircle className="h-4 w-4" />
                Skipped
              </div>
              <div className="text-2xl font-semibold text-slate-700 dark:text-slate-200">
                {skippedCount}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
