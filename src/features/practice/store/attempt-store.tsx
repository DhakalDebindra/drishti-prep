import React, { createContext, useContext, useReducer, ReactNode, useMemo, useEffect } from "react";
import { usePracticeSet } from "@/hooks/usePracticeSet";
import type { DecoratedAnswer, Question } from "@/types/practice";

// --- Types ---

interface Answer {
  question_id: string;
  selected_option: string;
  is_correct?: boolean;
}

interface AttemptState {
  currentIndex: number;
  attemptId: string | null;
  answers: Record<string, Answer>; 
  correctness: Record<string, boolean>;
  showExplanation: Record<string, boolean>;
  error: string | null;
  message: string | null;
  status: string;
  authRequired: boolean;
  announcementText: string;
}

type AttemptAction =
  | { type: "SET_INDEX"; payload: number }
  | { type: "SAVE_ANSWER"; payload: Answer }
  | { type: "TOGGLE_EXPLANATION"; payload: string }
  | { type: "SET_ERROR"; payload: string | null }
  | { type: "SET_STATUS"; payload: string }
  | { type: "SET_AUTH_REQUIRED"; payload: boolean }
  | { type: "SET_ATTEMPT_ID"; payload: string }
  | { type: "RESET_STORE" };

// --- Reducer ---

const initialState: AttemptState = {
  currentIndex: 0,
  attemptId: null,
  answers: {},
  correctness: {},
  showExplanation: {},
  error: null,
  message: null,
  status: "idle",
  authRequired: false,
  announcementText: "",
};

function attemptReducer(state: AttemptState, action: AttemptAction): AttemptState {
  switch (action.type) {
    case "SET_INDEX":
      return { ...state, currentIndex: action.payload };
    case "SAVE_ANSWER":
      return {
        ...state,
        answers: { ...state.answers, [action.payload.question_id]: action.payload },
        correctness: { ...state.correctness, [action.payload.question_id]: !!action.payload.is_correct },
        announcementText: action.payload.selected_option === "skipped" 
          ? `Question ${state.currentIndex + 1} skipped` 
          : `Question ${state.currentIndex + 1}: Selected option ${action.payload.selected_option}. ${action.payload.is_correct ? 'Correct' : 'Incorrect'}`,
      };
    case "TOGGLE_EXPLANATION":
      return {
        ...state,
        showExplanation: { ...state.showExplanation, [action.payload]: !state.showExplanation[action.payload] }
      };
    case "SET_ERROR":
      return { ...state, error: action.payload };
    case "SET_STATUS":
      return { ...state, status: action.payload };
    case "SET_AUTH_REQUIRED":
      return { ...state, authRequired: action.payload };
    case "SET_ATTEMPT_ID":
      return { ...state, attemptId: action.payload };
    case "RESET_STORE":
      return initialState;
    default:
      return state;
  }
}

// --- Context ---

const AttemptContext = createContext<any>(null);

