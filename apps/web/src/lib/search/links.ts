/**
 * URL builders for search results.
 *
 * The course tree serves practice from two shapes — sets that hang off a
 * subtopic and sets that hang directly off a topic — so a set's practice URL
 * depends on whether it has a subtopic. Getting this wrong sends the learner to
 * a 404 from what looked like a working result, so it lives in one place.
 */

type SetLinkParts = {
  id: string;
  module_slug: string | null;
  subject_slug: string | null;
  topic_slug: string | null;
  subtopic_slug: string | null;
};

type TopicLinkParts = {
  module_slug: string | null;
  subject_slug: string | null;
  topic_slug: string | null;
};

/** True when every slug needed to build a course-tree URL is present. */
function hasTopicPath(parts: TopicLinkParts): boolean {
  return Boolean(parts.module_slug && parts.subject_slug && parts.topic_slug);
}

/**
 * Practice URL for a set, or null when the taxonomy is missing a slug.
 * Callers must render a non-link fallback for null rather than a dead anchor.
 */
export function practiceUrl(parts: SetLinkParts): string | null {
  if (!hasTopicPath(parts)) return null;
  const base = `/courses/${parts.module_slug}/${parts.subject_slug}/${parts.topic_slug}`;
  return parts.subtopic_slug
    ? `${base}/${parts.subtopic_slug}/practice/${parts.id}`
    : `${base}/practice/${parts.id}`;
}

/** Course-tree URL for a topic, or null when a slug is missing. */
export function topicUrl(parts: TopicLinkParts): string | null {
  if (!hasTopicPath(parts)) return null;
  return `/courses/${parts.module_slug}/${parts.subject_slug}/${parts.topic_slug}`;
}

/** The search page itself, with the query and any active filters preserved. */
export function searchUrl(params: {
  q: string;
  subjectId?: string | null;
  topicId?: string | null;
  page?: number;
}): string {
  const search = new URLSearchParams({ q: params.q });
  if (params.subjectId) search.set("subjectId", params.subjectId);
  if (params.topicId) search.set("topicId", params.topicId);
  if (params.page && params.page > 1) search.set("page", String(params.page));
  return `/search?${search.toString()}`;
}
