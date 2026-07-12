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
              return "border-success/30 bg-success/10 text-success-foreground shadow-sm";
            }
            if (isSelected && selectedAnswer?.is_correct === false) {
              return "border-destructive/30 bg-destructive/10 text-destructive-foreground shadow-sm";
            }
            if (isCorrectOption && selectedAnswer) {
              return "border-success/30 bg-success/10 text-success-foreground shadow-sm";
            }
            if (isSelected) {
              return "border-primary/30 bg-primary/10 text-primary-foreground shadow-sm";
            }
            return "border-border bg-card text-foreground shadow-sm hover:-translate-y-0.5 hover:border-primary/30 hover:bg-primary/10";
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
              className={`group relative w-full rounded-2xl border p-4 text-left transition-all duration-200 focus:outline-none focus-visible:outline focus-visible:outline-4 focus-visible:outline-offset-4 focus-visible:outline-ring forced-colors:focus-visible:outline-[Highlight] sm:p-5 ${optionClasses} ${
                isSubmitted ? "cursor-not-allowed opacity-95" : "cursor-pointer"
              }`}
            >
              <div className="flex items-start gap-4 sm:gap-5">
                <div
                  aria-hidden="true"
                  className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl border text-base font-semibold transition-colors sm:h-12 sm:w-12 sm:text-lg ${
                    isSelected && selectedAnswer?.is_correct === true
                      ? "border-success bg-success text-success-foreground"
                      : isSelected && selectedAnswer?.is_correct === false
                      ? "border-destructive bg-destructive text-destructive-foreground"
                      : isCorrectOption && selectedAnswer
                      ? "border-success bg-success text-success-foreground"
                      : isSelected
                      ? "border-primary bg-primary text-primary-foreground"
                      : "border-border bg-card text-foreground group-hover:border-primary group-hover:text-primary"
                  }`}
                >
                  {option.value}
                </div>

                <div className="min-w-0 flex-1 space-y-3 pt-1">
                  <p
                    id={optionLabelId}
                    className="text-base font-semibold leading-relaxed text-foreground transition-colors sm:text-lg md:text-xl"
                  >
                    <Lang>{option.text}</Lang>
                  </p>

                  <div className="flex flex-wrap items-center gap-3">
                    {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                      <div
                        className={`flex items-center gap-2 rounded-full px-3 py-1.5 text-sm font-semibold ${
                          selectedAnswer?.is_correct === false
                            ? "bg-destructive/20 text-destructive-foreground"
                            : selectedAnswer?.is_correct === true
                            ? "bg-success/20 text-success-foreground"
                            : "bg-primary/20 text-primary-foreground"
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
                      <div className="flex items-center gap-2 rounded-full bg-success/20 px-3 py-1.5 text-sm font-semibold text-success-foreground">
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
