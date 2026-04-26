"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Info } from "lucide-react";

interface SetMetadataFormProps {
  register: any;
  errors: any;
  subjectListId: string;
  topicListId: string;
  subjects: any[];
  subjectsLoading: boolean;
  isCreatingSubject: boolean;
  subjectsError: string | null;
  subjectCreationError: string | null;
  onSubjectChange: (e: any) => void;
  topicsLoading: boolean;
  filteredTopics: any[];
  topicsError: string | null;
  topicCreationError: string | null;
  matchedTopic: any;
  matchedSubject: any;
  submissionMessage: string | null;
  submissionError: string | null;
}

export function SetMetadataForm({
  register,
  errors,
  subjectListId,
  topicListId,
  subjects,
  subjectsLoading,
  isCreatingSubject,
  subjectsError,
  subjectCreationError,
  onSubjectChange,
  topicsLoading,
  filteredTopics,
  topicsError,
  topicCreationError,
  matchedTopic,
  matchedSubject,
  submissionMessage,
  submissionError,
}: SetMetadataFormProps) {
  return (
    <Card className="shadow-sm border-slate-200">
      <CardHeader className="border-b bg-slate-50/30">
        <CardTitle className="text-xl font-bold flex items-center gap-2">
            <Info className="w-5 h-5 text-blue-500" />
            Set Configuration
        </CardTitle>
      </CardHeader>
      <CardContent className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 pt-6">
        
        {/* Title */}
        <div className="space-y-2 lg:col-span-2">
          <Label htmlFor="title" className="font-semibold text-slate-700">Set Title</Label>
          <Input lang="ne" id="title" {...register("title")} placeholder="E.g. Nepal Constitution - Set 1" className="bg-white" />
          {errors.title && <p className="text-xs text-red-500">{errors.title.message}</p>}
        </div>

        {/* Difficulty */}
        <div className="space-y-2">
          <Label htmlFor="difficulty_level" className="font-semibold text-slate-700">Difficulty (1-3)</Label>
          <Input
            id="difficulty_level"
            type="number"
            min="1"
            max="3"
            {...register("difficulty_level")}
            className="bg-white"
          />
          {errors.difficulty_level && <p className="text-xs text-red-500">{errors.difficulty_level.message}</p>}
        </div>

        {/* Subject Lookup */}
        <div className="space-y-2">
          <Label htmlFor="subject_id" className="font-semibold text-slate-700">Subject</Label>
          <select
            id="subject_id"
            {...register("subject_id")}
            onChange={onSubjectChange}
            disabled={subjectsLoading}
            lang="ne"
            className="flex h-10 w-full rounded-md border border-slate-200 bg-white px-3 py-2 text-sm ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
          >
            <option value="" disabled>Select a subject</option>
            {subjects.map((subject) => (
              <option key={subject.id} value={subject.id}>{subject.name}</option>
            ))}
          </select>
          {subjectsError && <p className="text-xs text-red-500">{subjectsError}</p>}
          {errors?.subject_id && <p className="text-xs text-red-500">{errors.subject_id.message}</p>}
        </div>

        {/* Topic Lookup */}
        <div className="space-y-2">
          <Label htmlFor="topic_id" className="font-semibold text-slate-700">Topic</Label>
          <select
            id="topic_id"
            {...register("topic_id")}
            disabled={topicsLoading || filteredTopics.length === 0}
            lang="ne"
            className="flex h-10 w-full rounded-md border border-slate-200 bg-white px-3 py-2 text-sm ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
          >
            <option value="" disabled>Select a topic</option>
            {filteredTopics.map((topic) => (
              <option key={topic.id} value={topic.id}>{topic.name}</option>
            ))}
          </select>
          {topicsError && <p className="text-xs text-red-500">{topicsError}</p>}
          {errors?.topic_id && <p className="text-xs text-red-500">{errors.topic_id.message}</p>}
        </div>

        {/* Set Type & Order - Phase 1 Enhancements */}
        <div className="space-y-2">
          <Label htmlFor="set_type" className="font-semibold text-slate-700">Set Type</Label>
          <select 
            id="set_type"
            {...register("set_type")}
            className="flex h-10 w-full rounded-md border border-slate-200 bg-white px-3 py-2 text-sm ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
            defaultValue="learning"
          >
            <option value="learning">Learning Path (Standard)</option>
            <option value="mock_exam">Mock Exam</option>
            <option value="daily_practice">Daily Practice</option>
            <option value="revision">Revision Set</option>
            <option value="custom">Custom Set</option>
          </select>
        </div>

        {/* Verification & Visibility */}
        <div className="flex items-center space-x-3 pt-8">
          <div className="flex h-10 items-center">
            <input 
                type="checkbox"
                id="is_verified"
                {...register("is_verified")}
                className="w-5 h-5 rounded border-slate-300 text-blue-600 focus:ring-blue-500 accent-blue-600"
            />
          </div>
          <div className="space-y-0.5">
            <Label htmlFor="is_verified" className="cursor-pointer font-semibold text-slate-700">Publish Set</Label>
            <p className="text-[10px] text-slate-400">Makes the set visible to learners.</p>
          </div>
        </div>

        <div className="lg:col-span-3">
          {submissionMessage && <p className="text-sm font-medium text-emerald-700 bg-emerald-50 p-3 rounded-lg border border-emerald-100">{submissionMessage}</p>}
          {submissionError && <p className="text-sm font-medium text-red-700 bg-red-50 p-3 rounded-lg border border-red-100">{submissionError}</p>}
        </div>

      </CardContent>
    </Card>
  );
}
