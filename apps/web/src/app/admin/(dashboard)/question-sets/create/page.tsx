"use client";

import {
  questionSetSchema,
  type QuestionSetFormValues,
  type QuestionSetQuestionFormValues,
} from "@repo/validation";
import { parseExplanation } from "@repo/utils";
import { useEffect, useId, useMemo, useState } from "react";
import { useForm, useFieldArray, type SubmitHandler } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { Button } from "@/components/ui/button";
import { Prompts } from "@/config/prompts/index";
import { Label } from "@/components/ui/label";
import { Plus, Search, Loader2 } from "lucide-react";

// Modularized Components
import { SetMetadataForm } from "@/components/admin/SetMetadataForm";
import { QuestionFormCard } from "@/components/admin/QuestionFormCard";
import { QuestionSearchModal } from "@/components/admin/QuestionSearchModal";

const MAX_QUESTIONS = 30;
type TopicOption = {
  id: string;
  name: string;
  subject_id: string | null;
  subject_name: string | null;
};

type SubjectOption = {
  id: string;
  name: string;
};

const createBlankQuestion = (
  order_number: number
): QuestionSetQuestionFormValues => ({
  order_number,
  content: "",
  option_a: "",
  option_b: "",
  option_c: "",
  option_d: "",
  correct_option: "A" as const,
  general_explanation: "",
  exam_year: null,
  paper_ref: "",
  language: "nepali" as const,
});

const createDefaultFormValues = (): QuestionSetFormValues => ({
  subject_id: "",
  topic_id: "",
  title: "",
  difficulty_level: 1,
  set_type: "learning",
  is_verified: false,
  questions: [createBlankQuestion(1)],
});

const defaultFormValues = createDefaultFormValues();

const TIMEOUT_MS = 25_000;



