import { Suspense } from "react";
import ReviewClient from "./ReviewClient";

export default async function ReviewPage({
  params,
}: {
  params: { subject: string; topic: string; set: string } | Promise<{ subject: string; topic: string; set: string }>;
}) {
  const resolvedParams = await Promise.resolve(params);
  const subject = decodeURIComponent(resolvedParams.subject);
  const topic = decodeURIComponent(resolvedParams.topic);
  const setId = resolvedParams.set;

  return (
    <Suspense fallback={<div className="flex w-full justify-center p-12 text-gray-600">Loading review...</div>}>
      <ReviewClient subject={subject} topic={topic} set={setId} />
    </Suspense>
  );
}
