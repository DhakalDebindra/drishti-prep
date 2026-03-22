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
  const { data: auth } = await supabase.auth.getUser();
  const user = auth?.user ?? null;
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

  // Surface user progress
  const setAttemptsMap: Record<string, any> = {};
  if (user && sets.length > 0) {
    const setIds = sets.map((s) => s.id);
    const { data: userAttempts } = await supabase
      .from("attempts")
      .select("id, set_id, status, score_raw, question_count")
      .eq("user_id", user.id)
      .in("set_id", setIds)
      .order("started_at", { ascending: false });

    if (userAttempts) {
      userAttempts.forEach((attempt) => {
        if (!setAttemptsMap[attempt.set_id]) {
          setAttemptsMap[attempt.set_id] = attempt;
        }
      });
    }
  }

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
          {sets.map((set) => {
            const attempt = setAttemptsMap[set.id];
            const isCompleted = attempt?.status === "submitted";
            const isInProgress = attempt?.status === "in_progress";

            return (
              <Link
                key={set.id}
                href={`/practice/${encodeURIComponent(subjectRow.name)}/${encodeURIComponent(topicRow.name)}/${set.id}`}
                className="group relative flex flex-col justify-between rounded-xl border border-gray-200 bg-white p-5 shadow-sm transition-all hover:-translate-y-1 hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <div>
                  <div className="mb-3 flex flex-wrap items-center justify-between gap-2">
                    <span className="text-xs rounded-full bg-emerald-50 px-2.5 py-1 font-semibold text-emerald-700">
                      Level {set.difficulty_level}
                    </span>
                    {isCompleted && (
                      <span className="text-xs rounded-full bg-blue-50 px-2.5 py-1 font-semibold text-blue-700">
                        ✓ Completed
                      </span>
                    )}
                    {isInProgress && (
                      <span className="text-xs rounded-full bg-yellow-50 px-2.5 py-1 font-semibold text-yellow-800">
                        In Progress
                      </span>
                    )}
                  </div>
                  <h2 className="text-lg font-semibold text-gray-900 line-clamp-2">{set.title}</h2>
                </div>
                
                <div className="mt-6 flex items-center text-sm font-medium text-blue-600 transition-colors group-hover:text-blue-800">
                  {isCompleted ? "Practice Again" : isInProgress ? "Resume" : "Start Practice"}
                </div>
              </Link>
            );
          })}
        </div>
      )}
    </section>
  );
}
