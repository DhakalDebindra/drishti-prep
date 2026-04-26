import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";

interface LayoutProps {
  children: React.ReactNode;
  params: Promise<{ moduleSlug: string }>;
}

export default async function ModuleLayout({ children, params }: LayoutProps) {
  const { moduleSlug } = await params;
  const supabase = createStaticClient();

  const { data: moduleData } = await supabase
    .from("modules")
    .select("id, name, slug")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) {
    notFound();
  }

  // We could also provide this data to a client context if we needed deeply nested breadcrumbs,
  // but since we are using Server Components, we can just let each page fetch what it needs
  // or construct a Breadcrumb component that fetches its path. However, passing it through 
  // Context would require a Client Component. For now, since Next.js cache deduplicates 
  // identical fetch requests (if using standard fetch) and we use Supabase client, we might 
  // still hit the DB unless cached. We'll leave the breadcrumb UI for a dedicated component 
  // or built per-page.

  return (
    <div className="max-w-5xl mx-auto px-4 py-8">
      {/* Basic Layout-level Header or Breadcrumb could go here */}
      <div className="mb-6">
        <div className="text-sm text-gray-500 font-medium">
          <span className="text-gray-400">Course / </span>
          {moduleData.name}
        </div>
      </div>
      {children}
    </div>
  );
}
