"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

export default function EditorClient({ initialSet, initialQuestions }: { initialSet: any, initialQuestions: any[] }) {
  const [questionSet, setQuestionSet] = useState(initialSet);
  const [questions, setQuestions] = useState(initialQuestions);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [savingKey, setSavingKey] = useState<string | null>(null);

  const togglePublishStatus = async () => {
    setSavingKey('set');
    const newStatus = !questionSet.is_verified;
    try {
      const res = await fetch(`/api/question-sets/${questionSet.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ is_verified: newStatus })
      });
      if (!res.ok) throw new Error("Failed to update status");
      
      const payload = await res.json();
      setQuestionSet(payload);
    } catch (e) {
      alert("Error updating status");
    } finally {
      setSavingKey(null);
    }
  };

  const updateQuestion = async (id: string, updates: any) => {
    setSavingKey(id);
    try {
      const res = await fetch(`/api/questions/${id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updates)
      });
      if (!res.ok) throw new Error("Failed to update question");
      
      const updatedQ = await res.json();
      setQuestions(prev => prev.map(q => q.id === id ? updatedQ : q));
      setEditingId(null);
    } catch (e) {
      alert("Error updating question");
    } finally {
      setSavingKey(null);
    }
  };

  // Accessible drag and drop alias: Move up/down
  const moveQuestion = async (index: number, direction: 'up' | 'down') => {
    if (direction === 'up' && index === 0) return;
    if (direction === 'down' && index === questions.length - 1) return;

    const newQuestions = [...questions];
    const swapIndex = direction === 'up' ? index - 1 : index + 1;
    
    // Swap order_number
    const tempOrder = newQuestions[index].order_number;
    newQuestions[index].order_number = newQuestions[swapIndex].order_number;
    newQuestions[swapIndex].order_number = tempOrder;

    // Swap position in array for optimistic UI
    const tempQ = newQuestions[index];
    newQuestions[index] = newQuestions[swapIndex];
    newQuestions[swapIndex] = tempQ;
    
    setQuestions(newQuestions);

    // Save both
    await Promise.all([
      fetch(`/api/questions/${newQuestions[index].id}`, {
        method: "PATCH",
        headers:{ "Content-Type" : "application/json" },
        body: JSON.stringify({ order_number: newQuestions[index].order_number })
      }),
      fetch(`/api/questions/${newQuestions[swapIndex].id}`, {
        method: "PATCH",
        headers:{ "Content-Type" : "application/json" },
        body: JSON.stringify({ order_number: newQuestions[swapIndex].order_number })
      })
    ]);
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center bg-slate-50 p-4 rounded-lg border">
        <div>
          <h1 className="text-2xl font-bold">{questionSet.title}</h1>
          <p className="text-muted-foreground text-sm">
            Status: {questionSet.is_verified ? "Published" : "Draft"} | Questions: {questions.length}
          </p>
        </div>
        <Button 
          variant={questionSet.is_verified ? "outline" : "default"}
          onClick={togglePublishStatus}
          disabled={savingKey === 'set'}
          aria-live="polite"
        >
          {savingKey === 'set' ? "Saving..." : (questionSet.is_verified ? "Revert to Draft" : "Publish Set")}
        </Button>
      </div>

      <div className="space-y-4">
        {questions.map((q, index) => {
          const isEditing = editingId === q.id;
          const isDeprecated = q.status === 'deprecated';

          if (isEditing) {
            return (
              <Card key={q.id} className="border-blue-400 border-2">
                <CardHeader>
                  <CardTitle>Editing Question {q.order_number}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <label htmlFor={`edit-content-${q.id}`} className="text-sm font-medium">Question Content</label>
                    <Textarea 
                      defaultValue={q.content} 
                      id={`edit-content-${q.id}`} 
                      autoFocus
                    />
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div><label htmlFor={`edit-a-${q.id}`} className="text-sm">Option A</label><Input defaultValue={q.option_a} id={`edit-a-${q.id}`} /></div>
                    <div><label htmlFor={`edit-b-${q.id}`} className="text-sm">Option B</label><Input defaultValue={q.option_b} id={`edit-b-${q.id}`} /></div>
                    <div><label htmlFor={`edit-c-${q.id}`} className="text-sm">Option C</label><Input defaultValue={q.option_c} id={`edit-c-${q.id}`} /></div>
                    <div><label htmlFor={`edit-d-${q.id}`} className="text-sm">Option D</label><Input defaultValue={q.option_d} id={`edit-d-${q.id}`} /></div>
                  </div>
                  <div>
                    <label htmlFor={`edit-correct-${q.id}`} className="text-sm font-medium">Correct Option (A, B, C, D)</label>
                    <Input defaultValue={q.correct_option} id={`edit-correct-${q.id}`} />
                  </div>
                  <div>
                    <label htmlFor={`edit-explanation-${q.id}`} className="text-sm font-medium">General Explanation</label>
                    <Textarea defaultValue={q.explanation} id={`edit-explanation-${q.id}`} rows={3} />
                  </div>
                  <div className="flex gap-2 justify-end mt-4">
                    <Button variant="ghost" onClick={() => setEditingId(null)}>Cancel</Button>
                    <Button 
                      disabled={savingKey === q.id}
                      aria-live="polite"
                      onClick={() => {
                        const content = (document.getElementById(`edit-content-${q.id}`) as HTMLTextAreaElement).value;
                        const option_a = (document.getElementById(`edit-a-${q.id}`) as HTMLInputElement).value;
                        const option_b = (document.getElementById(`edit-b-${q.id}`) as HTMLInputElement).value;
                        const option_c = (document.getElementById(`edit-c-${q.id}`) as HTMLInputElement).value;
                        const option_d = (document.getElementById(`edit-d-${q.id}`) as HTMLInputElement).value;
                        const correct_option = (document.getElementById(`edit-correct-${q.id}`) as HTMLInputElement).value.toUpperCase();
                        const explanation = (document.getElementById(`edit-explanation-${q.id}`) as HTMLTextAreaElement).value;
                        updateQuestion(q.id, { content, option_a, option_b, option_c, option_d, correct_option, explanation });
                      }}>
                      {savingKey === q.id ? 'Saving...' : 'Save Changes'}
                    </Button>
                  </div>
                </CardContent>
              </Card>
            );
          }

          return (
            <Card key={q.id} className={isDeprecated ? "opacity-60 bg-gray-50 strike bg-diagonal-stripes" : ""}>
              {isDeprecated && <span className="sr-only">Status: Deprecated</span>}
              <CardContent className="p-4 flex flex-col md:flex-row gap-4">
                <div className="flex md:flex-col items-center justify-center space-x-2 md:space-x-0 md:space-y-1">
                  <Button 
                    aria-label="Move question up" 
                    aria-describedby={`q-content-${q.id}`}
                    variant="ghost" 
                    size="sm" 
                    onClick={() => moveQuestion(index, 'up')} 
                    disabled={index === 0}
                  >
                    ▲
                  </Button>
                  <span className="font-bold">{q.order_number}</span>
                  <Button 
                    aria-label="Move question down" 
                    aria-describedby={`q-content-${q.id}`}
                    variant="ghost" 
                    size="sm" 
                    onClick={() => moveQuestion(index, 'down')} 
                    disabled={index === questions.length - 1}
                  >
                    ▼
                  </Button>
                </div>
                
                <div className="flex-1 space-y-2">
                  <p 
                    id={`q-content-${q.id}`}
                    className={`font-medium ${isDeprecated ? 'line-through text-gray-500' : ''}`}
                  >
                    {q.content}
                  </p>
                  <div className="grid grid-cols-2 gap-2 text-sm text-muted-foreground">
                    <div className={q.correct_option === 'A' ? 'font-bold text-green-600' : ''}>A: {q.option_a}</div>
                    <div className={q.correct_option === 'B' ? 'font-bold text-green-600' : ''}>B: {q.option_b}</div>
                    <div className={q.correct_option === 'C' ? 'font-bold text-green-600' : ''}>C: {q.option_c}</div>
                    <div className={q.correct_option === 'D' ? 'font-bold text-green-600' : ''}>D: {q.option_d}</div>
                  </div>
                  {q.explanation && (
                    <p className="text-xs text-muted-foreground mt-2 bg-slate-50 p-2 rounded border italic">
                      Exp: {q.explanation}
                    </p>
                  )}
                  {isDeprecated && (
                    <span className="inline-block mt-2 bg-red-100 text-red-800 text-xs px-2 py-1 rounded">Deprecated</span>
                  )}
                </div>

                <div className="flex flex-col space-y-2 min-w-[120px]">
                  <Button 
                    variant="outline" 
                    size="sm" 
                    onClick={() => setEditingId(q.id)}
                  >
                    Edit Inline
                  </Button>
                  <Button 
                    variant={isDeprecated ? "default" : "destructive"} 
                    size="sm"
                    disabled={savingKey === q.id}
                    onClick={() => updateQuestion(q.id, { status: isDeprecated ? 'active' : 'deprecated' })}
                  >
                    {isDeprecated ? "Restore Object" : "Deprecate"}
                  </Button>
                </div>
              </CardContent>
            </Card>
          );
        })}
      </div>
    </div>
  );
}
