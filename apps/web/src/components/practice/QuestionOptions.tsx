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

export const QuestionOptions = memo(
  ({ questionId, options, selectedAnswer, onSelect, isSubmitted, correctAnswer }: QuestionOptionsProps) => {
    const questionTitleId = `question-${questionId}-title`;
    const optionsContainerRef = useRef<HTMLDivElement | null>(null);

    useEffect(() => {
      if (window.matchMedia("(pointer: coarse)").matches) return;

      const container = optionsContainerRef.current;
      if (!container) return;

      const buttons = Array.from(container.querySelectorAll('[role="radio"]')) as HTMLButtonElement[];
      const selectedButton = buttons.find((button) => button.getAttribute("aria-checked") === "true");
      const target = selectedButton ?? buttons[0];

      if (target) {
        requestAnimationFrame(() => target.focus({ preventScroll: true }));
      }
    }, [questionId]);

    return (
      <div
        ref={optionsContainerRef}
        className="grid grid-cols-1 gap-4 lg:grid-cols-2 sm:gap-5 md:gap-6"
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

          const optionClasses = (() => {
            if (isSelected && selectedAnswer?.is_correct === true) {
              return "border-emerald-200 bg-emerald-50 text-emerald-950 shadow-sm dark:border-emerald-900/50 dark:bg-emerald-950/30 dark:text-emerald-50";
            }
            if (isSelected && selectedAnswer?.is_correct === false) {
              return "border-rose-200 bg-rose-50 text-rose-950 shadow-sm dark:border-rose-900/50 dark:bg-rose-950/30 dark:text-rose-50";
            }
            if (isCorrectOption && selectedAnswer) {
              return "border-emerald-200 bg-emerald-50 text-emerald-950 shadow-sm dark:border-emerald-900/50 dark:bg-emerald-950/30 dark:text-emerald-50";
            }
            if (isSelected) {
              return "border-cyan-200 bg-cyan-50 text-cyan-950 shadow-sm dark:border-cyan-900/50 dark:bg-cyan-950/30 dark:text-cyan-50";
            }
            return "border-slate-200 bg-white text-slate-800 shadow-sm hover:-translate-y-0.5 hover:border-emerald-200 hover:bg-emerald-50/70 dark:border-slate-800 dark:bg-slate-950/60 dark:text-slate-100 dark:hover:border-emerald-900/50 dark:hover:bg-slate-900";
          })();

          return (
            <button
              key={option.value}
              type="button"
              role="radio"
              aria-checked={isSelected}
              aria-labelledby={optionLabelId}
              tabIndex={tabIndex}
              onClick={(e) => {
                e.preventDefault();
                e.stopPropagation();
                if (isSubmitted) return;
                onSelect(option.value);
              }}
              className={`group relative w-full rounded-[1.5rem] border p-4 text-left transition-all duration-200 focus:outline-none focus-visible:outline focus-visible:outline-4 focus-visible:outline-offset-4 focus-visible:outline-emerald-500 dark:focus-visible:outline-cyan-400 forced-colors:focus-visible:outline-[Highlight] sm:p-5 ${optionClasses} ${
                isSubmitted ? "cursor-not-allowed opacity-95" : "cursor-pointer"
              }`}
            >
              <div className="flex items-start gap-4 sm:gap-5">
                <div
                  aria-hidden="true"
                  className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl border text-base font-semibold transition-colors sm:h-12 sm:w-12 sm:text-lg ${
                    isSelected && selectedAnswer?.is_correct === true
                      ? "border-emerald-500 bg-emerald-500 text-white"
                      : isSelected && selectedAnswer?.is_correct === false
                      ? "border-rose-500 bg-rose-500 text-white"
                      : isCorrectOption && selectedAnswer
                      ? "border-emerald-500 bg-emerald-500 text-white"
                      : isSelected
                      ? "border-cyan-500 bg-cyan-500 text-white"
                      : "border-slate-300 bg-white text-slate-700 group-hover:border-emerald-300 group-hover:text-emerald-700 dark:border-slate-700 dark:bg-slate-950 dark:text-slate-200 dark:group-hover:border-emerald-700 dark:group-hover:text-emerald-300"
                  }`}
                >
                  {option.value}
                </div>

                <div className="min-w-0 flex-1 space-y-3 pt-1">
                  <p
                    id={optionLabelId}
                    className={`text-base font-semibold leading-relaxed transition-colors sm:text-lg md:text-xl ${
                      isSelected || (isCorrectOption && selectedAnswer)
                        ? "text-slate-950 dark:text-white"
                        : "text-slate-800 dark:text-slate-100"
                    }`}
                  >
                    <Lang>{option.text}</Lang>
                  </p>

                  <div className="flex flex-wrap items-center gap-3">
                    {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                      <div
                        className={`flex items-center gap-2 rounded-full px-3 py-1.5 text-sm font-semibold ${
                          selectedAnswer?.is_correct === false
                            ? "bg-rose-100 text-rose-900 dark:bg-rose-950/40 dark:text-rose-200"
                            : selectedAnswer?.is_correct === true
                            ? "bg-emerald-100 text-emerald-900 dark:bg-emerald-950/40 dark:text-emerald-200"
                            : "bg-cyan-100 text-cyan-900 dark:bg-cyan-950/40 dark:text-cyan-200"
                        }`}
                      >
                        {selectedAnswer?.is_correct === false && <XCircle className="h-4 w-4" />}
                        {selectedAnswer?.is_correct === true && <CheckCircle2 className="h-4 w-4" />}
                        {selectedAnswer?.is_correct === undefined && <Circle className="h-4 w-4 fill-current" />}
                        <span className="sr-only">
                          {selectedAnswer?.is_correct === false
                            ? "incorrect"
                            : selectedAnswer?.is_correct === true
                              ? "correct"
                              : "selected"}
                        </span>
                        Your choice
                      </div>
                    )}
                    {isCorrectOption && selectedAnswer && (
                      <div className="flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1.5 text-sm font-semibold text-emerald-900 dark:bg-emerald-950/40 dark:text-emerald-200">
                        <CheckCircle2 className="h-4 w-4" />
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
  }
);

QuestionOptions.displayName = "QuestionOptions";
