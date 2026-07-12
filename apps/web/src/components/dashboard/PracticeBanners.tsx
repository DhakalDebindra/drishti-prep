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
        <div className="relative overflow-hidden rounded-3xl border-2 border-primary bg-primary p-6 text-primary-foreground">
          <div className="flex h-full flex-col gap-5">
            <div className="space-y-2">
              <div className="inline-flex items-center gap-2 rounded-full bg-primary-foreground/15 px-3 py-1 text-xs font-semibold uppercase tracking-[0.22em] text-primary-foreground/90">
                <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
                Resume practice
              </div>
              <h3 className="text-2xl font-bold tracking-tight">
                {inProgressAttempt.question_sets.title}
              </h3>
              <p className="text-sm text-primary-foreground/85">
                {inProgressAttempt.question_sets.topic.subject.name} ·{" "}
                {inProgressAttempt.question_sets.topic.name}
              </p>
            </div>
            <Link
              href={`/practice/${inProgressAttempt.set_id}`}
              className="inline-flex w-fit items-center gap-2 rounded-full bg-primary-foreground px-4 py-2.5 text-sm font-semibold text-primary transition hover:opacity-90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-foreground/80"
            >
              <PlayCircle className="h-4 w-4" />
              Continue set
            </Link>
          </div>
        </div>
      ) : (
        <div className="rounded-3xl border border-border bg-card p-6 text-center shadow-sm">
          <div className="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-2xl bg-primary/10 text-primary">
            <Sparkles className="h-5 w-5" aria-hidden="true" />
          </div>
          <div className="space-y-1">
            <p className="text-base font-semibold text-foreground">
              No active practice sets
            </p>
            <p className="text-sm text-muted-foreground">
              Start a fresh session when you are ready.
            </p>
          </div>
          <Link
            href="/practice"
            className="mt-4 inline-flex items-center gap-2 rounded-full border border-border bg-card px-4 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
          >
            Browse available sets
            <ArrowRight className="h-4 w-4" aria-hidden="true" />
          </Link>
        </div>
      )}

      <div className="rounded-3xl border border-border bg-card p-6 shadow-sm">
        <div className="flex items-center gap-2 text-foreground">
          <Bookmark className="h-5 w-5 text-primary" />
          <span className="text-lg font-bold">My Bookmarks</span>
        </div>
        <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
          Review questions you found challenging or want to memorize.
        </p>
        <Link
          href="/bookmarks"
          className="mt-4 inline-flex items-center gap-2 rounded-full bg-muted px-4 py-2 text-sm font-semibold text-foreground transition hover:bg-muted/70 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
        >
          View bookmarks
          <ArrowRight className="h-4 w-4" aria-hidden="true" />
        </Link>
      </div>
    </div>
  );
}
