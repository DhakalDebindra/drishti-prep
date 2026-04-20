import { createClient } from "@/lib/supabase/server";
import { CurriculumClient } from "./CurriculumClient";

export const metadata = {
  title: "Curriculum Management | Dristiprep Admin",
  description: "Manage modules, subjects, and topics for Loksewa preparation.",
};

export default async function CurriculumPage() {
  const supabase = await createClient();

  // Fetch all initial data for the management hub
  const [
    { data: modules },
    { data: subjects },
    { data: topics }
  ] = await Promise.all([
    supabase.from("modules").select("*").order("display_order", { ascending: true }),
    supabase.from("subjects").select("*, modules(name)").order("display_order", { ascending: true }),
    supabase.from("topics").select("*, subjects(name)").order("display_order", { ascending: true }),
  ]);

  return (
    <div className="container mx-auto py-8 space-y-8">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Curriculum Manager</h1>
        <p className="text-muted-foreground mt-2">
          Organize your content hierarchy from Modules to granular Topics.
        </p>
      </div>

      <CurriculumClient 
        initialModules={modules || []} 
        initialSubjects={subjects || []} 
        initialTopics={topics || []} 
      />
    </div>
  );
}
