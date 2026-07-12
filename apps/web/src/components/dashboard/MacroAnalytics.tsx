import React from "react";
import { Target, Activity, CheckCircle2 } from "lucide-react";
import { StatCard } from "@/components/ui/stat-card";

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
    <div className="grid grid-cols-1 gap-4 md:grid-cols-3 mb-8">
      <StatCard
        icon={Target}
        label="Questions Practiced"
        value={totalQuestionsPracticed}
        tone="primary"
      />
      <StatCard
        icon={CheckCircle2}
        label="Overall Accuracy"
        value={`${overallAccuracy}%`}
        tone="success"
      />
      <StatCard
        icon={Activity}
        label="Active Study Days"
        value={7}
        tone="primary"
      />
    </div>
  );
}
