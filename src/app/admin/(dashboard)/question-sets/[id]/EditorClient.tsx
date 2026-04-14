"use client";

import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { useManageQuestionSet } from "@/hooks/admin/useManageQuestionSet";
import { useManageQuestions } from "@/hooks/admin/useManageQuestions";
import { InlineQuestionForm } from "@/components/admin/InlineQuestionForm";

export default function EditorClient({ initialSet, initialQuestions }: { initialSet: any, initialQuestions: any[] }) {
  const { questionSet, savingKey: setSavingKey, togglePublishStatus } = useManageQuestionSet(initialSet);
  const { questions, editingId, savingKey, setEditingId, updateQuestion, moveQuestion } = useManageQuestions(initialQuestions, initialSet.id);

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
          disabled={setSavingKey === 'set'}
          aria-live="polite"
        >
          {setSavingKey === 'set' ? "Saving..." : (questionSet.is_verified ? "Revert to Draft" : "Publish Set")}
        </Button>
      </div>

      <div className="space-y-4">
        {questions.map((q, index) => {
          const isEditing = editingId === q.id;
          const isDeprecated = q.status === 'deprecated';

          if (isEditing) {
            return (
              <InlineQuestionForm
                key={q.id}
                q={q}
                title={`Editing Question ${q.order_number}`}
                savingKey={savingKey}
                onCancel={() => setEditingId(null)}
                onSave={(updates) => updateQuestion(q.id, updates)}
              />
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
