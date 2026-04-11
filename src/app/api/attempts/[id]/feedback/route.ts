import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { generateReviewFeedback } from "@/lib/gemini";
import { safeParseCoachFeedback } from "@/config/prompts/index";

type RouteParams = { params: Promise<{ id: string }> };

export async function GET(req: Request, { params }: RouteParams) {
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
    .select("id, user_id, set_id, question_count, score_raw, score_pct, status")
    .eq("id", attemptId)
    .maybeSingle();

  if (attemptError || !attempt) {
    return NextResponse.json({ error: "Attempt not found" }, { status: 404 });
  }

  if (attempt.user_id !== user.id) {
    return NextResponse.json({ error: "Not allowed" }, { status: 403 });
  }

  if (attempt.status !== "submitted") {
    return NextResponse.json({ error: "Attempt not yet submitted" }, { status: 400 });
  }

  // Check if we already have feedback
  const { data: existingFeedback } = await supabase
    .from("ai_feedback")
    .select("strengths, weak_zones, explanations, model, latency_ms, cost_cents")
    .eq("attempt_id", attemptId)
    .maybeSingle();

  if (existingFeedback) {
    return NextResponse.json(existingFeedback);
  }

  // Generate new feedback
  const { data: questions } = await supabase
    .from("questions")
    .select("id, content, option_a, option_b, option_c, option_d, correct_option, explanation")
    .eq("set_id", attempt.set_id);

  const { data: answers } = await supabase
    .from("attempt_answers")
    .select("question_id, selected_option, is_correct")
    .eq("attempt_id", attemptId);

  const decorated = (questions ?? []).map((q) => {
    const match = answers?.find((a) => a.question_id === q.id);
    return {
      question_id: q.id,
      content: q.content,
      selected_option: match?.selected_option ?? "skipped",
      is_correct: match?.is_correct ?? false,
      correct_option: q.correct_option,
      explanation: q.explanation ?? null,
    };
  });

  const totalQuestions = attempt.question_count || questions?.length || decorated.length || 0;
  const scoreRaw = attempt.score_raw ?? decorated.filter((a) => a.is_correct).length;
  const scorePct = attempt.score_pct ?? (totalQuestions > 0 ? (scoreRaw / totalQuestions) * 100 : 0);

  const questionsSummary = decorated.map((a) => ({
    question_id: a.question_id,
    content: a.content,
    selected_option: a.selected_option,
    correct_option: a.correct_option,
    is_correct: a.is_correct,
  }));

  const result = await generateReviewFeedback(questionsSummary, scoreRaw, totalQuestions, scorePct);
  const parsed = result.data ? safeParseCoachFeedback(result.data) : null;

  const explanationsFallback: Record<string, string> = {};
  decorated.forEach((a) => {
    if (a.explanation) explanationsFallback[a.question_id] = a.explanation;
  });

  const feedbackPayload = {
    strengths: parsed?.strengths || result.error || "AI feedback generation failed.",
    weak_zones: parsed?.weakZones || null,
    explanations: explanationsFallback,
    model: result.model || null,
    latency_ms: result.latency_ms || null,
    cost_cents: null,
  };

  // Save dynamically generated feedback
  await supabase
    .from("ai_feedback")
    .upsert({
      attempt_id: attemptId,
      ...feedbackPayload,
    }, { onConflict: "attempt_id" });

  return NextResponse.json(feedbackPayload);
}
