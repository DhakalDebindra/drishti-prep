import Link from "next/link";

export default function PracticeLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-gray-50 text-gray-900">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-5xl items-center gap-3 px-6 py-4">
          <Link
            href="/"
            className="text-sm font-medium text-blue-700 hover:text-blue-900"
          >
            ← Home
          </Link>
          <span className="text-sm text-gray-500" aria-current="page">
            Practice
          </span>
        </div>
      </header>
      <main className="mx-auto flex max-w-5xl flex-col gap-8 px-6 py-8">
        {children}
      </main>
    </div>
  );
}
