import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowRight } from "lucide-react";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";
import { Breadcrumbs } from "@/components/ui/Breadcrumbs";

interface PageProps {
  params: Promise<{ moduleSlug: string; subjectSlug: string; topicSlug: string }>;
}

export const revalidate = 3600;

export default async function TopicPage({ params }: PageProps) {
  const { moduleSlug, subjectSlug, topicSlug } = await params;
  const supabase = createStaticClient();

  const { data: topicData } = await supabase
    .from("topics")
    .select("id, name, description, subjects!inner(id, name, slug, modules!inner(slug, name))")
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

  const crumbs = [
    { label: "Courses", href: "/courses" },
    {
      label: moduleItem?.name ? <Lang>{moduleItem.name}</Lang> : "Course",
      href: `/courses/${moduleSlug}`,
    },
    { label: <Lang>{subject.name}</Lang>, href: `/courses/${moduleSlug}/${subjectSlug}` },
    { label: <Lang>{topicData.name}</Lang> },
  ];

  // Subtopics take priority; a topic with subtopics shows them, otherwise its
  // own question sets.
  const { data: subtopics } = await supabase
    .from("subtopics")
    .select("id, name, name_np, slug, description, display_order, syllabus_ref")
    .eq("topic_id", topicData.id)
    .eq("is_active", true)
    .order("display_order", { ascending: true });

  if (subtopics && subtopics.length > 0) {
    return (
      <section className="space-y-6">
        <Breadcrumbs items={crumbs} />
        <header className="space-y-2">
          <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
            <Lang>{topicData.name}</Lang>
          </h1>
          <p className="text-muted-foreground">Choose a sub-topic to see available practice sets.</p>
        </header>

        <ul className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {subtopics.map((subtopic) => (
            <li key={subtopic.id}>
              <Link
                href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/${subtopic.slug}`}
                className="group flex h-full flex-col rounded-2xl border-2 border-border bg-card p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-primary/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
              >
                <h2 className="line-clamp-2 text-lg font-semibold text-foreground transition-colors group-hover:text-primary">
                  {subtopic.syllabus_ref && (
                    <span className="mr-2 font-normal text-muted-foreground">{subtopic.syllabus_ref}</span>
                  )}
                  <Lang>{subtopic.name_np || subtopic.name}</Lang>
                </h2>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-medium text-primary">
                  View sets
                  <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" aria-hidden="true" />
                </span>
              </Link>
            </li>
          ))}
        </ul>
      </section>
    );
  }

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
      <Breadcrumbs items={crumbs} />
      <header className="space-y-2">
        <h1 id="main-heading" className="text-2xl font-bold tracking-tight text-foreground sm:text-3xl">
          <Lang>{topicData.name}</Lang>
        </h1>
        <p className="text-muted-foreground">Choose a question set to begin your practice attempt.</p>
      </header>

      {!sets || sets.length === 0 ? (
        <div className="rounded-2xl border-2 border-dashed border-border bg-card p-6 text-muted-foreground">
          <Lang>यस विषयमा अहिले कुनै सामग्री उपलब्ध छैन।</Lang>
        </div>
      ) : (
        <ul className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {sets.map((set) => (
            <li key={set.id}>
              <Link
                href={`/courses/${moduleSlug}/${subjectSlug}/${topicSlug}/practice/${set.id}`}
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