export default function CreateQuestionSetPage() {
  const [isGenerating, setIsGenerating] = useState<number | null>(null);
  const [topics, setTopics] = useState<TopicOption[]>([]);
  const [topicsLoading, setTopicsLoading] = useState(true);
  const [topicsError, setTopicsError] = useState<string | null>(null);
  const [topicCreationError, setTopicCreationError] = useState<string | null>(null);
  const [isCreatingTopic, setIsCreatingTopic] = useState(false);
  const [subjects, setSubjects] = useState<SubjectOption[]>([]);
  const [subjectsLoading, setSubjectsLoading] = useState(true);
  const [subjectsError, setSubjectsError] = useState<string | null>(null);
  const [subjectCreationError, setSubjectCreationError] = useState<string | null>(null);
  const [isCreatingSubject, setIsCreatingSubject] = useState(false);
  const [subjectTouched, setSubjectTouched] = useState(false);
  const [feedbackErrors, setFeedbackErrors] = useState<Record<number, string>>({});
  const [submissionMessage, setSubmissionMessage] = useState<string | null>(null);
  const [submissionError, setSubmissionError] = useState<string | null>(null);
  const {
    register,
    control,
    handleSubmit,
    setValue,
    getValues,
    reset,
    watch,
    formState: { errors, isSubmitting },
  } = useForm<QuestionSetFormValues>({
    resolver: zodResolver(questionSetSchema as any),
    defaultValues: defaultFormValues,
  });

  const topicListId = useId();
  const subjectListId = useId();
  const topicIdValue = watch("topic_id");
  const subjectIdValue = watch("subject_id");
  const subjectRegister = register("subject_id");
  const questionsWatch = watch("questions");
  const matchedSubject = useMemo(() => {
    if (!subjectIdValue) return undefined;
    return subjects.find((subject) => subject.id === subjectIdValue);
  }, [subjects, subjectIdValue]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) {
      return [];
    }
    return topics.filter((topic) => topic.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const matchedTopic = useMemo(() => {
    if (!topicIdValue) return undefined;
    return filteredTopics.find((topic) => topic.id === topicIdValue);
  }, [filteredTopics, topicIdValue]);


  const { fields, append, remove } = useFieldArray({
    control,
    name: "questions",
  });

  useEffect(() => {
    let isMounted = true;

    const loadTopics = async () => {
      setTopicsLoading(true);
      setTopicsError(null);

      try {
        const response = await fetch("/api/topics");
        if (!response.ok) {
          const body = await response.text();
          throw new Error(body || "Failed to load topics");
        }

        const data: TopicOption[] = await response.json();
        if (!isMounted) return;

          setTopics(data ?? []);

      } catch (error) {
        if (!isMounted) return;
        const message = error instanceof Error ? error.message : "Unable to load topics";
        setTopicsError(message);
      } finally {
        if (isMounted) {
          setTopicsLoading(false);
        }
      }
    };

    loadTopics();

    return () => {
      isMounted = false;
    };
  }, [getValues, setValue]);

  useEffect(() => {
    let isMounted = true;

    const loadSubjects = async () => {
      setSubjectsLoading(true);
      setSubjectsError(null);

      try {
        const response = await fetch("/api/subjects");
        if (!response.ok) {
          const body = await response.text();
          throw new Error(body || "Failed to load subjects");
        }

        const data: SubjectOption[] = await response.json();
        if (!isMounted) return;

        const sortedSubjects = (data ?? []).sort((a, b) => a.name.localeCompare(b.name));
        setSubjects(sortedSubjects);
      } catch (error) {
        if (!isMounted) return;
        const message =
          error instanceof Error ? error.message : "Unable to load subjects";
        setSubjectsError(message);
      } finally {
        if (isMounted) {
          setSubjectsLoading(false);
        }
      }
    };

    loadSubjects();

    return () => {
      isMounted = false;
    };
  }, []);



  const isQuestionComplete = (
    question?: QuestionSetFormValues["questions"][number]
  ) => {
    if (!question) return false;
    const requiredText = [
      question.content,
      question.option_a,
      question.option_b,
      question.option_c,
      question.option_d,
    ];
    const allOptionsFilled = requiredText.every(
      (value) => typeof value === "string" && value.trim().length > 0
    );
    return allOptionsFilled && Boolean(question.correct_option);
  };

  const generateFeedback = async (index: number) => {
    const question = getValues(`questions.${index}`);
    if (!isQuestionComplete(question)) {
      setFeedbackErrors((prev) => ({
        ...prev,
        [index]: "Fill the question and all options before generating.",
      }));
      return;
    }

    setIsGenerating(index);
    setFeedbackErrors((prev) => ({ ...prev, [index]: "" }));
    try {
      const payload = {
        content: question.content,
        option_a: question.option_a,
        option_b: question.option_b,
        option_c: question.option_c,
        option_d: question.option_d,
        correct_option: question.correct_option,
      };

      const prompt = Prompts["loksewa gk facilitator"](payload);

      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), TIMEOUT_MS);
      
      const response = await fetch("/api/generate-feedback", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
        signal: controller.signal,
      }).catch((err) => {
        clearTimeout(timeoutId);
        throw err;
      });
      clearTimeout(timeoutId);

      const responseText = await response.text();
      if (!response.ok) {
        let parsedError: any = null;
        try {
          parsedError = JSON.parse(responseText);
        } catch {
          parsedError = null;
        }
        const message = parsedError?.error ?? responseText ?? "Unknown error";
        const code = parsedError?.code ? ` (${parsedError.code})` : "";
        throw new Error(`Failed to generate feedback: ${message}${code}`);
      }

      const parsed = parseExplanation(responseText);
      const explanation = parsed.text || "Could not generate explanation.";

      if (!explanation) {
        throw new Error("Failed to generate feedback: Empty explanation from AI");
      }

      setValue(`questions.${index}.general_explanation`, explanation);
      setFeedbackErrors((prev) => {
        const { [index]: _, ...rest } = prev;
        return rest;
      });
    } catch (error) {
      console.error(error);
      const userMessage = error instanceof Error ? error.message : "Unknown error";
      setFeedbackErrors((prev) => ({ ...prev, [index]: userMessage }));
      alert(`Error generating feedback: ${userMessage}`);
    } finally {
      setIsGenerating(null);
    }
  };

  const onSubmit: SubmitHandler<QuestionSetFormValues> = async (values) => {
    setSubjectCreationError(null);
    setTopicCreationError(null);
    setSubmissionMessage(null);
    setSubmissionError(null);

    const subjectId = values.subject_id;
    if (!subjectId) {
      setSubjectCreationError("Please select a subject.");
      return;
    }

    const topicId = values.topic_id;
    if (!topicId) {
      setTopicCreationError("Please select a topic.");
      return;
    }

    const payload = {
      topic_id: topicId,
      title: values.title,
      difficulty_level: Number(values.difficulty_level),
      set_type: values.set_type,
      is_verified: values.is_verified,
      
      questions: values.questions.map((question, index) => ({
        id: question.id, // Pass ID for imported questions
        order_number: Number(question.order_number ?? index + 1),
        content: question.content,
        option_a: question.option_a,
        option_b: question.option_b,
        option_c: question.option_c,
        option_d: question.option_d,
        correct_option: question.correct_option,
        general_explanation: question.general_explanation?.trim() ? question.general_explanation : undefined,
        exam_year: question.exam_year,
        paper_ref: question.paper_ref,
        language: question.language,
      })),
    };

    try {
      const response = await fetch("/api/question-sets", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });
      const responseBody = await response.json().catch(() => null);

      if (!response.ok) {
        console.error("Question set API error payload:", response.status, responseBody);
        const message =
          responseBody?.error ?? "Failed to save the question set. Please try again.";
        throw new Error(message);
      }

      const setId = responseBody?.id ?? "unknown";
      setSubmissionMessage(`Saved question set "${values.title || "Untitled"}" (ID ${setId}).`);
      setFeedbackErrors({});
      reset(createDefaultFormValues());
      setSubjectTouched(false);
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Unable to save the question set";
      setSubmissionError(message);
      console.error("Question set submission error:", error);
    }
  };

  const [isSearchOpen, setIsSearchOpen] = useState(false);

  const handleImportQuestion = (q: any) => {
    append({
        id: q.id,
        order_number: fields.length + 1,
        content: q.content,
        option_a: q.option_a,
        option_b: q.option_b,
        option_c: q.option_c,
        option_d: q.option_d,
        correct_option: q.correct_option as any,
        general_explanation: q.explanation || "",
        exam_year: q.exam_year || null,
        paper_ref: q.paper_ref || "",
        language: (q.language as any) || "nepali",
    });
    setIsSearchOpen(false);
  };

  const existingQuestionIds = useMemo(() => {
    return (questionsWatch || []).map((q: any) => q.id).filter(Boolean) as string[];
  }, [questionsWatch]);

  return (
    <div className="container mx-auto py-8 max-w-6xl">
      <div className="flex justify-between items-center mb-10">
        <div>
            <h1 className="text-4xl font-black tracking-tight text-slate-900 border-b-4 border-blue-600 pb-2 inline-block">Create Question Set</h1>
            <p className="text-slate-500 mt-2 font-medium">Build curated learning paths and mock exams.</p>
        </div>
        <Button 
            type="button" 
            size="lg"
            variant="outline"
            className="rounded-full shadow-sm hover:shadow transition-all bg-white border-slate-200"
            onClick={() => setIsSearchOpen(true)}
        >
            <Search className="w-4 h-4 mr-2" />
            Import Existing
        </Button>
      </div>
      
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-12">
        <SetMetadataForm
            register={register}
            errors={errors}
            subjectListId={subjectListId}
            topicListId={topicListId}
            subjects={subjects}
            subjectsLoading={subjectsLoading}
            isCreatingSubject={isCreatingSubject}
            subjectsError={subjectsError}
            subjectCreationError={subjectCreationError}
            onSubjectChange={(event) => {
                subjectRegister.onChange(event);
                setValue("topic_id", "");
                setSubjectTouched(true);
            }}
            topicsLoading={topicsLoading}
            filteredTopics={filteredTopics}
            topicsError={topicsError}
            topicCreationError={topicCreationError}
            matchedTopic={matchedTopic}
            matchedSubject={matchedSubject}
            submissionMessage={submissionMessage}
            submissionError={submissionError}
        />

        <div className="space-y-6">
          <div className="flex items-center justify-between">
            <h2 className="text-2xl font-bold text-slate-800 flex items-center gap-3">
               Content Builder
               <span className="text-sm font-medium bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full">
                 {fields.length} {fields.length === 1 ? 'Question' : 'Questions'}
               </span>
            </h2>
          </div>
          
          <div className="space-y-8">
            {fields.map((field, index) => (
              <QuestionFormCard
                key={field.id}
                index={index}
                register={register}
                setValue={setValue}
                getValues={getValues}
                watch={watch}
                remove={remove}
                isGenerating={isGenerating}
                generateFeedback={generateFeedback}
                feedbackError={feedbackErrors[index]}
                isQuestionComplete={isQuestionComplete}
              />
            ))}
          </div>
        </div>

        <div className="flex gap-4 items-center justify-center py-10 border-t border-dashed border-slate-300">
            <Button
              type="button"
              variant="outline"
              size="lg"
              className="rounded-full px-8 shadow-sm hover:shadow-md transition-all h-14 text-base font-bold bg-white"
              disabled={fields.length >= MAX_QUESTIONS}
              onClick={() => {
                if (fields.length >= MAX_QUESTIONS) return;
                append(createBlankQuestion(fields.length + 1));
              }}
            >
            <Plus className="w-5 h-5 mr-2" />
            Add New Question
          </Button>

          <Button
            type="submit"
            size="lg"
            className="rounded-full px-12 h-14 text-base font-bold shadow-lg shadow-blue-200 bg-blue-600 hover:bg-blue-700 transition-all text-white"
            disabled={
              topicsLoading || isCreatingTopic || Boolean(topicsError) || isSubmitting
            }
          >
            {isCreatingTopic || isSubmitting ? (
              <span className="flex items-center gap-2">
                 <Loader2 className="w-5 h-5 animate-spin" /> Saving…
              </span>
            ) : "Submit Question Set"}
          </Button>
        </div>

      </form>

      <QuestionSearchModal 
        isOpen={isSearchOpen}
        onClose={() => setIsSearchOpen(false)}
        onImport={handleImportQuestion}
        existingQuestionIds={existingQuestionIds}
      />
    </div>
  );
}
