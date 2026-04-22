import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";

interface PageProps {
  params: Promise<{ moduleSlug: string; subjectSlug: string }>;
}

export const revalidate = 3600;

export async function generateStaticParams() {
  const supabase = createStaticClient();
  const { data: subjects } = await supabase
    .from("subjects")
    .select("slug, modules(slug)");
  
  return (subjects || []).map((s: any) => {
    const modules = s.modules;
    const moduleSlug = Array.isArray(modules) ? modules[0]?.slug : modules?.slug;
    return {
      moduleSlug: moduleSlug || "unknown",
      subjectSlug: s.slug,
    };
  }).filter(p => p.moduleSlug !== "unknown");
}

export default async function SubjectPage({ params }: PageProps) {
  const { moduleSlug, subjectSlug } = await params;
  const supabase = createStaticClient();

  const { data: subjectData } = await supabase
    .from("subjects")
    .select("id, name, description, module_id, modules!inner(slug)")
    .eq("slug", subjectSlug)
    .eq("modules.slug", moduleSlug)
    .single();

  if (!subjectData) {
    notFound();
  }

  const { data: topics, error } = await supabase
    .from("topics")
    .select("id, name, slug, description, display_order")
    .eq("subject_id", subjectData.id)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching topics:", error);
  }

  return (
    <section className="space-y-6">
      <div>
        <div className="text-sm text-gray-500 font-medium mb-1">
          <Link href={`/courses/${moduleSlug}`} className="hover:text-blue-600 transition-colors">
            Back to Course
          </Link>
          <span className="mx-2 text-gray-300">|</span>
          {subjectData.name}
        </div>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">Topics in {subjectData.name}</h1>
        <p className="text-gray-600">
          {subjectData.description || "Select a topic to view its question sets."}
        </p>
      </div>
      
      {!topics || topics.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No topics are available yet in this subject.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {topics.map((topic) => (
            <Link
              key={topic.id}
              href={`/courses/${moduleSlug}/${subjectSlug}/${topic.slug}`}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500 hover:border-blue-200"
            >
              <h2 className="text-lg font-semibold text-gray-900">{topic.name}</h2>
              <p className="text-sm text-gray-600 mt-1">
                {topic.description || "Explore question sets for this topic."}
              </p>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
