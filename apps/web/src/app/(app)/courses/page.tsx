import Link from "next/link";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";

export const revalidate = 3600;

export default async function CoursesIndexPage() {
  const supabase = createStaticClient();
  const { data: modules, error } = await (supabase as any)
    .from("modules")
    .select("id, name, description, slug, price_paisa")
    .eq("is_active", true)
    .order("display_order", { ascending: true });

  if (error) {
    console.error("Error fetching courses:", error);
  }

  return (
    <section className="space-y-6 max-w-5xl mx-auto px-4 py-8">
      <div>
        <p className="text-sm uppercase tracking-wide text-gray-500">Learning Paths</p>
        <h1 id="main-heading" className="text-2xl font-semibold text-gray-900">Available Courses</h1>
        <p className="text-gray-600">Choose a course module to start your preparation.</p>
        {error && (
          <p className="mt-2 rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">
            Unable to load courses right now. Please retry.
          </p>
        )}
      </div>
      {!modules || modules.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-6 text-gray-600">
          No courses are available yet.
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {modules.map((module: any) => (
            <Link
              key={module.id}
              href={`/courses/${module.slug}`}
              className="group flex flex-col rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition hover:shadow-md hover:border-blue-200"
            >
              <div className="flex items-start justify-between gap-4">
                <h2 className="text-lg font-semibold text-gray-900 group-hover:text-blue-600 transition-colors">
                  <Lang>{module.name}</Lang>
                </h2>
                {module.price_paisa ? (
                  <span className="inline-flex items-center rounded-full bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10">
                    NPR {module.price_paisa / 100}
                  </span>
                ) : (
                  <span className="inline-flex items-center rounded-full bg-green-50 px-2 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-green-600/20">
                    Free
                  </span>
                )}
              </div>
              <p className="mt-2 text-sm text-gray-600 flex-grow">
                {module.description ? <Lang>{module.description}</Lang> : "Explore subjects and topics within this module."}
              </p>
              <div className="mt-4 flex items-center text-sm font-medium text-blue-600">
                View subjects <span className="ml-1 group-hover:translate-x-1 transition-transform">→</span>
              </div>
            </Link>
          ))}
        </div>
      )}
    </section>
  );
}
