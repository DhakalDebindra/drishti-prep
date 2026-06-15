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

    const { topic_id, subtopic_id, title, difficulty_level, set_type, is_verified, questions } =
      parseResult.data;

    const { data: insertedSet, error: setInsertError } = await supabase
      .from("question_sets")
      .insert({
        topic_id,
        subtopic_id,
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

    // Register the set in question_set_modules (primary module + cross-module mirrors)
    const { data: topicRow } = await supabase
      .from("topics")
      .select("subjects!inner(module_id)")
      .eq("id", topic_id)
      .single();

    const primaryModuleId = (topicRow?.subjects as any)?.module_id as string | undefined;
    if (primaryModuleId) {
      await supabase.from("question_set_modules").insert({
        question_set_id: insertedSet.id,
        module_id: primaryModuleId,
        subtopic_id: subtopic_id ?? null,
      });

      // Auto-mirror source subtopics to the Nimavi course
      const NIMAVI_MODULE_ID = "6695669a-f40e-421a-a4ec-b09bbeaf56c4";
      const SOURCE_TO_NIMAVI_SLUG: Record<string, string> = {
        "68f17c03-c021-4bd6-bf1d-b5f3273a8c75": "nimavi-aasman-collection",
        "496b46ba-91ca-44b6-9dba-9ac38f2713f7": "nimavi-gorkhapatra",
        "6f1b8a1c-8c6a-4892-9600-9525550d5270": "nimavi-psc-publications",
        "58e63396-f84a-4f4c-afc6-4b8878f4c445": "nimavi-daily-news-digest",
      };
      const nimaviSlug = subtopic_id ? SOURCE_TO_NIMAVI_SLUG[subtopic_id] : undefined;
      if (nimaviSlug) {
        const { data: nimaviSub } = await supabase
          .from("subtopics")
          .select("id")
          .eq("slug", nimaviSlug)
          .single();
        if (nimaviSub) {
          await supabase.from("question_set_modules").upsert(
            { question_set_id: insertedSet.id, module_id: NIMAVI_MODULE_ID, subtopic_id: nimaviSub.id },
            { onConflict: "question_set_id,module_id", ignoreDuplicates: true }
          );
        }
      }
    }

    return NextResponse.json({ id: insertedSet.id }, { status: 201 });
  } catch (error: unknown) {
    console.error("Error creating question set:", error);
    const message =
      error instanceof Error ? error.message : "Unable to create question set";
    return errorResponse(message);
  }
}
