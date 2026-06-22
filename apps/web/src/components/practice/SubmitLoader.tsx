import { useEffect, useRef } from "react";
import { Loader2 } from "lucide-react";
import { useAttemptStore } from "@/features/practice/store/attempt-store";

export function SubmitLoader() {
  const {
    state: { isSubmitting },
  } = useAttemptStore();
  const loaderRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (isSubmitting) {
      document.body.style.overflow = "hidden";
      loaderRef.current?.focus();
      return () => {
        document.body.style.overflow = "";
      };
    }
  }, [isSubmitting]);

  if (!isSubmitting) return null;

  return (
    <div
      ref={loaderRef}
      tabIndex={-1}
      aria-modal="true"
      onClick={(e) => e.stopPropagation()}
      className="fixed inset-0 z-[9999] flex flex-col items-center justify-center bg-slate-950/45 p-4 backdrop-blur-sm focus:outline-none"
    >
      <div className="flex flex-col items-center justify-center rounded-[1.75rem] border border-white/20 bg-white px-8 py-7 shadow-2xl dark:bg-slate-950">
        <Loader2 className="h-10 w-10 animate-spin text-emerald-500" />
        <div role="status" aria-live="assertive" aria-atomic="true" className="mt-4 text-center">
          <p className="text-lg font-semibold text-slate-950 dark:text-white">Generating review...</p>
          <p className="text-sm text-slate-500 dark:text-slate-400">Our AI is analyzing your responses.</p>
        </div>
      </div>
    </div>
  );
}
