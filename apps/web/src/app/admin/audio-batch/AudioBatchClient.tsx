"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";

type Status = "idle" | "running" | "done" | "error";

type Props = {
  setId: string;
  setTitle: string;
  total: number;
  ready: number;
};

export function AudioBatchClient({ setId, total, ready }: Props) {
  const router = useRouter();
  const [status, setStatus] = useState<Status>("idle");
  const [progress, setProgress] = useState({ done: 0, failed: 0, total: 0 });
  const [, startTransition] = useTransition();

  const missing = total - ready;

  async function run() {
    setStatus("running");
    setProgress({ done: 0, failed: 0, total: 0 });

    const listRes = await fetch(`/api/admin/audio-batch/list?set_id=${setId}`);
    if (!listRes.ok) {
      setStatus("error");
      return;
    }
    const ids: string[] = ((await listRes.json()).ids as string[] | undefined) ?? [];

    setProgress({ done: 0, failed: 0, total: ids.length });

    for (const id of ids) {
      try {
        const res = await fetch(`/api/admin/questions/${id}/audio`, {
          method: "POST",
        });
        if (res.ok) {
          setProgress((p) => ({ ...p, done: p.done + 1 }));
        } else {
          setProgress((p) => ({ ...p, failed: p.failed + 1 }));
        }
      } catch {
        setProgress((p) => ({ ...p, failed: p.failed + 1 }));
      }
    }

    setStatus("done");
    startTransition(() => router.refresh());
  }

  if (total === 0) {
    return <span className="text-xs text-slate-400">No questions</span>;
  }

  if (status === "running") {
    return (
      <div className="text-xs text-slate-700 text-right">
        <div className="font-mono">
          {progress.done + progress.failed} / {progress.total}
        </div>
        {progress.failed > 0 && (
          <div className="text-rose-600">{progress.failed} failed</div>
        )}
      </div>
    );
  }

  if (status === "done") {
    return (
      <div className="text-xs text-emerald-700 text-right">
        Done — {progress.done} generated
        {progress.failed > 0 && (
          <span className="text-rose-600">, {progress.failed} failed</span>
        )}
      </div>
    );
  }

  if (missing === 0) {
    return <span className="text-xs text-emerald-700 font-semibold">Complete</span>;
  }

  return (
    <Button size="sm" variant="outline" onClick={run}>
      Generate {missing}
    </Button>
  );
}
