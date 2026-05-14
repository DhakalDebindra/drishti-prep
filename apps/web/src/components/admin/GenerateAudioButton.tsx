"use client";

import { useEffect, useState, useCallback } from "react";
import { Button } from "@/components/ui/button";
import { Headphones, Loader2, Play, RefreshCw, CheckCircle2, AlertCircle } from "lucide-react";
import toast from "react-hot-toast";

type Segment = "stem" | "opt_a" | "opt_b" | "opt_c" | "opt_d" | "explanation";
const SEGMENTS: Segment[] = ["stem", "opt_a", "opt_b", "opt_c", "opt_d", "explanation"];

const SEGMENT_LABEL: Record<Segment, string> = {
  stem: "Question stem",
  opt_a: "Option A",
  opt_b: "Option B",
  opt_c: "Option C",
  opt_d: "Option D",
  explanation: "Explanation",
};

type AudioStatus = {
  ready: boolean;
  voice: string | null;
  version: number | null;
  urls: Partial<Record<Segment, string>>;
  segments_present: Segment[];
};

type Props = {
  questionId: string;
  initialReady?: boolean | null;
  initialVoice?: string | null;
};

/**
 * Per-segment audio panel for the admin question editor.
 *
 * Each of the 6 segments shows its own status (✓ ready / – missing),
 * a Play preview button, and a per-segment Regenerate. A "Generate all
 * missing" action covers the common case after editing question text;
 * a voice override picks one of the three tutor voices when the default
 * deterministic assignment pronounces a term badly.
 */
export function GenerateAudioButton({
  questionId,
  initialReady,
  initialVoice,
}: Props) {
  const [loading, setLoading] = useState(true);
  const [status, setStatus] = useState<AudioStatus | null>(
    initialReady === true && initialVoice
      ? {
          ready: true,
          voice: initialVoice,
          version: null,
          urls: {},
          segments_present: [],
        }
      : null
  );
  const [busy, setBusy] = useState<"all" | Segment | null>(null);

  // Fetch is split into a pure async loader and a state-updating wrapper.
  // The wrapper sets `loading`, so it must NOT be called synchronously from
  // an effect (react-hooks/set-state-in-effect). The effect inlines its own
  // load, while explicit refreshes after generate() use the wrapper.
  const fetchStatus = useCallback(async (): Promise<AudioStatus | null> => {
    try {
      const res = await fetch(`/api/questions/${questionId}/audio`);
      const json = await res.json();
      return {
        ready: !!json.ready,
        voice: json.voice ?? null,
        version: json.version ?? null,
        urls: json.urls ?? {},
        segments_present: json.segments_present ?? [],
      };
    } catch {
      return null;
    }
  }, [questionId]);

  const refresh = useCallback(async () => {
    setLoading(true);
    const next = await fetchStatus();
    setStatus(next);
    setLoading(false);
  }, [fetchStatus]);

  useEffect(() => {
    let cancelled = false;
    fetchStatus().then((next) => {
      if (cancelled) return;
      setStatus(next);
      setLoading(false);
    });
    return () => {
      cancelled = true;
    };
  }, [fetchStatus]);

  async function generate(segments: Segment[] | null, force: boolean) {
    const key: "all" | Segment = segments && segments.length === 1 ? segments[0] : "all";
    setBusy(key);
    try {
      const res = await fetch(`/api/admin/questions/${questionId}/audio`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          ...(segments ? { segments } : {}),
          ...(force ? { force: true } : {}),
        }),
      });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body.error || `HTTP ${res.status}`);
      }
      const json = await res.json();
      const gen = json.generated_count ?? 0;
      toast.success(
        gen === 0 ? "Already up to date." : `Generated ${gen} segment${gen === 1 ? "" : "s"}.`
      );
      await refresh();
    } catch (err: any) {
      toast.error(err.message || "Generation failed.");
    } finally {
      setBusy(null);
    }
  }

  const presentSet = new Set(status?.segments_present ?? []);
  const missingCount = SEGMENTS.filter((s) => !presentSet.has(s)).length;

  return (
    <div className="space-y-3">
      <div className="flex flex-wrap items-center gap-3 text-sm">
        <div className="flex items-center gap-2 text-slate-700">
          <Headphones className="w-4 h-4" aria-hidden="true" />
          <span className="font-medium">Tutor audio</span>
          {loading ? (
            <span className="text-slate-400">checking…</span>
          ) : status?.ready ? (
            <span className="text-emerald-700 inline-flex items-center gap-1">
              <CheckCircle2 className="w-3.5 h-3.5" /> all 6 segments ready
            </span>
          ) : (
            <span className="text-amber-700 inline-flex items-center gap-1">
              <AlertCircle className="w-3.5 h-3.5" /> {missingCount} missing
            </span>
          )}
          {status?.voice && (
            <span className="text-xs text-slate-500">
              voice <span className="font-mono">{status.voice}</span>
              {status.version !== null && (
                <> · v{status.version}</>
              )}
            </span>
          )}
        </div>

        <Button
          type="button"
          variant="outline"
          size="sm"
          className="gap-1.5 border-blue-200 text-blue-700 hover:bg-blue-50"
          onClick={() => generate(null, false)}
          disabled={busy !== null || loading}
        >
          {busy === "all" ? (
            <>
              <Loader2 className="w-3.5 h-3.5 animate-spin" /> Generating…
            </>
          ) : (
            <>
              <Headphones className="w-3.5 h-3.5" />
              {missingCount > 0 ? `Generate ${missingCount} missing` : "Regenerate all"}
            </>
          )}
        </Button>
      </div>

      <div
        role="table"
        aria-label="Audio segments"
        className="rounded border border-slate-200 divide-y divide-slate-100 text-sm"
      >
        {SEGMENTS.map((seg) => {
          const has = presentSet.has(seg);
          const url = status?.urls?.[seg];
          const isBusy = busy === seg;
          return (
            <div
              key={seg}
              role="row"
              className="flex items-center gap-2 px-3 py-2"
            >
              <span role="cell" className="w-32 font-medium text-slate-700">
                {SEGMENT_LABEL[seg]}
              </span>
              <span
                role="cell"
                className={`w-20 text-xs ${
                  has ? "text-emerald-700" : "text-amber-700"
                }`}
              >
                {has ? "ready" : "missing"}
              </span>
              <span role="cell" className="flex-1">
                {has && url ? (
                  <audio
                    controls
                    preload="none"
                    src={url}
                    className="h-8 max-w-xs"
                    aria-label={`Preview ${SEGMENT_LABEL[seg]} audio`}
                  />
                ) : (
                  <span className="text-xs text-slate-400">no preview</span>
                )}
              </span>
              <button
                type="button"
                onClick={() => generate([seg], true)}
                disabled={busy !== null || loading}
                className="inline-flex items-center gap-1 rounded border border-slate-300 bg-white px-2 py-1 text-xs hover:bg-slate-50 disabled:opacity-50"
                aria-label={`Regenerate ${SEGMENT_LABEL[seg]} audio`}
              >
                {isBusy ? (
                  <Loader2 className="w-3 h-3 animate-spin" />
                ) : has ? (
                  <RefreshCw className="w-3 h-3" />
                ) : (
                  <Play className="w-3 h-3" />
                )}
                {has ? "Regenerate" : "Generate"}
              </button>
            </div>
          );
        })}
      </div>
    </div>
  );
}
