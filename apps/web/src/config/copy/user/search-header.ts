/** The orientation block above results: counts, progress, resume, exam weight. */
export const SearchHeaderCopy = {
  completed: (done: number, total: number) =>
    `You have completed ${done} of ${total} sets here.`,
  resume: "Continue",
  start: "Start",
  nextUp: "Next up:",
  /**
   * Official figure only. The syllabus publishes counts per unit, never per
   * topic, so nothing of this kind is ever shown on a topic row.
   */
  examWeight: (ref: string, count: number) =>
    `Lok Sewa syllabus ${ref} · about ${count} questions from this subject`,
  examSource: (note: string) => ` (source: ${note})`,
} as const;
