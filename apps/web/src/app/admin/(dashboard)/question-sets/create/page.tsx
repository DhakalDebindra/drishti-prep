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

type SubtopicOption = {
  id: string;
  name: string;
  name_np: string | null;
  topic_id: string;
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
  subtopic_id: null,
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
  const [subjects, setSubjects] = useState<SubjectOption[]>([]);
  const [subjectsLoading, setSubjectsLoading] = useState(true);
  const [subjectsError, setSubjectsError] = useState<string | null>(null);
  const [subtopics, setSubtopics] = useState<SubtopicOption[]>([]);
  const [subtopicsLoading, setSubtopicsLoading] = useState(true);
  const [subtopicsError, setSubtopicsError] = useState<string | null>(null);
  
  const [subjectCreationError, setSubjectCreationError] = useState<string | null>(null);
  const [topicCreationError, setTopicCreationError] = useState<string | null>(null);
  const [subtopicCreationError, setSubtopicCreationError] = useState<string | null>(null);

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
  const subtopicIdValue = watch("subtopic_id");
  const subjectRegister = register("subject_id");

  const matchedSubject = useMemo(() => {
    if (!subjectIdValue) return undefined;
    return subjects.find((subject) => subject.id === subjectIdValue);
  }, [subjects, subjectIdValue]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) return [];
    return topics.filter((topic) => topic.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const matchedTopic = useMemo(() => {
    if (!topicIdValue) return undefined;
    return filteredTopics.find((topic) => topic.id === topicIdValue);
  }, [filteredTopics, topicIdValue]);

  const filteredSubtopics = useMemo(() => {
    if (!matchedTopic) return [];
    return subtopics.filter((st) => st.topic_id === matchedTopic.id);
  }, [subtopics, matchedTopic]);

  const matchedSubtopic = useMemo(() => {
    if (!subtopicIdValue) return undefined;
    return filteredSubtopics.find((st) => st.id === subtopicIdValue);
  }, [filteredSubtopics, subtopicIdValue]);

  const { fields, append, remove } = useFieldArray({
    control,
    name: "questions",
  });

  useEffect(() => {
    let isMounted = true;
    const loadSubjects = async () => {
      setSubjectsLoading(true);
      try {
        const response = await fetch("/api/subjects");
        if (!response.ok) throw new Error("Failed to load subjects");
        const data = await response.json();
        if (isMounted) setSubjects(data.sort((a: any, b: any) => a.name.localeCompare(b.name)));
      } catch (err: any) {
        if (isMounted) setSubjectsError(err.message);
      } finally {
        if (isMounted) setSubjectsLoading(false);
      }
    };
    loadSubjects();
    return () => { isMounted = false; };
  }, []);

  useEffect(() => {
    let isMounted = true;
    const loadTopics = async () => {
      setTopicsLoading(true);
      try {
        const response = await fetch("/api/topics");
        if (!response.ok) throw new Error("Failed to load topics");
        const data = await response.json();
        if (isMounted) setTopics(data);
      } catch (err: any) {
        if (isMounted) setTopicsError(err.message);
      } finally {
        if (isMounted) setTopicsLoading(false);
      }
    };
    loadTopics();
    return () => { isMounted = false; };
  }, []);

  useEffect(() => {
    let isMounted = true;
    const loadSubtopics = async () => {
      setSubtopicsLoading(true);
      try {
        const response = await fetch("/api/subtopics");
        if (!response.ok) throw new Error("Failed to load subtopics");
        const data = await response.json();
        if (isMounted) setSubtopics(data);
      } catch (err: any) {
        if (isMounted) setSubtopicsError(err.message);
      } finally {
        if (isMounted) setSubtopicsLoading(false);
      }
    };
    loadSubtopics();
    return () => { isMounted = false; };
  }, []);

  const isQuestionComplete = (question?: any) => {
    if (!question) return false;
    return [question.content, question.option_a, question.option_b, question.option_c, question.option_d].every(v => v?.trim().length > 0) && Boolean(question.correct_option);
  };

  const generateFeedback = async (index: number) => {
    const question = getValues(`questions.${index}`);
    if (!isQuestionComplete(question)) {
      setFeedbackErrors(prev => ({ ...prev, [index]: "Fill all fields first." }));
      return;
    }
    setIsGenerating(index);
    try {
      const payload = { content: question.content, option_a: question.option_a, option_b: question.option_b, option_c: question.option_c, option_d: question.option_d, correct_option: question.correct_option };
      const response = await fetch("/api/generate-feedback", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      const text = await response.text();
      if (!response.ok) throw new Error(text);
      const parsed = parseExplanation(text);
      setValue(`questions.${index}.general_explanation`, parsed.text || "Generated.");
    } catch (err: any) {
      alert(err.message);
    } finally {
      setIsGenerating(null);
    }
  };

  const onSubmit: SubmitHandler<QuestionSetFormValues> = async (values) => {
    setSubmissionMessage(null);
    setSubmissionError(null);
    const payload = {
      topic_id: values.topic_id,
      subtopic_id: values.subtopic_id || undefined,
      title: values.title,
      difficulty_level: Number(values.difficulty_level),
      set_type: values.set_type,
      is_verified: values.is_verified,
      questions: values.questions.map((q, i) => ({
        id: q.id,
        order_number: i + 1,
        content: q.content,
        option_a: q.option_a,
        option_b: q.option_b,
        option_c: q.option_c,
        option_d: q.option_d,
        correct_option: q.correct_option,
        general_explanation: q.general_explanation?.trim() || undefined,
        exam_year: q.exam_year,
        paper_ref: q.paper_ref,
        language: q.language,
      })),
    };

    try {
      const response = await fetch("/api/question-sets", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || "Failed to save");
      setSubmissionMessage(`Saved set "${values.title}" (ID: ${data.id})`);
      reset(createDefaultFormValues());
    } catch (err: any) {
      setSubmissionError(err.message);
    }
  };

  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const handleImportQuestion = (q: any) => {
    append({ id: q.id, order_number: fields.length + 1, content: q.content, option_a: q.option_a, option_b: q.option_b, option_c: q.option_c, option_d: q.option_d, correct_option: q.correct_option as any, general_explanation: q.explanation || "", exam_year: q.exam_year || null, paper_ref: q.paper_ref || "", language: (q.language as any) || "nepali" });
    setIsSearchOpen(false);
  };

  return (
    <div className="container mx-auto py-8 max-w-6xl">
      <div className="flex justify-between items-center mb-10">
        <div>
            <h1 className="text-4xl font-black tracking-tight text-slate-900 border-b-4 border-blue-600 pb-2 inline-block">Create Question Set</h1>
            <p className="text-slate-500 mt-2 font-medium">Restructured 5-level hierarchy supported.</p>
        </div>
        <Button type="button" size="lg" variant="outline" className="rounded-full shadow-sm" onClick={() => setIsSearchOpen(true)}>
            <Search className="w-4 h-4 mr-2" /> Import Existing
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
            subjectsError={subjectsError}
            subjectCreationError={subjectCreationError}
            onSubjectChange={(e) => { subjectRegister.onChange(e); setValue("topic_id", ""); setValue("subtopic_id", null); }}
            onTopicChange={() => { setValue("subtopic_id", null); }}
            topicsLoading={topicsLoading}
            filteredTopics={filteredTopics}
            topicsError={topicsError}
            topicCreationError={topicCreationError}
            subtopicsLoading={subtopicsLoading}
            filteredSubtopics={filteredSubtopics}
            subtopicsError={subtopicsError}
            subtopicCreationError={subtopicCreationError}
            matchedTopic={matchedTopic}
            matchedSubject={matchedSubject}
            matchedSubtopic={matchedSubtopic}
            submissionMessage={submissionMessage}
            submissionError={submissionError}
        />

        <div className="space-y-6">
          <h2 className="text-2xl font-bold text-slate-800 flex items-center gap-3">
             Content Builder
             <span className="text-sm font-medium bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full">
               {fields.length} {fields.length === 1 ? 'Question' : 'Questions'}
             </span>
          </h2>
          <div className="space-y-8">
            {fields.map((field, index) => (
              <QuestionFormCard key={field.id} index={index} register={register} setValue={setValue} getValues={getValues} watch={watch} remove={remove} isGenerating={isGenerating} generateFeedback={generateFeedback} feedbackError={feedbackErrors[index]} isQuestionComplete={isQuestionComplete} />
            ))}
          </div>
        </div>

        <div className="flex gap-4 items-center justify-center py-10 border-t border-dashed border-slate-300">
            <Button type="button" variant="outline" size="lg" className="rounded-full px-8 h-14" disabled={fields.length >= MAX_QUESTIONS} onClick={() => append(createBlankQuestion(fields.length + 1))}>
              <Plus className="w-5 h-5 mr-2" /> Add New Question
            </Button>
            <Button type="submit" size="lg" className="rounded-full px-12 h-14 bg-blue-600 hover:bg-blue-700 text-white" disabled={subjectsLoading || topicsLoading || isSubmitting}>
              {isSubmitting ? <span className="flex items-center gap-2"><Loader2 className="w-5 h-5 animate-spin" /> Saving…</span> : "Submit Question Set"}
            </Button>
        </div>
      </form>

      <QuestionSearchModal isOpen={isSearchOpen} onClose={() => setIsSearchOpen(false)} onImport={handleImportQuestion} existingQuestionIds={[]} />
    </div>
  );
}
