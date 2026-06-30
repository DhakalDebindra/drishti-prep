import { NextResponse } from "next/server";
import { LoksewaGKFacilitatorGrounded } from "@/config/prompts/index";
import { generateGroundedProse } from "@/lib/ai-service";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit, extractClientIp } from "@/lib/rate-limit";

export async function POST(req: Request) {
  try {
    const { success } = await aiRatelimit.limit(extractClientIp(req));

    if (!success) {
      return NextResponse.json(
        { error: "Too many requests. Please wait before trying again." },
        {
          status: 429,
          headers: {
            "Retry-After": "60",
            "X-RateLimit-Remaining": "0",
          },
        },
      );
    }

    const { content, option_a, option_b, option_c, option_d, correct_option } = await req.json();

    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    const totalLength = `${content || ""}${option_a || ""}${option_b || ""}${option_c || ""}${option_d || ""}`.length;
    if (totalLength > 2000) {
      return NextResponse.json({ error: "Request too large" }, { status: 413 });
    }

    if (!content || !option_a || !option_b || !option_c || !option_d || !correct_option) {
      return NextResponse.json(
        { error: "Missing required fields for generation" },
        { status: 400 },
      );
    }

    const result = await generateGroundedProse({
      systemInstruction: LoksewaGKFacilitatorGrounded.system,
      userMessage: LoksewaGKFacilitatorGrounded.buildUser({
        content,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_option,
      }),
    });

    return NextResponse.json(
      {
        general_explanation: result.text.trim(),
        provider: "google",
        model: result.model,
        latency_ms: result.latencyMs,
        grounding_sources: result.groundingChunks
          .map((c) => c.web?.uri)
          .filter((u): u is string => Boolean(u)),
      },
      { status: 200 },
    );
  } catch (error: unknown) {
    if (error instanceof Error && error.message === "TIMEOUT") {
      return NextResponse.json(
        { error: "Generation timed out after 90s" },
        { status: 504 },
      );
    }

    const message = error instanceof Error ? error.message : "Something went wrong";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
