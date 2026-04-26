import { NextResponse } from "next/server";
import { guestFeedbackRequestSchema } from "@repo/validation";
import { generateReviewFeedback } from "@/lib/gemini";
import { rateLimitByIp } from "@/lib/rate-limit";
import { safeParseCoachFeedback } from "@/config/prompts/index";

export async function POST(req: Request) {
  try {
    // Aggressive IP-based rate limit
    const limitResult = await rateLimitByIp(req, { windowMs: 60_000, max: 10 });
    if (!limitResult.ok) {
      return NextResponse.json({ error: "Rate limit exceeded" }, { status: 429 });
    }

    const body = await req.json();
    const parsedBody = guestFeedbackRequestSchema.safeParse(body);

    if (!parsedBody.success) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const { answers, scoreRaw, totalQuestions, scorePct } = parsedBody.data;

    // Strict size checks
    const answersSize = JSON.stringify(answers || "").length;
    if (answersSize > 4000) {
      return NextResponse.json({ error: "Payload too large" }, { status: 413 });
    }

    const questionsSummary = answers.map((a: any) => ({
      question_id: a.question_id,
      content: a.content,
      selected_option: a.selected_option,
      correct_option: a.correct_option,
      is_correct: a.is_correct,
    }));

    const result = await generateReviewFeedback(
      questionsSummary,
      scoreRaw,
      totalQuestions,
      scorePct
    );

    const parsed = result.data ? safeParseCoachFeedback(result.data) : null;
    
    // Provide a graceful fallback for guest mode instead of an error,
    // to ensure potential users always see something encouraging.
    const feedback = parsed || {
      strengths: "अभ्यास जारी राख्नुहोस्! तपाईंको प्रयास राम्रो छ।",
      weakZones: ["तपाईंले गलत गर्नुभएको वा छोड्नुभएको प्रश्नहरू फेरि एक पटक दोहोर्याउनुहोस्।"]
    };

    return NextResponse.json({
      strengths: feedback.strengths,
      weakZones: feedback.weakZones,
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
