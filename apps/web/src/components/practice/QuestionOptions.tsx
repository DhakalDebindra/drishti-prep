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

  useEffect(() => {
    const container = optionsContainerRef.current;
    if (!container) return;

    const buttons = Array.from(container.querySelectorAll('[role="radio"]')) as HTMLButtonElement[];
    const selectedButton = buttons.find((btn) => btn.getAttribute("aria-checked") === "true");
    const target = selectedButton ?? buttons[0];

    if (target) {
      requestAnimationFrame(() => target.focus());
    }
  }, [questionId]);

  return (
    <div
      ref={optionsContainerRef}
      className="space-y-3"
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
            className={`w-full rounded-xl p-4 sm:p-5 text-left transition-all duration-150 motion-safe:hover:scale-[1.01] motion-safe:active:scale-[0.99] focus:outline-none focus-visible:outline focus-visible:outline-[3px] focus-visible:outline-offset-2 focus-visible:outline-blue-600 forced-colors:focus-visible:outline-[Highlight] ${
              isSelected && selectedAnswer?.is_correct === true
                ? "border-[3px] border-emerald-600 bg-emerald-50 text-emerald-900 shadow-sm forced-colors:outline forced-colors:outline-2 forced-colors:outline-[CanvasText]"
                : isSelected && selectedAnswer?.is_correct === false
                ? "border-[3px] border-red-600 bg-red-50 text-red-900 shadow-sm forced-colors:outline forced-colors:outline-2 forced-colors:outline-[CanvasText]"
                : isCorrectOption && selectedAnswer
                ? "border-[3px] border-emerald-600 bg-emerald-50 text-emerald-900 shadow-sm forced-colors:outline forced-colors:outline-2 forced-colors:outline-[CanvasText]"
                : isSelected
                ? "border-[3px] border-blue-600 bg-blue-50 text-blue-900 shadow-sm forced-colors:bg-[Highlight] forced-colors:text-[HighlightText] forced-colors:border-[HighlightText]"
                : "border-2 border-slate-500 hover:border-slate-700 hover:bg-slate-50 text-slate-900"
            } ${isSubmitted ? "cursor-not-allowed opacity-90" : "cursor-pointer"}`}
          >
            <div className="flex items-start gap-4">
              <div aria-hidden="true" className="mt-0.5 shrink-0">
                {isSelected && selectedAnswer?.is_correct === true && (
                  <CheckCircle2 className="h-6 w-6 text-emerald-600 motion-safe:animate-in motion-safe:zoom-in-50 motion-safe:duration-300" />
                )}
                {isSelected && selectedAnswer?.is_correct === false && (
                  <XCircle className="h-6 w-6 text-red-600 motion-safe:animate-in motion-safe:zoom-in-50 motion-safe:duration-300" />
                )}
                {!isSelected && isCorrectOption && selectedAnswer && (
                  <CheckCircle2 className="h-6 w-6 text-emerald-600 motion-safe:animate-in motion-safe:zoom-in-50 motion-safe:duration-300" />
                )}
                {(!selectedAnswer || (isSelected && selectedAnswer?.is_correct === undefined) || (!isSelected && !isCorrectOption)) && (
                  <Circle className={`h-6 w-6 ${isSelected ? "fill-blue-600 text-blue-600" : "text-slate-600"}`} />
                )}
              </div>
              <div className="space-y-1.5 flex-1">
                <p id={optionLabelId} className="text-base sm:text-lg text-slate-900">
                  <span className="mr-2 font-bold">{option.value}.</span>
                  <Lang>{option.text}</Lang>
                </p>
                <div className="flex flex-wrap items-center gap-2">
                  {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                    <p className={`text-sm font-bold ${selectedAnswer?.is_correct === false ? 'text-red-700' : selectedAnswer?.is_correct === true ? 'text-emerald-700' : 'text-blue-700'}`}>
                      <span className="sr-only">{selectedAnswer?.is_correct === false ? 'incorrect' : selectedAnswer?.is_correct === true ? 'correct' : 'selected'}</span>
                      Your choice
                    </p>
                  )}
                  {isCorrectOption && selectedAnswer && (
                    <p className="text-sm font-bold text-emerald-700">
                      Correct Answer
                    </p>
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
