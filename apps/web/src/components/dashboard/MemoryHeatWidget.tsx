import { Activity, RotateCcw } from "lucide-react";
import Link from "next/link";
import { WidgetCard } from "@/components/ui/widget-card";

export type ColdTopic = {
  topicId: string;
  name: string;
  slug: string | null;
  subjectSlug: string | null;
  moduleSlug: string | null;
  avgHeat: number;
  questionCount: number;
};

export function MemoryHeatWidget({
  overallHeat,
  totalQuestions,
  coldestTopics,
}: {
  overallHeat: number; // 0–100
  totalQuestions: number;
  coldestTopics: ColdTopic[];
}) {
  if (totalQuestions === 0) {
    return null;
  }

  // Graded readiness scale (orange/amber/sky) — a semantic 3-way gradient,
  // not the app's binary success/destructive tokens, so kept as literal
  // Tailwind colors rather than forced into a 2-tone token.
  const heatColor =
    overallHeat >= 70
      ? "text-orange-600 dark:text-orange-400"
      : overallHeat >= 40
        ? "text-amber-600 dark:text-amber-400"
        : "text-sky-600 dark:text-sky-400";

  const readinessLabel =
    overallHeat >= 70 ? "Strong" : overallHeat >= 40 ? "Steady" : "Needs a refresh";

  return (
    <WidgetCard
      title="Revision"
      subtitle={`Based on the ${totalQuestions} questions you have practised so far.`}
      actionSlot={
        <div className="flex items-center gap-2 shrink-0">
          <Activity className={`w-6 h-6 ${heatColor}`} aria-hidden="true" />
          <div className={`text-3xl font-bold ${heatColor}`}>
            {overallHeat}
            <span className="text-base font-medium ml-1">/ 100</span>
          </div>
        </div>
      }
    >
      <div className="text-xs uppercase tracking-wide text-muted-foreground mb-1">
        This week&apos;s readiness
      </div>
      <div className="text-sm font-medium text-foreground mb-4">
        {readinessLabel}
      </div>

      {coldestTopics.length > 0 && (
        <div>
          <div className="flex items-center gap-2 text-xs uppercase tracking-wide text-muted-foreground mb-2">
            <RotateCcw className="w-3 h-3" aria-hidden="true" />
            Topics to revisit
          </div>
          <ul className="space-y-2">
            {coldestTopics.map((t) => {
              const href =
                t.moduleSlug && t.subjectSlug && t.slug
                  ? `/courses/${t.moduleSlug}/${t.subjectSlug}/${t.slug}`
                  : null;
              const inner = (
                <div className="flex items-center justify-between gap-3 py-1.5">
                  <span className="text-sm text-foreground truncate">
                    {t.name}
                  </span>
                  <span className="text-xs text-muted-foreground shrink-0">
                    {t.questionCount} question{t.questionCount === 1 ? "" : "s"}
                  </span>
                </div>
              );
              return (
                <li key={t.topicId}>
                  {href ? (
                    <Link
                      href={href}
                      className="block rounded-md hover:bg-muted px-2 -mx-2 focus:outline-none focus:ring-2 focus:ring-ring"
                    >
                      {inner}
                    </Link>
                  ) : (
                    <div className="px-2 -mx-2">{inner}</div>
                  )}
                </li>
              );
            })}
          </ul>
        </div>
      )}
    </WidgetCard>
  );
}
