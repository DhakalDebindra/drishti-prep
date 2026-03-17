import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

type SupabaseClient = Awaited<ReturnType<typeof createClient>>;

type SubjectRecord = { id: string; name: string };
type TopicRecord = { id: string; name: string; subject_id: string | null };
type TopicPayload = {
  id: string;
  name: string;
  subject_id: string | null;
  subject_name: string | null;
};

const errorResponse = (message: string, status = 500) =>
  NextResponse.json({ error: message }, { status });

const enrichWithSubjectName = (
  topic: TopicRecord,
  subjectMap: Map<string, string>
): TopicPayload => ({
  id: topic.id,
  name: topic.name,
  subject_id: topic.subject_id,
  subject_name: topic.subject_id ? subjectMap.get(topic.subject_id) ?? null : null,
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

export async function GET() {
  try {
    const supabase = await createClient();
    const subjects = await fetchSubjects(supabase);
    const subjectMap = buildSubjectMap(subjects);

    const { data: topics, error } = await supabase
      .from("topics")
      .select("id,name,subject_id")
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
    const subjects = await fetchSubjects(supabase);
    const subjectMap = buildSubjectMap(subjects);
    const fallbackSubjectId = getSubjectFallbackId(subjects);

    const body = await req.json().catch(() => ({}));
    const name = typeof body?.name === "string" ? body.name.trim() : "";

    if (!name) {
      return NextResponse.json({ error: "Topic name is required" }, { status: 400 });
    }

    const { data: existingTopics, error: searchError } = await supabase
      .from("topics")
      .select("id,name,subject_id")
      .ilike("name", name)
      .limit(1);

    if (searchError) {
      throw searchError;
    }

    if (existingTopics && existingTopics.length > 0) {
      return NextResponse.json(enrichWithSubjectName(existingTopics[0], subjectMap));
    }

    let subjectId = typeof body?.subject_id === "string" ? body.subject_id.trim() : "";
    if (!subjectId) {
      subjectId = fallbackSubjectId ?? "";
    }

    if (!subjectId) {
      return NextResponse.json(
        { error: "At least one subject must exist before creating a topic" },
        { status: 400 }
      );
    }

    const { data: insertedTopic, error: insertError } = await supabase
      .from("topics")
      .insert({ name, subject_id: subjectId })
      .select("id,name,subject_id")
      .single();

    if (insertError) {
      throw insertError;
    }

    return NextResponse.json(enrichWithSubjectName(insertedTopic, subjectMap));
  } catch (error) {
    console.error("Error creating topic:", error);
    const message = error instanceof Error ? error.message : "Unable to create topic";
    return errorResponse(message);
  }
}
