import { redirect } from "next/navigation";

export default function AdminIndexPage() {
  // Real dashboard goes here; for now, let's redirect to the only feature we have:
  redirect("/admin/question-sets/create");
}
