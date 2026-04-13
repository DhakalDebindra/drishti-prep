import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export function InlineQuestionForm({ 
  q, 
  title,
  savingKey, 
  onCancel, 
  onSave, 
  highlightCorrect = false 
}: { 
  q: any, 
  title?: string,
  savingKey: string | null, 
  onCancel: () => void, 
  onSave: (updates: any) => void,
  highlightCorrect?: boolean
}) {
  return (
    <Card className="border-blue-400 border-2">
      {title && (
        <CardHeader>
          <CardTitle>{title}</CardTitle>
        </CardHeader>
      )}
      <CardContent className={title ? "space-y-4" : "space-y-4 pt-6"}>
        <div>
          <label htmlFor={`edit-content-${q.id}`} className="text-sm font-medium">Question Content</label>
          <Textarea 
            defaultValue={q.content} 
            id={`edit-content-${q.id}`} 
            rows={4}
            autoFocus
          />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div><label htmlFor={`edit-a-${q.id}`} className="text-sm text-muted-foreground">Option A</label><Input defaultValue={q.option_a} id={`edit-a-${q.id}`} /></div>
          <div><label htmlFor={`edit-b-${q.id}`} className="text-sm text-muted-foreground">Option B</label><Input defaultValue={q.option_b} id={`edit-b-${q.id}`} /></div>
          <div><label htmlFor={`edit-c-${q.id}`} className="text-sm text-muted-foreground">Option C</label><Input defaultValue={q.option_c} id={`edit-c-${q.id}`} /></div>
          <div><label htmlFor={`edit-d-${q.id}`} className="text-sm text-muted-foreground">Option D</label><Input defaultValue={q.option_d} id={`edit-d-${q.id}`} /></div>
        </div>
        <div>
          <label htmlFor={`edit-correct-${q.id}`} className={`text-sm font-medium ${highlightCorrect ? 'text-red-600 font-bold' : ''}`}>Correct Option (A, B, C, D)</label>
          <Input defaultValue={q.correct_option} id={`edit-correct-${q.id}`} className={highlightCorrect ? 'border-red-300 font-bold' : ''} />
        </div>
        <div>
          <label htmlFor={`edit-explanation-${q.id}`} className="text-sm font-medium">General Explanation</label>
          <Textarea defaultValue={q.explanation} id={`edit-explanation-${q.id}`} rows={3} />
        </div>
        <div className="flex gap-2 justify-end mt-4 pt-4 border-t">
          <Button variant="ghost" onClick={onCancel}>Cancel</Button>
          <Button 
            disabled={savingKey === q.id || savingKey === 'question'}
            aria-live="polite"
            onClick={() => {
              const content = (document.getElementById(`edit-content-${q.id}`) as HTMLTextAreaElement).value;
              const option_a = (document.getElementById(`edit-a-${q.id}`) as HTMLInputElement).value;
              const option_b = (document.getElementById(`edit-b-${q.id}`) as HTMLInputElement).value;
              const option_c = (document.getElementById(`edit-c-${q.id}`) as HTMLInputElement).value;
              const option_d = (document.getElementById(`edit-d-${q.id}`) as HTMLInputElement).value;
              const correct_option = (document.getElementById(`edit-correct-${q.id}`) as HTMLInputElement).value.toUpperCase();
              const explanation = (document.getElementById(`edit-explanation-${q.id}`) as HTMLTextAreaElement).value;
              onSave({ content, option_a, option_b, option_c, option_d, correct_option, explanation });
            }}>
            {(savingKey === q.id || savingKey === 'question') ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
