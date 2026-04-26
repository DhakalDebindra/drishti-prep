export type ModuleRecord = {
  id: string;
  name: string;
  name_np: string | null;
  slug: string;
  description: string | null;
  is_universal: boolean;
  exam_levels: string[] | null;
  display_order: number;
  is_active: boolean;
  created_at: string;
};

export type SubjectRecord = {
  id: string;
  name: string;
  module_id: string | null;
  name_np: string | null;
  slug?: string;
  syllabus_ref: string | null;
  display_order: number;
  description?: string | null;
};

export type TopicRecord = {
  id: string;
  name: string;
  subject_id: string | null;
  slug?: string;
  subject_name?: string | null;
  syllabus_ref: string | null;
  display_order: number;
  description?: string | null;
};
