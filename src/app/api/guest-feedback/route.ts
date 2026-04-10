import { NextResponse } from "next/server";
import { generateReviewFeedback } from "@/lib/gemini";
import { rateLimitByIp } from "@/lib/rate-limit";

export async function POST(req: Request) {
  try {
    // Aggressive IP-based rate limit
    const limitResult = await rateLimitByIp(req, { windowMs: 60_000, max: 10 });
    if (!limitResult.ok) {
      return NextResponse.json({ error: "Rate limit exceeded" }, { status: 429 });
    }

    const body = await req.json();
    const { answers, scoreRaw, totalQuestions, scorePct } = body;

    // Strict size checks
    const answersSize = JSON.stringify(answers || "").length;
    if (answersSize > 4000) {
      return NextResponse.json({ error: "Payload too large" }, { status: 413 });
    }

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
