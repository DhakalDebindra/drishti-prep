import { createClient } from "@/lib/supabase/server";
import { CurriculumClient } from "./CurriculumClient";

export const metadata = {
  title: "Curriculum Management | DrishtiPrep Admin",
  description: "Manage modules, subjects, topics, and sub-topics.",
};

export default async function CurriculumPage() {
  const supabase = await createClient();

  // Fetch all initial data for the management hub
  const [
    { data: modules },
    { data: subjects },
    { data: topics },
    { data: subtopics }
  ] = await Promise.all([
    supabase.from("modules").select("*").order("display_order", { ascending: true }),
    supabase.from("subjects").select("*, modules(name)").order("display_order", { ascending: true }),
    supabase.from("topics").select("*, subjects(name)").order("display_order", { ascending: true }),
    supabase.from("subtopics").select("*, topics(name)").order("display_order", { ascending: true }),
  ]);

  return (
    <div className="container mx-auto py-8 space-y-8">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-900">Curriculum Manager</h1>
        <p className="text-slate-500 mt-2">
          Organize your content hierarchy across 5 layers: Module → Subject → Topic → Sub-topic → Practice Set.
        </p>
      </div>

      <CurriculumClient 
        initialModules={modules || []} 
        initialSubjects={subjects || []} 
        initialTopics={topics || []} 
        initialSubtopics={subtopics || []}
      />
    </div>
  );
}
