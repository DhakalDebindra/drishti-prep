import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function TopicSetsPage({
  params,
}: {
  params: Promise<{ subject: string; topic: string }>;
}) {
  const { subject, topic } = await params;
  const supabase = await createClient();
  const subjectName = decodeURIComponent(subject);
  const topicName = decodeURIComponent(topic);

  const [subjectRes, topicRes, setsRes] = await Promise.all([
    supabase.from("subjects").select("id, name").eq("name", subjectName).maybeSingle(),
    supabase.from("topics").select("id, name, description, subject_id").eq("name", topicName).maybeSingle(),
    supabase
      .from("question_sets")
      .select("id, title, difficulty_level, is_verified, version, topic_id")
      .order("created_at", { ascending: false }),
  ]);

  if (!subjectRes.data || !topicRes.data) {
    notFound();
  }

  const topicRow = topicRes.data;
  const subjectRow = subjectRes.data;

  if (topicRow.subject_id !== subjectRow.id) {
    notFound();
  }

  const sets = (setsRes.data ?? []).filter((set) => set.topic_id === topicRow.id);

  return (
    <section className="space-y-6">
      <div className="flex items-center gap-2 text-sm text-gray-500" aria-label="Breadcrumb">
        <Link href="/practice" className="text-blue-700 hover:text-blue-900">
          Practice
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${encodeURIComponent(subjectRow.name)}`}
          className="text-blue-700 hover:text-blue-900"
        >
          {subjectRow.name}
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          {topicRow.name}
        </span>
      </div>
      <header className="space-y-2">
        <p className="text-sm uppercase tracking-wide text-gray-500">Question Sets</p>
        <h1 className="text-2xl font-semibold text-gray-900">Pick a set for {topicRow.name}</h1>
        <p className="text-gray-600">{topicRow.description || "Choose a set to start practicing."}</p>
      </header>
      {sets.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No sets found for this topic.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {sets.map((set) => (
            <Link
              key={set.id}
              href={`/practice/${encodeURIComponent(subjectRow.name)}/${encodeURIComponent(topicRow.name)}/${set.id}`}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <div className="flex items-center justify-between">
                <h2 className="text-lg font-semibold text-gray-900">{set.title}</h2>
                <span className="text-xs rounded-full bg-emerald-50 px-2 py-1 font-semibold text-emerald-700">
                  Level {set.difficulty_level}
                </span>
              </div>
              
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
