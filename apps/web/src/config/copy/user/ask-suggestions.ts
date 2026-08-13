/**
 * Fallback chat openers, used only when the taxonomy matched but no question
 * text did — an English query against a Nepali-titled subject, say. Normally
 * the suggestions are real questions pulled from the bank instead.
 */
export const SuggestionCopy = {
  explain: (label: string) => `${label} बुझाउनुहोस्`,
  examAsks: (label: string) =>
    `${label} बारे परीक्षामा के सोधिन्छ?`,
  whereToStart: "कहाँबाट सुरु गरूँ?",
  related: (label: string) =>
    `${label} सँग मिल्दो अरू सामग्री देखाउनुहोस्`,
  examAsksGeneric: "यो विषयमा परीक्षामा के सोधिन्छ?",
} as const;
