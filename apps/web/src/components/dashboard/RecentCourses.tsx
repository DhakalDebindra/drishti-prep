"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronRight, GraduationCap, Loader2 } from "lucide-react";
import { cn } from "@repo/utils";
import { Lang } from "@/components/ui/Lang";

export type CourseInput = { id: string; name: string; slug: string };

type Subtopic = { id: string; name: string; slug: string; syllabus_ref: string | null };
type Topic = {
  id: string;
  name: string;
  slug: string;
  syllabus_ref: string | null;
  subtopics: Subtopic[];
};
type Subject = {
  id: string;
  name: string;
  slug: string;
  syllabus_ref: string | null;
  topics: Topic[];
};

/**
 * Expandable syllabus trees for the courses a learner has recently practised.
 * Each course lazy-loads its subject/topic/subtopic structure the first time it
 * is opened (one request per course), then expands/collapses purely client-side.
 * Leaves link to the canonical topic/subtopic pages, which list the sets.
 *
 * All state changes happen in event handlers (never in an effect), so this
 * stays clear of the CI react-hooks/set-state-in-effect rule.
 */
export function RecentCourses({ courses }: { courses: CourseInput[] }) {
  return (
    <ul className="space-y-3">
      {courses.map((course) => (
        <li key={course.id}>
          <CourseNode course={course} />
        </li>
      ))}
    </ul>
  );
}

function Ref({ value }: { value: string | null }) {
  if (!value) return null;
  return <span className="mr-2 font-normal text-muted-foreground">{value}</span>;
}

function CourseNode({ course }: { course: CourseInput }) {
  const [open, setOpen] = useState(false);
  const [subjects, setSubjects] = useState<Subject[] | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const panelId = `course-${course.id}-panel`;

  async function loadStructure() {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/courses/structure?module_id=${encodeURIComponent(course.id)}`);
      if (!res.ok) throw new Error("Request failed");
      const json = await res.json();
      setSubjects(Array.isArray(json.subjects) ? json.subjects : []);
    } catch {
      setError("Could not load this course's contents. Please try again.");
    } finally {
      setLoading(false);
    }
  }

  function toggle() {
    const next = !open;
    setOpen(next);
    if (next && subjects === null && !loading) {
      void loadStructure();
    }
  }

  return (
    <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-sm">
      <button
        type="button"
        onClick={toggle}
        aria-expanded={open}
        aria-controls={panelId}
        className="flex w-full items-center gap-3 px-4 py-4 text-left transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring sm:px-5"
      >
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-primary/15 text-primary">
          <GraduationCap className="h-5 w-5" aria-hidden="true" />
        </span>
        <span className="flex-1 text-base font-semibold text-foreground">
          <Lang>{course.name}</Lang>
        </span>
        <ChevronRight
          className={cn(
            "h-5 w-5 shrink-0 text-muted-foreground transition-transform",
            open && "rotate-90"
          )}
          aria-hidden="true"
        />
      </button>

      {open && (
        <div id={panelId} className="border-t border-border px-2 py-2 sm:px-3">
          {loading && (
            <p className="flex items-center gap-2 px-3 py-3 text-sm text-muted-foreground">
              <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
              Loading course contents…
            </p>
          )}
          {error && (
            <div className="px-3 py-3">
              <p role="alert" className="text-sm font-medium text-destructive">
                {error}
              </p>
              <button
                type="button"
                onClick={() => void loadStructure()}
                className="mt-2 rounded-lg border border-border bg-card px-3 py-1.5 text-sm font-medium text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                Retry
              </button>
            </div>
          )}
          {!loading && !error && subjects !== null && subjects.length === 0 && (
            <p className="px-3 py-3 text-sm text-muted-foreground">
              No subjects are available yet in this course.
            </p>
          )}
          {!loading && !error && subjects && subjects.length > 0 && (
            <ul className="space-y-1">
              {subjects.map((subject) => (
                <li key={subject.id}>
                  <SubjectNode subject={subject} courseSlug={course.slug} />
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}

function SubjectNode({ subject, courseSlug }: { subject: Subject; courseSlug: string }) {
  const [open, setOpen] = useState(false);
  const panelId = `subject-${subject.id}-panel`;

  return (
    <div>
      <button
        type="button"
        onClick={() => setOpen((value) => !value)}
        aria-expanded={open}
        aria-controls={panelId}
        className="flex w-full items-center gap-2 rounded-lg px-3 py-2.5 text-left text-sm font-semibold text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
      >
        <ChevronRight
          className={cn(
            "h-4 w-4 shrink-0 text-muted-foreground transition-transform",
            open && "rotate-90"
          )}
          aria-hidden="true"
        />
        <span className="flex-1">
          <Ref value={subject.syllabus_ref} />
          <Lang>{subject.name}</Lang>
        </span>
      </button>
      {open && (
        <div id={panelId} className="ml-4 border-l border-border pl-2">
          {subject.topics.length > 0 ? (
            <ul className="space-y-0.5 py-1">
              {subject.topics.map((topic) => (
                <li key={topic.id}>
                  <TopicNode topic={topic} courseSlug={courseSlug} subjectSlug={subject.slug} />
                </li>
              ))}
            </ul>
          ) : (
            <p className="px-3 py-2 text-sm text-muted-foreground">No topics yet.</p>
          )}
        </div>
      )}
    </div>
  );
}

function TopicNode({
  topic,
  courseSlug,
  subjectSlug,
}: {
  topic: Topic;
  courseSlug: string;
  subjectSlug: string;
}) {
  const [open, setOpen] = useState(false);
  const topicHref = `/courses/${courseSlug}/${subjectSlug}/${topic.slug}`;
  const panelId = `topic-${topic.id}-panel`;

  // A topic with no subtopics links straight to its practice sets.
  if (topic.subtopics.length === 0) {
    return (
      <Link
        href={topicHref}
        className="flex items-center gap-2 rounded-lg px-3 py-2.5 text-sm font-medium text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
      >
        <span className="h-4 w-4 shrink-0" aria-hidden="true" />
        <span className="flex-1">
          <Ref value={topic.syllabus_ref} />
          <Lang>{topic.name}</Lang>
        </span>
        <ChevronRight className="h-4 w-4 shrink-0 text-muted-foreground" aria-hidden="true" />
      </Link>
    );
  }

  return (
    <div>
      <button
        type="button"
        onClick={() => setOpen((value) => !value)}
        aria-expanded={open}
        aria-controls={panelId}
        className="flex w-full items-center gap-2 rounded-lg px-3 py-2.5 text-left text-sm font-medium text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
      >
        <ChevronRight
          className={cn(
            "h-4 w-4 shrink-0 text-muted-foreground transition-transform",
            open && "rotate-90"
          )}
          aria-hidden="true"
        />
        <span className="flex-1">
          <Ref value={topic.syllabus_ref} />
          <Lang>{topic.name}</Lang>
        </span>
      </button>
      {open && (
        <ul id={panelId} className="ml-4 space-y-0.5 border-l border-border py-1 pl-2">
          {topic.subtopics.map((subtopic) => (
            <li key={subtopic.id}>
              <Link
                href={`/courses/${courseSlug}/${subjectSlug}/${topic.slug}/${subtopic.slug}`}
                className="flex items-center gap-2 rounded-lg px-3 py-2 text-sm text-foreground transition-colors hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <span className="flex-1">
                  <Ref value={subtopic.syllabus_ref} />
                  <Lang>{subtopic.name}</Lang>
                </span>
                <ChevronRight className="h-4 w-4 shrink-0 text-muted-foreground" aria-hidden="true" />
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
