import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";

interface PageProps {
  params: Promise<{ moduleSlug: string; subjectSlug: string; topicSlug: string }>;
}

export const revalidate = 3600;

export async function generateStaticParams() {
  const supabase = createStaticClient();
  const { data: topics } = await supabase
    .from("topics")
    .select("slug, subjects!inner(slug, modules!inner(slug))");
  
  return (topics || []).map((t) => {
    const subject = Array.isArray(t.subjects) ? t.subjects[0] : t.subjects;
    const moduleItem = subject ? (Array.isArray(subject.modules) ? subject.modules[0] : subject.modules) : null;
    return {
      moduleSlug: moduleItem?.slug || "unknown",
      subjectSlug: subject?.slug || "unknown",
      topicSlug: t.slug,
    };
  }).filter(p => p.moduleSlug !== "unknown" && p.subjectSlug !== "unknown");
}

export default async function TopicPage({ params }: PageProps) {
  const { moduleSlug, subjectSlug, topicSlug } = await params;
  const supabase = createStaticClient();

  const { data: topicData } = await supabase
    .from("topics")
    .select("id, name, description, subjects!inner(id, name, slug, modules!inner(slug))")
    .eq("slug", topicSlug)
    .eq("subjects.slug", subjectSlug)
    .single();

  if (!topicData) {
    notFound();
  }

  // Double check module routing matches to avoid routing confusion
  const subject = Array.isArray(topicData.subjects) ? topicData.subjects[0] : topicData.subjects;
  const moduleItem = subject ? (Array.isArray(subject.modules) ? subject.modules[0] : subject.modules) : null;
  if (moduleItem?.slug !== moduleSlug) {
    notFound();
  }

  // Fetch verified active question sets
  const { data: sets, error } = await supabase
    .from("question_sets")
    .select("id, title, difficulty_level, version")
    .eq("topic_id", topicData.id)
    .eq("is_verified", true)
    .order("created_at", { ascending: true });

  if (error) {
    console.error("Error fetching question sets:", error);
  }

  return (
    <section className="space-y-6">
      <div>
        <div className="text-sm text-gray-500 font-medium mb-1 flex items-center space-x-2">
          <Link href={`/courses/${moduleSlug}`} className="hover:text-blue-600 transition-colors">
            Course
          </Link>
          <span className="text-gray-300">/</span>
          <Link href={`/courses/${moduleSlug}/${subjectSlug}`} className="hover:text-blue-600 transition-colors">
            {subject.name}
          </Link>
          <span className="text-gray-300">/</span>
          <span className="text-gray-900">{topicData.name}</span>
        </div>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">Practice Sets for {topicData.name}</h1>
        <p className="text-gray-600">
          Choose a question set to begin your practice attempt.
        </p>
      </div>

      {!sets || sets.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No practice sets are available yet for this topic.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {sets.map((set) => (
            <Link
              key={set.id}
              href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/practice/${set.id}`}
              className="group rounded-xl border border-gray-200 bg-white p-5 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500 hover:border-blue-200"
            >
              <div className="flex justify-between items-start mb-2">
                <h2 className="text-lg font-semibold text-gray-900 line-clamp-2">{set.title}</h2>
                {set.difficulty_level && (
                  <span className="inline-block px-2 py-1 bg-gray-100 text-xs font-medium text-gray-600 rounded">
                    Lvl {set.difficulty_level}
                  </span>
                )}
              </div>
              <p className="text-sm text-gray-500 mt-4 flex items-center">
                Start Practice <span className="ml-1 group-hover:translate-x-1 transition-transform">→</span>
              </p>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
