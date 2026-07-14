import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

/**
 * Returns a module's syllabus as a nested tree — subjects → topics →
 * (subtopics) → question sets — used by the dashboard's "Continue studying"
 * tree to lazy-load a course's contents when the learner expands it.
 *
 * Set resolution mirrors the canonical topic/subtopic pages: a topic with
 * subtopics exposes its sets through those subtopics; a topic without subtopics
 * exposes its own topic-direct sets. Subtopic sets include both native sets
 * (subtopic_id) and cross-module sets linked via the question_set_modules
 * junction, so the tree lists exactly what the pages do.
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
    const subtopicIds = (subtopics ?? []).map((st) => st.id);

    // Topics that have subtopics surface their sets through those subtopics; the
    // rest expose topic-direct sets (same rule the topic page uses).
    const topicsWithSubtopics = new Set((subtopics ?? []).map((st) => st.topic_id));
    const directTopicIds = topicIds.filter((id) => !topicsWithSubtopics.has(id));

    const { data: topicSets } = directTopicIds.length
      ? await supabase
          .from("question_sets")
          .select("id, title, difficulty_level, topic_id")
          .in("topic_id", directTopicIds)
          .eq("is_verified", true)
          .order("created_at", { ascending: true })
      : { data: [] as any[] };

    const { data: nativeSubtopicSets } = subtopicIds.length
      ? await supabase
          .from("question_sets")
          .select("id, title, difficulty_level, subtopic_id")
          .in("subtopic_id", subtopicIds)
          .eq("is_verified", true)
          .order("created_at", { ascending: true })
      : { data: [] as any[] };

    // Cross-module sets: sets from another module linked to these subtopics
    // through the question_set_modules junction.
    const { data: crossLinks } = subtopicIds.length
      ? await supabase
          .from("question_set_modules")
          .select("subtopic_id, question_sets!inner(id, title, difficulty_level, is_verified)")
          .eq("module_id", moduleId)
          .in("subtopic_id", subtopicIds)
          .eq("question_sets.is_verified", true)
      : { data: [] as any[] };

    const setsByTopic = new Map<string, any[]>();
    for (const s of topicSets ?? []) {
      const list = setsByTopic.get(s.topic_id) ?? [];
      list.push({ id: s.id, title: s.title, difficulty_level: s.difficulty_level });
      setsByTopic.set(s.topic_id, list);
    }

    const setsBySubtopic = new Map<string, any[]>();
    const seenBySubtopic = new Map<string, Set<string>>();
    const pushSubtopicSet = (subtopicId: string, set: any) => {
      if (!subtopicId || !set?.id) return;
      const seen = seenBySubtopic.get(subtopicId) ?? new Set<string>();
      if (seen.has(set.id)) return;
      seen.add(set.id);
      seenBySubtopic.set(subtopicId, seen);
      const list = setsBySubtopic.get(subtopicId) ?? [];
      list.push({ id: set.id, title: set.title, difficulty_level: set.difficulty_level });
      setsBySubtopic.set(subtopicId, list);
    };
    for (const s of nativeSubtopicSets ?? []) {
      pushSubtopicSet(s.subtopic_id, s);
    }
    for (const link of crossLinks ?? []) {
      pushSubtopicSet((link as any).subtopic_id, (link as any).question_sets);
    }

    const subtopicsByTopic = new Map<string, any[]>();
    for (const st of subtopics ?? []) {
      const list = subtopicsByTopic.get(st.topic_id) ?? [];
      list.push({
        id: st.id,
        name: st.name_np || st.name,
        slug: st.slug,
        syllabus_ref: st.syllabus_ref,
        sets: setsBySubtopic.get(st.id) ?? [],
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
        sets: setsByTopic.get(t.id) ?? [],
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
