import {
  MODEL_WRITTEN,
  SECTION_TITLES,
  type AskMaterial,
  type LessonSection,
  type SectionKey,
} from "@/lib/ask/types";

/**
 * Which sections this lesson is allowed to have.
 *
 * This is the whole defence against invented exam facts. A fixed template with
 * mandatory headings is a hallucination pump: told to always write
 * "परीक्षामा सोधिएका प्रश्नहरू", a model will write one whether or not the
 * material exists. And it usually does not — of 13,415 questions only 207 carry
 * exam_year and 1,772 carry paper_ref, so that heading is unsupported for the
 * large majority of queries.
 *
 * So the gates are evaluated here, against retrieved data, and the prompt is
 * given ONLY the headings that survive. The model is never handed a heading it
 * has no sources for, so there is no empty section for it to fill.
 */

/**
 * Minimum questions before a bulleted facts section is worth having.
 *
 * Two, not three. The facts list is where the concrete dates and figures land,
 * and withholding it left short answers reading as a bland paragraph — the
 * exact complaint that prompted this threshold to drop.
 */
const MIN_FACTS_QUESTIONS = 2;

/** Minimum distinct topics before "related topics" says anything useful. */
const MIN_RELATED_TOPICS = 2;

export function permittedSections(material: AskMaterial): SectionKey[] {
  const permitted: SectionKey[] = [];

  // Any readable material at all justifies an introduction.
  if (material.questions.length > 0) permitted.push("intro");

  if (material.questions.length >= MIN_FACTS_QUESTIONS) permitted.push("facts");

  // Only when a retrieved question actually carries a paper reference.
  if (material.has_paper_ref && material.questions.some(hasPaperReference)) {
    permitted.push("exam");
  }

  if (material.topics.length >= MIN_RELATED_TOPICS) permitted.push("related");

  return permitted;
}

/**
 * Trust only the flag the database computed, which requires a year AND a
 * non-blank reference. The old test (`exam_year !== null || paper_ref !== null`)
 * was true for 1,537 questions whose paper_ref is an empty string, so the exam
 * section fired constantly and claimed model-set questions had been asked in
 * the exam.
 */
export function hasPaperReference(question: { is_past_paper?: boolean }): boolean {
  return question.is_past_paper === true;
}

/** The subset of permitted sections the model is asked to write. */
export function modelSections(permitted: SectionKey[]): SectionKey[] {
  return permitted.filter((key) => MODEL_WRITTEN.includes(key));
}

/**
 * "सम्बन्धित विषयहरू" is built from the taxonomy, not written by the model.
 * Topic names are facts about the catalogue; there is nothing for a language
 * model to add and plenty for it to get wrong.
 */
export function buildRelatedSection(material: AskMaterial): LessonSection | null {
  if (material.topics.length < MIN_RELATED_TOPICS) return null;
  return {
    key: "related",
    title: SECTION_TITLES.related,
    bullets: material.topics.slice(0, 5).map((topic) => topic.name),
  };
}

/**
 * Discard anything the model returned that it was not permitted to write.
 *
 * Belt and braces: the prompt already withholds unpermitted headings, but a
 * model that invents one anyway must not reach a learner preparing for an exam.
 */
export function filterToPermitted(
  sections: LessonSection[],
  permitted: SectionKey[]
): LessonSection[] {
  const allowed = new Set(modelSections(permitted));
  return sections.filter((section) => allowed.has(section.key));
}

/** One section rendered as speech: its heading, then its content. */
function sectionToSpeech(section: LessonSection): string {
  const body = section.body?.trim();
  const bullets = section.bullets?.filter(Boolean) ?? [];
  const inner = body || bullets.join("। ");
  return `${section.title}। ${inner}`;
}

/**
 * A lesson split for playback, one entry per section.
 *
 * Playback is per section rather than whole-lesson because synthesising the
 * entire reply first meant roughly 15 seconds of silence before a word was
 * heard. For a learner who listens rather than reads, that dead air is the
 * difference between using the feature and abandoning it — the first section
 * can start in about three seconds while the rest is fetched behind it.
 */
export function sectionsToSpeechParts(sections: LessonSection[]): string[] {
  return sections.map(sectionToSpeech).filter((part) => part.trim().length > 0);
}

/** Render a lesson to flat text, for display and for the whole-reply fallback. */
export function sectionsToPlainText(sections: LessonSection[]): string {
  return sectionsToSpeechParts(sections).join("\n\n");
}
