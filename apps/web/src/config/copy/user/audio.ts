/**
 * Lesson playback controls.
 *
 * English on purpose — interface chrome, like the navigation — and short
 * English verbs read more clearly on a button than their Nepali equivalents.
 * The progress readout is Nepali because it sits inside Nepali content.
 */
export const AudioCopy = {
  listen: "Listen",
  pause: "Pause",
  resume: "Resume",
  stop: "Stop",
  loading: "Preparing…",
  retry: "Try again",

  /**
   * The accessible name carries the current rate, so a screen-reader user
   * knows what speed they are on without a separate readout to find.
   */
  speedLabel: (rate: number) => `Playback speed: ${rate}×. Press to change.`,

  /** e.g. "भाग २/४" while a multi-section lesson plays. */
  progress: (current: number, total: number) => `भाग ${current}/${total}`,
} as const;
