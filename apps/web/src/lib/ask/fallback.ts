import "server-only";

import { generateAiContentJSON } from "@/lib/ai-service";
import { MAX_CLARIFY_OPTIONS, buildFallbackPrompt } from "@/config/prompts";

/**
 * What to do when DrishtiPrep's own content cannot answer the question.
 *
 * Two outcomes, chosen by one cheap call (prompt in config/prompts/ask.ts):
 *
 *   clarify — the question is too vague to answer well. Say what is unclear and
 *             offer specific questions, the way a teacher asks back instead of
 *             guessing. This is the "what I don't know" signal.
 *   outside — the question is clear, we simply do not cover it. Answer from
 *             general knowledge, LABELLED as outside DrishtiPrep content so a
 *             candidate never mistakes it for verified exam material.
 *
 * The labelling is the whole safety property. It is enforced by the caller
 * rendering `outside` differently, not by asking the model to be careful.
 */

export type FallbackResult =
  | { kind: "clarify"; message: string; options: string[] }
  | { kind: "outside"; answer: string }
  | { kind: "none" };

type ModelReply = {
  kind?: string;
  message?: string;
  options?: string[];
  answer?: string;
};

export async function resolveFallback(query: string): Promise<FallbackResult> {
  const prompt = buildFallbackPrompt(query);

  const result = await generateAiContentJSON(prompt, true, "flash");
  const reply = JSON.parse(result.data) as ModelReply;

  if (reply.kind === "clarify") {
    const options = (reply.options ?? [])
      .map((option) => option?.trim())
      .filter((option): option is string => Boolean(option))
      .slice(0, MAX_CLARIFY_OPTIONS);
    const message = reply.message?.trim();
    // A clarification with nothing to choose from is just another refusal.
    if (message && options.length > 0) return { kind: "clarify", message, options };
    return { kind: "none" };
  }

  if (reply.kind === "outside") {
    const answer = reply.answer?.trim();
    if (answer) return { kind: "outside", answer };
  }

  return { kind: "none" };
}
