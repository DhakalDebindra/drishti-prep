import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function SubjectTopicsPage({
  params,
}: {
  params: Promise<{ subject: string }>;
}) {
  const { subject } = await params;
  const supabase = await createClient();
  const subjectName = decodeURIComponent(subject);

  const [{ data: subjectRow }, { data: topics, error }] = await Promise.all([
    supabase.from("subjects").select("id, name, description").eq("name", subjectName).maybeSingle(),
    supabase
      .from("topics")
      .select("id, name, description, subject_id")
      .order("name", { ascending: true }),
  ]);

  if (!subjectRow) {
    notFound();
  }

  const topicList = (topics ?? []).filter((t) => t.subject_id === subjectRow.id);

  return (
    <section className="space-y-6">
      <div className="flex items-center gap-2 text-sm text-gray-500" aria-label="Breadcrumb">
        <Link href="/practice" className="text-blue-700 hover:text-blue-900">
          Practice
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          {subjectRow.name}
        </span>
      </div>
      <header className="space-y-2">
        <p className="text-sm uppercase tracking-wide text-gray-500">Topics</p>
        <h1 className="text-2xl font-semibold text-gray-900">Pick a topic in {subjectRow.name}</h1>
        <p className="text-gray-600">
          {subjectRow.description || "Browse available topics to start practicing."}
        </p>
        {error && (
          <p className="mt-2 rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">
            Unable to load topics right now.
          </p>
        )}
      </header>
      {topicList.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No topics found for this subject.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {topicList.map((topic) => (
            <Link
              key={topic.id}
              href={`/practice/${encodeURIComponent(subjectRow.name)}/${encodeURIComponent(topic.name)}`}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <div className="flex items-start justify-between">
                <h2 className="text-lg font-semibold text-gray-900">{topic.name}</h2>
              </div>
              <p className="text-sm text-gray-600">{topic.description || "Start a set in this topic."}</p>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
