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
    <nav
      aria-label="Question Navigator"
      className="mt-6 rounded-lg border border-gray-200 dark:border-slate-800 bg-white dark:bg-slate-950 p-5 shadow-sm"
    >
      <h3 className="mb-4 text-sm font-semibold text-gray-700 dark:text-slate-300">
        Question Navigator
      </h3>
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
            extraClasses = "ring-2 ring-blue-600 dark:ring-blue-400 ring-offset-2 dark:ring-offset-slate-900 font-bold border-2 border-blue-600 dark:border-blue-400 scale-105 shadow-md z-10";
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
              className={`h-11 w-11 sm:h-10 sm:w-10 p-0 text-sm font-semibold transition-all focus-visible:ring-2 focus-visible:ring-blue-600 dark:focus-visible:ring-blue-400 focus-visible:ring-offset-2 dark:focus-visible:ring-offset-slate-900 ${extraClasses}`}
              aria-label={ariaLabel}
              aria-current={isCurrent ? "true" : undefined}
              onClick={() => jumpToQuestion(index)}
            >
              {index + 1}
            </Button>
          );
        })}
      </div>
    </nav>
  );
}
