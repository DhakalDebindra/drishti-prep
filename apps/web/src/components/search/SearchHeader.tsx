import Link from "next/link";
import { PlayCircle } from "lucide-react";

import { SearchHeaderCopy } from "@/config/copy";
import { Lang } from "@/components/ui/Lang";
import { plural } from "@/lib/search/format";
import { practiceUrl } from "@/lib/search/links";
import type { SubjectHeader } from "@/lib/search/types";

/**
 * Orientation for a subject-shaped query: how big it is, how far the learner
 * has come, and where to pick up. All of it is SQL — no AI on this page.
 */
export function SearchHeader({ header }: { header: SubjectHeader }) {
  const { subject, totals, progress, resume, exam } = header;
  if (!subject) return null;

  const resumeHref = resume ? practiceUrl(resume) : null;

  return (
    <section
      aria-labelledby="subject-header-heading"
      className="rounded-2xl border-2 border-border bg-card p-5 shadow-sm sm:p-6"
    >
      <h2
        id="subject-header-heading"
        className="text-lg font-bold text-foreground sm:text-xl"
      >
        <Lang>{subject.name_np || subject.name}</Lang>
      </h2>

      <p className="mt-1 text-sm text-muted-foreground">
        {plural(totals.sets, "set")} · {plural(totals.questions, "question")} ·{" "}
        {plural(totals.topics, "topic")}
      </p>

      {progress.started_sets > 0 && (
        <p className="mt-2 text-sm font-medium text-foreground">
          {SearchHeaderCopy.completed(progress.completed_sets, totals.sets)}
        </p>
      )}

      {resume && (
        <div className="mt-4 flex flex-wrap items-center gap-3">
          {resumeHref ? (
            <Link
              href={resumeHref}
              className="inline-flex min-h-11 items-center gap-2 rounded-lg border-2 border-primary bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground transition hover:opacity-90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
            >
              <PlayCircle className="h-4 w-4" aria-hidden="true" />
              {resume.reason === "in_progress" ? SearchHeaderCopy.resume : SearchHeaderCopy.start}:{" "}
              <Lang>{resume.title}</Lang>
            </Link>
          ) : (
            <span className="text-sm text-muted-foreground">
              {SearchHeaderCopy.nextUp} <Lang>{resume.title}</Lang>
            </span>
          )}
          <span className="text-sm text-muted-foreground">
            {plural(resume.q_count, "question")}
          </span>
        </div>
      )}

      {/*
        Official exam weighting, shown only when the syllabus actually states
        one. subjects.syllabus_ref maps to a published unit; topic-level counts
        do not exist officially, so nothing is ever shown per topic.
      */}
      {exam && (
        <p className="mt-4 border-t border-border pt-3 text-sm text-muted-foreground">
          {SearchHeaderCopy.examWeight(
            subject.syllabus_ref ?? "",
            exam.question_count
          )}
          <span className="sr-only">
            {SearchHeaderCopy.examSource(exam.source_note)}
          </span>
        </p>
      )}
    </section>
  );
}
