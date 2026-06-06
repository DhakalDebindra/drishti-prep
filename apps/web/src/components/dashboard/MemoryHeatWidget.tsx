import { Activity, RotateCcw } from "lucide-react";
import Link from "next/link";

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

  const heatColor =
    overallHeat >= 70
      ? "text-orange-600 dark:text-orange-400"
      : overallHeat >= 40
        ? "text-amber-600 dark:text-amber-400"
        : "text-sky-600 dark:text-sky-400";

  const readinessLabel =
    overallHeat >= 70 ? "Strong" : overallHeat >= 40 ? "Steady" : "Needs a refresh";

  return (
    <section
      aria-labelledby="revision-snapshot-heading"
      className="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl shadow-sm p-5"
    >
      <div className="flex items-start justify-between gap-4 mb-4">
        <div>
          <h2 id="revision-snapshot-heading" className="text-lg font-bold text-slate-900 dark:text-white">
            Revision Snapshot
          </h2>
          <p className="text-sm text-slate-500 dark:text-slate-400">
            A quick view of what still feels solid and what may need another pass from your {totalQuestions} practiced questions.
          </p>
        </div>
        <div className="flex items-center gap-2 shrink-0">
          <Activity className={`w-6 h-6 ${heatColor}`} aria-hidden="true" />
          <div className={`text-3xl font-bold ${heatColor}`}>
            {overallHeat}
            <span className="text-base font-medium ml-1">/ 100</span>
          </div>
        </div>
      </div>

      <div className="text-xs uppercase tracking-wide text-slate-500 dark:text-slate-400 mb-1">
        This week&apos;s readiness
      </div>
      <div className="text-sm font-medium text-slate-800 dark:text-slate-200 mb-4">
        {readinessLabel}
      </div>

      {coldestTopics.length > 0 && (
        <div>
          <div className="flex items-center gap-2 text-xs uppercase tracking-wide text-slate-500 dark:text-slate-400 mb-2">
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
                  <span className="text-sm text-slate-800 dark:text-slate-200 truncate">
                    {t.name}
                  </span>
                  <span className="text-xs text-slate-500 dark:text-slate-400 shrink-0">
                    {t.questionCount} question{t.questionCount === 1 ? "" : "s"}
                  </span>
                </div>
              );
              return (
                <li key={t.topicId}>
                  {href ? (
                    <Link
                      href={href}
                      className="block rounded-md hover:bg-slate-50 dark:hover:bg-slate-800/60 px-2 -mx-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
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
    </section>
  );
}
