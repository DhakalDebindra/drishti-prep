"use client";

import { useEffect, useId, useMemo, useState } from "react";
import { puter } from "@heyputer/puter.js";
import { useForm, useFieldArray, type SubmitHandler } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";

const MAX_QUESTIONS = 20;

const questionSchema = z.object({
  order_number: z.number().min(1).max(20),
  content: z.string().min(1, "Question content is required"),
  option_a: z.string().min(1, "Option A is required"),
  option_b: z.string().min(1, "Option B is required"),
  option_c: z.string().min(1, "Option C is required"),
  option_d: z.string().min(1, "Option D is required"),
  correct_option: z.enum(["A", "B", "C", "D"]),
  general_explanation: z.string().optional(),
});

const questionSetSchema = z.object({
  subject_lookup: z.string().min(1, "Subject is required"),
  topic_lookup: z.string().min(1, "Topic is required"),
  title: z.string().min(1, "Title is required"),
  difficulty_level: z.coerce.number().min(1).max(3),
  is_verified: z.boolean().default(false),
  questions: z.array(questionSchema).min(1, "At least one question is required").max(20),
});

type QuestionSetFormValues = z.infer<typeof questionSetSchema>;
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

const createBlankQuestion = (order_number: number) => ({
  order_number,
  content: "",
  option_a: "",
  option_b: "",
  option_c: "",
  option_d: "",
  correct_option: "A" as const,
  general_explanation: "",
});

const createDefaultFormValues = (): QuestionSetFormValues => ({
  subject_lookup: "",
  topic_lookup: "",
  title: "",
  difficulty_level: 1,
  is_verified: false,
  questions: [createBlankQuestion(1)],
});

const defaultFormValues = createDefaultFormValues();

const PUTER_MODEL = process.env.NEXT_PUBLIC_PUTER_MODEL ?? "deepseek/deepseek-chat";
const PUTER_TIMEOUT_MS = 25_000;
const FALLBACK_TIMEOUT_MS = 25_000;

const withTimeout = <T,>(promise: Promise<T>, ms: number) =>
  new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("TIMEOUT")), ms);
    promise
      .then((res) => {
        clearTimeout(timer);
        resolve(res);
      })
      .catch((err) => {
        clearTimeout(timer);
        reject(err);
      });
  });

