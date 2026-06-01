import { NextResponse } from "next/server";
import { generateExplanation } from "@/lib/gemini";
import { createClient } from "@/lib/supabase/server";
import { aiRatelimit } from "@/lib/rate-limit";

export async function POST(req: Request) {
  try {
    // Apply rate limit
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

    const supabase = await createClient();
    
    // Check if user is admin
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) {
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    const body = await req.json();
    const { content, option_a, option_b, option_c, option_d, correct_option } = body;

    if (!content || !correct_option) {
      return NextResponse.json({ error: "Missing required fields" }, { status: 400 });
    }

    const result = await generateExplanation({
      content,
      option_a,
      option_b,
      option_c,
      option_d,
      correct_option
    } as any);

    if (result.error || !result.data) {
      console.error("[admin.generate-explanation] AI failed", {
        provider_error: result.error,
      });
      return NextResponse.json(
        { error: "Explanation generation temporarily unavailable." },
        { status: 503 },
      );
    }

    return NextResponse.json({ explanation: result.data });
  } catch (error: any) {
    console.error("[admin.generate-explanation] handler error", error);
    return NextResponse.json(
      { error: "Internal error generating explanation." },
      { status: 500 },
    );
  }
}
