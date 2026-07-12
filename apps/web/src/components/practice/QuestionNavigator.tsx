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
      className="mt-2 rounded-2xl border border-border bg-card p-4 shadow-sm sm:p-5"
    >
      <div className="mb-4 flex items-center justify-between gap-3">
        <h3 className="text-sm font-semibold text-foreground">
          Question Navigator
        </h3>
        <p className="text-xs text-muted-foreground">
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
            ? "ring-2 ring-ring ring-offset-2 ring-offset-background font-semibold"
            : isAnswered
            ? "bg-primary text-primary-foreground hover:bg-primary/90"
            : isSkipped
            ? "bg-muted text-foreground hover:bg-muted/70"
            : "bg-card text-foreground hover:bg-primary/10 hover:text-primary";

          const status = isAnswered ? "answered" : isSkipped ? "skipped" : "unanswered";
          const currentLabel = isCurrent ? "currently active" : "";
          const ariaLabel = `Question ${index + 1}, ${status}${currentLabel ? `, ${currentLabel}` : ""}`;

          return (
            <Button
              key={index}
              variant={variant}
              className={`h-11 w-11 p-0 text-sm transition-all focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:ring-offset-background ${statusClasses}`}
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
