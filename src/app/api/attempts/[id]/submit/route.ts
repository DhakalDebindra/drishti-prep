import OpenAI, { OpenAIError } from "openai";
import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type RouteParams = { params: Promise<{ id: string }> };

type QuestionRow = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  explanation: string | null;
};

type DecoratedAnswer = {
  question_id: string;
  selected_option: string | null;
  is_correct: boolean;
  correct_option: string;
  explanation: string | null;
};

const getOpenAIClient = () => {
  const apiKey =
    process.env.OPENAI_API_KEY ??
    process.env.DRISTI_API_KEY ??
    process.env.DristiApiKey ??
    process.env.DristiprepOpenAIKey;
  if (!apiKey) return null;
  return new OpenAI({ apiKey });
};

export async function POST(req: Request, { params }: RouteParams) {
  const supabase = await createClient();
  const attemptId = (await params).id;
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  const { data: attempt, error: attemptError } = await supabase
    .from("attempts")
    .select("id, user_id, set_id, question_count, status")
    .eq("id", attemptId)
    .maybeSingle();

  if (attemptError || !attempt) {
    return NextResponse.json({ error: "Attempt not found" }, { status: 404 });
  }

  if (attempt.user_id !== user.id) {
    return NextResponse.json({ error: "Not allowed" }, { status: 403 });
  }

  // If already submitted, return existing feedback.
  const { data: existingFeedback } = attempt.status === "submitted"
    ? await supabase
        .from("ai_feedback")
        .select("attempt_id, strengths, weak_zones, explanations, model, latency_ms, cost_cents, created_at")
        .eq("attempt_id", attemptId)
        .maybeSingle()
    : { data: null } as { data: any };

  const { data: questions } = await supabase
    .from("questions")
    .select("id, content, option_a, option_b, option_c, option_d, correct_option, explanation")
    .eq("set_id", attempt.set_id);

  const { data: answers } = await supabase
    .from("attempt_answers")
    .select("question_id, selected_option, is_correct")
    .eq("attempt_id", attemptId);

  const decorated: DecoratedAnswer[] = (questions ?? []).map((q) => {
    const match = answers?.find((a) => a.question_id === q.id);
    return {
      question_id: q.id,
      selected_option: match?.selected_option ?? null,
      is_correct: match?.is_correct ?? false,
      correct_option: q.correct_option,
      explanation: q.explanation ?? null,
    };
  });

  const scoreRaw = decorated.filter((a) => a.is_correct).length;
  const totalQuestions = attempt.question_count || questions?.length || decorated.length || 0;
  const scorePct = totalQuestions > 0 ? (scoreRaw / totalQuestions) * 100 : 0;

  let updatedAttempt = attempt;

  if (attempt.status !== "submitted") {
    const { data: updated, error: updateError } = await supabase
      .from("attempts")
      .update({
        status: "submitted",
        score_raw: scoreRaw,
        score_pct: scorePct,
        submitted_at: new Date().toISOString(),
      })
      .eq("id", attemptId)
      .select("id, question_count, score_raw, score_pct, submitted_at")
      .single();

    if (updateError || !updated) {
      return NextResponse.json({ error: updateError?.message || "Failed to finalize attempt" }, { status: 500 });
    }
    updatedAttempt = { ...attempt, ...updated, status: "submitted" } as typeof attempt;
  }

  const aiClient = getOpenAIClient();

  const feedbackPayload = await buildFeedback({
    aiClient,
    attemptId,
    decorated,
    scoreRaw,
    scorePct,
    totalQuestions,
  });

  if (feedbackPayload) {
    await supabase
      .from("ai_feedback")
      .upsert({
        attempt_id: attemptId,
        strengths: feedbackPayload.strengths ?? null,
        weak_zones: feedbackPayload.weak_zones ?? null,
        explanations: feedbackPayload.explanations ?? null,
        model: feedbackPayload.model ?? null,
        latency_ms: feedbackPayload.latency_ms ?? null,
        cost_cents: feedbackPayload.cost_cents ?? null,
      }, { onConflict: "attempt_id" });
  }

  const responseBody = {
    attempt: {
      id: updatedAttempt.id,
      question_count: totalQuestions,
      score_raw: scoreRaw,
      score_pct: scorePct,
      submitted_at: (updatedAttempt as any).submitted_at ?? null,
    },
    answers: decorated,
    feedback: feedbackPayload ?? existingFeedback ?? null,
  };

  return NextResponse.json(responseBody);
}

type FeedbackInput = {
  aiClient: OpenAI | null;
  attemptId: string;
  decorated: DecoratedAnswer[];
  scoreRaw: number;
  scorePct: number;
  totalQuestions: number;
};

type FeedbackPayload = {
  strengths: string | null;
  weak_zones: Record<string, unknown> | null;
  explanations: Record<string, string> | null;
  model?: string | null;
  latency_ms?: number | null;
  cost_cents?: number | null;
};

async function buildFeedback({ aiClient, decorated, scoreRaw, scorePct, totalQuestions }: FeedbackInput): Promise<FeedbackPayload | null> {
  const explanationsFallback: Record<string, string> = {};
  decorated.forEach((a) => {
    if (a.explanation) explanationsFallback[a.question_id] = a.explanation;
  });

  if (!aiClient) {
    return {
      strengths: "AI key not configured; showing stored explanations only.",
      weak_zones: null,
      explanations: explanationsFallback,
    };
  }

  const missed = decorated.filter((a) => !a.is_correct);
  const prompt = `You are an encouraging exam coach. The learner just finished a multiple-choice set.
Score: ${scoreRaw}/${totalQuestions} (${scorePct.toFixed(1)}%).
Questions summary (JSON): ${JSON.stringify(
    decorated.map((a) => ({
      question_id: a.question_id,
      selected: a.selected_option,
      correct: a.correct_option,
      is_correct: a.is_correct,
    })),
  null,
  2)}

Return JSON with keys:
- strengths: 1-2 sentences celebrating what went well.
- weak_zones: array of 1-3 short pointers on what to review (cite question_id when relevant).
- explanations: object mapping question_id -> short plain-text explanation (2-3 sentences, screen-reader friendly).
`;

  const started = performance.now();
  try {
    const completion = await aiClient.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: "You are an accessible, supportive tutor for Nepali civil service prep." },
        { role: "user", content: prompt },
      ],
      temperature: 0.2,
    });
    const latency = Math.round(performance.now() - started);
    const text = completion.choices?.[0]?.message?.content?.trim() || "";
    let parsed: FeedbackPayload | null = null;
    try {
      parsed = JSON.parse(text);
    } catch {
      parsed = null;
    }
    return parsed
      ? { ...parsed, model: completion.model, latency_ms: latency }
      : {
          strengths: "AI response was not parseable; using stored explanations.",
          weak_zones: null,
          explanations: explanationsFallback,
          model: completion.model,
          latency_ms: latency,
        };
  } catch (error) {
    const message = error instanceof OpenAIError ? error.message : "AI generation failed";
    console.error("AI feedback error", message);
    return {
      strengths: message,
      weak_zones: null,
      explanations: explanationsFallback,
    };
  }
}
