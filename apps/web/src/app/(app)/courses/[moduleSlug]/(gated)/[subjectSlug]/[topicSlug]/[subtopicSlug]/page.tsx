import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";

interface PageProps {
  params: Promise<{ 
    moduleSlug: string; 
    subjectSlug: string; 
    topicSlug: string; 
    subtopicSlug: string;
  }>;
}

export const revalidate = 3600;

export default async function SubtopicPage({ params }: PageProps) {
  const { moduleSlug, subjectSlug, topicSlug, subtopicSlug } = await params;
  const supabase = createStaticClient();

  // Fetch subtopic details and its parent topic/subject
  const { data: subtopicData } = await supabase
    .from("subtopics")
    .select(`
      id,
      name,
      name_np,
      description,
      topics!inner(
        id,
        name,
        slug,
        subjects!inner(
          id,
          name,
          slug,
          modules!inner(id, slug)
        )
      )
    `)
    .eq("slug", subtopicSlug)
    .eq("topics.slug", topicSlug)
    .eq("topics.subjects.slug", subjectSlug)
    .single();

  if (!subtopicData) {
    notFound();
  }

  const topic = subtopicData.topics as any;
  const subject = topic.subjects as any;
  const moduleItem = subject.modules as any;

  if (moduleItem?.slug !== moduleSlug) {
    notFound();
  }

  // Native sets directly assigned to this subtopic
  const [{ data: nativeSets, error }, { data: crossLinks }] = await Promise.all([
    supabase
      .from("question_sets")
      .select("id, title, difficulty_level, version")
      .eq("subtopic_id", subtopicData.id)
      .eq("is_verified", true)
      .order("created_at", { ascending: true }),
    // Cross-module sets: sets from another module's subtopic linked here via junction table
    supabase
      .from("question_set_modules")
      .select("question_sets!inner(id, title, difficulty_level, version)")
      .eq("module_id", moduleItem.id)
      .eq("subtopic_id", subtopicData.id)
      .eq("question_sets.is_verified", true),
  ]);

  if (error) {
    console.error("Error fetching question sets:", error);
  }

  const nativeIds = new Set((nativeSets ?? []).map((s) => s.id));
  const crossSets = (crossLinks ?? [])
    .map((link) => (link as any).question_sets)
    .filter((s): s is NonNullable<typeof s> => s && !nativeIds.has(s.id));

  const sets = [...(nativeSets ?? []), ...crossSets];

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
          <Link href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}`} className="hover:text-blue-600 transition-colors">
            <Lang>{topic.name}</Lang>
          </Link>
          <span className="text-gray-300">/</span>
          <span className="text-gray-900"><Lang>{subtopicData.name_np || subtopicData.name}</Lang></span>
        </div>
      </nav>

      <header>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">
          Practice Sets for <Lang>{subtopicData.name_np || subtopicData.name}</Lang>
        </h1>
        <p className="text-gray-600">
          {subtopicData.description || "Choose a question set to begin your practice attempt."}
        </p>
      </header>

      {!sets || sets.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          यस उप-विषयमा अहिले कुनै सेट उपलब्ध छैन।
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {sets.map((set) => (
            <Link
              key={set.id}
              href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/${subtopicSlug}/practice/${set.id}`}
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
