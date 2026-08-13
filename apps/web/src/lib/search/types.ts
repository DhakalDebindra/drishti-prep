/** Shapes returned by the search_content() and search_subject_header() RPCs. */

export type SearchSubject = {
  id: string;
  name: string;
  name_np: string | null;
  slug: string | null;
  syllabus_ref: string | null;
};

export type SearchTopic = {
  id: string;
  name: string;
  topic_slug: string | null;
  display_order: number | null;
  subject_id: string;
  subject_name: string;
  subject_name_np: string | null;
  subject_slug: string | null;
  module_slug: string | null;
  set_count: number;
  q_count: number;
};

export type SearchSet = {
  id: string;
  title: string;
  subtopic_name: string | null;
  subtopic_name_np: string | null;
  subtopic_slug: string | null;
  topic_id: string;
  topic_name: string;
  topic_slug: string | null;
  subject_id: string;
  subject_name: string;
  subject_name_np: string | null;
  subject_slug: string | null;
  module_id: string;
  module_name: string;
  module_slug: string | null;
  q_count: number;
  /** How many of this set's questions matched the query. Drives the ranking. */
  match_count: number;
  locked: boolean;
};

export type SearchQuestion = {
  id: string;
  content: string;
  /**
   * The full answer, matching what the review page shows. A learner who
   * searches for a fact is looking for the fact — a list of question stems with
   * the answers withheld sends them away to find what they already asked for.
   */
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  explanation: string | null;
  set_id: string;
  set_title: string;
  topic_name: string;
  subject_name_np: string | null;
  locked: boolean;
};

export type SearchCounts = {
  subjects: number;
  topics: number;
  sets: number;
  /** Questions the learner can actually read. Never counts locked material. */
  questions: number;
  /** Matches inside courses they have not enrolled in. Counted, never shown. */
  locked_questions: number;
};

/**
 * Courses holding matches the learner cannot open yet.
 *
 * All courses are free today, but they are all becoming paid with access by
 * enrolment — so this is the sales surface: it names the course and how much of
 * it answers this query, without giving away a single question.
 */
export type LockedCourse = {
  module_name: string;
  module_slug: string | null;
  question_count: number;
};

export type SearchResults = {
  counts: SearchCounts;
  locked_courses: LockedCourse[];
  subjects: SearchSubject[];
  topics: SearchTopic[];
  sets: SearchSet[];
  questions: SearchQuestion[];
};

export type SubjectHeader = {
  subject: SearchSubject | null;
  totals: { sets: number; questions: number; topics: number };
  progress: { completed_sets: number; started_sets: number };
  resume: {
    id: string;
    title: string;
    q_count: number;
    module_slug: string | null;
    subject_slug: string | null;
    topic_slug: string | null;
    subtopic_slug: string | null;
    reason: "in_progress" | "next";
  } | null;
  /** Official exam weighting. Null whenever the syllabus does not state one. */
  exam: { exam: string; question_count: number; source_note: string } | null;
};

/**
 * A query is "broad" when the learner named a whole area of the syllabus rather
 * than asked about one thing. Broad results lead with the topic map and hide the
 * question list, because 27 sets and 503 questions is a syllabus, not a result
 * list — and reading it aloud in full is punishing.
 */
export type SearchBreadth = "narrow" | "broad" | "empty";

export type SearchPayload = {
  /** The query as typed, for display and for the <h1>. */
  query: string;
  /** True when the query had no searchable content (blank or all stopwords). */
  blank: boolean;
  breadth: SearchBreadth;
  results: SearchResults;
  /** Present only when exactly one subject matched — powers the header. */
  header: SubjectHeader | null;
};
