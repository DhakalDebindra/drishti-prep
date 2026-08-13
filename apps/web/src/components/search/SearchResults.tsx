import Link from "next/link";
import { ChevronRight, Lock } from "lucide-react";

import {
  AskChatCopy,
  SearchPaginationCopy,
  SearchResultsCopy,
} from "@/config/copy";
import { Lang } from "@/components/ui/Lang";
import { SearchQuestionCard } from "@/components/search/SearchQuestionCard";
import { plural, setsAndQuestions } from "@/lib/search/format";
import { practiceUrl, searchUrl, topicUrl } from "@/lib/search/links";
import type { SearchPayload, SearchSet } from "@/lib/search/types";

/**
 * The catalogue half of the search page: what DrishtiPrep already has for this
 * query. Pure database output, no AI.
 *
 * Grouping follows breadth. A subject-shaped query ("नेपालको भूगोल") returns 27
 * sets and 503 questions, which is a syllabus rather than a result list — so it
 * leads with the topic map and collapses the questions. Reading 503 stems aloud
 * to a screen-reader user is not a result page, it is a punishment.
 */
export function SearchResults({ payload }: { payload: SearchPayload }) {
  const { results, breadth, query } = payload;
  const { counts, topics, sets, questions } = results;

  const showTopicMap = breadth === "broad" && topics.length > 0;
  const showQuestions = breadth === "narrow" && questions.length > 0;

  return (
    <section aria-labelledby="results-heading" className="space-y-8">
      <div>
        <h2
          id="results-heading"
          className="text-lg font-bold text-foreground sm:text-xl"
        >
          {SearchResultsCopy.heading}
        </h2>
        {/*
          Counts come before the results themselves: a screen-reader user needs
          the shape of the page before walking it, and "503 questions" is the
          difference between reading on and filtering first.
        */}
        <p className="mt-1 text-sm text-muted-foreground">
          {counts.topics > 0 && <>{plural(counts.topics, "topic")} · </>}
          {plural(counts.sets, "practice set")} ·{" "}
          {plural(counts.questions, "question")}
        </p>
      </div>

      {showTopicMap && (
        <div>
          <h3 className="text-base font-semibold text-foreground">{SearchResultsCopy.byTopic}</h3>
          <ul className="mt-3 space-y-2">
            {topics.map((topic) => {
              const href = topicUrl(topic);
              const label = (
                <>
                  <span className="font-medium">
                    <Lang>{topic.name}</Lang>
                  </span>
                  <span className="text-sm text-muted-foreground">
                    {setsAndQuestions(topic.set_count, topic.q_count)}
                  </span>
                </>
              );
              return (
                <li key={topic.id}>
                  {href ? (
                    <Link
                      href={href}
                      className="flex min-h-11 flex-wrap items-center justify-between gap-2 rounded-xl border-2 border-border bg-card px-4 py-3 text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                    >
                      {label}
                      <ChevronRight
                        className="h-4 w-4 shrink-0 text-muted-foreground"
                        aria-hidden="true"
                      />
                    </Link>
                  ) : (
                    <div className="flex flex-wrap items-center justify-between gap-2 rounded-xl border-2 border-border bg-card px-4 py-3">
                      {label}
                    </div>
                  )}
                </li>
              );
            })}
          </ul>
        </div>
      )}

      {/*
        Matching questions come before the sets on a narrow query. Someone
        searching "नेपालका झरना" is looking for the waterfalls, not for a
        catalogue — so the thing they asked for leads, and what we have to offer
        follows it. Broad queries keep the topic map on top instead, because
        there the learner is navigating rather than looking something up.
      */}
      {showQuestions && (
        <div>
          <h3 className="text-base font-semibold text-foreground">
            {SearchResultsCopy.questions}{" "}
            <span className="font-normal text-muted-foreground">
              ({counts.questions})
            </span>
          </h3>
          <ul className="mt-3 space-y-2">
            {questions.map((question, index) => (
              <li key={question.id}>
                {/*
                  The first answer is open on arrival — that is the one the
                  learner came for, and making them expand it is a keystroke
                  charged for nothing. The rest stay collapsed so the page does
                  not become a wall of text to scroll or listen through.
                */}
                <SearchQuestionCard question={question} defaultOpen={index === 0} />
              </li>
            ))}
          </ul>
        </div>
      )}

      {sets.length > 0 && (
        <div>
          <h3 className="text-base font-semibold text-foreground">
            {SearchResultsCopy.practiceSets}{" "}
            <span className="font-normal text-muted-foreground">
              ({counts.sets})
            </span>
          </h3>
          <ul className="mt-3 space-y-2">
            {sets.map((set) => (
              <li key={set.id}>
                <SetRow set={set} />
              </li>
            ))}
          </ul>
        </div>
      )}

      {/*
        Matches the learner cannot open yet. Named and counted so the course can
        sell itself; not one question of it is shown. Every course is becoming
        paid with access by enrolment, so this is the only place locked content
        appears at all.
      */}
      {results.locked_courses.length > 0 && (
        <div>
          <h3 className="text-base font-semibold text-foreground">
            {SearchResultsCopy.otherCoursesNe}
          </h3>
          <ul className="mt-3 space-y-2">
            {results.locked_courses.map((course) => {
              const label = (
                <>
                  <span className="flex items-center gap-2 font-medium text-foreground">
                    <Lock className="h-4 w-4 shrink-0" aria-hidden="true" />
                    <Lang>{course.module_name}</Lang>
                  </span>
                  <span className="text-sm text-muted-foreground">
                    <Lang>{`${course.question_count} ${AskChatCopy.questionsSuffixNe}`}</Lang>
                  </span>
                </>
              );
              const shell =
                "flex min-h-11 flex-wrap items-center justify-between gap-3 rounded-xl border-2 border-border bg-card px-4 py-3";
              return (
                <li key={course.module_slug ?? course.module_name}>
                  {course.module_slug ? (
                    <Link
                      href={`/courses/${course.module_slug}`}
                      className={`${shell} transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring`}
                    >
                      {label}
                    </Link>
                  ) : (
                    <div className={shell}>{label}</div>
                  )}
                </li>
              );
            })}
          </ul>
        </div>
      )}

      {breadth === "broad" && counts.questions > 0 && (
        <p className="text-sm text-muted-foreground">
          {plural(counts.questions, "matching question")}{" "}
          {counts.questions === 1 ? "sits" : "sit"} inside these sets. Open a set
          to practise them.
        </p>
      )}

      {/*
        "Nothing matches" must not be said when matches exist behind a paywall —
        that would be untrue, and would waste the sale. The locked-course block
        above already tells them where the material is.
      */}
      {counts.sets === 0 &&
        counts.questions === 0 &&
        counts.topics === 0 &&
        results.locked_courses.length === 0 && (
          <p className="rounded-xl border-2 border-border bg-card px-4 py-6 text-center text-muted-foreground">
            {SearchResultsCopy.noMatchPrefix}{" "}
            <span className="font-medium text-foreground">
              <Lang>{query}</Lang>
            </span>{" "}
            {SearchResultsCopy.noMatchSuffix}
          </p>
        )}
    </section>
  );
}

