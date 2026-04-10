import { NextResponse } from "next/server";
import { Prompts } from "@/config/prompts";
import { normalizeJson } from "@/utils/normalizeJson";
import { generateAiContentJSON } from "@/lib/ai-service";
import { createClient } from "@/lib/supabase/server";

const REQUEST_TIMEOUT_MS = 25_000;

const withTimeout = <T>(promise: Promise<T>, ms: number) => {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("TIMEOUT")), ms);
    promise
      .then((res) => {
        clearTimeout(timer);
        resolve(res);
      })
      .catch((err) => {
        clearTimeout(timer);
        reject(err);
      });
  });
};



export async function POST(req: Request) {
  try {
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

    const prompt = Prompts["loksewa gk facilitator"](
      content,
      option_a,
      option_b,
      option_c,
      option_d,
      correct_option
    );

    const result = await generateAiContentJSON(prompt, true);
    const cleaned = normalizeJson(result.data);

    let explanation = "";
    try {
      const parsed = JSON.parse(cleaned);
      explanation = (parsed.general_explanation || parsed.explanation || "").trim();
    } catch {
      explanation = cleaned.trim();
    }

    if (!explanation) {
      explanation = "AI response was empty.";
    }

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
