"use client";

import { useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ModuleTab } from "./ModuleTab";
import { SubjectTab } from "./SubjectTab";
import { TopicTab } from "./TopicTab";
import { SubtopicTab } from "./SubtopicTab";

interface CurriculumClientProps {
  initialModules: any[];
  initialSubjects: any[];
  initialTopics: any[];
  initialSubtopics: any[];
}

export function CurriculumClient({
  initialModules,
  initialSubjects,
  initialTopics,
  initialSubtopics,
}: CurriculumClientProps) {
  const [activeTab, setActiveTab] = useState("modules");

  return (
    <Tabs 
      defaultValue="modules" 
      value={activeTab} 
      onValueChange={setActiveTab}
      className="w-full"
    >
      <TabsList className="mb-4 grid w-full grid-cols-4 lg:w-[600px]" aria-label="Curriculum sections">
        <TabsTrigger value="modules">Modules</TabsTrigger>
        <TabsTrigger value="subjects">Subjects</TabsTrigger>
        <TabsTrigger value="topics">Topics</TabsTrigger>
        <TabsTrigger value="subtopics">Sub-topics</TabsTrigger>
      </TabsList>

      <TabsContent value="modules" className="space-y-4">
        <ModuleTab initialData={initialModules} />
      </TabsContent>

      <TabsContent value="subjects" className="space-y-4">
        <SubjectTab initialData={initialSubjects} initialModules={initialModules} />
      </TabsContent>

      <TabsContent value="topics" className="space-y-4">
        <TopicTab initialData={initialTopics} initialSubjects={initialSubjects} />
      </TabsContent>

      <TabsContent value="subtopics" className="space-y-4">
        <SubtopicTab initialData={initialSubtopics} initialTopics={initialTopics} />
      </TabsContent>
    </Tabs>
  );
}
