"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { useManageDisputes } from "@/hooks/admin/useManageDisputes";
import { InlineQuestionForm } from "@/components/admin/InlineQuestionForm";

export default function ResolveClient({ question: initialQ, reports }: { question: any, reports: any[] }) {
  const router = useRouter();
  const [isEditing, setIsEditing] = useState(false);
  const { q, savingKey, updateQuestion, markResolved } = useManageDisputes(initialQ);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center pb-4 border-b">
        <div>
          <h1 className="text-2xl font-bold">Dispute Context View</h1>
          <p className="text-muted-foreground">Practice Set: {q.question_sets?.title || "Unknown"}</p>
        </div>
        <div className="flex gap-2">
            <Button variant="outline" onClick={() => router.push('/admin/disputes')}>Back to Inbox</Button>
            <Button 
               variant="default" 
               className="bg-green-600 hover:bg-green-700"
               onClick={markResolved}
               disabled={savingKey === 'resolve'}
               aria-live="polite"
            >
               {savingKey === 'resolve' ? "Resolving..." : "Mark as Resolved"}
            </Button>
        </div>
      </div>

      <div className="grid md:grid-cols-2 gap-6 items-start">
        {/* Left Side: Learner Reports */}
        <div className="space-y-4">
            <h2 className="text-lg font-bold">Learner Reports ({reports.length})</h2>
            {reports.map((report) => (
                <Card key={report.id} className="border-red-200 bg-red-50">
                    <CardHeader className="py-3 px-4">
                        <CardTitle className="text-sm font-semibold text-red-800">Issue: {report.issue_type}</CardTitle>
                        <CardDescription className="text-xs text-red-600">Reported on {new Date(report.created_at).toLocaleDateString()}</CardDescription>
                    </CardHeader>
                    <CardContent className="px-4 pb-4 text-sm text-red-900">
                        {report.description || <span className="italic opacity-70">No additional description provided.</span>}
                    </CardContent>
                </Card>
            ))}
        </div>

        {/* Right Side: Question Render & Edit */}
        <div className="space-y-4">
            <div className="flex justify-between items-center">
                <h2 className="text-lg font-bold">Flagged Question</h2>
                {!isEditing && (
                    <Button 
                      variant="outline" 
                      size="sm" 
                      onClick={() => setIsEditing(true)}
                    >
                      Edit to Fix
                    </Button>
                )}
            </div>

            {isEditing ? (
                 <InlineQuestionForm
                    q={q}
                    title="Correcting Content"
                    savingKey={savingKey}
                    highlightCorrect={true}
                    onCancel={() => setIsEditing(false)}
                    onSave={async (updates) => {
                      const success = await updateQuestion(updates);
                      if (success) setIsEditing(false);
                    }}
                 />
            ) : (
                <Card>
                    <CardContent className="p-6 space-y-4">
                        <p 
                          id="disputed-question-text"
                          className="font-semibold text-lg"
                        >
                          {q.content}
                        </p>
                        <div className="space-y-2 text-sm bg-slate-50 p-4 rounded-md border">
                            <div className={q.correct_option === 'A' ? 'font-bold text-green-700 bg-green-100 p-1 rounded' : 'p-1'}>A: {q.option_a}</div>
                            <div className={q.correct_option === 'B' ? 'font-bold text-green-700 bg-green-100 p-1 rounded' : 'p-1'}>B: {q.option_b}</div>
                            <div className={q.correct_option === 'C' ? 'font-bold text-green-700 bg-green-100 p-1 rounded' : 'p-1'}>C: {q.option_c}</div>
                            <div className={q.correct_option === 'D' ? 'font-bold text-green-700 bg-green-100 p-1 rounded' : 'p-1'}>D: {q.option_d}</div>
                        </div>
                        {q.explanation && (
                            <div className="pt-2 border-t">
                                <h4 className="font-semibold text-xs text-muted-foreground uppercase mb-1">Explanation</h4>
                                <p className="text-sm">{q.explanation}</p>
                            </div>
                        )}
                    </CardContent>
                </Card>
            )}

        </div>
      </div>
    </div>
  );
}
