import React from "react";
import Link from "next/link";
import { ChevronRight, TrendingUp, TrendingDown, Minus } from "lucide-react";
import { Lang } from "@/components/ui/Lang";
import { WidgetCard } from "@/components/ui/widget-card";

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
      <div className="rounded-2xl border border-border bg-card p-8 text-center text-muted-foreground">
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
    <WidgetCard
      title="Active Practice Sets"
      subtitle="Your recent practice sessions across all courses."
      contentClassName="p-0"
      actionSlot={
        <span className="rounded-full border border-border bg-muted px-3 py-1.5 text-xs font-medium text-muted-foreground">
          {Object.keys(grouped).length} sets
        </span>
      }
    >
      <div className="flex flex-col divide-y divide-border">
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
                 diffElement = <span className="text-success flex items-center text-xs font-medium"><TrendingUp className="w-3.5 h-3.5 mr-1" /> +{diff}% vs last</span>;
              } else if (diff < 0) {
                 diffElement = <span className="text-destructive flex items-center text-xs font-medium"><TrendingDown className="w-3.5 h-3.5 mr-1" /> {diff}% vs last</span>;
              } else {
                 diffElement = <span className="text-muted-foreground flex items-center text-xs font-medium"><Minus className="w-3.5 h-3.5 mr-1" /> No change</span>;
              }
           } else {
              diffElement = <span className="text-muted-foreground flex items-center text-xs font-medium">First attempt</span>;
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
               className="flex flex-col sm:flex-row sm:items-center justify-between p-5 sm:p-6 hover:bg-muted/60 transition-colors group gap-4"
             >
                <div className="flex-1">
                  <div className="flex flex-wrap items-center gap-2 mb-2">
                    <span className="rounded-full border border-border bg-muted px-2.5 py-1 text-[10px] font-semibold uppercase tracking-[0.22em] text-muted-foreground">
                      <Lang>{subject}</Lang> &bull; <Lang>{topic}</Lang>
                    </span>
                    <span className="text-xs text-muted-foreground">
                      {dateStr}
                    </span>
                  </div>
                  <h4 className="text-base font-semibold tracking-tight text-foreground group-hover:text-primary transition-colors">
                    <Lang>{setTitle}</Lang>
                  </h4>
                </div>

                <div className="flex items-center justify-between sm:justify-end gap-6 sm:w-auto w-full border-t border-border sm:border-0 pt-4 sm:pt-0">
                   <div className="text-left sm:text-right">
                     <div className="text-2xl font-bold text-foreground tracking-tight leading-none mb-1.5 flex items-end sm:justify-end gap-2 text-right">
                       <span>{latestScore}%</span>
                     </div>
                     {diffElement}
                   </div>
                   <div className="w-10 h-10 rounded-full border border-border bg-card shadow-sm flex items-center justify-center group-hover:bg-primary/10 group-hover:border-primary/30 group-hover:text-primary transition-all shrink-0 text-muted-foreground">
                     <ChevronRight className="w-5 h-5 fill-current" />
                   </div>
                </div>
             </Link>
           );
        })}
      </div>
    </WidgetCard>
  );
}
