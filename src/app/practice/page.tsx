import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export default async function PracticeIndexPage() {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("subjects")
    .select("id, name, description")
    .order("name", { ascending: true });

  const subjects = data ?? [];

  return (
    <section className="space-y-6">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Practice</p>
        <h1 className="text-2xl font-semibold text-gray-900">Pick a subject to start</h1>
        <p className="text-gray-600">
          Choose a subject to explore topics and question sets. Data is served live from Supabase.
        </p>
        {error && (
          <p className="mt-2 rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">
            Unable to load subjects right now. Please retry.
          </p>
        )}
      </div>
      {subjects.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No subjects are available yet. Ask an admin to create one.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {subjects.map((subject) => (
            <Link
              key={subject.id}
              href={`/practice/${encodeURIComponent(subject.name)}`}
              className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:shadow-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <p className="text-xs font-semibold uppercase tracking-wide text-blue-700">
                Subject
              </p>
              <h2 className="text-lg font-semibold text-gray-900">{subject.name}</h2>
              <p className="text-sm text-gray-600">
                {subject.description || "Explore this subject's topics and sets."}
              </p>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