export function AttemptProvider({ 
  children, questions, setInfo, userEmail, existingAnswers, existingAttempt
}: { 
  children: ReactNode; questions: Question[]; setInfo: any; userEmail: string | null; existingAnswers: DecoratedAnswer[]; existingAttempt?: any; 
}) {
  const [state, dispatch] = useReducer(
    attemptReducer,
    undefined,
    () => {
      let initialIndex = 0;
      if (existingAnswers && existingAnswers.length > 0) {
        const firstUnansweredIndex = questions.findIndex(q => {
          const ans = existingAnswers.find(a => a.question_id === q.id);
          return !ans || ans.selected_option === null;
        });
        initialIndex = firstUnansweredIndex !== -1 ? firstUnansweredIndex : Math.max(0, questions.length - 1);
      }

      return {
        ...initialState,
        currentIndex: initialIndex,
        attemptId: existingAttempt?.id || null,
        status: existingAttempt?.status || "idle",
        answers: (existingAnswers || []).filter((a: any) => a.selected_option !== null).reduce((acc: any, curr: any) => ({
          ...acc, 
          [curr.question_id]: { 
            question_id: curr.question_id, 
            selected_option: curr.selected_option, 
            is_correct: curr.is_correct 
          }
        }), {}),
        correctness: (existingAnswers || []).filter((a: any) => a.selected_option !== null).reduce((acc: any, curr: any) => ({
          ...acc,
          [curr.question_id]: !!curr.is_correct
        }), {}),
      };
    }
  );

  const derived = useMemo(() => {
  const answerValues = Object.values(state.answers) as any[];

  return {
    currentQuestion: questions[state.currentIndex] || null,
    questionCount: questions.length,
    // Count only real answers (A, B, C, D), excluding "skipped"
    answeredCount: answerValues.filter((a: any) => 
      a !== null && a.selected_option && a.selected_option !== "skipped"
    ).length,
    // Count only "skipped" entries
    skippedCount: answerValues.filter((a: any) => 
      a?.selected_option === "skipped"
    ).length,
    // Total handled is the count of all keys compared to question list
    allHandled: Object.keys(state.answers).length === questions.length,
    progress: questions.length > 0 ? ((state.currentIndex + 1) / questions.length) * 100 : 0,
  };
}, [state.currentIndex, state.answers, questions]);

  const { isSubmitting, showConfirmDialog, setShowConfirmDialog, submitPracticeSet } = usePracticeSet({
    status: state.status,
    answeredCount: derived.answeredCount,
    questionCount: questions.length,
    userEmail,
    questions,
    answers: Object.fromEntries(
  Object.entries(state.answers).map(([k, v]: [string, any]) => [
    k, 
    v?.selected_option ?? v 
  ])
),  
    correctness: state.correctness,
    setInfo,
    attemptId: state.attemptId,
    ensureAttempt: async () => {
      if (state.attemptId) return state.attemptId;
      if (!userEmail) return undefined;
      const res = await fetch('/api/attempts', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({ set_id: setInfo.id })
      });
      if (res.ok) {
         const data = await res.json();
         dispatch({ type: "SET_ATTEMPT_ID", payload: data.id });
         return data.id;
      }
      return undefined;
    },
    setError: (e: string | null) => dispatch({ type: "SET_ERROR", payload: e }),
    setStatus: (s: string) => dispatch({ type: "SET_STATUS", payload: s }),
    setAuthRequired: (r: boolean) => dispatch({ type: "SET_AUTH_REQUIRED", payload: r }),
  });

  const actions = useMemo(() => ({
    goNext: () => dispatch({ type: "SET_INDEX", payload: Math.min(state.currentIndex + 1, questions.length - 1) }),
    goPrev: () => dispatch({ type: "SET_INDEX", payload: Math.max(state.currentIndex - 1, 0) }),
    jumpToQuestion: (index: number) => dispatch({ type: "SET_INDEX", payload: index }),
    toggleExplanation: (id: string) => dispatch({ type: "TOGGLE_EXPLANATION", payload: id }),
    handleSelect: async (qId: string, option: string) => {
      const isCorrect = questions.find(q => q.id === qId)?.correct_option === option;
      dispatch({ type: "SAVE_ANSWER", payload: { question_id: qId, selected_option: option, is_correct: isCorrect } });
      
      if (userEmail) {
        let aid = state.attemptId;
        if (!aid) {
            const res = await fetch('/api/attempts', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ set_id: setInfo.id }) });
            if (res.ok) {
                const data = await res.json();
                aid = data.id;
                dispatch({ type: "SET_ATTEMPT_ID", payload: data.id });
            }
        }
        if (aid) {
            fetch(`/api/attempts/${aid}/answers`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ question_id: qId, selected_option: option }) }).catch(() => {});
        }
      }
    },

    handleSkip: async (qId: string) => {
        dispatch({ type: "SAVE_ANSWER", payload: { question_id: qId, selected_option: "skipped", is_correct: false } });
        
        if (userEmail) {
            let aid = state.attemptId;
            if (!aid) {
                const res = await fetch('/api/attempts', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ set_id: setInfo.id }) });
                if (res.ok) {
                    const data = await res.json();
                    aid = data.id;
                    dispatch({ type: "SET_ATTEMPT_ID", payload: data.id });
                }
            }
            if (aid) {
                fetch(`/api/attempts/${aid}/answers`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ question_id: qId, selected_option: "skipped" }) }).catch(() => {});
            }
        }

         if (state.currentIndex < questions.length - 1) {
        dispatch({ type: "SET_INDEX", payload: state.currentIndex + 1 });
      }
    },
    setShowConfirmDialog,
    submitPracticeSet,
  }), [state.currentIndex, questions, setShowConfirmDialog, submitPracticeSet]);

  return (
    <AttemptContext.Provider value={{ 
    state: { ...state, isSubmitting, showConfirmDialog }, 
      derived, 
      actions, 
      questions, 
      setInfo, 
      userEmail 
    }}>
      {children}
    </AttemptContext.Provider>
  );
}

export function useAttemptStore() {
  const context = useContext(AttemptContext);
  if (!context) throw new Error("useAttemptStore must be used within an AttemptProvider");
  return context;
}