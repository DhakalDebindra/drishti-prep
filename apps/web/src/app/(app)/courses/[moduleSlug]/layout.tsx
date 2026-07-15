import { notFound } from "next/navigation";
import { createStaticClient } from "@/lib/supabase/server";

interface LayoutProps {
  children: React.ReactNode;
  params: Promise<{ moduleSlug: string }>;
}

export default async function ModuleLayout({ children, params }: LayoutProps) {
  const { moduleSlug } = await params;
  const supabase = createStaticClient();

  // Existence guard only; each content page renders its own full breadcrumb
  // trail so learners can step back up the hierarchy from any level.
  const { data: moduleData } = await supabase
    .from("modules")
    .select("id")
    .eq("slug", moduleSlug)
    .single();

  if (!moduleData) {
    notFound();
  }

  return <div className="mx-auto max-w-5xl px-4 py-8">{children}</div>;
}
