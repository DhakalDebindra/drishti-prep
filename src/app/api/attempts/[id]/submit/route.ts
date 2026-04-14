import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type RouteParams = { params: Promise<{ id: string }> };

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

  if (attempt.status === "submitted") {
      return NextResponse.json({ success: true, attemptId });
  }

  // Fetch answers to calculate score
  const { data: answers } = await supabase
    .from("attempt_answers")
    .select("question_id, selected_option, is_correct")
    .eq("attempt_id", attemptId);

  // Fallback to fetching questions if attempt.question_count is missing
  let totalQuestions = attempt.question_count;
  if (!totalQuestions) {
    const { count } = await supabase
      .from("question_set_questions")
      .select("*", { count: "exact", head: true })
      .eq("question_set_id", attempt.set_id);
    totalQuestions = count || 0;
  }

  const scoreRaw = answers?.filter((a) => a.is_correct).length || 0;
  const scorePct = totalQuestions && totalQuestions > 0 ? (scoreRaw / totalQuestions) * 100 : 0;

  const { error: updateError } = await supabase
    .from("attempts")
    .update({
      status: "submitted",
      score_raw: scoreRaw,
      score_pct: scorePct,
      submitted_at: new Date().toISOString(),
    })
    .eq("id", attemptId);

  if (updateError) {
    return NextResponse.json({ error: updateError.message || "Failed to finalize attempt" }, { status: 500 });
  }

  // CLEANUP LOGIC: Maintain clean database
  // 1. Nuke stale in_progress attempts for this set
  await supabase
    .from("attempts")
    .delete()
    .eq("user_id", user.id)
    .eq("set_id", attempt.set_id)
    .eq("status", "in_progress")
    .neq("id", attemptId);

  // 2. Identify attempts older than the latest two (by started_at)
  const { data: submittedAttempts } = await supabase
    .from("attempts")
    .select("id")
    .eq("user_id", user.id)
    .eq("set_id", attempt.set_id)
    .eq("status", "submitted")
    .order("started_at", { ascending: false });

  if (submittedAttempts && submittedAttempts.length > 2) {
    const oldAttemptIds = submittedAttempts.slice(2).map(a => a.id);
    // 3. Delete the heavy payloads from relate tables (we keep the attempts row for scores)
    await Promise.all([
      supabase.from("attempt_answers").delete().in("attempt_id", oldAttemptIds),
      supabase.from("ai_feedback").delete().in("attempt_id", oldAttemptIds)
    ]);
  }

  return NextResponse.json({ success: true, attemptId });
}
