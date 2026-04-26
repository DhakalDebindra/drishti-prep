import { z } from "zod";

export const loginSchema = z.object({
  email: z.string().trim().email("Please enter a valid email address."),
  password: z.string().min(1, "Password is required."),
});

export type LoginFormValues = z.infer<typeof loginSchema>;

export const signupSchema = z
  .object({
    fullName: z.string().trim().min(1, "Please enter your name."),
    email: z.string().trim().email("Please enter a valid email address."),
    password: z.string().min(6, "Password must be at least 6 characters."),
    confirmPassword: z
      .string()
      .min(6, "Confirm password must be at least 6 characters."),
  })
  .superRefine(({ password, confirmPassword }, ctx) => {
    if (password !== confirmPassword) {
      ctx.addIssue({
        code: "custom",
        message: "Passwords do not match.",
        path: ["confirmPassword"],
      });
    }
  });

export type SignupFormValues = z.infer<typeof signupSchema>;

export const questionSetQuestionSchema = z.object({
  id: z.string().optional(),
  order_number: z.coerce.number().min(1).max(30),
  content: z.string().min(1, "Question content is required"),
  option_a: z.string().min(1, "Option A is required"),
  option_b: z.string().min(1, "Option B is required"),
  option_c: z.string().min(1, "Option C is required"),
  option_d: z.string().min(1, "Option D is required"),
  correct_option: z.enum(["A", "B", "C", "D"]),
  general_explanation: z.string().optional(),
  exam_year: z.coerce.number().optional().nullable(),
  paper_ref: z.string().optional().nullable(),
  language: z
    .enum(["nepali", "english", "both"])
    .default("nepali")
    .optional(),
});

export type QuestionSetQuestionFormValues = z.infer<
  typeof questionSetQuestionSchema
>;

export const questionSetSchema = z.object({
  subject_id: z.string().min(1, "Subject is required"),
  topic_id: z.string().min(1, "Topic is required"),
  subtopic_id: z.string().optional().nullable(),
  title: z.string().min(1, "Title is required"),
  difficulty_level: z.coerce.number().min(1).max(3),
  set_type: z
    .enum(["learning", "mock_exam", "daily_practice", "revision", "custom"])
    .default("learning"),
  is_verified: z.boolean().default(false),
  questions: z
    .array(questionSetQuestionSchema)
    .min(1, "At least one question is required")
    .max(30, "Maximum of 30 questions allowed per set"),
});

export type QuestionSetFormValues = z.infer<typeof questionSetSchema>;

export const questionSetPayloadSchema = questionSetSchema.omit({
  subject_id: true,
});

export type QuestionSetPayload = z.infer<typeof questionSetPayloadSchema>;

export const questionSetEditSchema = z.object({
  subject_id: z.string().min(1, "Subject is required"),
  topic_id: z.string().min(1, "Topic is required"),
  subtopic_id: z.string().optional().nullable(),
  title: z.string().min(1, "Title is required"),
  difficulty_level: z.coerce.number().min(1).max(3),
  set_type: z
    .enum(["learning", "mock_exam", "daily_challenge", "revision"])
    .default("learning"),
  is_verified: z.boolean().default(false),
});

export type QuestionSetEditFormValues = z.infer<typeof questionSetEditSchema>;

export const guestFeedbackAnswerSchema = z.object({
  question_id: z.string().min(1, "Question ID is required"),
  content: z.string().min(1, "Question content is required"),
  option_a: z.string().min(1, "Option A is required"),
  option_b: z.string().min(1, "Option B is required"),
  option_c: z.string().min(1, "Option C is required"),
  option_d: z.string().min(1, "Option D is required"),
  selected_option: z.string().nullable(),
  correct_option: z.string().min(1, "Correct option is required"),
  is_correct: z.boolean(),
  explanation: z.string().nullable().optional(),
});

export const guestFeedbackRequestSchema = z.object({
  answers: z
    .array(guestFeedbackAnswerSchema)
    .min(1, "At least one answer is required"),
  scoreRaw: z.number().nonnegative(),
  totalQuestions: z.number().int().positive(),
  scorePct: z.number().min(0).max(100),
});

export type GuestFeedbackRequest = z.infer<typeof guestFeedbackRequestSchema>;
