import React from "react";
import { Target, Activity, CheckCircle2 } from "lucide-react";

interface AttemptRow {
  id: string;
  set_id: string;
  question_count: number | null;
  score_raw: number | null;
  status: string;
  submitted_at: string | null;
}

export function MacroAnalytics({ attempts }: { attempts: AttemptRow[] }) {
  const completedAttempts = attempts.filter((a) => a.status === "submitted");

  // Keep only the best attempt per question set to avoid double-counting the same questions.
  const bestAttemptsMap = completedAttempts.reduce((acc, current) => {
    const existing = acc[current.set_id];
    if (!existing || (current.score_raw || 0) > (existing.score_raw || 0)) {
       acc[current.set_id] = current;
    }
    return acc;
  }, {} as Record<string, AttemptRow>);

  const uniqueSetAttempts = Object.values(bestAttemptsMap);

  const totalQuestionsPracticed = uniqueSetAttempts.reduce(
    (sum, a) => sum + (a.question_count || 0),
    0
  );

  const totalCorrect = uniqueSetAttempts.reduce(
    (sum, a) => sum + (a.score_raw || 0),
    0
  );

  const overallAccuracy =
    totalQuestionsPracticed > 0
      ? Math.round((totalCorrect / totalQuestionsPracticed) * 100)
      : 0;



  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
      <div className="rounded-[1.5rem] border border-slate-200 bg-slate-50/80 p-5 flex items-center gap-4 dark:border-slate-800 dark:bg-slate-900/60 transition hover:-translate-y-0.5 hover:shadow-sm">
        <div className="p-3 bg-blue-100/50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-xl">
          <Target className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-slate-500 dark:text-slate-400">
            Questions Practiced
          </div>
          <div className="text-2xl font-bold tracking-tight text-slate-950 dark:text-white">
            {totalQuestionsPracticed}
          </div>
        </div>
      </div>

      <div className="rounded-[1.5rem] border border-emerald-200 bg-emerald-50/80 p-5 flex items-center gap-4 dark:border-emerald-900/50 dark:bg-emerald-950/30 transition hover:-translate-y-0.5 hover:shadow-sm">
        <div className="p-3 bg-emerald-100/50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300 rounded-xl">
          <CheckCircle2 className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-emerald-800 dark:text-emerald-300">
            Overall Accuracy
          </div>
          <div className="text-2xl font-bold tracking-tight text-emerald-950 dark:text-emerald-50">
            {overallAccuracy}%
          </div>
        </div>
      </div>

      <div className="rounded-[1.5rem] border border-cyan-200 bg-cyan-50/80 p-5 flex items-center gap-4 dark:border-cyan-900/50 dark:bg-cyan-950/30 transition hover:-translate-y-0.5 hover:shadow-sm">
        <div className="p-3 bg-cyan-100/50 dark:bg-cyan-900/30 text-cyan-700 dark:text-cyan-300 rounded-xl">
          <Activity className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-cyan-800 dark:text-cyan-300">
            Active Study Days
          </div>
          <div className="text-2xl font-bold tracking-tight text-cyan-950 dark:text-cyan-50">
            7
          </div>
        </div>
      </div>
    </div>
  );
}
