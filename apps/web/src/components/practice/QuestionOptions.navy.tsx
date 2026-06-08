import { useEffect, useRef, memo } from "react";
import { CheckCircle2, XCircle, Circle } from "lucide-react";
import { Lang } from "@/components/ui/Lang";

export const optionKeys = ["A", "B", "C", "D"] as const;

export type QuestionOption = { value: (typeof optionKeys)[number]; text: string };

export type QuestionOptionsProps = {
  questionId: string;
  options: QuestionOption[];
  selectedAnswer: { question_id: string; selected_option: string; is_correct?: boolean } | null;
  onSelect: (option: (typeof optionKeys)[number]) => void;
  isSubmitted?: boolean;
  correctAnswer: string | null;
};

export const QuestionOptions = memo(({ questionId, options, selectedAnswer, onSelect, isSubmitted, correctAnswer }: QuestionOptionsProps) => {
  const questionTitleId = `question-${questionId}-title`;
  const optionsContainerRef = useRef<HTMLDivElement | null>(null);

  // Focus management has been moved to the QuestionContent in PracticeSetClient
  // for mobile/touch devices so screen readers read the question before the options.
  // For desktop/keyboard users, we restore the auto-focus on the options.
  useEffect(() => {
    // Only auto-focus options on non-touch devices (desktop)
    if (window.matchMedia("(pointer: coarse)").matches) return;

    const container = optionsContainerRef.current;
    if (!container) return;

    const buttons = Array.from(container.querySelectorAll('[role="radio"]')) as HTMLButtonElement[];
    const selectedButton = buttons.find((btn) => btn.getAttribute("aria-checked") === "true");
    const target = selectedButton ?? buttons[0];

    if (target) {
      requestAnimationFrame(() => target.focus({ preventScroll: true }));
    }
  }, [questionId]);

  return (
    <div
      ref={optionsContainerRef}
      className="grid grid-cols-1 lg:grid-cols-2 gap-4 sm:gap-5 md:gap-6"
      role="radiogroup"
      aria-labelledby={questionTitleId}
      onKeyDown={(e) => {
        const target = e.target as HTMLElement;
        if (target.getAttribute("role") !== "radio") return;

        if (["ArrowDown", "ArrowRight", "ArrowUp", "ArrowLeft"].includes(e.key)) {
          e.preventDefault();

          const buttons = Array.from(
            e.currentTarget.querySelectorAll('[role="radio"]')
          ) as HTMLButtonElement[];
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
      {options.map((option, index) => {
        const optionLabelId = `option-${questionId}-${option.value}-label`;
        const isSelected = selectedAnswer?.selected_option === option.value;
        const isCorrectOption = option.value === correctAnswer;
        const tabIndex = isSelected ? 0 : index === 0 ? 0 : -1;

        return (
          <button
            key={option.value}
            type="button"
            role="radio"
            aria-checked={isSelected}
            aria-labelledby={`${optionLabelId} `}
            tabIndex={tabIndex}
            onClick={(e) => {
              e.preventDefault();
              e.stopPropagation();
              if (isSubmitted) return;
              onSelect(option.value);
            }}
            className={`w-full relative group rounded-2xl p-5 sm:p-6 text-left transition-all duration-200 focus:outline-none focus-visible:outline focus-visible:outline-4 focus-visible:outline-offset-4 focus-visible:outline-white forced-colors:focus-visible:outline-[Highlight] ${
              isSelected && selectedAnswer?.is_correct === true
                ? "border-[3px] border-b-[6px] border-emerald-500 bg-emerald-950/40 text-emerald-50 shadow-lg"
                : isSelected && selectedAnswer?.is_correct === false
                ? "border-[3px] border-b-[6px] border-red-500 bg-red-950/40 text-red-50 shadow-lg"
                : isCorrectOption && selectedAnswer
                ? "border-[3px] border-b-[6px] border-emerald-500 bg-emerald-950/40 text-emerald-50 shadow-lg"
                : isSelected
                ? "border-[3px] border-b-[6px] border-white bg-white/10 text-white shadow-lg"
                : "border-[3px] border-b-[6px] active:translate-y-[3px] active:border-b-[3px] border-[#233554] hover:border-slate-400 hover:bg-[#233554]/50 text-slate-300 hover:text-white"
            } ${isSubmitted ? "cursor-not-allowed opacity-95 hover:translate-y-0 hover:border-b-[6px]" : "cursor-pointer"}`}
          >
            <div className="flex items-start gap-4 sm:gap-6">
              {/* Option Identifier Box */}
              <div aria-hidden="true" className={`shrink-0 flex items-center justify-center w-12 h-12 rounded-xl border-[3px] text-xl font-black transition-colors ${
                isSelected && selectedAnswer?.is_correct === true ? "bg-emerald-500 border-emerald-500 text-[#0a192f]" :
                isSelected && selectedAnswer?.is_correct === false ? "bg-red-500 border-red-500 text-[#0a192f]" :
                isCorrectOption && selectedAnswer ? "bg-emerald-500 border-emerald-500 text-[#0a192f]" :
                isSelected ? "bg-white border-white text-[#0a192f]" :
                "bg-[#0a192f] border-[#233554] text-slate-400 group-hover:border-slate-400 group-hover:text-white"
              }`}>
                {option.value}
              </div>

              <div className="space-y-3 flex-1 pt-1">
                <p id={optionLabelId} className={`text-lg sm:text-xl md:text-2xl font-black leading-snug transition-colors ${
                  isSelected || (isCorrectOption && selectedAnswer) ? "text-white" : "text-slate-200"
                }`}>
                  <Lang>{option.text}</Lang>
                </p>

                {/* State Indicators & Feedback */}
                <div className="flex flex-wrap items-center gap-3">
                  {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                    <div className={`flex items-center gap-2 text-base font-black px-3 py-1 rounded-md ${
                      selectedAnswer?.is_correct === false 
                        ? 'bg-red-200 dark:bg-red-900/60 text-red-800 dark:text-red-200' 
                        : selectedAnswer?.is_correct === true 
                          ? 'bg-emerald-200 dark:bg-emerald-900/60 text-emerald-800 dark:text-emerald-200' 
                          : 'bg-indigo-200 dark:bg-indigo-900/60 text-indigo-800 dark:text-indigo-200'
                    }`}>
                      {selectedAnswer?.is_correct === false && <XCircle className="w-5 h-5" />}
                      {selectedAnswer?.is_correct === true && <CheckCircle2 className="w-5 h-5" />}
                      {selectedAnswer?.is_correct === undefined && <Circle className="w-5 h-5 fill-current" />}
                      <span className="sr-only">
                        {selectedAnswer?.is_correct === false ? 'incorrect' : selectedAnswer?.is_correct === true ? 'correct' : 'selected'}
                      </span>
                      Your choice
                    </div>
                  )}
                  {isCorrectOption && selectedAnswer && (
                    <div className="flex items-center gap-2 text-base font-black px-3 py-1 rounded-md bg-emerald-200 dark:bg-emerald-900/60 text-emerald-800 dark:text-emerald-200">
                      <CheckCircle2 className="w-5 h-5" />
                      Correct Answer
                    </div>
                  )}
                </div>
              </div>
            </div>
          </button>
        );
      })}
    </div>
  );
});

QuestionOptions.displayName = "QuestionOptions";
