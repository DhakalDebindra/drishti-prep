import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";
import { Lang } from "@/components/ui/Lang";

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

  return (
    <div className="max-w-5xl mx-auto px-4 py-8">
      <div className="mb-6">
        <div className="text-sm text-gray-500 font-medium">
          <span className="text-gray-400">Course / </span>
          <Lang>{moduleData.name}</Lang>
        </div>
      </div>
      {children}
    </div>
  );
}
