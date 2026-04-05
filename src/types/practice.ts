export type DecoratedAnswer = {
  question_id: string;
  content?: string;
  option_a?: string;
  option_b?: string;
  option_c?: string;
  option_d?: string;
  selected_option: string | null;
  is_correct: boolean;
  correct_option: string;
  explanation: string | null;
};

export type PracticeReview = {
  attempt: {
    id: string;
    question_count: number;
    score_raw: number;
    score_pct: number;
    submitted_at?: string;
  };
  answers: DecoratedAnswer[];
  feedback: {
    strengths: string | null;
    weak_zones: Record<string, unknown> | null;
    explanations: Record<string, string> | null;
    model?: string | null;
    latency_ms?: number | null;
    cost_cents?: number | null;
  } | null;
};

export type Question = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  order_number: number;
  explanation: string | null;
};

export type AttemptSummary = {
  id: string;
  status: string;
  question_count: number | null;
  score_raw: number | null;
  score_pct: number | null;
  set_version: number | null;
};
