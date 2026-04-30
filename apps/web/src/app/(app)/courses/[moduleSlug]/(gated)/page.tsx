import Link from "next/link";
import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";
import { SeeMoreText } from "@/components/ui/SeeMoreText";

interface PageProps {
  params: Promise<{ moduleSlug: string }>;
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
    .select("id, name, slug, description, display_order, syllabus_ref")
    .eq("module_id", moduleData.id)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching subjects:", error);
  }

  return (
    <section className="space-y-6">
      <div>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900"><Lang>{moduleData.name}</Lang> - Subjects</h1>
        <div className="text-gray-600 mt-2">
          {moduleData.description ? <SeeMoreText text={moduleData.description} maxLength={150} /> : "Pick a subject to explore its topics."}
        </div>
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
              <h2 className="text-lg font-semibold text-gray-900">
                {subject.syllabus_ref && <span className="text-gray-500 font-normal mr-2">{subject.syllabus_ref}</span>}
                <Lang>{subject.name}</Lang>
              </h2>
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
