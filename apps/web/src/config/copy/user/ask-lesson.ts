/**
 * Lesson structure and the wording for replies that carry no lesson.
 *
 * SINGLE SOURCE OF TRUTH for section headings — lib/ask/types.ts and the prompt
 * builder both read them from here, so a heading cannot drift between what the
 * model is asked to write and what the interface renders.
 */

/**
 * A fixed vocabulary; the model never invents a heading. The exam heading names
 * the paper explicitly, because material cannot support "this was asked in the
 * exam" unless it says which exam.
 */
export const AskSectionCopy = {
  intro: "परिचय",
  facts: "मुख्य तथ्यहरू",
  exam: "विगतका परीक्षामा सोधिएका प्रश्न",
  related: "सम्बन्धित विषयहरू",
} as const;

/**
 * One short line each: these are chat messages, not notices, and a screen
 * reader reads every word. greeting / clarify / outside supply their own text.
 */
export const AskRouteCopy = {
  lesson: "",
  greeting: "",
  clarify: "",
  outside: "",
  insufficient: "यो विषयमा अहिले सामग्री भेटिएन।",
  rate_limited: "अहिले व्यस्त छ। केही बेरपछि फेरि सोध्नुहोस्।",
  error: "उत्तर तयार गर्न सकिएन। फेरि प्रयास गर्नुहोस्।",
} as const;