function SetRow({ set }: { set: SearchSet }) {
  const href = set.locked ? null : practiceUrl(set);
  const subtopic = set.subtopic_name_np || set.subtopic_name;

  const body = (
    <>
      <div className="min-w-0">
        <Lang as="p" className="font-medium text-foreground">
          {set.title}
        </Lang>
        <p className="mt-0.5 text-xs text-muted-foreground">
          <Lang>{set.topic_name}</Lang>
          {subtopic && (
            <>
              {" › "}
              <Lang>{subtopic}</Lang>
            </>
          )}
        </p>
      </div>
      <div className="flex shrink-0 items-center gap-3">
        <span className="text-sm text-muted-foreground">
          {plural(set.q_count, "question")}
        </span>
        {set.locked && (
          <span className="inline-flex items-center gap-1 rounded-md border-2 border-border bg-muted px-2 py-1 text-xs font-medium text-foreground">
            <Lock className="h-3 w-3" aria-hidden="true" />
            {set.module_name}
          </span>
        )}
      </div>
    </>
  );

  const shell =
    "flex min-h-11 flex-wrap items-center justify-between gap-3 rounded-xl border-2 border-border bg-card px-4 py-3";

  // A locked set is still shown by name and count — the learner sees exactly
  // what the course holds — but it never links into content they cannot open.
  return href ? (
    <Link
      href={href}
      className={`${shell} transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring`}
    >
      {body}
    </Link>
  ) : (
    <div className={shell}>{body}</div>
  );
}

/** Prev/next paging over the set list. Never infinite scroll. */
export function SearchPagination({
  payload,
  page,
  subjectId,
  topicId,
  perPage,
}: {
  payload: SearchPayload;
  page: number;
  subjectId: string | null;
  topicId: string | null;
  perPage: number;
}) {
  const totalPages = Math.max(1, Math.ceil(payload.results.counts.sets / perPage));
  if (totalPages <= 1) return null;

  const linkClass =
    "inline-flex min-h-11 items-center rounded-lg border-2 border-border bg-card px-4 py-2 text-sm font-semibold text-foreground transition hover:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring";
  const disabledClass = "pointer-events-none opacity-40";

  return (
    <nav aria-label={SearchPaginationCopy.label} className="flex items-center justify-center gap-4">
      <Link
        href={searchUrl({ q: payload.query, subjectId, topicId, page: page - 1 })}
        aria-disabled={page <= 1}
        tabIndex={page <= 1 ? -1 : undefined}
        className={`${linkClass} ${page <= 1 ? disabledClass : ""}`}
      >
        {SearchPaginationCopy.previous}
      </Link>
      <span className="text-sm text-muted-foreground">
        {SearchPaginationCopy.position(page, totalPages)}
      </span>
      <Link
        href={searchUrl({ q: payload.query, subjectId, topicId, page: page + 1 })}
        aria-disabled={page >= totalPages}
        tabIndex={page >= totalPages ? -1 : undefined}
        className={`${linkClass} ${page >= totalPages ? disabledClass : ""}`}
      >
        {SearchPaginationCopy.next}
      </Link>
    </nav>
  );
}
