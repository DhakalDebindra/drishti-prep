import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type SubjectPayload = {
  id: string;
  name: string;
  module_id: string | null;
  name_np: string | null;
  syllabus_ref: string | null;
  display_order: number;
};

const errorResponse = (message: string, status = 500) =>
  NextResponse.json({ error: message }, { status });

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const moduleId = searchParams.get("module_id");

    const supabase = await createClient();
    let query = supabase
      .from("subjects")
      .select("id, name, module_id, name_np, syllabus_ref, display_order")
      .order("display_order", { ascending: true })
      .order("name", { ascending: true });

    if (moduleId) {
      query = query.eq("module_id", moduleId);
    }

    const { data, error } = await query;

    if (error) {
      throw error;
    }

    return NextResponse.json(data ?? []);
  } catch (error) {
    console.error("Error fetching subjects:", error);
    const message = error instanceof Error ? error.message : "Unable to fetch subjects";
    return errorResponse(message);
  }
}

export async function POST(req: Request) {
  try {
    const supabase = await createClient();

    // Auth + admin guard
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) {
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }
    const body = await req.json().catch(() => ({}));
    const name = typeof body?.name === "string" ? body.name.trim() : "";
    const name_np = typeof body?.name_np === "string" ? body.name_np.trim() : null;
    const moduleId = typeof body?.module_id === "string" ? body.module_id.trim() : null;
    const syllabusRef = typeof body?.syllabus_ref === "string" ? body.syllabus_ref.trim() : null;
    const displayOrder = typeof body?.display_order === "number" ? body.display_order : 0;

    if (!name) {
      return NextResponse.json({ error: "Subject name is required" }, { status: 400 });
    }

    const { data: existingSubjects, error: searchError } = await supabase
      .from("subjects")
      .select("id, name, module_id, name_np, syllabus_ref, display_order")
      .ilike("name", name)
      .limit(1);

    if (searchError) {
      throw searchError;
    }

    if (existingSubjects && existingSubjects.length > 0) {
      return NextResponse.json(existingSubjects[0]);
    }

    const { data: insertedSubject, error: insertError } = await supabase
      .from("subjects")
      .insert({ 
        name, 
        name_np, 
        module_id: moduleId, 
        syllabus_ref: syllabusRef, 
        display_order: displayOrder 
      })
      .select("id, name, module_id, name_np, syllabus_ref, display_order")
      .single();

    if (insertError) {
      throw insertError;
    }

    return NextResponse.json(insertedSubject as SubjectPayload);
  } catch (error) {
    console.error("Error creating subject:", error);
    const message = error instanceof Error ? error.message : "Unable to create subject";
    return errorResponse(message);
  }
}
