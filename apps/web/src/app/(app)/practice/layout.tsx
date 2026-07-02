export default function PracticeLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 via-white to-teal-50/50 text-slate-900 dark:from-slate-950 dark:via-slate-950 dark:to-slate-900 dark:text-slate-50">
      <div className="pointer-events-none fixed inset-0 overflow-hidden">
        <div className="absolute left-[-5rem] top-[-5rem] h-72 w-72 rounded-full bg-teal-200/25 blur-3xl dark:bg-teal-500/10" />
        <div className="absolute right-[-5rem] top-24 h-72 w-72 rounded-full bg-cyan-200/20 blur-3xl dark:bg-cyan-500/10" />
      </div>

      <main className="relative mx-auto flex max-w-[var(--dp-shell-width)] flex-col gap-8 px-4 py-6 sm:px-6 sm:py-8 lg:px-8">
        {children}
      </main>
    </div>
  );
}
