export default function Loading() {
  return (
    <div className="flex min-h-[50vh] items-center justify-center bg-gradient-to-b from-slate-50 via-white to-teal-50/50 text-slate-700 dark:from-slate-950 dark:via-slate-950 dark:to-slate-900 dark:text-slate-300">
      <div className="flex items-center gap-3 rounded-[1.5rem] border border-white/70 bg-white/85 px-6 py-4 shadow-[0_16px_40px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-slate-800 dark:bg-slate-950/80">
        <div className="h-5 w-5 animate-spin rounded-full border-2 border-emerald-500 border-t-transparent" aria-hidden="true" />
        <p className="text-sm font-medium">Loading practice content…</p>
      </div>
    </div>
  );
}
