import { useEffect, useRef, memo } from "react";

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
            className={`w-full rounded-md border p-3 text-left transition focus:outline-none focus:ring-2 focus:ring-blue-400 ${
              isSelected
                ? "border-blue-400 bg-blue-50"
                : isCorrectOption && selectedAnswer
                ? "border-emerald-500 bg-emerald-50"
                : "border-gray-200 hover:border-blue-200 hover:bg-gray-50"
            } ${isSubmitted ? "cursor-not-allowed opacity-90" : "cursor-pointer"}`}
          >
            <div className="flex items-start gap-3">
              <span
                aria-hidden="true"
                className={`mt-1 h-5 w-5 rounded-full border ${
                  isSelected 
                    ? "border-blue-500 bg-blue-500" 
                    : isCorrectOption && selectedAnswer
                    ? "border-emerald-500 bg-emerald-500"
                    : "border-gray-300"
                }`}
              />
              <div className="space-y-1">
                <p id={optionLabelId} className="text-gray-900">
                  <span className="mr-2 font-semibold">{option.value}.</span>
                  {option.text}
                </p>
                <div className="flex items-center gap-2">
                  {isSelected && selectedAnswer?.selected_option !== "skipped" && (
                    <p className={`text-xs font-semibold ${selectedAnswer?.is_correct ? 'text-emerald-700' : 'text-orange-700'}`}>
                      <span className="sr-only">{selectedAnswer?.is_correct ? 'correct' : 'incorrect'}</span>
                      Your choice
                    </p>
                  )}
                  {isCorrectOption && selectedAnswer && (
                    <p className="text-xs font-semibold text-emerald-700">
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
