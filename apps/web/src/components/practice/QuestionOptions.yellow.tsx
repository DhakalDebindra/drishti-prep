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
            className={`w-full relative group rounded-2xl p-5 sm:p-6 text-left transition-all duration-200 focus:outline-none focus-visible:outline focus-visible:outline-4 focus-visible:outline-offset-4 focus-visible:outline-black dark:focus-visible:outline-yellow-400 forced-colors:focus-visible:outline-[Highlight] ${
              isSelected && selectedAnswer?.is_correct === true
                ? "border-[4px] border-b-[8px] border-emerald-600 dark:border-emerald-400 bg-emerald-50 dark:bg-emerald-950/40 text-black dark:text-emerald-50 shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] dark:shadow-[4px_4px_0px_0px_rgba(52,211,153,1)] forced-colors:outline forced-colors:outline-[4px] forced-colors:outline-[CanvasText]"
                : isSelected && selectedAnswer?.is_correct === false
                ? "border-[4px] border-b-[8px] border-red-600 dark:border-red-500 bg-red-50 dark:bg-red-950/40 text-black dark:text-red-50 shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] dark:shadow-[4px_4px_0px_0px_rgba(239,68,68,1)] forced-colors:outline forced-colors:outline-[4px] forced-colors:outline-[CanvasText]"
                : isCorrectOption && selectedAnswer
                ? "border-[4px] border-b-[8px] border-emerald-600 dark:border-emerald-400 bg-emerald-50 dark:bg-emerald-950/40 text-black dark:text-emerald-50 shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] dark:shadow-[4px_4px_0px_0px_rgba(52,211,153,1)] forced-colors:outline forced-colors:outline-[4px] forced-colors:outline-[CanvasText]"
                : isSelected
                ? "border-[4px] border-b-[8px] border-black dark:border-yellow-400 bg-yellow-400 dark:bg-[#222] text-black dark:text-yellow-400 shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] dark:shadow-[4px_4px_0px_0px_rgba(250,204,21,1)] forced-colors:bg-[Highlight] forced-colors:text-[HighlightText] forced-colors:border-[HighlightText]"
                : "border-[4px] border-b-[8px] active:translate-y-[4px] active:border-b-[4px] border-black dark:border-yellow-400 hover:bg-yellow-100 dark:hover:bg-[#222] text-black dark:text-yellow-400"
            } ${isSubmitted ? "cursor-not-allowed opacity-95 hover:translate-y-0 hover:border-b-[8px]" : "cursor-pointer"}`}
          >
            <div className="flex items-start gap-4 sm:gap-6">
              {/* Option Identifier Box */}
              <div aria-hidden="true" className={`shrink-0 flex items-center justify-center w-12 h-12 rounded-xl border-[3px] text-xl font-black transition-colors ${
                isSelected && selectedAnswer?.is_correct === true ? "bg-emerald-600 border-emerald-600 text-white" :
                isSelected && selectedAnswer?.is_correct === false ? "bg-red-600 border-red-600 text-white" :
                isCorrectOption && selectedAnswer ? "bg-emerald-600 border-emerald-600 text-white" :
                isSelected ? "bg-black border-black text-yellow-400 dark:bg-yellow-400 dark:border-yellow-400 dark:text-black" :
                "bg-white dark:bg-black border-black dark:border-yellow-400 text-black dark:text-yellow-400 group-hover:bg-black group-hover:text-yellow-400 dark:group-hover:bg-yellow-400 dark:group-hover:text-black"
              }`}>
                {option.value}
              </div>

              <div className="space-y-3 flex-1 pt-1">
                <p id={optionLabelId} className={`text-lg sm:text-xl md:text-2xl font-black leading-snug transition-colors ${
                  isSelected || (isCorrectOption && selectedAnswer) ? "text-black dark:text-yellow-400" : "text-black dark:text-yellow-400"
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
