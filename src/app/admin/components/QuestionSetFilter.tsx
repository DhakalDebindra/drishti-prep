"use client";

import { useRouter, useSearchParams, usePathname } from "next/navigation";
import { 
  Select, 
  SelectContent, 
  SelectItem, 
  SelectTrigger, 
  SelectValue 
} from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { useEffect, useState } from "react";

interface Subject {
  id: string;
  name: string;
}

interface Topic {
  id: string;
  name: string;
  subject_id: string;
}

interface QuestionSetFilterProps {
  subjects: Subject[];
  topics: Topic[];
}

export function QuestionSetFilter({ subjects, topics }: QuestionSetFilterProps) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const pathname = usePathname();

  const currentSubjectId = searchParams.get("subjectId") || "all";
  const currentTopicId = searchParams.get("topicId") || "all";
  const currentPerPage = searchParams.get("perPage") || "10";

  const [filteredTopics, setFilteredTopics] = useState<Topic[]>(topics);

  // Narrow down topics when subject changes
  useEffect(() => {
    if (currentSubjectId === "all") {
      setFilteredTopics(topics);
    } else {
      setFilteredTopics(topics.filter(t => t.subject_id === currentSubjectId));
    }
  }, [currentSubjectId, topics]);

  const updateFilters = (key: string, value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value === "all") {
      params.delete(key);
      if (key === "subjectId") params.delete("topicId"); // Reset topic if subject resets
    } else {
      params.set(key, value);
      if (key === "subjectId") {
        params.delete("topicId"); // Reset topic if subject changes
      }
    }
    params.set("page", "1"); // Reset to page 1 on filter change
    router.push(`${pathname}?${params.toString()}`);
  };

  const resetFilters = () => {
    router.push(pathname);
  };

  return (
    <div className="flex flex-wrap items-end gap-4 bg-white p-4 rounded-xl border border-slate-200 shadow-sm mb-8">
      <div className="space-y-2 flex-1 min-w-[200px]">
        <Label htmlFor="subject-filter" className="text-slate-600 font-medium ml-1">Filter by Subject</Label>
        <Select 
          value={currentSubjectId} 
          onValueChange={(val) => updateFilters("subjectId", val)}
        >
          <SelectTrigger id="subject-filter" className="bg-slate-50 border-slate-200 focus:ring-blue-500 rounded-lg">
            <SelectValue placeholder="All Subjects" />
          </SelectTrigger>
          <SelectContent className="rounded-lg shadow-lg border-slate-200">
            <SelectItem value="all">All Subjects</SelectItem>
            {subjects.map((subject) => (
              <SelectItem key={subject.id} value={subject.id}>
                {subject.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      <div className="space-y-2 flex-1 min-w-[200px]">
        <Label htmlFor="topic-filter" className="text-slate-600 font-medium ml-1">Filter by Topic</Label>
        <Select 
          value={currentTopicId} 
          onValueChange={(val) => updateFilters("topicId", val)}
          disabled={currentSubjectId === "all" && filteredTopics.length === topics.length}
        >
          <SelectTrigger id="topic-filter" className="bg-slate-50 border-slate-200 focus:ring-blue-500 rounded-lg">
            <SelectValue placeholder="All Topics" />
          </SelectTrigger>
          <SelectContent className="rounded-lg shadow-lg border-slate-200">
            <SelectItem value="all">All Topics</SelectItem>
            {filteredTopics.map((topic) => (
              <SelectItem key={topic.id} value={topic.id}>
                {topic.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      <div className="space-y-2 w-[120px]">
        <Label htmlFor="per-page" className="text-slate-600 font-medium ml-1">Per Page</Label>
        <Select 
          value={currentPerPage} 
          onValueChange={(val) => updateFilters("perPage", val)}
        >
          <SelectTrigger id="per-page" className="bg-slate-50 border-slate-200 focus:ring-blue-500 rounded-lg">
            <SelectValue />
          </SelectTrigger>
          <SelectContent className="rounded-lg shadow-lg border-slate-200">
            <SelectItem value="10">10</SelectItem>
            <SelectItem value="20">20</SelectItem>
            <SelectItem value="30">30</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Button variant="ghost" onClick={resetFilters} className="text-slate-500 hover:text-slate-900 mb-0.5">
        Clear Filters
      </Button>
    </div>
  );
}
