import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowRight } from "lucide-react";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";
import { Breadcrumbs } from "@/components/ui/Breadcrumbs";

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

  const { data: subtopicData } = await supabase
    .from("subtopics")
    .select(`
      id,
      name,
      name_np,
      syllabus_ref,
      description,
      topics!inner(
        id,
        name,
        slug,
        subjects!inner(
          id,
          name,
          slug,
          modules!inner(id, slug, name)
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

  // Native sets directly assigned to this subtopic, plus cross-module sets
  // linked here through the junction table.
  const [{ data: nativeSets, error }, { data: crossLinks }] = await Promise.all([
    supabase
      .from("question_sets")
      .select("id, title, difficulty_level, version")
      .eq("subtopic_id", subtopicData.id)
      .eq("is_verified", true)
      .order("created_at", { ascending: true }),
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
  const subtopicTitle = subtopicData.name_np || subtopicData.name;

  return (
    <section className="space-y-6">
      <Breadcrumbs
        items={[
          { label: "Courses", href: "/courses" },
          {
            label: moduleItem?.name ? <Lang>{moduleItem.name}</Lang> : "Course",
            href: `/courses/${moduleSlug}`,
          },
          { label: <Lang>{subject.name}</Lang>, href: `/courses/${moduleSlug}/${subjectSlug}` },
          {
            label: <Lang>{topic.name}</Lang>,
            href: `/courses/${moduleSlug}/${subjectSlug}/${topicSlug}`,
          },
          { label: <Lang>{subtopicTitle}</Lang> },
        ]}
      />

      <header className="space-y-2">
        <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
          {subtopicData.syllabus_ref && (
            <span className="mr-2 font-normal text-muted-foreground">{subtopicData.syllabus_ref}</span>
          )}
          <Lang>{subtopicTitle}</Lang>
        </h1>
        <p className="text-muted-foreground">
          {subtopicData.description ? (
            <Lang>{subtopicData.description}</Lang>
          ) : (
            "Choose a question set to begin your practice attempt."
          )}
        </p>
      </header>

      {!sets || sets.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-border bg-card p-6 text-muted-foreground">
          <Lang>यस उप-विषयमा अहिले कुनै सेट उपलब्ध छैन।</Lang>
        </div>
      ) : (
        <ul className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {sets.map((set) => (
            <li key={set.id}>
              <Link
                href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/${subtopicSlug}/practice/${set.id}`}
                className="group flex h-full flex-col rounded-2xl border-2 border-border bg-card p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-primary/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <div className="flex items-start justify-between gap-2">
                  <h2 className="line-clamp-2 text-lg font-semibold text-foreground transition-colors group-hover:text-primary">
                    <Lang>{set.title}</Lang>
                  </h2>
                  {set.difficulty_level ? (
                    <span className="shrink-0 rounded-full border border-border bg-muted px-2 py-0.5 text-xs font-medium text-muted-foreground">
                      Lvl {set.difficulty_level}
                    </span>
                  ) : null}
                </div>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-medium text-primary">
                  Start practice
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
