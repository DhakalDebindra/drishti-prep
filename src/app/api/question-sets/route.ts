import { NextResponse } from 'next/server';
import { createClient } from "../../../lib/supabase/server";
import * as z from "zod";

const questionPayload = z.object({
  id: z.string().optional(), // Needed for importing existing questions
  order_number: z.coerce.number().int().min(1),
  content: z.string().min(1, "Question content is required"),
  option_a: z.string().min(1, "Option A is required"),
  option_b: z.string().min(1, "Option B is required"),
  option_c: z.string().min(1, "Option C is required"),
  option_d: z.string().min(1, "Option D is required"),
  correct_option: z.enum(["A", "B", "C", "D"]),
  general_explanation: z.string().optional(),
  exam_year: z.coerce.number().optional().nullable(),
  paper_ref: z.string().optional().nullable(),
  language: z.enum(["nepali", "english", "both"]).default("nepali").optional(),
});

const questionSetPayload = z.object({
  topic_id: z.string().min(1, "Topic ID is required"),
  title: z.string().min(1, "Title is required"),
  difficulty_level: z.coerce.number().int().min(1).max(3),
  set_type: z.enum(["learning", "mock_exam", "daily_challenge", "revision"]).default("learning"),
  is_verified: z.boolean(),
  questions: z.array(questionPayload).min(1, "At least one question is required").max(30, "Maximum of 30 questions allowed per set"),
});

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
    const parseResult = questionSetPayload.safeParse(requestBody);

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
      return errorResponse("Failed to create question set");
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
