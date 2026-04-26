import { NextResponse } from "next/server";
import { generateExplanation } from "@/lib/gemini";
import { createClient } from "@/lib/supabase/server";
import { rateLimitByIp } from "@/lib/rate-limit";

export async function POST(req: Request) {
  try {
    // Apply rate limit
    const limitResult = await rateLimitByIp(req, { windowMs: 60_000, max: 10 });
    if (!limitResult.ok) {
      return NextResponse.json({ error: "Rate limit exceeded" }, { status: 429 });
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

    if (result.error) {
      return NextResponse.json({ error: result.error }, { status: 500 });
    }

    return NextResponse.json({ explanation: result.data });
  } catch (error: any) {
    console.error("Explanation Generation Error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
