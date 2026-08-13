/**
 * Count formatting for search and chat.
 *
 * The results page is made of counts, so "1 questions" shows up constantly once
 * a query is narrow enough. It reads as broken — and a screen reader says it
 * out loud, in full, on every result row.
 */
export function plural(
  count: number,
  singular: string,
  pluralForm = `${singular}s`
): string {
  return `${count} ${count === 1 ? singular : pluralForm}`;
}

/** "3 sets · 60 questions" — the count pair used on every result row. */
export function setsAndQuestions(sets: number, questions: number): string {
  return `${plural(sets, "set")} · ${plural(questions, "question")}`;
}
