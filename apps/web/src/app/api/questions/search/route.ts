import { NextResponse } from 'next/server';
import { createClient } from "../../../../lib/supabase/server";
import { apiRatelimit, extractClientIp } from "@/lib/rate-limit";

export async function GET(req: Request) {
  const { success } = await apiRatelimit.limit(extractClientIp(req));

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

  try {
    const supabase = await createClient();
    const { searchParams } = new URL(req.url);
    const query = searchParams.get("query")?.trim();
    const topicId = searchParams.get("topic_id");

    // AUTH + ADMIN CHECK
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    let supabaseQuery = supabase
      .from("questions")
      .select(`
        id, 
        content, 
        option_a, 
        option_b, 
        option_c, 
        option_d, 
        correct_option, 
        explanation,
        exam_year,
        paper_ref,
        language
      `)
      .order("created_at", { ascending: false })
      .limit(20);

    if (query) {
      // Using ilike for flexible partial matching across bilingual content
      supabaseQuery = supabaseQuery.ilike("content", `%${query}%`);
    }

    if (topicId) {
      // In the new architecture, we might want to filter by the sets the question belongs to
      // or if we kept topic_id on questions (optional), we check that.
      // For now, let's assume we search across all questions but allowing topic filtering 
      // if the question is linked to a set in that topic.
      // BUT for simplicity in search, we'll just search all questions for now.
    }

    const { data, error } = await supabaseQuery;

    if (error) throw error;

    return NextResponse.json(data);
  } catch (err: unknown) {
    console.error("Search Questions Error:", err);
    return NextResponse.json({ error: "Failed to search questions" }, { status: 500 });
  }
}
