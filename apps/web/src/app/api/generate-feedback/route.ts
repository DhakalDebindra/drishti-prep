import { NextResponse } from "next/server";
import { Prompts, safeParseGKExplanation, GKFacilitatorFewShot } from "@/config/prompts/index";
import { generateAiContentJSON } from "@/lib/ai-service";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit } from "@/lib/rate-limit";

export async function POST(req: Request) {
  try {
    const ip =
      req.headers.get("x-forwarded-for")?.split(",")[0].trim() ??
      req.headers.get("x-real-ip") ??
      "anonymous";

    const { success } = await aiRatelimit.limit(ip);

    if (!success) {
      return NextResponse.json(
        { error: "Too many requests. Please wait before trying again." },
        { 
          status: 429,
          headers: {
            "Retry-After": "60",
            "X-RateLimit-Remaining": "0",
          }
        }
      );
    }

    const { content, option_a, option_b, option_c, option_d, correct_option } = await req.json();

    // Require authentication
    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    // Basic payload size guard
    const totalLength = `${content || ""}${option_a || ""}${option_b || ""}${option_c || ""}${option_d || ""}`.length;
    if (totalLength > 2000) {
      return NextResponse.json({ error: "Request too large" }, { status: 413 });
    }

    if (!content || !option_a || !option_b || !option_c || !option_d || !correct_option) {
      return NextResponse.json(
        { error: "Missing required fields for generation" },
        { status: 400 }
      );
    }

    const payload = { content, option_a, option_b, option_c, option_d, correct_option };
    const prompt = Prompts["loksewa gk facilitator"](payload);

    const result = await generateAiContentJSON(prompt, true, "flash", GKFacilitatorFewShot);
    
    // Use the new validation layer
    const parsed = safeParseGKExplanation(result.data);
    let explanation = parsed?.general_explanation || "AI response format was invalid. Please try again.";

    return NextResponse.json(
      {
        general_explanation: explanation,
        provider: result.provider,
        model: result.model,
        latency_ms: result.latency_ms,
      },
      { status: 200 }
    );

    return NextResponse.json(
      {
        general_explanation: explanation,
        provider: result.provider,
        model: result.model,
        latency_ms: result.latency_ms,
      },
      { status: 200 }
    );
  } catch (error: any) {
    if (error instanceof Error && error.message === "TIMEOUT") {
      return NextResponse.json(
        { error: "Generation timed out after 25s" },
        { status: 504 }
      );
    }

    const message = error instanceof Error ? error.message : "Something went wrong";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
