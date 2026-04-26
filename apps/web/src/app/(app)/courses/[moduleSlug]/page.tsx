import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";

interface PageProps {
  params: Promise<{ moduleSlug: string }>;
}

export const revalidate = 3600;

export async function generateStaticParams() {
  const supabase = createStaticClient();
  const { data: modules } = await supabase.from("modules").select("slug");
  return (modules || []).map((m) => ({ moduleSlug: m.slug }));
}

export default async function ModulePage({ params }: PageProps) {
  const { moduleSlug } = await params;
  const supabase = createStaticClient();

  const { data: moduleData } = await supabase
    .from("modules")
    .select("id, name, description")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) {
    notFound();
  }

  const { data: subjects, error } = await supabase
    .from("subjects")
    .select("id, name, slug, description, display_order")
    .eq("module_id", moduleData.id)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching subjects:", error);
  }

  return (
    <section className="space-y-6">
      <div>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900"><Lang>{moduleData.name}</Lang> - Subjects</h1>
        <p className="text-gray-600">
          {moduleData.description ? <Lang>{moduleData.description}</Lang> : "Pick a subject to explore its topics."}
        </p>
      </div>
      {!subjects || subjects.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No subjects are available yet in this course.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {subjects.map((subject) => (
            <Link
              key={subject.id}
              href={`/courses/${moduleSlug}/${subject.slug}`}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500 hover:border-blue-200"
            >
              <h2 className="text-lg font-semibold text-gray-900"><Lang>{subject.name}</Lang></h2>
              <p className="text-sm text-gray-600 mt-1">
                {subject.description ? <Lang>{subject.description}</Lang> : "Explore topics for this subject."}
              </p>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
