import React from "react";
import Link from "next/link";
import { ChevronRight, TrendingUp, TrendingDown, Minus } from "lucide-react";
import { Lang } from "@/components/ui/Lang";

interface SetInfo {
  title: string;
  topic: {
    name: string;
    slug: string;
    subject: {
      name: string;
      slug: string;
      module: {
        slug: string;
      };
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
    <div className="rounded-[2rem] border border-white/70 bg-white/85 shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 overflow-hidden">
      <div className="flex items-center justify-between border-b border-slate-200 px-5 py-4 dark:border-slate-800 sm:px-6">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.24em] text-slate-500 dark:text-slate-400">
            Active Practice Sets
          </p>
          <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
            Your recent practice sessions across all courses.
          </p>
        </div>
        <span className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-600 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-300">
          {Object.keys(grouped).length} sets
        </span>
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
                 diffElement = <span className="text-emerald-600 dark:text-emerald-400 flex items-center text-xs font-medium"><TrendingUp className="w-3.5 h-3.5 mr-1" /> +{diff}% vs last</span>;
              } else if (diff < 0) {
                 diffElement = <span className="text-rose-600 dark:text-rose-400 flex items-center text-xs font-medium"><TrendingDown className="w-3.5 h-3.5 mr-1" /> {diff}% vs last</span>;
              } else {
                 diffElement = <span className="text-slate-500 dark:text-slate-400 flex items-center text-xs font-medium"><Minus className="w-3.5 h-3.5 mr-1" /> No change</span>;
              }
           } else {
              diffElement = <span className="text-slate-500 dark:text-slate-400 flex items-center text-xs font-medium">First attempt</span>;
           }

           const dateStr = latest.submitted_at
             ? new Date(latest.submitted_at).toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })
             : "Unknown Date";

           const latestSet = latest.question_sets;
           const topicSlug = latestSet?.topic.slug || "";
           const subjectSlug = latestSet?.topic.subject.slug || "";
           const moduleSlug = latestSet?.topic.subject.module.slug || "";

           return (
             <Link 
               key={latest.set_id} 
               href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/practice/${latest.set_id}/review?attemptId=${latest.id}`}
               className="flex flex-col sm:flex-row sm:items-center justify-between p-5 sm:p-6 hover:bg-slate-50/60 dark:hover:bg-slate-900/40 transition-colors group gap-4"
             >
                <div className="flex-1">
                  <div className="flex flex-wrap items-center gap-2 mb-2">
                    <span className="rounded-full border border-slate-200 bg-slate-50 px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.22em] text-slate-500 dark:border-slate-700 dark:bg-slate-900 dark:text-slate-400">
                      <Lang>{subject}</Lang> &bull; <Lang>{topic}</Lang>
                    </span>
                    <span className="text-xs text-slate-500 dark:text-slate-400">
                      {dateStr}
                    </span>
                  </div>
                  <h4 className="text-base font-semibold tracking-tight text-slate-950 dark:text-white group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">
                    <Lang>{setTitle}</Lang>
                  </h4>
                </div>
                
                <div className="flex items-center justify-between sm:justify-end gap-6 sm:w-auto w-full border-t border-slate-100 dark:border-slate-800 sm:border-0 pt-4 sm:pt-0">
                   <div className="text-left sm:text-right">
                     <div className="text-2xl font-bold text-slate-950 dark:text-white tracking-tight leading-none mb-1.5 flex items-end sm:justify-end gap-2 text-right">
                       <span>{latestScore}%</span>
                     </div>
                     {diffElement}
                   </div>
                   <div className="w-10 h-10 rounded-full border border-slate-200 bg-white dark:border-slate-700 dark:bg-slate-900 shadow-sm flex items-center justify-center group-hover:bg-emerald-50 group-hover:border-emerald-200 group-hover:text-emerald-600 dark:group-hover:bg-emerald-950/30 dark:group-hover:border-emerald-900/60 transition-all shrink-0 text-slate-400">
                     <ChevronRight className="w-5 h-5 fill-current" />
                   </div>
                </div>
             </Link>
           );
        })}
      </div>
    </div>
  );
}
