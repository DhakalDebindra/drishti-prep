import { createClient } from "@/lib/supabase/server";
import { notFound } from "next/navigation";
import EditorClient from "./EditorClient";

export default async function EditQuestionSetPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createClient();

  const { data: questionSet, error: setError } = await supabase
    .from("question_sets")
    .select("*")
    .eq("id", id)
    .single();

  if (setError || !questionSet) {
    return notFound();
  }

  const { data: qsqResponse, error: questionsError } = await supabase
    .from("question_set_questions")
    .select("position, questions(*)")
    .eq("question_set_id", id)
    .order("position", { ascending: true });

  const questions = qsqResponse?.map((row: any) => row.questions) || [];

  if (questionsError) {
    console.error("Failed to load questions", questionsError);
  }

  return (
    <div className="container mx-auto py-8">
      <EditorClient 
        initialSet={questionSet} 
        initialQuestions={questions || []} 
      />
    </div>
  );
}
