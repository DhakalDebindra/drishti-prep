import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

/**
 * Returns a module's syllabus as a nested tree — subjects → topics → subtopics —
 * used by the dashboard's "Continue studying" course tree to lazy-load a
 * course's contents when the learner expands it. Set-level resolution (which
 * mixes native and cross-module links) is deliberately left to the canonical
 * topic/subtopic pages, which each tree leaf links to.
 */
export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const moduleId = searchParams.get("module_id");
    if (!moduleId) {
      return NextResponse.json({ error: "module_id is required" }, { status: 400 });
    }

    const supabase = await createClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    const { data: subjects, error: subjectsError } = await supabase
      .from("subjects")
      .select("id, name, slug, syllabus_ref, display_order")
      .eq("module_id", moduleId)
      .order("display_order", { ascending: true })
      .order("name", { ascending: true });
    if (subjectsError) throw subjectsError;

    const subjectIds = (subjects ?? []).map((s) => s.id);
    const { data: topics } = subjectIds.length
      ? await supabase
          .from("topics")
          .select("id, name, slug, syllabus_ref, subject_id, display_order")
          .in("subject_id", subjectIds)
          .order("display_order", { ascending: true })
          .order("name", { ascending: true })
      : { data: [] as any[] };

    const topicIds = (topics ?? []).map((t) => t.id);
    const { data: subtopics } = topicIds.length
      ? await supabase
          .from("subtopics")
          .select("id, name, name_np, slug, syllabus_ref, topic_id, display_order")
          .in("topic_id", topicIds)
          .eq("is_active", true)
          .order("display_order", { ascending: true })
      : { data: [] as any[] };

    const subtopicsByTopic = new Map<string, any[]>();
    for (const st of subtopics ?? []) {
      const list = subtopicsByTopic.get(st.topic_id) ?? [];
      list.push({
        id: st.id,
        name: st.name_np || st.name,
        slug: st.slug,
        syllabus_ref: st.syllabus_ref,
      });
      subtopicsByTopic.set(st.topic_id, list);
    }

    const topicsBySubject = new Map<string, any[]>();
    for (const t of topics ?? []) {
      const list = topicsBySubject.get(t.subject_id) ?? [];
      list.push({
        id: t.id,
        name: t.name,
        slug: t.slug,
        syllabus_ref: t.syllabus_ref,
        subtopics: subtopicsByTopic.get(t.id) ?? [],
      });
      topicsBySubject.set(t.subject_id, list);
    }

    const tree = (subjects ?? []).map((s) => ({
      id: s.id,
      name: s.name,
      slug: s.slug,
      syllabus_ref: s.syllabus_ref,
      topics: topicsBySubject.get(s.id) ?? [],
    }));

    return NextResponse.json({ subjects: tree });
  } catch (error) {
    console.error("Error fetching course structure:", error);
    const message = error instanceof Error ? error.message : "Unable to fetch course structure";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
