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
      className="fixed inset-0 z-[9999] flex flex-col items-center justify-center bg-black/40 backdrop-blur-sm focus:outline-none"
    >
      <div className="flex flex-col items-center justify-center rounded-2xl bg-white p-8 shadow-2xl space-y-4">
        <Loader2 className="h-10 w-10 animate-spin text-blue-600" />
        <div role="status" aria-live="assertive" aria-atomic="true" className="text-center">
          <p className="text-lg font-medium text-gray-900">Generating review...</p>
          <p className="text-sm text-gray-500">Our AI is analyzing your responses.</p>
        </div>
      </div>
    </div>
  );
}
