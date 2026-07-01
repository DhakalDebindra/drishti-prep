import React from "react";
import Link from "next/link";
import { PlayCircle, Bookmark, ArrowRight, Sparkles } from "lucide-react";

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
  status: string;
  set_id: string;
  question_sets: SetInfo | null;
}

export function PracticeBanners({ attempts }: { attempts: AttemptWithSet[] }) {
  const inProgressAttempt = attempts.find((attempt) => attempt.status === "in_progress");

  return (
    <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
      {inProgressAttempt && inProgressAttempt.question_sets ? (
        <div className="relative overflow-hidden rounded-[2rem] border border-white/70 bg-gradient-to-br from-emerald-500 via-teal-500 to-cyan-500 p-6 text-white shadow-[0_20px_60px_rgba(15,23,42,0.16)]">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(255,255,255,0.18),transparent_45%)]" />
          <div className="relative flex h-full flex-col gap-5">
            <div className="space-y-2">
              <div className="inline-flex items-center gap-2 rounded-full bg-white/15 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-white/90">
                <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
                Resume practice
              </div>
              <h3 className="text-2xl font-bold tracking-tight">
                {inProgressAttempt.question_sets.title}
              </h3>
              <p className="text-sm text-white/85">
                {inProgressAttempt.question_sets.topic.subject.name} ·{" "}
                {inProgressAttempt.question_sets.topic.name}
              </p>
            </div>
            <Link
              href={`/practice/${inProgressAttempt.set_id}`}
              className="inline-flex w-fit items-center gap-2 rounded-full bg-white px-4 py-2.5 text-sm font-semibold text-slate-950 transition hover:-translate-y-0.5 hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/80"
            >
              <PlayCircle className="h-4 w-4" />
              Continue set
            </Link>
          </div>
        </div>
      ) : (
        <div className="rounded-[2rem] border border-slate-200 bg-white/85 p-6 text-center shadow-sm backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70">
          <div className="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-2xl bg-primary/10 text-primary">
            <Sparkles className="h-5 w-5" aria-hidden="true" />
          </div>
          <div className="space-y-1">
            <p className="text-base font-semibold text-slate-950 dark:text-white">
              No active practice sets
            </p>
            <p className="text-sm text-slate-600 dark:text-slate-300">
              Start a fresh session when you are ready.
            </p>
          </div>
          <Link
            href="/practice"
            className="mt-4 inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring dark:border-slate-700 dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
          >
            Browse available sets
            <ArrowRight className="h-4 w-4" aria-hidden="true" />
          </Link>
        </div>
      )}

      <div className="rounded-[2rem] border border-slate-200 bg-white/85 p-6 shadow-sm backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70">
        <div className="flex items-center gap-2 text-slate-800 dark:text-slate-200">
          <Bookmark className="h-5 w-5 text-primary" />
          <span className="text-lg font-bold">My Bookmarks</span>
        </div>
        <p className="mt-2 text-sm leading-relaxed text-slate-600 dark:text-slate-300">
          Review questions you found challenging or want to memorize.
        </p>
        <Link
          href="/bookmarks"
          className="mt-4 inline-flex items-center gap-2 rounded-full bg-slate-100 px-4 py-2 text-sm font-semibold text-slate-800 transition hover:bg-slate-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring dark:bg-slate-900 dark:text-slate-200 dark:hover:bg-slate-800"
        >
          View bookmarks
          <ArrowRight className="h-4 w-4" aria-hidden="true" />
        </Link>
      </div>
    </div>
  );
}
