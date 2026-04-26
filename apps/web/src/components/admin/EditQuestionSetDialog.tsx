"use client";

import {
  questionSetEditSchema,
  type QuestionSetEditFormValues,
} from "@repo/validation";
import { useEffect, useState, useMemo, useId } from "react";
import { useForm, type SubmitHandler } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Plus, Loader2 } from "lucide-react";
import { SetMetadataForm } from "./SetMetadataForm";

interface EditQuestionSetDialogProps {
  isOpen: boolean;
  onClose: () => void;
  questionSet: any;
  onSave: (updates: any) => Promise<void>;
}

export function EditQuestionSetDialog({
  isOpen,
  onClose,
  questionSet,
  onSave,
}: EditQuestionSetDialogProps) {
  const [topics, setTopics] = useState<any[]>([]);
  const [subjects, setSubjects] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    setValue,
    watch,
    reset,
    formState: { errors },
  } = useForm<QuestionSetEditFormValues>({
    resolver: zodResolver(questionSetEditSchema as any) as any,
  });

  const subjectLookupValue = watch("subject_lookup");
  const topicLookupValue = watch("topic_lookup");
  const topicListId = useId();
  const subjectListId = useId();

  // Load topics and subjects
  useEffect(() => {
    if (!isOpen) return;

    const loadData = async () => {
      setLoading(true);
      try {
        const [tRes, sRes] = await Promise.all([
          fetch("/api/topics"),
          fetch("/api/subjects"),
        ]);
        const topicsData = await tRes.json();
        const subjectsData = await sRes.json();
        setTopics(topicsData);
        setSubjects(subjectsData.sort((a: any, b: any) => a.name.localeCompare(b.name)));

        // Try to find current topic and subject name
        const currentTopic = topicsData.find((t: any) => t.id === questionSet.topic_id);
        
        reset({
          title: questionSet.title,
          difficulty_level: questionSet.difficulty_level,
          set_type: questionSet.set_type,
          is_verified: questionSet.is_verified,
          topic_lookup: currentTopic?.name || "",
          subject_lookup: currentTopic?.subject_name || "",
        });
      } catch (e) {
        console.error("Failed to load metadata", e);
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [isOpen, questionSet, reset]);

  const matchedSubject = useMemo(() => {
    const val = subjectLookupValue?.trim().toLowerCase();
    return subjects.find((s) => s.name.toLowerCase() === val);
  }, [subjects, subjectLookupValue]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) return topics;
    return topics.filter((t) => t.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const matchedTopic = useMemo(() => {
    const val = topicLookupValue?.trim().toLowerCase();
    return filteredTopics.find((t) => t.name.toLowerCase() === val);
  }, [filteredTopics, topicLookupValue]);

  const onSubmit: SubmitHandler<QuestionSetEditFormValues> = async (values) => {
    setIsSubmitting(true);
    setError(null);
    try {
      let subjectId = matchedSubject?.id;
      if (!subjectId) {
        // Create subject if not exists
        const res = await fetch("/api/subjects", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ name: values.subject_lookup }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to create subject");
        subjectId = data.id;
      }

      let topicId = matchedTopic?.id;
      if (!topicId) {
        // Create topic if not exists
        const res = await fetch("/api/topics", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ name: values.topic_lookup, subject_id: subjectId }),
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to create topic");
        topicId = data.id;
      }

      await onSave({
        title: values.title,
        difficulty_level: values.difficulty_level,
        set_type: values.set_type,
        is_verified: values.is_verified,
        topic_id: topicId,
      });
      onClose();
    } catch (e: any) {
      setError(e.message);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Edit Question Set Settings</DialogTitle>
          <DialogDescription>
            Update the title, category, and visibility of this question set.
          </DialogDescription>
        </DialogHeader>

        <form id="edit-set-form" onSubmit={handleSubmit(onSubmit)}>
          {loading ? (
            <div className="flex items-center justify-center p-12">
              <Loader2 className="w-8 h-8 animate-spin text-blue-500" />
            </div>
          ) : (
            <div className="space-y-4 py-4">
              <SetMetadataForm
                register={register}
                errors={errors}
                subjectListId={subjectListId}
                topicListId={topicListId}
                subjects={subjects}
                subjectsLoading={false}
                isCreatingSubject={false}
                subjectsError={null}
                subjectCreationError={null}
                onSubjectChange={() => {}}
                topicsLoading={false}
                filteredTopics={filteredTopics}
                topicsError={null}
                topicCreationError={null}
                matchedTopic={matchedTopic}
                matchedSubject={matchedSubject}
                submissionMessage={null}
                submissionError={error}
              />
            </div>
          )}
        </form>

        <DialogFooter className="gap-2 sm:gap-0">
          <Button variant="ghost" onClick={onClose} disabled={isSubmitting}>
            Cancel
          </Button>
          <Button 
            type="submit" 
            form="edit-set-form" 
            disabled={isSubmitting || loading}
          >
            {isSubmitting ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Saving...
              </>
            ) : (
              "Save Changes"
            )}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
