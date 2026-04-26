export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.4"
  }
  public: {
    Tables: {
      modules: {
        Row: {
          id: string
          name: string
          name_np: string | null
          slug: string
          description: string | null
          is_universal: boolean
          exam_levels: string[] | null
          display_order: number
          is_active: boolean
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          name_np?: string | null
          slug: string
          description?: string | null
          is_universal?: boolean
          exam_levels?: string[] | null
          display_order?: number
          is_active?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          name_np?: string | null
          slug?: string
          description?: string | null
          is_universal?: boolean
          exam_levels?: string[] | null
          display_order?: number
          is_active?: boolean
          created_at?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          best_streak: number
          created_at: string
          current_streak: number
          full_name: string | null
          id: string
          is_admin: boolean | null
          xp_points: number
        }
        Insert: {
          best_streak?: number
          created_at?: string
          current_streak?: number
          full_name?: string | null
          id: string
          is_admin?: boolean | null
          xp_points?: number
        }
        Update: {
          best_streak?: number
          created_at?: string
          current_streak?: number
          full_name?: string | null
          id?: string
          is_admin?: boolean | null
          xp_points?: number
        }
        Relationships: []
      }
      question_sets: {
        Row: {
          created_at: string
          difficulty_level: number
          id: string
          is_verified: boolean
          title: string
          topic_id: string
          version: number
          set_type: string
        }
        Insert: {
          created_at?: string
          difficulty_level: number
          id?: string
          is_verified?: boolean
          title: string
          topic_id: string
          version?: number
          set_type?: string
        }
        Update: {
          created_at?: string
          difficulty_level?: number
          id?: string
          is_verified?: boolean
          title?: string
          topic_id?: string
          version?: number
          set_type?: string
        }
        Relationships: [
          {
            foreignKeyName: "question_sets_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          content: string
          correct_option: string
          created_at: string
          explanation: string | null
          id: string
          option_a: string
          option_b: string
          option_c: string
          option_d: string
          order_number: number
          set_id: string
          exam_year: number | null
          paper_ref: string | null
          is_verified: boolean
          verified_by: string | null
          language: string
          source_question_id: string | null
          status: string | null
        }
        Insert: {
          content: string
          correct_option: string
          created_at?: string
          explanation?: string | null
          id?: string
          option_a: string
          option_b: string
          option_c: string
          option_d: string
          order_number: number
          set_id: string
          exam_year?: number | null
          paper_ref?: string | null
          is_verified?: boolean
          verified_by?: string | null
          language?: string
          source_question_id?: string | null
          status?: string | null
        }
        Update: {
          content?: string
          correct_option?: string
          created_at?: string
          explanation?: string | null
          id?: string
          option_a?: string
          option_b?: string
          option_c?: string
          option_d?: string
          order_number?: number
          set_id?: string
          exam_year?: number | null
          paper_ref?: string | null
          is_verified?: boolean
          verified_by?: string | null
          language?: string
          source_question_id?: string | null
          status?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "questions_set_id_fkey"
            columns: ["set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
        ]
      }
      attempts: {
        Row: {
          id: string
          user_id: string
          set_id: string
          set_version: number
          status: string
          question_count: number
          score_raw: number | null
          score_pct: number | null
          started_at: string
          submitted_at: string | null
        }
        Insert: {
          id?: string
          user_id: string
          set_id: string
          set_version?: number
          status?: string
          question_count?: number
          score_raw?: number | null
          score_pct?: number | null
          started_at?: string
          submitted_at?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          set_id?: string
          set_version?: number
          status?: string
          question_count?: number
          score_raw?: number | null
          score_pct?: number | null
          started_at?: string
          submitted_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "attempts_set_id_fkey"
            columns: ["set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attempts_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      attempt_answers: {
        Row: {
          id: string
          attempt_id: string
          question_id: string
          selected_option: string
          is_correct: boolean
          created_at: string
        }
        Insert: {
          id?: string
          attempt_id: string
          question_id: string
          selected_option: string
          is_correct: boolean
          created_at?: string
        }
        Update: {
          id?: string
          attempt_id?: string
          question_id?: string
          selected_option?: string
          is_correct?: boolean
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "attempt_answers_attempt_id_fkey"
            columns: ["attempt_id"]
            isOneToOne: false
            referencedRelation: "attempts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attempt_answers_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      ai_feedback: {
        Row: {
          attempt_id: string
          strengths: string | null
          weak_zones: Json | null
          explanations: Json | null
          model: string | null
          latency_ms: number | null
          cost_cents: number | null
          created_at: string
        }
        Insert: {
          attempt_id: string
          strengths?: string | null
          weak_zones?: Json | null
          explanations?: Json | null
          model?: string | null
          latency_ms?: number | null
          cost_cents?: number | null
          created_at?: string
        }
        Update: {
          attempt_id?: string
          strengths?: string | null
          weak_zones?: Json | null
          explanations?: Json | null
          model?: string | null
          latency_ms?: number | null
          cost_cents?: number | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "ai_feedback_attempt_id_fkey"
            columns: ["attempt_id"]
            isOneToOne: true
            referencedRelation: "attempts"
            referencedColumns: ["id"]
          },
        ]
      }
      bookmarks: {
        Row: {
          id: string
          user_id: string
          question_id: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          question_id: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          question_id?: string
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "bookmarks_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookmarks_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      question_set_questions: {
        Row: {
          id: string
          question_set_id: string
          question_id: string
          position: number
          added_at: string | null
        }
        Insert: {
          id?: string
          question_set_id: string
          question_id: string
          position?: number
          added_at?: string | null
        }
        Update: {
          id?: string
          question_set_id?: string
          question_id?: string
          position?: number
          added_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "question_set_questions_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_set_questions_question_set_id_fkey"
            columns: ["question_set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
        ]
      }
      reports: {
        Row: {
          id: string
          user_id: string
          question_id: string
          issue_type: string
          description: string | null
          status: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          question_id: string
          issue_type: string
          description?: string | null
          status?: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          question_id?: string
          issue_type?: string
          description?: string | null
          status?: string
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "reports_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "reports_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      subjects: {
        Row: {
          created_at: string
          description: string | null
          id: string
          name: string
          module_id: string | null
          name_np: string | null
          slug: string
          syllabus_ref: string | null
          display_order: number
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          name: string
          module_id?: string | null
          name_np?: string | null
          slug: string
          syllabus_ref?: string | null
          display_order?: number
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          name?: string
          module_id?: string | null
          name_np?: string | null
          slug?: string
          syllabus_ref?: string | null
          display_order?: number
        }
        Relationships: [
          {
            foreignKeyName: "subjects_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
        ]
      }
      topics: {
        Row: {
          created_at: string
          description: string | null
          id: string
          name: string
          slug: string
          subject_id: string
          syllabus_ref: string | null
          display_order: number
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          name: string
          slug: string
          subject_id: string
          syllabus_ref?: string | null
          display_order?: number
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          name?: string
          slug?: string
          subject_id?: string
          syllabus_ref?: string | null
          display_order?: number
        }
        Relationships: [
          {
            foreignKeyName: "topics_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
        ]
      }
      module_learning_paths: {
        Row: {
          id: string
          module_id: string
          question_set_id: string
          step_order: number
          is_locked: boolean
          unlocked_after: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          module_id: string
          question_set_id: string
          step_order: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          module_id?: string
          question_set_id?: string
          step_order?: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
      subject_learning_paths: {
        Row: {
          id: string
          subject_id: string
          question_set_id: string
          step_order: number
          is_locked: boolean
          unlocked_after: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          subject_id: string
          question_set_id: string
          step_order: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          subject_id?: string
          question_set_id?: string
          step_order?: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Relationships: []
      }
      topic_learning_paths: {
        Row: {
          id: string
          topic_id: string
          question_set_id: string
          step_order: number
          is_locked: boolean
          unlocked_after: string | null
          created_at: string | null
        }
        Insert: {
          id?: string
          topic_id: string
          question_set_id: string
          step_order: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Update: {
          id?: string
          topic_id?: string
          question_set_id?: string
          step_order?: number
          is_locked?: boolean
          unlocked_after?: string | null
          created_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "topic_learning_paths_question_set_id_fkey"
            columns: ["question_set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "topic_learning_paths_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      active_disputes_view: {
        Row: {
          question_id: string | null
          question_content: string | null
          set_id: string | null
          set_title: string | null
          report_count: number | null
          priority: string | null
          oldest_report_date: string | null
          issue_types: Json | null
        }
        Relationships: []
      }
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
