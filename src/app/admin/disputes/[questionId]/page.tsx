import { createClient } from "@/lib/supabase/server";
import { notFound } from "next/navigation";
import ResolveClient from "./ResolveClient";

export default async function DisputeDetailPage({
  params,
}: {
  params: Promise<{ questionId: string }>;
}) {
  const { questionId } = await params;
  const supabase = await createClient();

  // Fetch the disputed question details
  const { data: question, error: questionError } = await supabase
    .from("questions")
    .select("*, question_sets(title)")
    .eq("id", questionId)
    .single();

  if (questionError || !question) {
    return notFound();
  }

  // Fetch the actual reports to display to the admin
  const { data: reports, error: reportsError } = await supabase
    .from("reports")
    .select("*")
    .eq("question_id", questionId)
    .eq("status", "pending")
    .order("created_at", { ascending: false });

  if (reportsError) {
    console.error("Failed to fetch reports for question:", reportsError);
  }

  return (
    <div className="container mx-auto py-8">
      <ResolveClient 
        question={question} 
        reports={reports || []} 
      />
    </div>
  );
}
