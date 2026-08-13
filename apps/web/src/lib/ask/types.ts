/** Keys of every section a lesson may contain. Order here is render order. */
import { AskSectionCopy } from "@/config/copy";

export const SECTION_KEYS = ["intro", "facts", "exam", "related"] as const;

export type SectionKey = (typeof SECTION_KEYS)[number];

/**
 * Nepali headings, re-exported from the copy file so there is exactly one
 * place to edit them and no chance of the prompt and the interface drifting
 * apart. See config/copy/user/ask-lesson.ts.
 */
export const SECTION_TITLES: Record<SectionKey, string> = AskSectionCopy;

/** Sections the model writes. The rest are assembled from the database. */
export const MODEL_WRITTEN: SectionKey[] = ["intro", "facts", "exam"];

export type LessonSection = {
  key: SectionKey;
  title: string;
  /** Prose sections carry body; list sections carry bullets. */
  body?: string;
  bullets?: string[];
};

export type LessonSource = {
  set_id: string;
  set_title: string;
  question_count: number;
};

export type LessonRecommendation = {
  set_id: string;
  title: string;
  topic_name: string;
  subtopic_name: string | null;
  q_count: number;
  locked: boolean;
  module_name: string;
  href: string | null;
};

/**
 * "rate_limited" is deliberately separate from "error", and both are separate
 * from "insufficient". A learner told "we could not build a lesson" when the
 * real cause is an exhausted API quota will conclude DrishtiPrep has no content
 * on the topic — the opposite of the truth, and the one wrong impression this
 * feature must never give.
 */
export type AskRoute =
  | "lesson"
  | "greeting"
  /** Question was vague; we asked back instead of guessing or refusing. */
  | "clarify"
  /** Answered from general knowledge, outside DrishtiPrep content. Labelled. */
  | "outside"
  | "insufficient"
  | "rate_limited"
  | "error";

export type Lesson = {
  route: AskRoute;
  /** Prose for the non-lesson routes: greeting, clarify, outside. */
  message: string;
  /** Concrete questions offered when the query was too vague to answer. */
  clarifications: string[];
  sections: LessonSection[];
  sources: LessonSource[];
  recommendations: LessonRecommendation[];
  /** Locked material we can name but not teach from. */
  lockedNote: { count: number; sets: { title: string; module_name: string }[] } | null;
  /** Flat text of the whole lesson, for the Listen button and for storage. */
  plainText: string;
};

/** One question as handed to the model, with its 1-based prompt index. */
export type MaterialQuestion = {
  id: string;
  content: string;
  explanation: string | null;
  /**
   * True only when this question really came from a named past paper.
   *
   * Do not infer this from paper_ref alone: 1,537 questions carry an
   * empty-string paper_ref and 35 more have explanation prose written into the
   * column by a bad import. A source — a model set, a compilation like Aasman
   * Sangraha — is not an exam, and telling a candidate otherwise is a false
   * claim about what has been asked.
   */
  is_past_paper: boolean;
  exam_year: number | null;
  paper_ref: string | null;
  set_id: string;
  set_title: string;
  topic_id: string;
  topic_name: string;
  subtopic_name: string | null;
  subject_name_np: string | null;
  module_name: string;
};

export type AskMaterial = {
  total_matched: number;
  locked_count: number;
  questions: MaterialQuestion[];
  locked_sets: { id: string; title: string; module_name: string; match_count: number }[];
  topics: { id: string; name: string }[];
  has_paper_ref: boolean;
};
