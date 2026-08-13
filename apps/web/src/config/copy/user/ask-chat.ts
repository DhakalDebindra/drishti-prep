/** The conversation surface: labels, input, announcements, reply furniture. */
export const AskChatCopy = {
  assistantName: "DrishtiPrep AI",
  openingHeadingNe: "के सोध्नुहुन्छ?",
  inputLabelNe: "DrishtiPrep AI सँग सोध्नुहोस्",
  inputPlaceholderNe: "सोध्नुहोस्…",
  sendNe: "सोध्नुहोस्",
  /** Read by screen readers while the reply is being written. */
  pendingSrNe: "उत्तर तयार हुँदैछ",
  /** Announced once, on completion. Never while streaming. */
  readyAnnouncementNe: "DrishtiPrep AI को उत्तर तयार भयो",
  failedAnnouncementNe: "उत्तर तयार गर्न सकिएन",
  yourQuestionSrNe: "तपाईंको प्रश्न: ",
  sourcesNe: "स्रोत",
  practiceSetsNe: "अभ्यास सेटहरू",
  questionsSuffixNe: "प्रश्न",
  /** Marks a reply built from general knowledge, not DrishtiPrep content. */
  outsideBadgeNe: "सामान्य जानकारी",
  lockedNoteNe: (count: number, course: string) =>
    `यससँग सम्बन्धित ${count} प्रश्न ${course} पाठ्यक्रममा छन्।`,
  /** Openers on an empty chat — concrete subjects, not instructions. */
  openingSuggestionsNe: [
    "नेपालको भूगोल बुझाउनुहोस्",
    "संविधानका मौलिक हक बुझाउनुहोस्",
    "रामसार क्षेत्र भनेको के हो?",
  ],
} as const;
