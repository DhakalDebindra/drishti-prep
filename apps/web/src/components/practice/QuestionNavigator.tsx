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
      className="mt-2 rounded-[1.75rem] border border-slate-200 bg-white/85 p-4 shadow-sm backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/70 sm:p-5"
    >
      <div className="mb-4 flex items-center justify-between gap-3">
        <h3 className="text-sm font-semibold text-slate-700 dark:text-slate-200">
          Question Navigator
        </h3>
        <p className="text-xs text-slate-500 dark:text-slate-400">
          Jump between questions
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        {Array.from({ length: questionCount }).map((_, index) => {
          const qId = questions[index]?.id;
          const answer = qId ? answers[qId] : null;
          const isAnswered = answer?.selected_option && answer.selected_option !== "skipped";
          const isSkipped = answer?.selected_option === "skipped";
          const isCurrent = currentIndex === index;

          const variant: "default" | "outline" | "secondary" | "ghost" = isAnswered
            ? "default"
            : isSkipped
            ? "secondary"
            : "outline";

          const statusClasses = isCurrent
            ? "ring-2 ring-emerald-500 ring-offset-2 ring-offset-white dark:ring-offset-slate-950 font-semibold"
            : isAnswered
            ? "bg-emerald-500 text-white hover:bg-emerald-600 dark:bg-emerald-500 dark:text-white"
            : isSkipped
            ? "bg-slate-200 text-slate-700 hover:bg-slate-300 dark:bg-slate-800 dark:text-slate-200"
            : "bg-white text-slate-700 hover:bg-emerald-50 hover:text-emerald-800 dark:bg-slate-950 dark:text-slate-300 dark:hover:bg-slate-900 dark:hover:text-emerald-300";

          const status = isAnswered ? "answered" : isSkipped ? "skipped" : "unanswered";
          const currentLabel = isCurrent ? "currently active" : "";
          const ariaLabel = `Question ${index + 1}, ${status}${currentLabel ? `, ${currentLabel}` : ""}`;

          return (
            <Button
              key={index}
              variant={variant}
              className={`h-11 w-11 p-0 text-sm transition-all focus-visible:ring-2 focus-visible:ring-emerald-500 focus-visible:ring-offset-2 focus-visible:ring-offset-white dark:focus-visible:ring-cyan-400 dark:focus-visible:ring-offset-slate-950 ${statusClasses}`}
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
