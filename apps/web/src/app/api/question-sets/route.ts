import { NextResponse } from 'next/server';
import { questionSetPayloadSchema } from "@repo/validation";
import { createClient } from "@/lib/supabase/server";

const errorResponse = (message: string, status = 500) =>
  NextResponse.json({ error: message }, { status });

export async function POST(req: Request) {
  try {
    const supabase = await createClient();

    // Auth + admin guard
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user) {
      return errorResponse("Not authenticated", 401);
    }

    const { data: profile } = await supabase
      .from("profiles")
      .select("is_admin")
      .eq("id", user.id)
      .single();

    if (!profile?.is_admin) {
      return errorResponse("Forbidden", 403);
    }

    const requestBody = await req.json();
    const parseResult = questionSetPayloadSchema.safeParse(requestBody);

    if (!parseResult.success) {
      const issue = parseResult.error.issues[0];
      return errorResponse(issue.message, 400);
    }

    const { topic_id, title, difficulty_level, set_type, is_verified, questions } =
      parseResult.data;

    const { data: insertedSet, error: setInsertError } = await supabase
      .from("question_sets")
      .insert({
        topic_id,
        title,
        difficulty_level,
        set_type,
        is_verified,
      })
      .select("id")
      .single();

    if (setInsertError || !insertedSet?.id) {
      console.error("Failed to insert question set", setInsertError);
      return errorResponse(setInsertError?.message || "Failed to create question set");
    }

    // Handle Questions: 
    // New questions (without id) need insertion.
    // Imported questions (with id) already exist and should only be linked in the junction table.
    
    const newQuestionsPayload = questions.filter(q => !q.id);
    const importedQuestionIds = questions.filter(q => !!q.id).map(q => q.id as string);

    const questionRecords = newQuestionsPayload.map((question) => ({
      set_id: insertedSet.id,
      order_number: question.order_number,
      content: question.content,
      option_a: question.option_a,
      option_b: question.option_b,
      option_c: question.option_c,
      option_d: question.option_d,
      correct_option: question.correct_option,
      explanation: question.general_explanation ?? null,
      exam_year: question.exam_year,
      paper_ref: question.paper_ref,
      language: question.language,
    }));

    let allQuestionIds: string[] = [...importedQuestionIds];

    if (questionRecords.length > 0) {
      const { data: insertedQuestions, error: questionInsertError } = await supabase
        .from("questions")
        .insert(questionRecords)
        .select("id");

      if (questionInsertError || !insertedQuestions) {
        console.error("Failed to insert questions", questionInsertError);
        await supabase.from("question_sets").delete().eq("id", insertedSet.id);
        return errorResponse(
          questionInsertError?.message ?? "Failed to save questions for the set",
          400
        );
      }
      allQuestionIds = [...allQuestionIds, ...insertedQuestions.map(q => q.id)];
    }

    // Link all questions (new + imported) to the new set in the junction table
    const junctionRecords = allQuestionIds.map((qId, index) => ({
      question_set_id: insertedSet.id,
      question_id: qId,
      position: index + 1, // Using sequence order for junction table position
    }));

    const { error: junctionInsertError } = await supabase
      .from("question_set_questions")
      .insert(junctionRecords);

    if (junctionInsertError) {
      console.error("Failed to link questions to set", junctionInsertError);
      await supabase.from("question_sets").delete().eq("id", insertedSet.id);
      return errorResponse(junctionInsertError.message, 400);
    }

    return NextResponse.json({ id: insertedSet.id }, { status: 201 });
  } catch (error: unknown) {
    console.error("Error creating question set:", error);
    const message =
      error instanceof Error ? error.message : "Unable to create question set";
    return errorResponse(message);
  }
}
