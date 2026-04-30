import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";

interface PageProps {
  params: Promise<{ moduleSlug: string; subjectSlug: string; topicSlug: string }>;
}

export const revalidate = 3600;

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

  const subject = (topicData as any).subjects;
  const moduleItem = subject.modules;

  if (moduleItem?.slug !== moduleSlug) {
    notFound();
  }

  // NEW: Check for subtopics
  const { data: subtopics } = await supabase
    .from("subtopics")
    .select("id, name, name_np, slug, description, display_order")
    .eq("topic_id", topicData.id)
    .eq("is_active", true)
    .order("display_order", { ascending: true });

  if (subtopics && subtopics.length > 0) {
    // Render subtopic list
    return (
      <section className="space-y-6">
        <nav aria-label="Breadcrumb">
          <div className="text-sm text-gray-500 font-medium mb-1 flex items-center space-x-2">
            <Link href={`/courses/${moduleSlug}`} className="hover:text-blue-600 transition-colors">
              Course
            </Link>
            <span className="text-gray-300">/</span>
            <Link href={`/courses/${moduleSlug}/${subjectSlug}`} className="hover:text-blue-600 transition-colors">
              <Lang>{subject.name}</Lang>
            </Link>
            <span className="text-gray-300">/</span>
            <span className="text-gray-900"><Lang>{topicData.name}</Lang></span>
          </div>
        </nav>

        <header>
          <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
            Topics in <Lang>{topicData.name}</Lang>
          </h1>
          <p className="text-gray-600">
            Choose a sub-topic to see available practice sets.
          </p>
        </header>

        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {subtopics.map((subtopic) => (
            <Link
              key={subtopic.id}
              href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/${subtopic.slug}`}
              className="group rounded-xl border border-gray-200 bg-white p-5 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500 hover:border-blue-200"
            >
              <div className="flex justify-between items-start mb-2">
                <h2 className="text-lg font-semibold text-gray-900 line-clamp-2">
                  <Lang>{subtopic.name_np || subtopic.name}</Lang>
                </h2>
              </div>
              <p className="text-sm text-gray-500 mt-4 flex items-center">
                View Sets <span className="ml-1 group-hover:translate-x-1 transition-transform">→</span>
              </p>
            </Link>
          ))}
        </div>
      </section>
    );
  }

  // FALLBACK: Fetch verified active question sets directly under the topic
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
      <nav aria-label="Breadcrumb">
        <div className="text-sm text-gray-500 font-medium mb-1 flex items-center space-x-2">
          <Link href={`/courses/${moduleSlug}`} className="hover:text-blue-600 transition-colors">
            Course
          </Link>
          <span className="text-gray-300">/</span>
          <Link href={`/courses/${moduleSlug}/${subjectSlug}`} className="hover:text-blue-600 transition-colors">
            <Lang>{subject.name}</Lang>
          </Link>
          <span className="text-gray-300">/</span>
          <span className="text-gray-900"><Lang>{topicData.name}</Lang></span>
        </div>
      </nav>

      <header>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
          Practice Sets for <Lang>{topicData.name}</Lang>
        </h1>
        <p className="text-gray-600">
          Choose a question set to begin your practice attempt.
        </p>
      </header>

      {!sets || sets.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          यस विषयमा अहिले कुनै सामग्री उपलब्ध छैन।
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
                <h2 className="text-lg font-semibold text-gray-900 line-clamp-2"><Lang>{set.title}</Lang></h2>
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
