export { Prompts, SystemInstructions, GKFacilitatorFewShot, LoksewaGKFacilitatorGrounded } from "./templates";
export {
  buildLessonPrompt,
  buildFallbackPrompt,
  buildQueryRepairPrompt,
  DRISHTIPREP_PERSONA,
  LessonSectionBrief,
  MAX_CLARIFY_OPTIONS,
  MAX_EXPLANATION_CHARS,
  PROMPT_VARIANTS,
  DETAILED_VARIANT,
  TERSE_VARIANT,
  LABELLED_VARIANT,
} from "./ask";
export type { LessonQuestion, LessonSectionKey, PromptVariant } from "./ask";
export {
  parseCoachFeedback,
  safeParseCoachFeedback,
  parseGKExplanation,
  safeParseGKExplanation
} from "./validate";
export type {
  CoachFeedback,
  GKExplanation,
  QuestionSummaryItem,
  GKQuestion,
  FewShotExample
} from "./types";
