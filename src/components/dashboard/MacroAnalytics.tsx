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

  // Calculate active days (simple streak logic based on unique days practice submitted)
  const activeDays = new Set(
    completedAttempts
      .map((a) => (a.submitted_at ? new Date(a.submitted_at).toDateString() : ""))
      .filter(Boolean)
  ).size;

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 p-5 rounded-2xl shadow-sm flex items-center gap-4">
        <div className="p-3 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-xl">
          <Target className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-slate-500 dark:text-slate-400">
            Questions Practiced
          </div>
          <div className="text-2xl font-bold text-slate-900 dark:text-white">
            {totalQuestionsPracticed}
          </div>
        </div>
      </div>

      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 p-5 rounded-2xl shadow-sm flex items-center gap-4">
        <div className="p-3 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 rounded-xl">
          <CheckCircle2 className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-slate-500 dark:text-slate-400">
            Overall Accuracy
          </div>
          <div className="text-2xl font-bold text-slate-900 dark:text-white">
            {overallAccuracy}%
          </div>
        </div>
      </div>

      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 p-5 rounded-2xl shadow-sm flex items-center gap-4">
        <div className="p-3 bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400 rounded-xl">
          <Activity className="w-6 h-6" />
        </div>
        <div>
          <div className="text-sm font-medium text-slate-500 dark:text-slate-400">
            Active Study Days
          </div>
          <div className="text-2xl font-bold text-slate-900 dark:text-white">
            {activeDays}
          </div>
        </div>
      </div>
    </div>
  );
}
