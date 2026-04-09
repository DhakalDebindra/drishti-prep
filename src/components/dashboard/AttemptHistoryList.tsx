import React from "react";
import Link from "next/link";
import { ChevronRight, TrendingUp, TrendingDown, Minus } from "lucide-react";

interface SetInfo {
  title: string;
  topic: {
    name: string;
    subject: {
      name: string;
    };
  };
}

interface AttemptWithSet {
  id: string;
  set_id: string;
  status: string;
  score_raw: number | null;
  score_pct: number | null;
  submitted_at: string | null;
  question_sets: SetInfo | null;
}

export function AttemptHistoryList({ attempts }: { attempts: AttemptWithSet[] }) {
  const completedAttempts = attempts.filter((a) => a.status === "submitted" && a.question_sets);

  if (completedAttempts.length === 0) {
    return (
      <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-8 text-center text-slate-500 dark:text-slate-400">
        You haven't completed any practice sets yet.
      </div>
    );
  }

  // The attempts from DashboardPage are already ordered by started_at DESC
  // We Group by set_id to isolate one row per distinct set
  const grouped = completedAttempts.reduce((acc, attempt) => {
    if (!acc[attempt.set_id]) acc[attempt.set_id] = [];
    acc[attempt.set_id].push(attempt);
    return acc;
  }, {} as Record<string, AttemptWithSet[]>);

  return (
    <div className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl overflow-hidden">
      <div className="px-6 py-4 border-b border-slate-200 dark:border-slate-800">
        <h3 className="text-lg font-bold text-slate-900 dark:text-white">
          Active Practice Sets
        </h3>
      </div>
      <div className="divide-y divide-slate-200 dark:divide-slate-800 flex flex-col">
        {Object.values(grouped).map(groupAttempts => {
           const latest = groupAttempts[0];
           const previous = groupAttempts.length > 1 ? groupAttempts[1] : null;

           const subject = latest.question_sets?.topic.subject.name || "";
           const topic = latest.question_sets?.topic.name || "";
           const setTitle = latest.question_sets?.title || "";
           
           const latestScore = Math.round(latest.score_pct || 0);
           
           let diffElement = null;
           if (previous) {
              const previousScore = Math.round(previous.score_pct || 0);
              const diff = latestScore - previousScore;
              if (diff > 0) {
                 diffElement = <span className="text-green-600 dark:text-green-400 flex items-center text-xs font-medium"><TrendingUp className="w-3.5 h-3.5 mr-1" /> +{diff}% vs last</span>;
              } else if (diff < 0) {
                 diffElement = <span className="text-red-600 dark:text-red-400 flex items-center text-xs font-medium"><TrendingDown className="w-3.5 h-3.5 mr-1" /> {diff}% vs last</span>;
              } else {
                 diffElement = <span className="text-slate-500 dark:text-slate-400 flex items-center text-xs font-medium"><Minus className="w-3.5 h-3.5 mr-1" /> No change</span>;
              }
           } else {
              diffElement = <span className="text-slate-500 dark:text-slate-400 flex items-center text-xs font-medium">First attempt</span>;
           }

           const dateStr = latest.submitted_at
             ? new Date(latest.submitted_at).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })
             : "Unknown Date";

           return (
             <Link 
               key={latest.set_id} 
               href={`/practice/${subject.toLowerCase()}/${topic.toLowerCase()}/${setTitle.toLowerCase()}/review?attemptId=${latest.id}`}
               className="flex flex-col sm:flex-row sm:items-center justify-between p-5 sm:p-6 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors group gap-4"
             >
                <div className="flex-1">
                  <div className="text-sm font-medium text-slate-500 dark:text-slate-400 mb-1">
                    {subject} &bull; {topic} &bull; {dateStr}
                  </div>
                  <h4 className="text-base font-bold text-slate-900 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                    {setTitle}
                  </h4>
                </div>
                
                <div className="flex items-center justify-between sm:justify-end gap-6 sm:w-auto w-full border-t border-slate-100 dark:border-slate-800 sm:border-0 pt-4 sm:pt-0">
                   <div className="text-left sm:text-right">
                     <div className="text-2xl font-bold text-slate-900 dark:text-white leading-none mb-1.5 flex items-end sm:justify-end gap-2 text-right">
                       <span>{latestScore}%</span>
                     </div>
                     {diffElement}
                   </div>
                   <div className="w-10 h-10 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center group-hover:bg-blue-100 dark:group-hover:bg-blue-900/50 transition-colors shrink-0">
                     <ChevronRight className="w-5 h-5 text-slate-400 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors" />
                   </div>
                </div>
             </Link>
           );
        })}
      </div>
    </div>
  );
}
