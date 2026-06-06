// Per-question retention model for Manana / Memory Heat.
//
// Each (user, question) carries a stability S (days). Heat decays as
// H = exp(-(now - last_reviewed_at) / S), bounded [0, 1].
//
// Constants live here so they can be tuned without a migration. The DB
// CHECK clamps stability to [MIN_STABILITY, MAX_STABILITY] — keep these
// in sync with the user_memory_states constraint.

export const ALPHA = 2.0;          // stability multiplier on correct
export const BETA = 0.3;           // stability multiplier on wrong
export const WRONG_FLOOR = 0.5;    // never let a wrong drop S below this (days)
export const MIN_STABILITY = 0.1;  // matches DB CHECK
export const MAX_STABILITY = 365.0;// matches DB CHECK
export const INITIAL_STABILITY = 1.0;

const MS_PER_DAY = 86_400_000;

export type Outcome = "correct" | "wrong";

function clamp(v: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, v));
}

export function applyOutcome(prevStability: number, outcome: Outcome): number {
  const next = outcome === "correct"
    ? prevStability * ALPHA
    : Math.max(WRONG_FLOOR, prevStability * BETA);
  return clamp(next, MIN_STABILITY, MAX_STABILITY);
}

export function heat(
  stabilityDays: number,
  lastReviewedAt: Date | string,
  now: Date = new Date(),
): number {
  const last = typeof lastReviewedAt === "string" ? new Date(lastReviewedAt) : lastReviewedAt;
  const ageDays = Math.max(0, (now.getTime() - last.getTime()) / MS_PER_DAY);
  const s = clamp(stabilityDays, MIN_STABILITY, MAX_STABILITY);
  return Math.exp(-ageDays / s);
}
