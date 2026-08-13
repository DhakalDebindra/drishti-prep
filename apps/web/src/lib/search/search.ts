import "server-only";

import { createClient } from "@/lib/supabase/server";
import { normaliseQuery } from "@/lib/search/normalize";
import type {
  SearchBreadth,
  SearchPayload,
  SearchResults,
  SubjectHeader,
} from "@/lib/search/types";

/** Sets shown per page. Matches the admin list's default. */
export const SETS_PER_PAGE = 10;

/** Questions listed on a narrow result page before "see all". */
const QUESTIONS_SHOWN = 10;

/**
 * Above either threshold the learner has named an area of the syllabus rather
 * than asked about one thing, and the page switches to the topic map.
 */
const BROAD_SET_COUNT = 8;
const BROAD_QUESTION_COUNT = 100;

const EMPTY_RESULTS: SearchResults = {
  counts: { subjects: 0, topics: 0, sets: 0, questions: 0, locked_questions: 0 },
  locked_courses: [],
  subjects: [],
  topics: [],
  sets: [],
  questions: [],
};

export type SearchOptions = {
  subjectId?: string | null;
  topicId?: string | null;
  page?: number;
};

function decideBreadth(results: SearchResults): SearchBreadth {
  const { sets, questions, topics } = results.counts;
  if (sets === 0 && questions === 0 && topics === 0) return "empty";
  if (topics > 0 && (sets > BROAD_SET_COUNT || questions > BROAD_QUESTION_COUNT)) {
    return "broad";
  }
  return "narrow";
}

/**
 * Run a learner search.
 *
 * Tokens are ANDed. OR over a query like "नेपालको भूगोल" drags in every row
 * containing नेपाल, which on this platform is most of them.
 *
 * There is deliberately no OR fallback when AND finds nothing. It was tried:
 * searching क्वान्टम भौतिकी — a subject DrishtiPrep genuinely does not cover —
 * fell back to OR and returned 47 sets about classroom management and physical
 * geography. For exam candidates a confident pile of irrelevant material is
 * worse than an honest "we don't have this yet", which at least sends them to
 * the nearest real content instead of wasting their study time.
 */
export async function searchContent(
  rawQuery: string,
  options: SearchOptions = {}
): Promise<SearchPayload> {
  const { raw, tokens } = normaliseQuery(rawQuery);

  if (tokens.length === 0) {
    return {
      query: raw,
      blank: true,
      breadth: "empty",
      results: EMPTY_RESULTS,
      header: null,
    };
  }

  const supabase = await createClient();
  const page = Math.max(1, options.page ?? 1);

  const args = {
    p_tokens: tokens,
    p_subject_id: options.subjectId ?? null,
    p_topic_id: options.topicId ?? null,
    p_set_limit: SETS_PER_PAGE,
    p_set_offset: (page - 1) * SETS_PER_PAGE,
    p_q_limit: QUESTIONS_SHOWN,
  };

  const { data, error } = await (supabase as any).rpc("search_content", {
    ...args,
    p_require_all: true,
  });

  if (error) {
    console.error("[search] search_content failed:", error.message);
  }

  const finalResults = (data as SearchResults) ?? EMPTY_RESULTS;

  return {
    query: raw,
    blank: false,
    breadth: decideBreadth(finalResults),
    results: finalResults,
    header: await loadHeader(supabase, finalResults, options.subjectId ?? null),
  };
}

/**
 * The header only makes sense when the results point at exactly one subject —
 * "how far have you come" is meaningless spread across five subjects. An
 * explicit subject filter always wins.
 */
async function loadHeader(
  supabase: Awaited<ReturnType<typeof createClient>>,
  results: SearchResults,
  filterSubjectId: string | null
): Promise<SubjectHeader | null> {
  const subjectId =
    filterSubjectId ??
    (results.subjects.length === 1 ? results.subjects[0].id : null);

  if (!subjectId) return null;

  const { data, error } = await (supabase as any).rpc("search_subject_header", {
    p_subject_id: subjectId,
  });

  if (error) {
    // A missing header costs the learner one helpful line; it must never cost
    // them the results, so this failure is swallowed rather than thrown.
    console.error("[search] search_subject_header failed:", error.message);
    return null;
  }

  return (data as SubjectHeader) ?? null;
}
