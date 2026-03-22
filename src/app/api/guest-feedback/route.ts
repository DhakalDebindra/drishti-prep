import { NextResponse } from "next/server";
import { generateReviewFeedback } from "@/lib/gemini";

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const { answers, scoreRaw, totalQuestions, scorePct } = body;

    if (!answers || !Array.isArray(answers)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const questionsSummary = answers.map((a: any) => ({
      question_id: a.question_id,
      selected: a.selected_option,
      correct: a.correct_option,
      is_correct: a.is_correct,
    }));

    const result = await generateReviewFeedback(
      questionsSummary,
      scoreRaw,
      totalQuestions,
      scorePct
    );

    if (!result.feedback) {
      return NextResponse.json(
        { error: result.error || "Failed to generate feedback" },
        { status: 504 }
      );
    }

    return NextResponse.json({
      strengths: result.feedback.strengths,
      weakZones: result.feedback.weakZones,
      explanations: result.feedback.explanations,
      model: result.model,
      latency_ms: result.latency_ms,
    });
  } catch (error: any) {
    console.error("Guest feedback error:", error);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
