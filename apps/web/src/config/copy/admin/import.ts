/** Columns the import template defines. More than this means a row was split. */
export const MAX_IMPORT_COLUMNS = 10;

/** Mirrors the questions_paper_ref_length CHECK constraint. */
export const MAX_PAPER_REF_LENGTH = 120;

/**
 * Bulk CSV import diagnostics.
 *
 * Written for whoever maintains the content: precise, English, and naming the
 * likely cause. A batch import once split one explanation across
 * explanation / exam_year / paper_ref because the source file's delimiters were
 * unquoted, and 35 questions shipped with an explanation that stopped
 * mid-sentence. "Invalid row" would have sent an editor hunting.
 */
export const ImportCopy = {
  errors: {
    missingColumns: "Missing required columns",
    emptyRequiredFields: "Required fields are empty",
    invalidCorrectOption: (value: string) => `Invalid correct option "${value}"`,
    parseFailure: (message: string) => `CSV Parsing Error: ${message}`,

    tooManyColumns: (count: number, max: number) =>
      `Row has ${count} columns, expected at most ${max}. ` +
      `A delimiter inside an unquoted field has split this row.`,

    examYearNotNumeric: (value: string) =>
      `exam_year must be a 4-digit year, got "${value}". ` +
      `Text here usually means an earlier column overflowed.`,

    paperRefWithoutYear: (ref: string) =>
      `paper_ref "${ref}" has no exam_year. An exam reference needs a year; ` +
      `prose here means a spilled explanation.`,

    paperRefTooLong: (length: number, max: number) =>
      `paper_ref is ${length} characters, over the ${max} limit for an exam ` +
      `reference. This looks like explanation text.`,
  },
} as const;
