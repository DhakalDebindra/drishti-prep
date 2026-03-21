"use client";

import { useMemo, useState, useEffect } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { puter } from "@heyputer/puter.js";

const PUTER_MODEL = process.env.NEXT_PUBLIC_PUTER_MODEL ?? "deepseek/deepseek-chat";
const PUTER_TIMEOUT_MS = 25000;

const withTimeout = <T,>(promise: Promise<T>, ms: number): Promise<T | { isTimeoutError: true }> =>
  new Promise((resolve) => {
    const timer = setTimeout(() => resolve({ isTimeoutError: true }), ms);
    promise
      .then((res) => {
        clearTimeout(timer);
        resolve(res);
      })
      .catch((err) => {
        clearTimeout(timer);
        resolve({ isTimeoutError: true });
      });
  });

const extractPuterContent = (result: any): string => {
  if (typeof result === "string") return result;
  
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

const normalizeJson = (str: string) => {
  const s = str.trim();
  if (s.startsWith("```json")) {
    const end = s.indexOf("```", 7);
    if (end > 7) return s.slice(7, end).trim();
  }
  if (s.startsWith("```")) {
    const end = s.indexOf("```", 3);
    if (end > 3) return s.slice(3, end).trim();
  }
  return s;
};

const generateGuestFeedbackLocally = async (answers: any[]) => {
  const prompt = `
**Role:**
You are an expert tutor providing constructive feedback for a student who just submitted a practice quiz.
You will be provided with an array of answers the student just submitted, including the question content, their selected option, the correct option, whether it was correct or not, and the authoritative factual "explanation" for that question.

**Task:**
Analyze the student's performance and provide:
1. "strengths": A short paragraph summarizing what they did well.
2. "weakZones": An object categorized by topic showing areas for improvement.
3. "explanations": An object mapping the \`question_id\` to a short string explanation of WHY the correct answer is right and why their wrong answer was wrong (only provide explanations for questions they answered INCORRECTLY). Use the provided authoritative "explanation" text to ensure your facts are completely accurate and contextually rich for Nepali exam prep.

IMPORTANT: Return ONLY a valid JSON object (no markdown fences, no extra prose). Schema:
{
  "strengths": string,
  "weakZones": Record<string, string>,
  "explanations": Record<string, string>
}

**Answers to Analyze:**
${JSON.stringify(answers, null, 2)}
`;

  const started = performance.now();
  const puterResult = await withTimeout(
    (puter.ai.chat(prompt, { model: PUTER_MODEL, stream: false }) as unknown) as Promise<any>,
    PUTER_TIMEOUT_MS
  );

  if (puterResult && typeof puterResult === "object" && "isTimeoutError" in puterResult) {
    throw new Error("AI response empty or invalid (Timeout)");
  }

  const puterText = extractPuterContent(puterResult);
  console.log("RAW PUTER TEXT:", puterText);
  let parsed: any = null;
  const cleaned = normalizeJson(puterText);
  try {
    if (cleaned) {
      parsed = JSON.parse(cleaned);
    }
  } catch {
    console.warn("Could not parse guest feedback JSON from puter", cleaned);
  }

  if (!parsed || typeof parsed !== "object") {
     throw new Error("AI response empty or invalid");
  }

  return {
    strengths: parsed.strengths ?? null,
    weakZones: parsed.weakZones ?? null,
    explanations: parsed.explanations ?? {},
    model: PUTER_MODEL,
    latency_ms: Math.round(performance.now() - started),
  };
};


export type DecoratedAnswer = {
  question_id: string;
  content?: string;
  option_a?: string;
  option_b?: string;
  option_c?: string;
  option_d?: string;
  selected_option: string | null;
  is_correct: boolean;
  correct_option: string;
  explanation: string | null;
};

export type PracticeReview = {
  attempt: {
    id: string;
    question_count: number;
    score_raw: number;
    score_pct: number;
    submitted_at?: string;
  };
  answers: DecoratedAnswer[];
  feedback: {
    strengths: string | null;
    weak_zones: Record<string, unknown> | null;
    explanations: Record<string, string> | null;
    model?: string | null;
    latency_ms?: number | null;
    cost_cents?: number | null;
  } | null;
};

type Question = {
  id: string;
  content: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: string;
  order_number: number;
  explanation: string | null;
};

 type AttemptSummary = {
  id: string;
  status: string;
  question_count: number | null;
  score_raw: number | null;
  score_pct: number | null;
  set_version: number | null;
};

type Props = {
  setInfo: {
    id: string;
    title: string;
    difficulty_level: number;
    version: number;
    topicId: string;
    topicName: string;
    subjectId: string;
    subjectName: string;
    is_verified: boolean;
  };
  questions: Question[];
  existingAttempt: AttemptSummary | null;
  existingAnswers: DecoratedAnswer[];
  initialReview: PracticeReview | null;
  userEmail: string | null;
};

const optionKeys = ["A", "B", "C", "D"] as const;

export default function PracticeSetClient({
  setInfo,
  questions,
  existingAttempt,
  existingAnswers,
  initialReview,
  userEmail,
}: Props) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [attemptId, setAttemptId] = useState<string | null>(existingAttempt?.id ?? null);
  const [status, setStatus] = useState<string>(existingAttempt?.status ?? "idle");
  const [saving, setSaving] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [answers, setAnswers] = useState<Record<string, string | null>>(() => {
    const map: Record<string, string | null> = {};
    existingAnswers.forEach((a) => (map[a.question_id] = a.selected_option));
    return map;
  });
  const [correctness, setCorrectness] = useState<Record<string, boolean>>(() => {
    const map: Record<string, boolean> = {};
    existingAnswers.forEach((a) => {
      if (a.selected_option) map[a.question_id] = a.is_correct;
    });
    return map;
  });
  const [review, setReview] = useState<PracticeReview | null>(initialReview);
  const [authRequired, setAuthRequired] = useState(false);
  const [showExplanation, setShowExplanation] = useState<Record<string, boolean>>(() => {
    const map: Record<string, boolean> = {};
    questions.forEach((q) => (map[q.id] = false));
    return map;
  });
  const [focusedOption, setFocusedOption] = useState<string | null>(null);
  const router = useRouter();

  useEffect(() => {
    setFocusedOption(null);
  }, [currentIndex]);

  // Prevent guest sessions from bleeding across attempts
  useEffect(() => {
    sessionStorage.removeItem("demoReviewData");
  }, []);

  const questionCount = useMemo(() => questions.length, [questions.length]);
  const currentQuestion = questions[currentIndex];
  const questionLabelId = currentQuestion ? `question-${currentQuestion.id}-label` : undefined;
  const answeredCount = useMemo(
    () => Object.values(answers).filter(Boolean).length,
    [answers]
  );
  const allAnswered = answeredCount >= questionCount && questionCount > 0;
  const currentAnswered = currentQuestion ? Boolean(answers[currentQuestion.id]) : false;

  const resetStateForNewAttempt = () => {
    setAnswers({});
    setCorrectness({});
    setStatus("idle");
    setAttemptId(null);
    setMessage(null);
    setError(null);
    setFocusedOption(null);
  };

  const ensureAttempt = async () => {
    if (!userEmail) throw new Error("Please log in to save your progress.");
    if (attemptId && status !== "submitted") return attemptId;

    setSaving(true);
    setError(null);
    const res = await fetch("/api/attempts", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ set_id: setInfo.id }),
    });
    setSaving(false);

    if (res.status === 401) {
      setAuthRequired(true);
      throw new Error("Please log in to save your progress.");
    }

    if (!res.ok) {
      const data = await res.json().catch(() => ({}));
      throw new Error(data.error || "Could not start attempt");
    }

    const data: AttemptSummary = await res.json();
    setAttemptId(data.id);
    setStatus(data.status ?? "in_progress");
    setAuthRequired(false);
    return data.id;
  };

  const handleSelect = async (questionId: string, option: string) => {
    if (status === "submitted") return;
    // Prevent multiple attempts on same question
    if (answers[questionId]) {
      setError("You have already answered this question.");
      return;
    }

    setError(null);
    setMessage(null);
    setAnswers((prev) => ({ ...prev, [questionId]: option }));

    if (!userEmail) {
      // Guest users handle selection offline
      const tQuestion = questions.find(q => q.id === questionId);
      const isCorrect = tQuestion ? tQuestion.correct_option === option : false;
      setCorrectness((prev) => ({ ...prev, [questionId]: isCorrect }));
      setStatus("in_progress");
      setShowExplanation((prev) => ({ ...prev, [questionId]: true }));
      return;
    }

    try {
      const id = await ensureAttempt();
      setSaving(true);
      const res = await fetch(`/api/attempts/${id}/answers`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ question_id: questionId, selected_option: option }),
      });
      const data = await res.json().catch(() => ({}));
      setSaving(false);
      if (res.status === 401) {
        setAuthRequired(true);
        throw new Error("Please log in to save your progress.");
      }
      if (!res.ok) {
        throw new Error(data.error || "Could not save answer");
      }
      setCorrectness((prev) => ({ ...prev, [questionId]: data.is_correct }));
      setStatus("in_progress");
      setShowExplanation((prev) => ({ ...prev, [questionId]: true }));
    } catch (err: any) {
      setError(err.message || "Failed to save answer");
    }
  };

  const handleSubmit = async () => {
    if (status === "submitted") return;
    
    // Guest submission flow
    if (!userEmail) {
      setSubmitting(true);
      setError(null);
      
      const payloadAnswers = questions.filter(q => answers[q.id]).map((q) => ({
        question_id: q.id,
        content: q.content,
        option_a: q.option_a,
        option_b: q.option_b,
        option_c: q.option_c,
        option_d: q.option_d,
        selected_option: answers[q.id],
        correct_option: q.correct_option,
        is_correct: correctness[q.id] || false,
        explanation: q.explanation
      }));

      try {
        const data = await generateGuestFeedbackLocally(payloadAnswers);

        const mockReview: PracticeReview = {
          attempt: {
            id: "guest-attempt",
            question_count: questionCount,
            score_raw: Object.values(correctness).filter(Boolean).length,
            score_pct: (Object.values(correctness).filter(Boolean).length / questionCount) * 100,
          },
          answers: payloadAnswers.map(a => ({ 
            ...a, 
            explanation: data.explanations?.[a.question_id] || null, 
            selected_option: a.selected_option || null,
            content: a.content,
            option_a: a.option_a,
            option_b: a.option_b,
            option_c: a.option_c,
            option_d: a.option_d
          })),
          feedback: {
            strengths: data.strengths || null,
            weak_zones: data.weakZones || null,
            explanations: data.explanations || null
          }
        };

        sessionStorage.setItem('demoReviewData', JSON.stringify(mockReview));
        setStatus("submitted");
        router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review`);
      } catch (err: any) {
         console.warn("DEMO MODE ERROR:", err.message);
         const mockReview: PracticeReview = {
           attempt: {
             id: "guest-attempt-fallback",
             question_count: questionCount,
             score_raw: Object.values(correctness).filter(Boolean).length,
             score_pct: (Object.values(correctness).filter(Boolean).length / questionCount) * 100,
           },
           answers: payloadAnswers.map(a => ({ 
             ...a, 
             explanation: null, 
             selected_option: a.selected_option || null,
             content: a.content,
             option_a: a.option_a,
             option_b: a.option_b,
             option_c: a.option_c,
             option_d: a.option_d
           })),
           feedback: null
         };
         sessionStorage.setItem('demoReviewData', JSON.stringify(mockReview));
         setStatus("submitted");
         router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review`);
         return;
      } finally {
        setSubmitting(false);
      }
      return;
    }

    if (!attemptId) {
      try {
        await ensureAttempt();
      } catch (err: any) {
        setError(err.message || "Unable to start attempt");
        return;
      }
    }

    const id = attemptId;
    if (!id) return;
    setSubmitting(true);
    setError(null);
    try {
      const res = await fetch(`/api/attempts/${id}/submit`, { method: "POST" });
      const data = await res.json().catch(() => ({}));
      setSubmitting(false);
      if (res.status === 401) {
        setAuthRequired(true);
        throw new Error("Please log in to submit.");
      }
      if (!res.ok) {
        throw new Error(data.error || "Submit failed");
      }
      setStatus("submitted");
      router.push(`/practice/${setInfo.subjectName}/${setInfo.topicName}/${setInfo.id}/review?attemptId=${id}`);
    } catch (err: any) {
      setSubmitting(false);
      setError(err.message || "Submit failed");
    }
  };

  const startNewAttempt = () => {
    resetStateForNewAttempt();
  };

  const goPrev = () => setCurrentIndex((i) => Math.max(0, i - 1));
  const goNext = () => setCurrentIndex((i) => Math.min(questionCount - 1, i + 1));
  const toggleExplanation = (id: string) =>
    setShowExplanation((prev) => ({ ...prev, [id]: !prev[id] }));

  return (
    <section className="space-y-6">
      <div className="flex items-center gap-2 text-sm text-gray-500" aria-label="Breadcrumb">
        <Link href="/practice" className="text-blue-700 hover:text-blue-900">
          Practice
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${setInfo.subjectName}`}
          className="text-blue-700 hover:text-blue-900"
        >
          {setInfo.subjectName}
        </Link>
        <span aria-hidden="true">/</span>
        <Link
          href={`/practice/${setInfo.subjectName}/${setInfo.topicName}`}
          className="text-blue-700 hover:text-blue-900"
        >
          {setInfo.topicName}
        </Link>
        <span aria-hidden="true">/</span>
        <span className="text-gray-700" aria-current="page">
          {setInfo.title}
        </span>
      </div>

      <header className="space-y-2">
        <p className="text-sm uppercase tracking-wide text-gray-500">Quiz (untimed)</p>
        <h1 className="text-2xl font-semibold text-gray-900">{setInfo.title}</h1>
        <p className="text-gray-600">Difficulty {setInfo.difficulty_level} • Version {setInfo.version} • {setInfo.is_verified ? "Verified" : "Unverified"}</p>
        {message && <p className="rounded-md bg-emerald-50 px-3 py-2 text-sm text-emerald-700">{message}</p>}
        {error && <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">{error}</p>}
        {authRequired && (
          <p className="rounded-md bg-yellow-50 px-3 py-2 text-sm text-yellow-800">
            Please log in to save answers and submit. Your selections stay local until you sign in.
          </p>
        )}
        {!userEmail && !authRequired && (
          <p className="text-sm text-gray-600">
            You are browsing as a guest. Start answering to be prompted to sign in when saving.
          </p>
        )}
      </header>

      {currentQuestion && (
        <Card className={status === "submitted" ? "opacity-90" : ""}>
          <CardHeader>
            <CardTitle className="text-lg">
              Question {currentIndex + 1} of {questionCount}
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <p id={questionLabelId} className="text-base text-gray-900">
              {currentQuestion.content}
            </p>
            <div 
              className="space-y-3" 
              role="radiogroup" 
              aria-labelledby={questionLabelId}
              onKeyDown={(e) => {
                const target = e.target as HTMLElement;
                if (target.role !== "radio") return;

                if (["ArrowDown", "ArrowRight", "ArrowUp", "ArrowLeft"].includes(e.key)) {
                  e.preventDefault();
                  
                  const buttons = Array.from(e.currentTarget.querySelectorAll('[role="radio"]')) as HTMLButtonElement[];
                  const currentIdx = buttons.indexOf(target as HTMLButtonElement);
                  if (currentIdx === -1) return;

                  let nextIndex = currentIdx;
                  if (e.key === "ArrowDown" || e.key === "ArrowRight") {
                    nextIndex = (currentIdx + 1) % buttons.length;
                  } else if (e.key === "ArrowUp" || e.key === "ArrowLeft") {
                    nextIndex = (currentIdx - 1 + buttons.length) % buttons.length;
                  }

                  buttons[nextIndex].focus();
                }
              }}
            >
              {optionKeys.map((key) => {
                const value = currentQuestion[`option_${key.toLowerCase() as "a" | "b" | "c" | "d"}`];
                const selected = answers[currentQuestion.id];
                const isSelected = selected === key;
                const isCorrectOption = currentQuestion.correct_option === key;
                const isAnswered = selected != null;
                const disabled = status === "submitted" || Boolean(answers[currentQuestion.id]);
                const optionLabelId = `option-${currentQuestion.id}-${key}-label`;
                const labelledBy = optionLabelId;
                
                const isTabbable = 
                  focusedOption === key || 
                  isSelected || 
                  (!answers[currentQuestion.id] && !focusedOption && key === "A");

                return (
                  <button
                    key={key}
                    type="button"
                    role="radio"
                    aria-checked={isSelected}
                    aria-labelledby={labelledBy}
                    disabled={disabled}
                    tabIndex={disabled ? undefined : (isTabbable ? 0 : -1)}
                    onFocus={() => setFocusedOption(key)}
                    onClick={() => {
                      if (!disabled) handleSelect(currentQuestion.id, key);
                    }}
                    className={`w-full rounded-md border p-3 text-left transition focus:outline-none focus:ring-2 focus:ring-blue-400 ${
                      isSelected
                        ? "border-blue-400 bg-blue-50"
                        : "border-gray-200 hover:border-blue-200 hover:bg-gray-50"
                    } ${status === "submitted" && isCorrectOption ? "border-emerald-300" : ""} ${
                      disabled ? "cursor-not-allowed opacity-90" : "cursor-pointer"
                    }`}
                  >
                    <div className="flex items-start gap-3">
                      <span
                        aria-hidden="true"
                        className={`mt-1 h-5 w-5 rounded-full border ${
                          isSelected ? "border-blue-500 bg-blue-500" : "border-gray-300"
                        }`}
                      />
                      <div className="space-y-1">
                        <p id={optionLabelId} className="text-gray-900">
                          <span className="mr-2 font-semibold">{key}.</span>
                          {value}
                        </p>
                        {isAnswered && (
                          <p
                            className={`text-xs font-semibold ${
                              isCorrectOption
                                ? "text-emerald-700"
                                : isSelected
                                  ? "text-orange-700"
                                  : "text-gray-500"
                            }`}
                          >
                            {isCorrectOption
                              ? "Correct answer"
                              : isSelected
                                ? "Your choice (incorrect)"
                                : ""}
                          </p>
                        )}
                      </div>
                    </div>
                  </button>
                );
              })}
            </div>

            {answers[currentQuestion.id] && status !== "submitted" && (
              <p
                className={`text-sm font-medium ${
                  correctness[currentQuestion.id] ? "text-emerald-700" : "text-orange-700"
                }`}
              >
                {correctness[currentQuestion.id] ? "Right!" : "Wrong — try the next one or review the explanation."}
              </p>
            )}

            <div className="border-t pt-3">
              <button
                type="button"
                className="text-sm font-semibold text-blue-700 hover:text-blue-900"
                onClick={() => toggleExplanation(currentQuestion.id)}
              >
                {showExplanation[currentQuestion.id] ? "Hide explanation" : "Show explanation"}
              </button>
              {showExplanation[currentQuestion.id] && (
                <div className="mt-2 rounded-md bg-gray-50 p-3 text-sm text-gray-800">
                  <p className="font-semibold text-gray-900">Explanation</p>
                  <p className="text-gray-700">
                    {currentQuestion.explanation ||
                      "No explanation available."}
                  </p>
                  <p className="mt-2 text-xs text-gray-600">
                    Your choice: {answers[currentQuestion.id] ?? "—"} | Correct: {currentQuestion.correct_option}
                  </p>
                </div>
              )}
            </div>

            <div className="flex items-center justify-between pt-4">
              <Button variant="outline" onClick={goPrev} disabled={currentIndex === 0}>
                Previous
              </Button>
              <div className="flex items-center gap-2 text-sm text-gray-600">
                <span>Q {currentIndex + 1}</span>
                <span>•</span>
                <span>Answered {answeredCount}/{questionCount}</span>
              </div>
              {currentIndex === questionCount - 1 ? (
                <Button
                  variant="outline"
                  onClick={handleSubmit}
                  disabled={status === "submitted" || submitting || saving || !allAnswered}
                >
                  {submitting ? "Submitting..." : status === "submitted" ? "Submitted" : !userEmail ? "Submit & See Demo Feedback" : "Done"}
                </Button>
              ) : (
                <Button
                  variant="outline"
                  onClick={goNext}
                  disabled={currentIndex === questionCount - 1 || !currentAnswered}
                >
                  Next
                </Button>
              )}
            </div>
          </CardContent>
        </Card>
      )}

      <div className="flex flex-wrap gap-3">
        {/* Keep a secondary Done button hidden when using the inline Done above */}
        {currentIndex !== questionCount - 1 && (
          <Button
            onClick={handleSubmit}
            disabled={status === "submitted" || submitting || saving || !allAnswered}
          >
            {submitting ? "Submitting..." : status === "submitted" ? "Submitted" : !userEmail ? "Submit & See Demo Feedback" : "Done"}
          </Button>
        )}
      </div>
    </section>
  );
}



