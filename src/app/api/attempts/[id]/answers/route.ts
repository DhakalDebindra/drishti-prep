import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type RouteParams = { params: { id: string } };

type QuestionRow = {
  id: string;
  correct_option: string;
  set_id: string;
};

export async function POST(req: Request, { params }: RouteParams) {
  const supabase = await createClient();
  const attemptId = params.id;

  const payload = await req.json().catch(() => ({}));
  const questionId = payload?.question_id as string | undefined;
  const selected = payload?.selected_option as string | undefined;

  if (!questionId || !selected) {
    return NextResponse.json({ error: "question_id and selected_option are required" }, { status: 400 });
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  const { data: attempt, error: attemptError } = await supabase
    .from("attempts")
    .select("id, user_id, set_id, status")
    .eq("id", attemptId)
    .maybeSingle();

  if (attemptError || !attempt) {
    return NextResponse.json({ error: "Attempt not found" }, { status: 404 });
  }

  if (attempt.user_id !== user.id) {
    return NextResponse.json({ error: "Not allowed" }, { status: 403 });
  }

  if (attempt.status !== "in_progress") {
    return NextResponse.json({ error: "Attempt is not in progress" }, { status: 400 });
  }

  const { data: question, error: questionError } = await supabase
    .from("questions")
    .select("id, correct_option, set_id")
    .eq("id", questionId)
    .maybeSingle();

  if (questionError || !question) {
    return NextResponse.json({ error: "Question not found" }, { status: 404 });
  }

  if (question.set_id !== attempt.set_id) {
    return NextResponse.json({ error: "Question does not belong to this set" }, { status: 400 });
  }

  const isCorrect = question.correct_option === selected;

  const { error: upsertError } = await supabase
    .from("attempt_answers")
    .upsert({
      attempt_id: attemptId,
      question_id: questionId,
      selected_option: selected,
      is_correct: isCorrect,
    }, { onConflict: "attempt_id,question_id" });

  if (upsertError) {
    return NextResponse.json({ error: upsertError.message }, { status: 500 });
  }

  return NextResponse.json({ attempt_id: attemptId, question_id: questionId, selected_option: selected, is_correct: isCorrect });
}
