/**
 * Input: Item in the practice summary sent to the coach
 */
export type QuestionSummaryItem = {
  question_id: string;
  content: string;
  selected_option: string | "skipped";
  correct_option: string;
  is_correct: boolean;
};

/**
 * Input: GK Question data for the facilitator
 */
export type GKQuestion = {
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
};

/**
 * Output: Structured feedback for the learner
 */
export type CoachFeedback = {
  strengths: string;
  weakZones: string[];
};

/**
 * Output: Master explanation for a GK question
 */
export type GKExplanation = {
  general_explanation: string;
};

/**
 * A single few-shot example pair passed to the model as a user/model turn.
 */
export type FewShotExample = {
  user: string;
  model: string;
};
