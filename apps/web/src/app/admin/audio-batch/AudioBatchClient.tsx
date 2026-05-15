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

const CONCURRENCY = 3;

export function AudioBatchClient({ setId, total, ready }: Props) {
  const router = useRouter();
  const [status, setStatus] = useState<Status>("idle");
  const [progress, setProgress] = useState({ done: 0, failed: 0, total: 0 });
  const [failedIds, setFailedIds] = useState<string[]>([]);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [, startTransition] = useTransition();

  const missing = total - ready;

  async function readError(res: Response): Promise<string> {
    try {
      const body = await res.json();
      const raw = typeof body?.error === "string" ? body.error : `HTTP ${res.status}`;
      if (/quota|exceeded|RESOURCE_EXHAUSTED|429/i.test(raw)) {
        return "Gemini TTS daily quota exceeded — wait ~24h or enable billing.";
      }
      if (res.status === 429) return "Rate limited — wait a minute and retry.";
      if (res.status === 401 || res.status === 403) return "Not authorized.";
      return raw.length > 200 ? raw.slice(0, 200) + "…" : raw;
    } catch {
      return `HTTP ${res.status}`;
    }
  }

  // Process IDs with a fixed worker pool. Each worker pulls from a shared
  // cursor so naturally-faster questions don't sit idle behind slower ones.
  async function processPool(ids: string[]) {
    let cursor = 0;
    let firstError: string | null = null;
    const fails: string[] = [];

    async function worker() {
      while (cursor < ids.length) {
        const i = cursor++;
        const id = ids[i];
        try {
          const res = await fetch(`/api/admin/questions/${id}/audio`, {
            method: "POST",
          });
          if (res.ok) {
            setProgress((p) => ({ ...p, done: p.done + 1 }));
          } else {
            if (!firstError) firstError = await readError(res);
            fails.push(id);
            setProgress((p) => ({ ...p, failed: p.failed + 1 }));
          }
        } catch (e) {
          if (!firstError) firstError = e instanceof Error ? e.message : "Network error";
          fails.push(id);
          setProgress((p) => ({ ...p, failed: p.failed + 1 }));
        }
      }
    }

    await Promise.all(
      Array.from({ length: Math.min(CONCURRENCY, ids.length) }, () => worker())
    );
    return { firstError, fails };
  }

  async function run(idsToRun?: string[]) {
    setStatus("running");
    setErrorMessage(null);
    setFailedIds([]);

    let ids = idsToRun;
    if (!ids) {
      const listRes = await fetch(`/api/admin/audio-batch/list?set_id=${setId}`);
      if (!listRes.ok) {
        setErrorMessage(await readError(listRes));
        setStatus("error");
        return;
      }
      ids = ((await listRes.json()).ids as string[] | undefined) ?? [];
    }

    setProgress({ done: 0, failed: 0, total: ids.length });

    const { firstError, fails } = await processPool(ids);

    if (firstError) setErrorMessage(firstError);
    setFailedIds(fails);
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
        <div className="text-slate-500">×{CONCURRENCY} parallel</div>
        {progress.failed > 0 && (
          <div className="text-rose-600">{progress.failed} failed</div>
        )}
      </div>
    );
  }

  if (status === "done") {
    const allFailed = progress.failed > 0 && progress.done === 0;
    return (
      <div className="text-xs text-right space-y-1">
        <div className={allFailed ? "text-rose-700" : "text-emerald-700"}>
          {progress.done} generated
          {progress.failed > 0 && (
            <span className="text-rose-600">, {progress.failed} failed</span>
          )}
        </div>
        {errorMessage && (
          <div className="text-rose-600 max-w-xs ml-auto" title={errorMessage}>
            {errorMessage}
          </div>
        )}
        <div className="flex justify-end gap-2">
          {failedIds.length > 0 && (
            <button
              type="button"
              className="text-blue-700 hover:text-blue-900 underline"
              onClick={() => run(failedIds)}
            >
              Retry {failedIds.length} failed
            </button>
          )}
          <button
            type="button"
            className="text-slate-500 hover:text-slate-700 underline"
            onClick={() => {
              setStatus("idle");
              setErrorMessage(null);
              setFailedIds([]);
            }}
          >
            Dismiss
          </button>
        </div>
      </div>
    );
  }

  if (status === "error") {
    return (
      <div className="text-xs text-right space-y-1">
        <div className="text-rose-700 font-semibold">Failed to start</div>
        {errorMessage && (
          <div className="text-rose-600 max-w-xs ml-auto" title={errorMessage}>
            {errorMessage}
          </div>
        )}
        <button
          type="button"
          className="text-slate-500 hover:text-slate-700 underline"
          onClick={() => {
            setStatus("idle");
            setErrorMessage(null);
          }}
        >
          Dismiss
        </button>
      </div>
    );
  }

  if (missing === 0) {
    return <span className="text-xs text-emerald-700 font-semibold">Complete</span>;
  }

  return (
    <Button size="sm" variant="outline" onClick={() => run()}>
      Generate {missing}
    </Button>
  );
}
