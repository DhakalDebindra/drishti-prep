"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

export default function ResolveClient({ question: initialQ, reports }: { question: any, reports: any[] }) {
  const router = useRouter();
  const [q, setQ] = useState(initialQ);
  const [isEditing, setIsEditing] = useState(false);
  const [savingKey, setSavingKey] = useState<string | null>(null);

  const updateQuestion = async (updates: any) => {
    setSavingKey('question');
    try {
      const res = await fetch(`/api/questions/${q.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updates)
      });
      if (!res.ok) throw new Error("Failed to update question");
      
      const updatedQ = await res.json();
      setQ(updatedQ);
      setIsEditing(false);
    } catch (e) {
      alert("Error updating question");
    } finally {
      setSavingKey(null);
    }
  };

  const markResolved = async () => {
    setSavingKey('resolve');
    try {
      const res = await fetch(`/api/reports/${q.id}/resolve`, {
        method: "POST"
      });
      if (!res.ok) throw new Error("Failed to mark as resolved");
      
      router.push('/admin/disputes');
      router.refresh(); // force reload of Inbox
    } catch (e) {
      alert("Error resolving dispute");
    } finally {
      setSavingKey(null);
    }
  };

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
                 <Card className="border-blue-400 border-2">
                 <CardHeader>
                   <CardTitle className="text-blue-700">Correcting Content</CardTitle>
                 </CardHeader>
                 <CardContent className="space-y-4">
                   <div>
                     <label htmlFor="edit-content" className="text-sm font-medium">Question Content</label>
                     <Textarea defaultValue={q.content} id="edit-content" rows={4} autoFocus />
                   </div>
                   <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                     <div><label htmlFor="edit-a" className="text-sm text-muted-foreground">Option A</label><Input defaultValue={q.option_a} id="edit-a" /></div>
                     <div><label htmlFor="edit-b" className="text-sm text-muted-foreground">Option B</label><Input defaultValue={q.option_b} id="edit-b" /></div>
                     <div><label htmlFor="edit-c" className="text-sm text-muted-foreground">Option C</label><Input defaultValue={q.option_c} id="edit-c" /></div>
                     <div><label htmlFor="edit-d" className="text-sm text-muted-foreground">Option D</label><Input defaultValue={q.option_d} id="edit-d" /></div>
                   </div>
                   <div>
                     <label htmlFor="edit-correct" className="text-sm font-bold text-red-600">Correct Option (A, B, C, D)</label>
                     <Input defaultValue={q.correct_option} id="edit-correct" className="border-red-300 font-bold" />
                   </div>
                   <div>
                     <label htmlFor="edit-explanation" className="text-sm font-medium">General Explanation</label>
                     <Textarea defaultValue={q.explanation} id="edit-explanation" rows={3} />
                   </div>
                   <div className="flex gap-2 justify-end mt-4 pt-4 border-t">
                     <Button variant="ghost" onClick={() => setIsEditing(false)}>Cancel</Button>
                     <Button 
                       disabled={savingKey === 'question'}
                       aria-live="polite"
                       onClick={() => {
                         const content = (document.getElementById("edit-content") as HTMLTextAreaElement).value;
                         const option_a = (document.getElementById("edit-a") as HTMLInputElement).value;
                         const option_b = (document.getElementById("edit-b") as HTMLInputElement).value;
                         const option_c = (document.getElementById("edit-c") as HTMLInputElement).value;
                         const option_d = (document.getElementById("edit-d") as HTMLInputElement).value;
                         const correct_option = (document.getElementById("edit-correct") as HTMLInputElement).value.toUpperCase();
                         const explanation = (document.getElementById("edit-explanation") as HTMLTextAreaElement).value;
                         updateQuestion({ content, option_a, option_b, option_c, option_d, correct_option, explanation });
                       }}>
                       {savingKey === 'question' ? 'Saving...' : 'Save Emergency Fix'}
                     </Button>
                   </div>
                 </CardContent>
               </Card>
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