const normalizeJson = (text: string) => {
  if (!text) return text;
  let cleaned = text.trim();
  if (cleaned.startsWith("```")) {
    cleaned = cleaned.replace(/^```json\s*/i, "").replace(/^```\s*/i, "");
    cleaned = cleaned.replace(/```$/, "").trim();
  }
  const first = cleaned.indexOf("{");
  const last = cleaned.lastIndexOf("}");
  if (first !== -1 && last !== -1 && last > first) {
    cleaned = cleaned.slice(first, last + 1);
  }
  return cleaned;
};

const extractPuterContent = (result: any): string => {
  const content =
    result?.message?.content ??
    (Array.isArray(result?.messages) ? result.messages.at(-1)?.content : undefined) ??
    (Array.isArray(result?.choices) ? result.choices[0]?.message?.content : undefined) ??
    result?.output_text ??
    result?.result ??
    "";
  if (typeof content === "string") return content;
  return JSON.stringify(content ?? "");
};

const parseExplanation = (raw: string): { text: string; parseError: boolean } => {
  const cleaned = normalizeJson(raw);
  if (!cleaned) return { text: raw?.trim() ?? "", parseError: true };
  try {
    const parsed = JSON.parse(cleaned);
    const text =
      (parsed.general_explanation || parsed.explanation || "").trim();
    if (text) return { text, parseError: false };
  } catch {
    // fall through
  }
  return { text: cleaned.trim() || raw.trim(), parseError: true };
};

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
    resolver: zodResolver(questionSetSchema),
    defaultValues: defaultFormValues,
  });

  const topicListId = useId();
  const subjectListId = useId();
  const topicLookupValue = watch("topic_lookup");
  const subjectLookupValue = watch("subject_lookup");
  const subjectRegister = register("subject_lookup");
  const questionsWatch = watch("questions");
  const matchedSubject = useMemo(() => {
    const normalizedValue = subjectLookupValue?.trim().toLowerCase();
    if (!normalizedValue) {
      return undefined;
    }
    return subjects.find((subject) => subject.name.toLowerCase() === normalizedValue);
  }, [subjects, subjectLookupValue]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) {
      return topics;
    }
    return topics.filter((topic) => topic.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const matchedTopic = useMemo(() => {
    const normalizedValue = topicLookupValue?.trim().toLowerCase();
    if (!normalizedValue) {
      return undefined;
    }
    return filteredTopics.find(
      (topic) => topic.name.toLowerCase() === normalizedValue
    );
  }, [filteredTopics, topicLookupValue]);

  useEffect(() => {
    if (
      matchedTopic?.subject_name &&
      !subjectTouched &&
      !subjectLookupValue?.trim()
    ) {
      setValue("subject_lookup", matchedTopic.subject_name);
    }
  }, [matchedTopic, subjectLookupValue, setValue, subjectTouched]);

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
        if (!getValues("topic_lookup") && data.length > 0) {
          setValue("topic_lookup", data[0].name);
        }
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

  const resolveTopicId = async (inputValue: string, subjectId: string) => {
    const trimmedValue = inputValue.trim();
    if (!trimmedValue) {
      throw new Error("Please select or type a topic name.");
    }
    if (!subjectId) {
      throw new Error("Subject must be selected before choosing a topic.");
    }

    const matchedTopic = topics.find(
      (topic) =>
        topic.name.toLowerCase() === trimmedValue.toLowerCase() &&
        topic.subject_id === subjectId
    );
    if (matchedTopic) {
      return matchedTopic.id;
    }

    setIsCreatingTopic(true);
    try {
      const response = await fetch("/api/topics", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ name: trimmedValue, subject_id: subjectId }),
      });

      const payload = await response.json();
      if (!response.ok) {
        throw new Error(payload?.error ?? "Failed to create topic");
      }

      const newTopic: TopicOption = payload;
      setTopics((prev) => {
        if (prev.some((topic) => topic.id === newTopic.id)) {
          return prev;
        }
        return [...prev, newTopic].sort((a, b) => a.name.localeCompare(b.name));
      });

      return newTopic.id;
    } finally {
      setIsCreatingTopic(false);
    }
  };

  const resolveSubjectId = async (inputValue: string) => {
    const trimmedValue = inputValue.trim();
    if (!trimmedValue) {
      throw new Error("Please select or type a subject name.");
    }

    const matchedSubject = subjects.find(
      (subject) => subject.name.toLowerCase() === trimmedValue.toLowerCase()
    );
    if (matchedSubject) {
      return matchedSubject.id;
    }

    setIsCreatingSubject(true);
    try {
      const response = await fetch("/api/subjects", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ name: trimmedValue }),
      });

      const payload = await response.json();
      if (!response.ok) {
        throw new Error(payload?.error ?? "Failed to create subject");
      }

      const newSubject: SubjectOption = payload;

      setSubjects((prev) => {
        if (prev.some((subject) => subject.id === newSubject.id)) {
          return prev;
        }
        return [...prev, newSubject].sort((a, b) => a.name.localeCompare(b.name));
      });

      return newSubject.id;
    } finally {
      setIsCreatingSubject(false);
    }
  };

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

      const prompt = `
**Role:**
You are an expert Loksewa (Public Service Commission of Nepal) General Knowledge (GK) facilitator and instructor. Your primary goal is to prepare competitive exam aspirants by providing deeply informative, context-rich explanations for given Multiple Choice Questions (MCQs).

**Task:**
You will be provided with a Question, its Options, and the Correct Option. You must provide a comprehensive explanation in formal, grammatically correct Nepali.
IMPORTANT: Return ONLY a valid JSON object (no markdown fences, no extra prose). Schema:
{
  "general_explanation": "string"
}

**Instructions for the "general_explanation" Section:**
- Do not just state the right answer. Provide a rich context just like a real Loksewa facilitator would in a classroom.
- Always include related supplementary facts (e.g., exact dates of the event, themes, key participants, previous iterations, or historical significance) because Loksewa exams frequently test candidates on these peripheral details.
- Keep the tone educational, highly factual, accurate, and precise.

**CONTENT:**
- Question: ${payload.content}
- Option A: ${payload.option_a}
- Option B: ${payload.option_b}
- Option C: ${payload.option_c}
- Option D: ${payload.option_d}
- Correct Option: ${payload.correct_option}

**Reference Example of desired explanation style:**
If Question: International AI Impact Summit २०२६ कहाँ आयोजना भएको थियो?
And Options: A. Tokyo, B. New Delhi, C. London, D. Paris
And Correct Option: B
Your general_explanation string should be: "यो सम्मेलन भारतको नयाँ दिल्लीमा सन् २०२६ फेब्रुअरी १६ देखि २१ सम्म आयोजना गरिएको थियो। यसमा १०० भन्दा बढी देशका प्रतिनिधिहरु सहभागी भएका थिए। यस सम्मेलनको मुख्य उद्देश्य कृत्रिम बुद्धिमत्ता (AI) को सुरक्षित र जिम्मेवार प्रयोगका लागि विश्वव्यापी मापदण्ड तय गर्नु र यसले मानव जीवनमा पार्ने प्रभावको बारेमा छलफल गर्नु थियो।"

Return only JSON; must parse with JSON.parse without trimming.`;

      let explanation = "";
      let usedFallback = false;

      try {
        const startedPuter = performance.now();
        const puterResult = await withTimeout(
          puter.ai.chat(prompt, { model: PUTER_MODEL, stream: false }),
          PUTER_TIMEOUT_MS
        );
        const puterText = extractPuterContent(puterResult);
        const parsed = parseExplanation(puterText);
        explanation = parsed.text;
        if (parsed.parseError && process.env.NODE_ENV === "development") {
          console.warn("Puter parse fallback; raw:", puterText);
        }
        if (!explanation && process.env.NODE_ENV === "development") {
          console.warn(
            "Puter returned empty explanation in",
            Math.round(performance.now() - startedPuter),
            "ms"
          );
        }
      } catch (err) {
        if (process.env.NODE_ENV === "development") {
          console.warn("Puter call failed, will fall back:", err);
        }
      }

      // If Puter failed to produce explanation, fall back to backend
      if (!explanation || explanation.toLowerCase().includes("ai response was empty")) {
        usedFallback = true;
        const controller = new AbortController();
        const fallbackTimeout = setTimeout(() => controller.abort(), FALLBACK_TIMEOUT_MS);
        const response = await fetch("/api/generate-feedback", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
          signal: controller.signal,
        }).catch((err) => {
          clearTimeout(fallbackTimeout);
          throw err;
        });
        clearTimeout(fallbackTimeout);

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
        explanation = parsed.text || "Could not generate explanation.";
        if (parsed.parseError && process.env.NODE_ENV === "development") {
          console.warn("Fallback parse fallback; raw:", responseText);
        }
      }

      if (!explanation) {
        throw new Error("Failed to generate feedback: Empty explanation from AI");
      }

      if (usedFallback && process.env.NODE_ENV === "development") {
        console.warn("Used OpenAI fallback for explanation");
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

    let subjectId: string;
    try {
      subjectId = await resolveSubjectId(values.subject_lookup);
    } catch (error) {
      const message = error instanceof Error ? error.message : "Unable to resolve subject";
      setSubjectCreationError(message);
      console.error("Subject creation error:", error);
      return;
    }

    if (!subjectId) {
      const message = "Unable to resolve the subject ID for this set.";
      setSubjectCreationError(message);
      console.error("Subject ID not found for:", values.subject_lookup);
      return;
    }

    let topicId: string;
    try {
      topicId = await resolveTopicId(values.topic_lookup, subjectId);
    } catch (error) {
      const message = error instanceof Error ? error.message : "Unable to resolve topic";
      setTopicCreationError(message);
      console.error("Topic creation error:", error);
      return;
    }

    if (!topicId) {
      const message = "Unable to resolve the topic ID for this set.";
      setTopicCreationError(message);
      console.error("Topic ID not found for:", values.topic_lookup);
      return;
    }

    const payload = {
      topic_id: topicId,
      title: values.title,
      difficulty_level: Number(values.difficulty_level),
      is_verified: values.is_verified,
      questions: values.questions.map((question, index) => ({
        order_number: Number(question.order_number ?? index + 1),
        content: question.content,
        option_a: question.option_a,
        option_b: question.option_b,
        option_c: question.option_c,
        option_d: question.option_d,
        correct_option: question.correct_option,
        general_explanation:
          question.general_explanation?.trim() ? question.general_explanation : undefined,
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

  return (
    <div className="container mx-auto py-8">
      <h1 className="text-3xl font-bold mb-8">Create New Question Set</h1>
      
      <form onSubmit={handleSubmit(onSubmit)} className="space-y-8">
        <Card>
          <CardHeader>
            <CardTitle>Set details</CardTitle>
          </CardHeader>
          <CardContent className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="title">Title</Label>
              <Input id="title" {...register("title")} placeholder="E.G. नेपालको भूगोल Set 1" />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="difficulty_level">Difficulty Level (1-3)</Label>
              <Input
                id="difficulty_level"
                type="number"
                min="1"
                max="3"
                {...register("difficulty_level")}
              />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="subject_lookup">Subject (select or add new)</Label>
              <div className="relative">
                <Input
                  id="subject_lookup"
                  list={subjectListId}
                  placeholder="Select or type a subject"
                  {...subjectRegister}
                  onChange={(event) => {
                    subjectRegister.onChange(event);
                    setSubjectTouched(true);
                  }}
                  disabled={subjectsLoading || isCreatingSubject}
                  autoComplete="off"
                />
                <datalist id={subjectListId}>
                  {subjects.map((subject) => (
                    <option key={subject.id} value={subject.name} label={subject.name} />
                  ))}
                </datalist>
              </div>
              {subjectsError && (
                <p className="text-sm text-destructive">{subjectsError}</p>
              )}
              {subjectCreationError && (
                <p className="text-sm text-destructive">{subjectCreationError}</p>
              )}
              {errors.subject_lookup && (
                <p className="text-sm text-destructive">{errors.subject_lookup.message}</p>
              )}
              <p className="text-xs text-muted-foreground">
                Pick an existing subject or type a new one. New subjects are created automatically when you save the set.
              </p>
              {matchedSubject && (
                <p className="text-xs text-muted-foreground">
                  Existing subject "{matchedSubject.name}" will be reused.
                </p>
              )}
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="topic_lookup">Topic (select or add new)</Label>
              <div className="relative">
                <Input
                  id="topic_lookup"
                  list={topicListId}
                  placeholder="Select or type a topic name"
                  {...register("topic_lookup")}
                  disabled={topicsLoading}
                  autoComplete="off"
                />
                <datalist id={topicListId}>
                  {filteredTopics.map((topic) => (
                    <option
                      key={topic.id}
                      value={topic.name}
                      label={
                        topic.subject_name
                          ? `${topic.name} (${topic.subject_name})`
                          : topic.name
                      }
                    />
                  ))}
                </datalist>
              </div>
              {topicsError && (
                <p className="text-sm text-destructive">{topicsError}</p>
              )}
              {topicCreationError && (
                <p className="text-sm text-destructive">{topicCreationError}</p>
              )}
              {errors.topic_lookup && (
                <p className="text-sm text-destructive">{errors.topic_lookup.message}</p>
              )}
              {matchedTopic?.subject_name && (
                <p className="text-xs text-muted-foreground">
                  Subject: {matchedTopic.subject_name}
                </p>
              )}
              <p className="text-xs text-muted-foreground">
                Pick an existing topic or type a new one. New topics are created automatically under the selected subject when you save the set.
              </p>
              {matchedSubject && filteredTopics.length === 0 && (
                <p className="text-xs text-muted-foreground">
                  No topics exist for "{matchedSubject.name}" yet; type a new topic to create one.
                </p>
              )}
              {submissionMessage && (
                <p className="text-sm text-emerald-700">{submissionMessage}</p>
              )}
              {submissionError && (
                <p className="text-sm text-destructive">{submissionError}</p>
              )}
            </div>

            <div className="flex items-center space-x-2 pt-8">
              <input 
                type="checkbox"
                id="is_verified"
                {...register("is_verified")}
                className="w-4 h-4"
              />
              <Label htmlFor="is_verified">Mark as Verified (Publishes the set)</Label>
            </div>
          </CardContent>
        </Card>

        <div className="space-y-8">
          {fields.map((field, index) => (
            <Card key={field.id} className="border-l-4 border-l-blue-500">
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>Question {index + 1}</CardTitle>
                <Button variant="destructive" size="sm" type="button" onClick={() => remove(index)}>
                  Remove Question
                </Button>
              </CardHeader>
              <CardContent className="space-y-6">
                
                {/* Hidden Order Number */}
                <input type="hidden" {...register(`questions.${index}.order_number` as const)} value={index + 1} />

                <div className="space-y-2">
                  <Label>Question Content</Label>
                  <Textarea {...register(`questions.${index}.content` as const)} placeholder="Enter the main question..." className="min-h-[100px]" />
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {/* Options */}
                  <div className="space-y-4">
                    <h3 className="font-semibold text-lg">MCQ Options</h3>
                    
                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <Label>Option A</Label>
                        <input type="radio" value="A" {...register(`questions.${index}.correct_option` as const)} className="w-4 h-4 ml-2" title="Mark as correct" />
                      </div>
                      <Input {...register(`questions.${index}.option_a` as const)} placeholder="Option A text..." />
                    </div>

                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <Label>Option B</Label>
                        <input type="radio" value="B" {...register(`questions.${index}.correct_option` as const)} className="w-4 h-4 ml-2" title="Mark as correct" />
                      </div>
                      <Input {...register(`questions.${index}.option_b` as const)} placeholder="Option B text..." />
                    </div>

                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <Label>Option C</Label>
                        <input type="radio" value="C" {...register(`questions.${index}.correct_option` as const)} className="w-4 h-4 ml-2" title="Mark as correct" />
                      </div>
                      <Input {...register(`questions.${index}.option_c` as const)} placeholder="Option C text..." />
                    </div>

                    <div className="space-y-2">
                      <div className="flex justify-between items-center">
                        <Label>Option D</Label>
                        <input type="radio" value="D" {...register(`questions.${index}.correct_option` as const)} className="w-4 h-4 ml-2" title="Mark as correct" />
                      </div>
                      <Input {...register(`questions.${index}.option_d` as const)} placeholder="Option D text..." />
                    </div>
                    
                  </div>

                  {/* Master Explanation */}
                  <div className="space-y-4">
                    <div className="flex justify-between items-center">
                      <h3 className="font-semibold text-lg">Master Explanation</h3>
                      <Button
                        type="button"
                        variant="default"
                        size="sm"
                        disabled={
                          isGenerating === index ||
                          !isQuestionComplete(questionsWatch?.[index])
                        }
                        onClick={() => generateFeedback(index)}
                      >
                        {isGenerating === index ? "Generating with GPT..." : "Generate Explanation (AI)"}
                      </Button>
                    </div>

                    <div className="space-y-2">
                      <Label>GK Feedback</Label>
                      <Textarea 
                        {...register(`questions.${index}.general_explanation` as const)} 
                        placeholder="Wait for AI or type manually..." 
                        className="bg-slate-50 border-blue-200" 
                        rows={5}
                      />
                      {feedbackErrors[index] && (
                        <p className="text-sm text-destructive">{feedbackErrors[index]}</p>
                      )}
                    </div>
                  </div>
                </div>

              </CardContent>
            </Card>
          ))}
        </div>

        <div className="flex gap-4 items-center">
            <Button
              type="button"
              variant="outline"
              disabled={fields.length >= MAX_QUESTIONS}
              title={fields.length >= MAX_QUESTIONS ? "Question sets support up to 20 questions" : undefined}
              onClick={() => {
                if (fields.length >= MAX_QUESTIONS) return;
                append(createBlankQuestion(fields.length + 1));
              }}
            >
            Add Another Question
          </Button>

          <Button
            type="submit"
            size="lg"
            className="ml-auto"
            disabled={
              topicsLoading || isCreatingTopic || Boolean(topicsError) || isSubmitting
            }
          >
            {isCreatingTopic || isSubmitting ? "Saving…" : "Save Question Set"}
          </Button>
        </div>

      </form>
    </div>
  );
}
