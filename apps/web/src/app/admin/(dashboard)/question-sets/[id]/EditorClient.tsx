"use client";

import { useEffect, useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { useManageQuestionSet } from "@/hooks/admin/useManageQuestionSet";
import { useManageQuestions } from "@/hooks/admin/useManageQuestions";
import { InlineQuestionForm } from "@/components/admin/InlineQuestionForm";
import { EditQuestionSetDialog } from "@/components/admin/EditQuestionSetDialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger
} from "@/components/ui/alert-dialog";
import { RichText } from "@/components/ui/RichText";
import { Settings, Trash2, Loader2, Globe, Lock, Plus } from "lucide-react";

/** House standard for a practice set; sets below this are flagged as short. */
const TARGET_QUESTION_COUNT = 20;

/** Stable DOM key for the unsaved draft question (field ids, saving key). */
const DRAFT_ID = "new-question";

const BLANK_QUESTION = {
  id: DRAFT_ID,
  content: "",
  option_a: "",
  option_b: "",
  option_c: "",
  option_d: "",
  correct_option: "",
  explanation: ""
};

export default function EditorClient({ initialSet, initialQuestions }: { initialSet: any, initialQuestions: any[] }) {
  const { 
    questionSet, 
    savingKey: setSavingKey, 
    togglePublishStatus, 
    updateQuestionSet, 
    deleteQuestionSet 
  } = useManageQuestionSet(initialSet);
  
  const {
    questions,
    editingId,
    savingKey: questionsSavingKey,
    creating,
    setEditingId,
    addQuestion,
    updateQuestion,
    moveQuestion
  } = useManageQuestions(initialQuestions, initialSet.id);

  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isAdding, setIsAdding] = useState(false);
  // Bumped after each successful add so the draft form remounts empty,
  // ready for the next question without a round trip through the list.
  const [draftKey, setDraftKey] = useState(0);
  const draftRef = useRef<HTMLDivElement>(null);

  const activeCount = questions.filter(q => q.status !== 'deprecated').length;
  const shortBy = TARGET_QUESTION_COUNT - activeCount;

  useEffect(() => {
    if (isAdding) {
      draftRef.current?.scrollIntoView({ behavior: "smooth", block: "center" });
    }
  }, [isAdding, draftKey]);

  const openDraft = () => {
    setEditingId(null);
    setIsAdding(true);
  };

  return (
    <div className="space-y-6">
      {/* Header / Toolbar */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center bg-white p-6 rounded-xl border shadow-sm gap-4">
        <div>
          <div className="flex items-center gap-3 mb-1">
            <h1 className="text-2xl font-bold text-slate-900">{questionSet.title}</h1>
            <span className={`text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-full ${
              questionSet.is_verified 
                ? "bg-emerald-100 text-emerald-700 border border-emerald-200" 
                : "bg-amber-100 text-amber-700 border border-amber-200"
            }`}>
              {questionSet.is_verified ? "Published" : "Draft"}
            </span>
          </div>
          <p className="text-slate-500 text-sm flex flex-wrap items-center gap-x-4 gap-y-2">
            <span className="flex items-center gap-1.5">
              <span className="w-1.5 h-1.5 rounded-full bg-blue-500"></span>
              Questions: {questions.length} ({activeCount} active)
            </span>
            <span className="flex items-center gap-1.5 capitalize">
               {questionSet.set_type.replace('_', ' ')}
            </span>
            {shortBy > 0 && (
              <span className="rounded-full border border-amber-200 bg-amber-50 px-2 py-0.5 text-xs font-medium text-amber-800">
                {shortBy} short of the {TARGET_QUESTION_COUNT}-question target
              </span>
            )}
          </p>
        </div>

        <div className="flex flex-wrap items-center gap-2">
          {/* Add Question Button */}
          <Button
            variant="outline"
            size="sm"
            onClick={openDraft}
            className="gap-2 border-blue-200 text-blue-700 hover:bg-blue-50"
            aria-label="Add a new question to this set"
          >
            <Plus className="w-4 h-4" />
            Add Question
          </Button>

          {/* Settings Button */}
          <Button 
            variant="outline" 
            size="sm"
            onClick={() => setIsEditOpen(true)}
            className="gap-2"
            aria-label="Edit question set settings"
          >
            <Settings className="w-4 h-4" />
            Settings
          </Button>

          {/* Delete Button with Confirmation */}
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button 
                variant="outline" 
                size="sm"
                className="gap-2 text-red-600 hover:text-red-700 hover:bg-red-50 border-red-100"
                aria-label="Delete question set"
              >
                <Trash2 className="w-4 h-4" />
                Delete
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent>
              <AlertDialogHeader>
                <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                <AlertDialogDescription>
                  This action <strong>cannot be undone</strong>. This will permanently delete the 
                  <strong> {questionSet.title}</strong> question set, all of its questions, 
                  and all associated records.
                </AlertDialogDescription>
              </AlertDialogHeader>
              <AlertDialogFooter>
                <AlertDialogCancel disabled={setSavingKey === 'deleting'}>Cancel</AlertDialogCancel>
                <Button 
                  onClick={async (e) => {
                    e.preventDefault();
                    console.log("Starting deletion for:", questionSet.id);
                    try {
                      await deleteQuestionSet();
                    } catch (err) {
                      console.error("Critical Delete Error:", err);
                    }
                  }}
                  disabled={setSavingKey === 'deleting'}
                  className="bg-red-600 hover:bg-red-700 text-white"
                >
                  {setSavingKey === 'deleting' ? (
                    <>
                      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      Deleting...
                    </>
                  ) : (
                    "Delete Everything"
                  )}
                </Button>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>

          <div className="h-6 w-px bg-slate-200 mx-1 hidden sm:block"></div>

          {/* Publish Toggle Button */}
          <Button 
            variant={questionSet.is_verified ? "outline" : "default"}
            size="sm"
            onClick={togglePublishStatus}
            disabled={setSavingKey === 'set'}
            className="gap-2 min-w-[140px]"
            aria-live="polite"
          >
            {setSavingKey === 'set' ? (
              <Loader2 className="w-4 h-4 animate-spin" />
            ) : questionSet.is_verified ? (
              <Lock className="w-4 h-4" />
            ) : (
              <Globe className="w-4 h-4" />
            )}
            {setSavingKey === 'set' ? "Saving..." : (questionSet.is_verified ? "Revert to Draft" : "Publish Set")}
          </Button>
        </div>
      </div>

      {/* Edit Settings Dialog */}
      <EditQuestionSetDialog 
        isOpen={isEditOpen} 
        onClose={() => setIsEditOpen(false)}
        questionSet={questionSet}
        onSave={updateQuestionSet}
      />

      {/* Question List */}
      <div className="space-y-4">
        {questions.length === 0 && (
          <div className="text-center py-12 bg-slate-50 rounded-xl border-2 border-dashed border-slate-200">
             <p className="text-slate-400">No questions in this set yet.</p>
          </div>
        )}
        {questions.map((q, index) => {
          const isEditing = editingId === q.id;
          const isDeprecated = q.status === 'deprecated';

          if (isEditing) {
            return (
              <InlineQuestionForm
                key={q.id}
                q={q}
                title={`Editing Question ${q.order_number}`}
                savingKey={questionsSavingKey}
                onCancel={() => setEditingId(null)}
                onSave={(updates) => updateQuestion(q.id, updates)}
              />
            );
          }

          return (
            <Card key={q.id} className={isDeprecated ? "opacity-60 bg-gray-50 border-slate-200 strike bg-diagonal-stripes" : "border-slate-200 hover:border-slate-300 transition-colors"}>
              {isDeprecated && <span className="sr-only">Status: Deprecated</span>}
              <CardContent className="p-4 flex flex-col md:flex-row gap-4">
                <div className="flex md:flex-col items-center justify-center space-x-2 md:space-x-0 md:space-y-1">
                  <Button 
                    aria-label={`Move question ${q.order_number} up`} 
                    variant="ghost" 
                    size="sm" 
                    onClick={() => moveQuestion(index, 'up')} 
                    disabled={index === 0}
                    className="h-8 w-8 p-0"
                  >
                    ▲
                  </Button>
                  <span className="font-bold text-slate-700">{q.order_number}</span>
                  <Button 
                    aria-label={`Move question ${q.order_number} down`} 
                    variant="ghost" 
                    size="sm" 
                    onClick={() => moveQuestion(index, 'down')} 
                    disabled={index === questions.length - 1}
                    className="h-8 w-8 p-0"
                  >
                    ▼
                  </Button>
                </div>
                
                <div className="flex-1 space-y-2">
                  <p 
                    id={`q-content-${q.id}`}
                    className={`font-medium text-slate-800 ${isDeprecated ? 'line-through text-slate-400' : ''}`}
                  >
                    {q.content}
                  </p>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-sm">
                    <div className={`p-2 rounded border ${q.correct_option === 'A' ? 'bg-emerald-50 border-emerald-200 text-emerald-800 font-bold' : 'bg-slate-50 border-slate-100 text-slate-600'}`}>
                      <span className="opacity-60 mr-2">A:</span> {q.option_a}
                    </div>
                    <div className={`p-2 rounded border ${q.correct_option === 'B' ? 'bg-emerald-50 border-emerald-200 text-emerald-800 font-bold' : 'bg-slate-50 border-slate-100 text-slate-600'}`}>
                      <span className="opacity-60 mr-2">B:</span> {q.option_b}
                    </div>
                    <div className={`p-2 rounded border ${q.correct_option === 'C' ? 'bg-emerald-50 border-emerald-200 text-emerald-800 font-bold' : 'bg-slate-50 border-slate-100 text-slate-600'}`}>
                      <span className="opacity-60 mr-2">C:</span> {q.option_c}
                    </div>
                    <div className={`p-2 rounded border ${q.correct_option === 'D' ? 'bg-emerald-50 border-emerald-200 text-emerald-800 font-bold' : 'bg-slate-50 border-slate-100 text-slate-600'}`}>
                      <span className="opacity-60 mr-2">D:</span> {q.option_d}
                    </div>
                  </div>
                  {q.explanation && (
                    <div className="bg-blue-50 border border-blue-100 p-3 rounded-lg text-xs text-blue-800">
                      <span className="font-bold block mb-1">Explanation:</span>
                      <RichText className="leading-relaxed [&_ul]:mt-1 [&_li]:ml-3">{q.explanation}</RichText>
                    </div>
                  )}
                  {isDeprecated && (
                    <span className="inline-block mt-2 bg-red-100 text-red-800 text-xs px-2 py-0.5 rounded font-medium">Deprecated</span>
                  )}
                </div>

                <div className="flex flex-col space-y-2 min-w-[130px]">
                  <Button 
                    variant="outline" 
                    size="sm" 
                    onClick={() => setEditingId(q.id)}
                    className="w-full justify-start gap-2"
                  >
                    Edit Content
                  </Button>
                  <Button 
                    variant={isDeprecated ? "outline" : "ghost"} 
                    size="sm"
                    disabled={questionsSavingKey === q.id}
                    onClick={() => updateQuestion(q.id, { status: isDeprecated ? 'active' : 'deprecated' })}
                    className={`w-full justify-start gap-2 ${isDeprecated ? 'border-amber-200 text-amber-700 hover:bg-amber-50' : 'text-slate-400 hover:text-red-600 hover:bg-red-50'}`}
                  >
                    {isDeprecated ? "Restore Question" : "Deprecate"}
                  </Button>
                </div>
              </CardContent>
            </Card>
          );
        })}

        {/* Add a question to this set */}
        <div ref={draftRef}>
          {isAdding ? (
            <InlineQuestionForm
              key={`draft-${draftKey}`}
              q={BLANK_QUESTION}
              title={`New Question ${questions.length + 1}`}
              isNew
              savingKey={creating ? DRAFT_ID : null}
              onCancel={() => setIsAdding(false)}
              onSave={async (values) => {
                const added = await addQuestion(values);
                if (added) setDraftKey(k => k + 1);
              }}
            />
          ) : (
            <Button
              variant="outline"
              onClick={openDraft}
              className="w-full h-auto justify-center gap-2 border-2 border-dashed border-slate-300 py-6 text-slate-600 hover:border-blue-400 hover:bg-blue-50 hover:text-blue-700"
            >
              <Plus className="w-4 h-4" />
              Add question {questions.length + 1} to this set
            </Button>
          )}
        </div>
      </div>
    </div>
  );
}
