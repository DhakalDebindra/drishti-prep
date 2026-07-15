import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowRight } from "lucide-react";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";
import { SeeMoreText } from "@/components/ui/SeeMoreText";
import { Breadcrumbs } from "@/components/ui/Breadcrumbs";

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
      <Breadcrumbs
        items={[
          { label: "Courses", href: "/courses" },
          { label: <Lang>{moduleData.name}</Lang> },
        ]}
      />

      <header className="space-y-2">
        <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
          <Lang>{moduleData.name}</Lang>
        </h1>
        <div className="text-muted-foreground">
          {moduleData.description ? (
            <SeeMoreText text={moduleData.description} maxLength={150} />
          ) : (
            "Pick a subject to explore its topics."
          )}
        </div>
      </header>

      {!subjects || subjects.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-border bg-card p-6 text-muted-foreground">
          No subjects are available yet in this course.
        </div>
      ) : (
        <ul className="grid gap-4 sm:grid-cols-2">
          {subjects.map((subject) => (
            <li key={subject.id}>
              <Link
                href={`/courses/${moduleSlug}/${subject.slug}`}
                className="group flex h-full flex-col rounded-2xl border-2 border-border bg-card p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-primary/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <h2 className="text-lg font-semibold text-foreground transition-colors group-hover:text-primary">
                  {subject.syllabus_ref && (
                    <span className="mr-2 font-normal text-muted-foreground">{subject.syllabus_ref}</span>
                  )}
                  <Lang>{subject.name}</Lang>
                </h2>
                <p className="mt-1 flex-grow text-sm text-muted-foreground">
                  {subject.description ? <Lang>{subject.description}</Lang> : "Explore topics for this subject."}
                </p>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-medium text-primary">
                  View topics
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
