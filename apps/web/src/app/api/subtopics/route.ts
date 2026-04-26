import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { generateSlug } from "@repo/utils";

export async function GET() {
  try {
    const supabase = await createClient();
    const { data: subtopics, error } = await supabase
      .from("subtopics")
      .select("id, name, name_np, topic_id, display_order, description, topics(name)")
      .order("topic_id", { ascending: true })
      .order("display_order", { ascending: true });

    if (error) throw error;
    return NextResponse.json(subtopics || []);
  } catch (error) {
    console.error("Error fetching subtopics:", error);
    return NextResponse.json({ error: "Unable to fetch subtopics" }, { status: 500 });
  }
}

export async function POST(req: Request) {
  try {
    const supabase = await createClient();
    
    // Auth guard
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.json({ error: "Not authenticated" }, { status: 401 });

    const { data: profile } = await supabase.from("profiles").select("is_admin").eq("id", user.id).single();
    if (!profile?.is_admin) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

    const body = await req.json();
    const { name, name_np, topic_id, display_order, description } = body;

    if (!name || !topic_id) {
      return NextResponse.json({ error: "Name and topic_id are required" }, { status: 400 });
    }

    const slug = generateSlug(name);

    const { data: inserted, error } = await supabase
      .from("subtopics")
      .insert({
        name,
        name_np,
        topic_id,
        slug,
        display_order: display_order || 0,
        description
      })
      .select("*, topics(name)")
      .single();

    if (error) throw error;
    return NextResponse.json(inserted);
  } catch (error: any) {
    console.error("Error creating subtopic:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
