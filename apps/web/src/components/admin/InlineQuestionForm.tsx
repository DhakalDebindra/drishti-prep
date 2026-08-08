import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { RichText } from "@/components/ui/RichText";
import { Loader2, Sparkles, Eye, EyeOff } from "lucide-react";
import toast from "react-hot-toast";
import { GenerateAudioButton } from "./GenerateAudioButton";

export function InlineQuestionForm({
  q,
  title,
  savingKey,
  onCancel,
  onSave,
  highlightCorrect = false,
  isNew = false
}: {
  q: any,
  title?: string,
  savingKey: string | null,
  onCancel: () => void,
  onSave: (updates: any) => void,
  highlightCorrect?: boolean,
  /** Draft mode: no audio panel yet (audio needs a saved question) and the
   *  primary action reads "Add question". */
  isNew?: boolean
}) {
  const [isGenerating, setIsGenerating] = useState(false);
  const [explanationText, setExplanationText] = useState<string>(q.explanation || "");
  const [showPreview, setShowPreview] = useState(false);

  const isSaving = savingKey === q.id || savingKey === 'question';

  const readField = (id: string) =>
    (document.getElementById(id) as HTMLInputElement | HTMLTextAreaElement | null)?.value ?? "";

  const collectValues = () => ({
    content: readField(`edit-content-${q.id}`).trim(),
    option_a: readField(`edit-a-${q.id}`).trim(),
    option_b: readField(`edit-b-${q.id}`).trim(),
    option_c: readField(`edit-c-${q.id}`).trim(),
    option_d: readField(`edit-d-${q.id}`).trim(),
    correct_option: readField(`edit-correct-${q.id}`).trim().toUpperCase(),
  });

  const handleAiGenerate = async () => {
    try {
      const values = collectValues();

      if (!values.content || !values.correct_option) {
        toast.error("Please fill in the question and correct option first");
        return;
      }

      setIsGenerating(true);
      const res = await fetch("/api/admin/generate-explanation", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(values)
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to generate explanation");

      setExplanationText(data.explanation);
      setShowPreview(true);
      toast.success("Explanation generated!");
    } catch (err: any) {
      toast.error(err.message || "Something went wrong");
    } finally {
      setIsGenerating(false);
    }
  };

  const handleSave = () => {
    if (isSaving || isGenerating) return;

    const values = collectValues();

    const missing = [
      ["Question content", values.content],
      ["Option A", values.option_a],
      ["Option B", values.option_b],
      ["Option C", values.option_c],
      ["Option D", values.option_d],
    ].filter(([, value]) => !value).map(([label]) => label);

    if (missing.length > 0) {
      toast.error(`Please fill in: ${missing.join(", ")}`);
      return;
    }

    if (!["A", "B", "C", "D"].includes(values.correct_option)) {
      toast.error("Correct option must be A, B, C or D");
      return;
    }

    onSave({ ...values, explanation: explanationText });
  };

  return (
    <Card className="border-blue-400 border-2">
      {title && (
        <CardHeader>
          <CardTitle>{title}</CardTitle>
        </CardHeader>
      )}
      <CardContent
        className={title ? "space-y-4" : "space-y-4 pt-6"}
        onKeyDown={(e) => {
          if ((e.ctrlKey || e.metaKey) && e.key === "Enter") {
            e.preventDefault();
            handleSave();
          }
        }}
      >
        <div>
          <label htmlFor={`edit-content-${q.id}`} className="text-sm font-medium">Question Content</label>
          <Textarea
            lang="ne"
            defaultValue={q.content}
            id={`edit-content-${q.id}`}
            rows={4}
            autoFocus
          />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div><label htmlFor={`edit-a-${q.id}`} className="text-sm text-muted-foreground">Option A</label><Input lang="ne" defaultValue={q.option_a} id={`edit-a-${q.id}`} /></div>
          <div><label htmlFor={`edit-b-${q.id}`} className="text-sm text-muted-foreground">Option B</label><Input lang="ne" defaultValue={q.option_b} id={`edit-b-${q.id}`} /></div>
          <div><label htmlFor={`edit-c-${q.id}`} className="text-sm text-muted-foreground">Option C</label><Input lang="ne" defaultValue={q.option_c} id={`edit-c-${q.id}`} /></div>
          <div><label htmlFor={`edit-d-${q.id}`} className="text-sm text-muted-foreground">Option D</label><Input lang="ne" defaultValue={q.option_d} id={`edit-d-${q.id}`} /></div>
        </div>
        <div>
          <label htmlFor={`edit-correct-${q.id}`} className={`text-sm font-medium ${highlightCorrect ? 'text-red-600 font-bold' : ''}`}>Correct Option (A, B, C, D)</label>
          <Input defaultValue={q.correct_option} id={`edit-correct-${q.id}`} className={highlightCorrect ? 'border-red-300 font-bold' : ''} />
        </div>
        <div className="space-y-2">
          <div className="flex justify-between items-center">
            <label htmlFor={`edit-explanation-${q.id}`} className="text-sm font-medium">General Explanation</label>
            <div className="flex gap-2">
              {explanationText && (
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  className="h-7 text-[10px] gap-1.5 text-slate-600 hover:text-slate-900"
                  onClick={() => setShowPreview((p) => !p)}
                >
                  {showPreview ? <EyeOff className="w-3 h-3" /> : <Eye className="w-3 h-3" />}
                  {showPreview ? "Edit" : "Preview"}
                </Button>
              )}
              <Button
                type="button"
                variant="outline"
                size="sm"
                className="h-7 text-[10px] gap-1.5 border-blue-200 text-blue-700 hover:bg-blue-50"
                onClick={handleAiGenerate}
                disabled={isGenerating}
              >
                {isGenerating ? (
                  <>
                    <Loader2 className="w-3 h-3 animate-spin" />
                    Generating...
                  </>
                ) : (
                  <>
                    <Sparkles className="w-3 h-3" />
                    AI Generate
                  </>
                )}
              </Button>
            </div>
          </div>

          {showPreview && explanationText ? (
            <div className="min-h-[76px] rounded-md border border-blue-200 bg-blue-50 p-3 text-sm text-blue-900 leading-relaxed [&_ul]:mt-1 [&_li]:ml-3">
              <RichText>{explanationText}</RichText>
            </div>
          ) : (
            <Textarea
              lang="ne"
              id={`edit-explanation-${q.id}`}
              value={explanationText}
              onChange={(e) => setExplanationText(e.target.value)}
              rows={4}
              placeholder="Generate with AI or type manually…"
            />
          )}
        </div>

        {/* Save sits directly after the fields so it is one tab away — the
            audio panel below is collapsed and stays out of the tab order. */}
        <div className="flex flex-wrap gap-2 justify-end items-center pt-4 border-t">
          <p className="mr-auto text-xs text-slate-500">
            Press <kbd className="rounded border border-slate-300 bg-slate-100 px-1 py-0.5 font-mono text-[10px]">Ctrl</kbd>
            {" + "}
            <kbd className="rounded border border-slate-300 bg-slate-100 px-1 py-0.5 font-mono text-[10px]">Enter</kbd>
            {" "}to save from any field.
          </p>
          <Button variant="ghost" onClick={onCancel}>{isNew ? "Close" : "Cancel"}</Button>
          <Button
            disabled={isSaving || isGenerating}
            aria-live="polite"
            onClick={handleSave}
          >
            {isSaving
              ? (isNew ? "Adding..." : "Saving...")
              : (isNew ? "Add Question" : "Save Changes")}
          </Button>
        </div>

        {isNew ? (
          <p className="text-xs text-slate-500">
            Tutor audio can be generated once the question is saved. After
            adding, open it from the list to generate audio.
          </p>
        ) : (
          <div className="space-y-2">
            <GenerateAudioButton
              questionId={q.id}
              initialReady={q.audio_ready ?? null}
              initialVoice={q.audio_voice ?? null}
            />
            <p className="text-xs text-slate-500">
              Audio is generated from the saved version. If you&apos;ve edited the
              text above, save first. The trigger will mark audio as outdated
              and you can regenerate.
            </p>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
