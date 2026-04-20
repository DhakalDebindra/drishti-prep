"use client";

import { useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ModuleTab } from "./ModuleTab";
import { SubjectTab } from "./SubjectTab";
import { TopicTab } from "./TopicTab";

interface CurriculumClientProps {
  initialModules: any[];
  initialSubjects: any[];
  initialTopics: any[];
}

export function CurriculumClient({
  initialModules,
  initialSubjects,
  initialTopics,
}: CurriculumClientProps) {
  const [activeTab, setActiveTab] = useState("modules");

  return (
    <Tabs 
      defaultValue="modules" 
      value={activeTab} 
      onValueChange={setActiveTab}
      className="w-full"
    >
      <TabsList className="mb-4 grid w-full grid-cols-3 lg:w-[400px]" aria-label="Curriculum sections">
        <TabsTrigger value="modules">Modules</TabsTrigger>
        <TabsTrigger value="subjects">Subjects</TabsTrigger>
        <TabsTrigger value="topics">Topics</TabsTrigger>
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
    </Tabs>
  );
}
