import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowRight } from "lucide-react";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";
import { Breadcrumbs } from "@/components/ui/Breadcrumbs";

interface PageProps {
  params: Promise<{ moduleSlug: string; subjectSlug: string }>;
}

export const revalidate = 3600;

export async function generateStaticParams() {
  const supabase = createStaticClient();
  const { data: subjects } = await supabase
    .from("subjects")
    .select("slug, modules(slug)");

  return (subjects || [])
    .map((s: any) => {
      const modules = s.modules;
      const moduleSlug = Array.isArray(modules) ? modules[0]?.slug : modules?.slug;
      return {
        moduleSlug: moduleSlug || "unknown",
        subjectSlug: s.slug,
      };
    })
    .filter((p) => p.moduleSlug !== "unknown");
}

export default async function SubjectPage({ params }: PageProps) {
  const { moduleSlug, subjectSlug } = await params;
  const supabase = createStaticClient();

  const { data: subjectData } = await supabase
    .from("subjects")
    .select("id, name, description, module_id, syllabus_ref, modules!inner(slug, name)")
    .eq("slug", subjectSlug)
    .eq("modules.slug", moduleSlug)
    .single();

  if (!subjectData) {
    notFound();
  }

  const moduleRel = (subjectData as any).modules;
  const moduleName = Array.isArray(moduleRel) ? moduleRel[0]?.name : moduleRel?.name;

  const { data: topics, error } = await supabase
    .from("topics")
    .select("id, name, slug, description, display_order, syllabus_ref")
    .eq("subject_id", subjectData.id)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching topics:", error);
  }

  return (
    <section className="space-y-6">
      <Breadcrumbs
        items={[
          { label: "Courses", href: "/courses" },
          { label: moduleName ? <Lang>{moduleName}</Lang> : "Course", href: `/courses/${moduleSlug}` },
          { label: <Lang>{subjectData.name}</Lang> },
        ]}
      />

      <header className="space-y-2">
        <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
          {subjectData.syllabus_ref && (
            <span className="mr-2 font-normal text-muted-foreground">{subjectData.syllabus_ref}</span>
          )}
          <Lang>{subjectData.name}</Lang>
        </h1>
        <p className="text-muted-foreground">
          {subjectData.description ? (
            <Lang>{subjectData.description}</Lang>
          ) : (
            "Select a topic to view its question sets."
          )}
        </p>
      </header>

      {!topics || topics.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-border bg-card p-6 text-muted-foreground">
          No topics are available yet in this subject.
        </div>
      ) : (
        <ul className="grid gap-4 sm:grid-cols-2">
          {topics.map((topic) => (
            <li key={topic.id}>
              <Link
                href={`/courses/${moduleSlug}/${subjectSlug}/${topic.slug}`}
                className="group flex h-full flex-col rounded-2xl border-2 border-border bg-card p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-primary/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <h2 className="text-lg font-semibold text-foreground transition-colors group-hover:text-primary">
                  {topic.syllabus_ref && (
                    <span className="mr-2 font-normal text-muted-foreground">{topic.syllabus_ref}</span>
                  )}
                  <Lang>{topic.name}</Lang>
                </h2>
                <p className="mt-1 flex-grow text-sm text-muted-foreground">
                  {topic.description ? <Lang>{topic.description}</Lang> : "Explore question sets for this topic."}
                </p>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-medium text-primary">
                  View topic
                  <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden="true" />
                </span>
              </Link>
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}
