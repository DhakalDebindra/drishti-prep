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
import { Loader2 } from "lucide-react";
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
  const [subtopics, setSubtopics] = useState<any[]>([]);
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

  const subjectIdValue = watch("subject_id");
  const topicIdValue = watch("topic_id");
  const subtopicIdValue = watch("subtopic_id");

  const topicListId = useId();
  const subjectListId = useId();

  // Load topics and subjects
  useEffect(() => {
    if (!isOpen) return;

    const loadData = async () => {
      setLoading(true);
      try {
        const [tRes, sRes, stRes] = await Promise.all([
          fetch("/api/topics"),
          fetch("/api/subjects"),
          fetch("/api/subtopics"),
        ]);
        const topicsData = await tRes.json();
        const subjectsData = await sRes.json();
        const subtopicsData = await stRes.json();

        setTopics(topicsData);
        setSubjects(subjectsData.sort((a: any, b: any) => a.name.localeCompare(b.name)));
        setSubtopics(subtopicsData);

        const currentTopic = topicsData.find((t: any) => t.id === questionSet.topic_id);
        
        reset({
          title: questionSet.title,
          difficulty_level: questionSet.difficulty_level,
          set_type: questionSet.set_type,
          is_verified: questionSet.is_verified,
          subject_id: currentTopic?.subject_id || "",
          topic_id: questionSet.topic_id || "",
          subtopic_id: questionSet.subtopic_id || null,
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
    return subjects.find((s) => s.id === subjectIdValue);
  }, [subjects, subjectIdValue]);

  const filteredTopics = useMemo(() => {
    if (!matchedSubject) return [];
    return topics.filter((t) => t.subject_id === matchedSubject.id);
  }, [topics, matchedSubject]);

  const matchedTopic = useMemo(() => {
    return filteredTopics.find((t) => t.id === topicIdValue);
  }, [filteredTopics, topicIdValue]);

  const filteredSubtopics = useMemo(() => {
    if (!matchedTopic) return [];
    return subtopics.filter((st: any) => st.topic_id === matchedTopic.id);
  }, [subtopics, matchedTopic]);

  const matchedSubtopic = useMemo(() => {
    return filteredSubtopics.find((st: any) => st.id === subtopicIdValue);
  }, [filteredSubtopics, subtopicIdValue]);

  const onSubmit: SubmitHandler<QuestionSetEditFormValues> = async (values) => {
    setIsSubmitting(true);
    setError(null);
    try {
      await onSave({
        title: values.title,
        difficulty_level: values.difficulty_level,
        set_type: values.set_type,
        is_verified: values.is_verified,
        topic_id: values.topic_id,
        subtopic_id: values.subtopic_id,
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
                subjectsError={null}
                subjectCreationError={null}
                onSubjectChange={() => { setValue("topic_id", ""); setValue("subtopic_id", null); }}
                onTopicChange={() => { setValue("subtopic_id", null); }}
                topicsLoading={false}
                filteredTopics={filteredTopics}
                topicsError={null}
                topicCreationError={null}
                subtopicsLoading={false}
                filteredSubtopics={filteredSubtopics}
                subtopicsError={null}
                subtopicCreationError={null}
                matchedTopic={matchedTopic}
                matchedSubject={matchedSubject}
                matchedSubtopic={matchedSubtopic}
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
