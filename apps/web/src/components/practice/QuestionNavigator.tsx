import { Button } from "@/components/ui/button";
import { useAttemptStore } from "@/features/practice/store/attempt-store";

export function QuestionNavigator() {
  const {
    derived: { questionCount },
    state: { currentIndex, answers },
    actions: { jumpToQuestion },
    questions,
  } = useAttemptStore();

  return (
    <div className="mt-6 rounded-lg border border-gray-200 bg-white p-5 shadow-sm">
      <h3 className="mb-4 text-sm font-semibold text-gray-700">Question Navigator</h3>
      <div className="flex flex-wrap gap-2">
        {Array.from({ length: questionCount }).map((_, index) => {
          const qId = questions[index]?.id;
          const answer = qId ? answers[qId] : null;
          const isAnswered = answer?.selected_option && answer.selected_option !== "skipped";
          const isSkipped = answer?.selected_option === "skipped";
          const isCurrent = currentIndex === index;

          let variant: "default" | "outline" | "secondary" | "ghost" = "outline";
          let extraClasses = "";

          if (isCurrent) {
            extraClasses = "ring-2 ring-blue-500 ring-offset-2";
          }

          if (isAnswered) {
            variant = "default";
          } else if (isSkipped) {
            variant = "secondary";
          } else {
            variant = "outline";
          }

          const status = isAnswered ? "answered" : isSkipped ? "skipped" : "unanswered";
          const currentLabel = isCurrent ? "currently active" : "";
          const ariaLabel = `Question ${index + 1}, ${status}${currentLabel ? `, ${currentLabel}` : ""}`;

          return (
            <Button
              key={index}
              variant={variant}
              className={`h-10 w-10 p-0 text-sm font-medium ${extraClasses}`}
              aria-label={ariaLabel}
              aria-current={isCurrent ? "true" : undefined}
              onClick={() => jumpToQuestion(index)}
            >
              {index + 1}
            </Button>
          );
        })}
      </div>
    </div>
  );
}
