import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type SupabaseClient = Awaited<ReturnType<typeof createClient>>;

type SubjectRecord = { id: string; name: string };
type TopicRecord = { 
  id: string; 
  name: string; 
  subject_id: string | null;
  syllabus_ref: string | null;
  display_order: number;
};
type TopicPayload = {
  id: string;
  name: string;
  slug: string | null;
  subject_id: string | null;
  subject_name: string | null;
  syllabus_ref: string | null;
  display_order: number;
  description: string | null;
};

const errorResponse = (message: string, status = 500) =>
  NextResponse.json({ error: message }, { status });

const enrichWithSubjectName = (
  topic: TopicRecord,
  subjectMap: Map<string, string>
): TopicPayload => ({
  id: topic.id,
  name: topic.name,
  slug: (topic as any).slug || null,
  subject_id: topic.subject_id,
  subject_name: topic.subject_id ? subjectMap.get(topic.subject_id) ?? null : null,
  syllabus_ref: topic.syllabus_ref,
  display_order: topic.display_order,
  description: (topic as any).description || null,
});

const fetchSubjects = async (supabase: SupabaseClient) => {
  const { data, error } = await supabase
    .from("subjects")
    .select("id,name")
    .order("created_at", { ascending: true });

  if (error) {
    throw error;
  }

  return data ?? [];
};

const buildSubjectMap = (subjects: SubjectRecord[]) =>
  new Map(subjects.map((subject) => [subject.id, subject.name]));

const getSubjectFallbackId = (subjects: SubjectRecord[]) => subjects[0]?.id ?? null;

const generateSlug = (name: string) => {
  const base = name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
  
  return base || `topic-${Math.random().toString(36).substring(2, 10)}`;
};

export async function GET() {
  try {
    const supabase = await createClient();
    const subjects = await fetchSubjects(supabase);
    const subjectMap = buildSubjectMap(subjects);

    const { data: topics, error } = await supabase
      .from("topics")
      .select("id, name, subject_id, syllabus_ref, display_order")
      .order("display_order", { ascending: true })
      .order("name", { ascending: true });

    if (error) {
      throw error;
    }

    const payload = (topics ?? []).map((topic) =>
      enrichWithSubjectName(topic, subjectMap)
    );

    return NextResponse.json(payload);
  } catch (error) {
    console.error("Error fetching topics:", error);
    const message = error instanceof Error ? error.message : "Unable to fetch topics";
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
    const subjects = await fetchSubjects(supabase);
    const subjectMap = buildSubjectMap(subjects);
    const fallbackSubjectId = getSubjectFallbackId(subjects);

    const body = await req.json().catch(() => ({}));
    const name = typeof body?.name === "string" ? body.name.trim() : "";
    const subjectId = typeof body?.subject_id === "string" ? body.subject_id.trim() : fallbackSubjectId;

    if (!name) {
      return NextResponse.json({ error: "Topic name is required" }, { status: 400 });
    }

    if (!subjectId) {
      return NextResponse.json(
        { error: "At least one subject must exist before creating a topic" },
        { status: 400 }
      );
    }

    // Scope check to same subject
    const { data: existingTopics, error: searchError } = await supabase
      .from("topics")
      .select("id, name, subject_id, syllabus_ref, display_order, description")
      .eq("subject_id", subjectId)
      .ilike("name", name)
      .limit(1);

    if (searchError) {
      throw searchError;
    }

    if (existingTopics && existingTopics.length > 0) {
      return NextResponse.json(enrichWithSubjectName(existingTopics[0], subjectMap));
    }

    const syllabusRef = typeof body?.syllabus_ref === "string" ? body.syllabus_ref.trim() : null;
    const displayOrder = typeof body?.display_order === "number" ? (isNaN(body.display_order) ? 0 : body.display_order) : 0;
    const description = typeof body?.description === "string" ? body.description.trim() : null;
    const slug = generateSlug(name);

    const { data: insertedTopic, error: insertError } = await supabase
      .from("topics")
      .insert({ 
        name, 
        slug,
        subject_id: subjectId,
        syllabus_ref: syllabusRef,
        display_order: displayOrder,
        description: description
      })
      .select("id, name, slug, subject_id, syllabus_ref, display_order, description")
      .single();

    if (insertError) {
      throw insertError;
    }

    return NextResponse.json(enrichWithSubjectName(insertedTopic, subjectMap));
  } catch (error: any) {
    console.error("Error creating topic:", error);
    const message = error?.message || "Unable to create topic";
    return errorResponse(message);
  }
}
