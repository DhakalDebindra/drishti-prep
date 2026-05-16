import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Lang } from "@/components/ui/Lang";
import { AudioBatchClient } from "./AudioBatchClient";

export const dynamic = "force-dynamic";

type SetRow = {
  id: string;
  title: string;
  topicName: string;
  subjectName: string;
  total: number;
  ready: number;
};

export default async function AudioBatchPage() {
  const supabase = await createClient();

  const [setsRes, questionsRes, spendRes] = await Promise.all([
    (supabase as any)
      .from("question_sets")
      .select(
        `id, title, topics!inner ( name, subjects!inner ( name ) )`
      )
      .order("created_at", { ascending: false }),
    (supabase as any).from("questions").select("set_id, audio_ready"),
    (supabase as any).from("audio_generation_log").select("cost_micro_usd"),
  ]);

  const sets = (setsRes.data ?? []) as Array<{
    id: string;
    title: string;
    topics: { name: string; subjects: { name: string } };
  }>;
  const questions = (questionsRes.data ?? []) as Array<{
    set_id: string;
    audio_ready: boolean;
  }>;
  const spend = (spendRes.data ?? []) as Array<{ cost_micro_usd: number | null }>;

  const statsBySet = new Map<string, { total: number; ready: number }>();
  for (const q of questions) {
    const s = statsBySet.get(q.set_id) ?? { total: 0, ready: 0 };
    s.total += 1;
    if (q.audio_ready) s.ready += 1;
    statsBySet.set(q.set_id, s);
  }

  const rows: SetRow[] = sets.map((s) => {
    const stat = statsBySet.get(s.id) ?? { total: 0, ready: 0 };
    return {
      id: s.id,
      title: s.title,
      topicName: s.topics?.name ?? "",
      subjectName: s.topics?.subjects?.name ?? "",
      total: stat.total,
      ready: stat.ready,
    };
  });

  const totalMicroUsd = spend.reduce((sum, r) => sum + (r.cost_micro_usd ?? 0), 0);
  const totalUsd = totalMicroUsd / 1_000_000;
  const totalNpr = totalUsd * 136; // approx exchange rate; for display only

  const totalQuestions = rows.reduce((a, r) => a + r.total, 0);
  const totalReady = rows.reduce((a, r) => a + r.ready, 0);
  const missing = totalQuestions - totalReady;
  const estMissingUsd = missing * 0.0166;

  return (
    <div className="container mx-auto py-8 space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-900">Audio Library</h1>
        <p className="text-slate-500 mt-1">
          Pre-generate Nepali Shruti voice audio for question sets. Audio is cached
          forever in Storage; each question generates once and is then free to play.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm text-slate-500">Coverage</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">
              {totalReady} / {totalQuestions}
            </div>
            <p className="text-sm text-slate-500">
              questions with audio
              {totalQuestions > 0 && (
                <> ({Math.round((totalReady / totalQuestions) * 100)}%)</>
              )}
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm text-slate-500">Spent to date</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">
              ${totalUsd.toFixed(2)}
            </div>
            <p className="text-sm text-slate-500">≈ Rs {Math.round(totalNpr)}</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm text-slate-500">Remaining estimate</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900">
              ${estMissingUsd.toFixed(2)}
            </div>
            <p className="text-sm text-slate-500">
              to cover the remaining {missing} questions
            </p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Question sets</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="bg-slate-50/80 text-slate-500 uppercase text-[11px] font-bold tracking-widest border-b border-slate-200">
                <tr>
                  <th className="px-6 py-4">Set</th>
                  <th className="px-6 py-4">Curriculum</th>
                  <th className="px-6 py-4">Coverage</th>
                  <th className="px-6 py-4 text-right">Action</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {rows.map((row) => (
                  <tr key={row.id} className="hover:bg-blue-50/30">
                    <td className="px-6 py-4">
                      <div className="font-semibold text-slate-900">
                        <Lang>{row.title}</Lang>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-slate-600">
                      <div className="text-xs">
                        <Lang>{row.subjectName}</Lang> →{" "}
                        <Lang>{row.topicName}</Lang>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="w-32 bg-slate-200 rounded-full h-2 overflow-hidden">
                          <div
                            className="h-full bg-emerald-500"
                            style={{
                              width:
                                row.total === 0
                                  ? "0%"
                                  : `${(row.ready / row.total) * 100}%`,
                            }}
                          />
                        </div>
                        <span className="text-xs text-slate-600 font-mono">
                          {row.ready}/{row.total}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <AudioBatchClient
                        setId={row.id}
                        setTitle={row.title}
                        total={row.total}
                        ready={row.ready}
                      />
                    </td>
                  </tr>
                ))}
                {rows.length === 0 && (
                  <tr>
                    <td colSpan={4} className="px-6 py-12 text-center text-slate-500">
                      No question sets yet.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
