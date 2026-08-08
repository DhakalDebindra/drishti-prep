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
      ai_feedback: {
        Row: {
          attempt_id: string
          cost_cents: number | null
          created_at: string
          explanations: Json | null
          latency_ms: number | null
          model: string | null
          strengths: string | null
          weak_zones: Json | null
        }
        Insert: {
          attempt_id: string
          cost_cents?: number | null
          created_at?: string
          explanations?: Json | null
          latency_ms?: number | null
          model?: string | null
          strengths?: string | null
          weak_zones?: Json | null
        }
        Update: {
          attempt_id?: string
          cost_cents?: number | null
          created_at?: string
          explanations?: Json | null
          latency_ms?: number | null
          model?: string | null
          strengths?: string | null
          weak_zones?: Json | null
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
      attempt_answers: {
        Row: {
          attempt_id: string
          created_at: string
          id: string
          is_correct: boolean
          question_id: string
          selected_option: string
        }
        Insert: {
          attempt_id: string
          created_at?: string
          id?: string
          is_correct: boolean
          question_id: string
          selected_option: string
        }
        Update: {
          attempt_id?: string
          created_at?: string
          id?: string
          is_correct?: boolean
          question_id?: string
          selected_option?: string
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
      attempts: {
        Row: {
          id: string
          question_count: number
          score_pct: number | null
          score_raw: number | null
          set_id: string
          set_version: number
          started_at: string
          status: string
          submitted_at: string | null
          user_id: string
        }
        Insert: {
          id?: string
          question_count?: number
          score_pct?: number | null
          score_raw?: number | null
          set_id: string
          set_version?: number
          started_at?: string
          status?: string
          submitted_at?: string | null
          user_id: string
        }
        Update: {
          id?: string
          question_count?: number
          score_pct?: number | null
          score_raw?: number | null
          set_id?: string
          set_version?: number
          started_at?: string
          status?: string
          submitted_at?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "attempts_set_id_fkey"
            columns: ["set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
        ]
      }
      audio_generation_log: {
        Row: {
          audio_version: number
          bytes: number | null
          cost_micro_usd: number | null
          created_at: string
          duration_ms: number | null
          id: string
          latency_ms: number | null
          model: string
          question_id: string
          requested_by: string | null
          segment: string
          voice: string
        }
        Insert: {
          audio_version: number
          bytes?: number | null
          cost_micro_usd?: number | null
          created_at?: string
          duration_ms?: number | null
          id?: string
          latency_ms?: number | null
          model: string
          question_id: string
          requested_by?: string | null
          segment: string
          voice: string
        }
        Update: {
          audio_version?: number
          bytes?: number | null
          cost_micro_usd?: number | null
          created_at?: string
          duration_ms?: number | null
          id?: string
          latency_ms?: number | null
          model?: string
          question_id?: string
          requested_by?: string | null
          segment?: string
          voice?: string
        }
        Relationships: [
          {
            foreignKeyName: "audio_generation_log_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "audio_generation_log_requested_by_fkey"
            columns: ["requested_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      bookmarks: {
        Row: {
          created_at: string
          id: string
          question_id: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          question_id: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          question_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "bookmarks_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      enrollments: {
        Row: {
          admin_notes: string | null
          amount_quoted_paisa: number
          created_at: string
          id: string
          module_id: string
          payment_reference: string | null
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          short_code: string
          status: Database["public"]["Enums"]["enrollment_status"]
          updated_at: string
          user_id: string
        }
        Insert: {
          admin_notes?: string | null
          amount_quoted_paisa: number
          created_at?: string
          id?: string
          module_id: string
          payment_reference?: string | null
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          short_code?: string
          status?: Database["public"]["Enums"]["enrollment_status"]
          updated_at?: string
          user_id: string
        }
        Update: {
          admin_notes?: string | null
          amount_quoted_paisa?: number
          created_at?: string
          id?: string
          module_id?: string
          payment_reference?: string | null
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          short_code?: string
          status?: Database["public"]["Enums"]["enrollment_status"]
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "enrollments_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "enrollments_reviewed_by_fkey"
            columns: ["reviewed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "enrollments_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      identity_verifications: {
        Row: {
          admin_notes: string | null
          card_path: string
          created_at: string
          id: string
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["disability_status"]
          updated_at: string
          user_id: string
        }
        Insert: {
          admin_notes?: string | null
          card_path: string
          created_at?: string
          id?: string
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["disability_status"]
          updated_at?: string
          user_id: string
        }
        Update: {
          admin_notes?: string | null
          card_path?: string
          created_at?: string
          id?: string
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["disability_status"]
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "identity_verifications_reviewed_by_fkey"
            columns: ["reviewed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "identity_verifications_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      modules: {
        Row: {
          created_at: string | null
          currency: string
          description: string | null
          display_order: number | null
          exam_levels: string[] | null
          id: string
          is_active: boolean | null
          is_universal: boolean | null
          name: string
          name_np: string | null
          price_paisa: number | null
          slug: string
        }
        Insert: {
          created_at?: string | null
          currency?: string
          description?: string | null
          display_order?: number | null
          exam_levels?: string[] | null
          id?: string
          is_active?: boolean | null
          is_universal?: boolean | null
          name: string
          name_np?: string | null
          price_paisa?: number | null
          slug: string
        }
        Update: {
          created_at?: string | null
          currency?: string
          description?: string | null
          display_order?: number | null
          exam_levels?: string[] | null
          id?: string
          is_active?: boolean | null
          is_universal?: boolean | null
          name?: string
          name_np?: string | null
          price_paisa?: number | null
          slug?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          best_streak: number
          created_at: string
          current_streak: number
          disability_card_path: string | null
          disability_card_uploaded_at: string | null
          disability_rejection_reason: string | null
          disability_status: Database["public"]["Enums"]["disability_status"]
          disability_verified: boolean
          disability_verified_at: string | null
          disability_verified_by: string | null
          district: string | null
          email: string | null
          full_name: string | null
          id: string
          is_admin: boolean | null
          province: string | null
          target_exam_level: string | null
          target_year: number | null
          tutor_voice_enabled: boolean
          xp_points: number
        }
        Insert: {
          best_streak?: number
          created_at?: string
          current_streak?: number
          disability_card_path?: string | null
          disability_card_uploaded_at?: string | null
          disability_rejection_reason?: string | null
          disability_status?: Database["public"]["Enums"]["disability_status"]
          disability_verified?: boolean
          disability_verified_at?: string | null
          disability_verified_by?: string | null
          district?: string | null
          email?: string | null
          full_name?: string | null
          id: string
          is_admin?: boolean | null
          province?: string | null
          target_exam_level?: string | null
          target_year?: number | null
          tutor_voice_enabled?: boolean
          xp_points?: number
        }
        Update: {
          best_streak?: number
          created_at?: string
          current_streak?: number
          disability_card_path?: string | null
          disability_card_uploaded_at?: string | null
          disability_rejection_reason?: string | null
          disability_status?: Database["public"]["Enums"]["disability_status"]
          disability_verified?: boolean
          disability_verified_at?: string | null
          disability_verified_by?: string | null
          district?: string | null
          email?: string | null
          full_name?: string | null
          id?: string
          is_admin?: boolean | null
          province?: string | null
          target_exam_level?: string | null
          target_year?: number | null
          tutor_voice_enabled?: boolean
          xp_points?: number
        }
        Relationships: [
          {
            foreignKeyName: "profiles_disability_verified_by_fkey"
            columns: ["disability_verified_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      question_set_questions: {
        Row: {
          added_at: string | null
          id: string
          position: number
          question_id: string
          question_set_id: string
        }
        Insert: {
          added_at?: string | null
          id?: string
          position?: number
          question_id: string
          question_set_id: string
        }
        Update: {
          added_at?: string | null
          id?: string
          position?: number
          question_id?: string
          question_set_id?: string
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
      question_set_modules: {
        Row: {
          module_id: string
          question_set_id: string
          subtopic_id: string | null
        }
        Insert: {
          module_id: string
          question_set_id: string
          subtopic_id?: string | null
        }
        Update: {
          module_id?: string
          question_set_id?: string
          subtopic_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "question_set_modules_module_id_fkey"
            columns: ["module_id"]
            isOneToOne: false
            referencedRelation: "modules"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_set_modules_question_set_id_fkey"
            columns: ["question_set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_set_modules_subtopic_id_fkey"
            columns: ["subtopic_id"]
            isOneToOne: false
            referencedRelation: "subtopics"
            referencedColumns: ["id"]
          },
        ]
      }
      question_sets: {
        Row: {
          created_at: string
          difficulty_level: number
          id: string
          is_verified: boolean
          set_type: string
          subtopic_id: string | null
          title: string
          topic_id: string
          version: number
        }
        Insert: {
          created_at?: string
          difficulty_level: number
          id?: string
          is_verified?: boolean
          set_type?: string
          subtopic_id?: string | null
          title: string
          topic_id: string
          version?: number
        }
        Update: {
          created_at?: string
          difficulty_level?: number
          id?: string
          is_verified?: boolean
          set_type?: string
          subtopic_id?: string | null
          title?: string
          topic_id?: string
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "question_sets_subtopic_id_fkey"
            columns: ["subtopic_id"]
            isOneToOne: false
            referencedRelation: "subtopics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_sets_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_sets_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics_with_set_counts"
            referencedColumns: ["id"]
          },
        ]
      }
      question_tags: {
        Row: {
          question_id: string
          tag_id: string
        }
        Insert: {
          question_id: string
          tag_id: string
        }
        Update: {
          question_id?: string
          tag_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "question_tags_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_tags_tag_id_fkey"
            columns: ["tag_id"]
            isOneToOne: false
            referencedRelation: "tags"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          audio_ready: boolean
          audio_version: number
          audio_voice: string | null
          content: string
          correct_option: string
          created_at: string
          exam_year: number | null
          explanation: string | null
          id: string
          is_verified: boolean
          language: string
          option_a: string
          option_b: string
          option_c: string
          option_d: string
          order_number: number
          paper_ref: string | null
          set_id: string
          source_question_id: string | null
          status: string | null
          verified_by: string | null
        }
        Insert: {
          audio_ready?: boolean
          audio_version?: number
          audio_voice?: string | null
          content: string
          correct_option: string
          created_at?: string
          exam_year?: number | null
          explanation?: string | null
          id?: string
          is_verified?: boolean
          language?: string
          option_a: string
          option_b: string
          option_c: string
          option_d: string
          order_number: number
          paper_ref?: string | null
          set_id: string
          source_question_id?: string | null
          status?: string | null
          verified_by?: string | null
        }
        Update: {
          audio_ready?: boolean
          audio_version?: number
          audio_voice?: string | null
          content?: string
          correct_option?: string
          created_at?: string
          exam_year?: number | null
          explanation?: string | null
          id?: string
          is_verified?: boolean
          language?: string
          option_a?: string
          option_b?: string
          option_c?: string
          option_d?: string
          order_number?: number
          paper_ref?: string | null
          set_id?: string
          source_question_id?: string | null
          status?: string | null
          verified_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "questions_set_id_fkey"
            columns: ["set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "questions_source_question_id_fkey"
            columns: ["source_question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "questions_verified_by_fkey"
            columns: ["verified_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      reports: {
        Row: {
          created_at: string
          description: string | null
          id: string
          issue_type: string
          question_id: string
          status: string
          user_id: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          issue_type: string
          question_id: string
          status?: string
          user_id: string
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          issue_type?: string
          question_id?: string
          status?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "reports_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      site_settings: {
        Row: {
          id: number
          payment_instructions: string | null
          payment_qr_url: string | null
          updated_at: string | null
          whatsapp_message_template: string | null
          whatsapp_number: string | null
        }
        Insert: {
          id?: number
          payment_instructions?: string | null
          payment_qr_url?: string | null
          updated_at?: string | null
          whatsapp_message_template?: string | null
          whatsapp_number?: string | null
        }
        Update: {
          id?: number
          payment_instructions?: string | null
          payment_qr_url?: string | null
          updated_at?: string | null
          whatsapp_message_template?: string | null
          whatsapp_number?: string | null
        }
        Relationships: []
      }
      subjects: {
        Row: {
          created_at: string
          description: string | null
          display_order: number | null
          id: string
          module_id: string | null
          name: string
          name_np: string | null
          slug: string
          syllabus_ref: string | null
        }
        Insert: {
          created_at?: string
          description?: string | null
          display_order?: number | null
          id?: string
          module_id?: string | null
          name: string
          name_np?: string | null
          slug: string
          syllabus_ref?: string | null
        }
        Update: {
          created_at?: string
          description?: string | null
          display_order?: number | null
          id?: string
          module_id?: string | null
          name?: string
          name_np?: string | null
          slug?: string
          syllabus_ref?: string | null
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
      subtopics: {
        Row: {
          created_at: string
          description: string | null
          display_order: number
          id: string
          is_active: boolean
          name: string
          name_np: string | null
          slug: string
          syllabus_ref: string | null
          topic_id: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          display_order?: number
          id?: string
          is_active?: boolean
          name: string
          name_np?: string | null
          slug: string
          syllabus_ref?: string | null
          topic_id: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          description?: string | null
          display_order?: number
          id?: string
          is_active?: boolean
          name?: string
          name_np?: string | null
          slug?: string
          syllabus_ref?: string | null
          topic_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "subtopics_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "subtopics_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics_with_set_counts"
            referencedColumns: ["id"]
          },
        ]
      }
      tags: {
        Row: {
          color: string | null
          created_at: string | null
          id: string
          name: string
          name_np: string | null
          slug: string
        }
        Insert: {
          color?: string | null
          created_at?: string | null
          id?: string
          name: string
          name_np?: string | null
          slug: string
        }
        Update: {
          color?: string | null
          created_at?: string | null
          id?: string
          name?: string
          name_np?: string | null
          slug?: string
        }
        Relationships: []
      }
      topic_learning_paths: {
        Row: {
          created_at: string | null
          id: string
          is_locked: boolean
          question_set_id: string
          step_order: number
          topic_id: string
          unlocked_after: string | null
        }
        Insert: {
          created_at?: string | null
          id?: string
          is_locked?: boolean
          question_set_id: string
          step_order: number
          topic_id: string
          unlocked_after?: string | null
        }
        Update: {
          created_at?: string | null
          id?: string
          is_locked?: boolean
          question_set_id?: string
          step_order?: number
          topic_id?: string
          unlocked_after?: string | null
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
          {
            foreignKeyName: "topic_learning_paths_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics_with_set_counts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "topic_learning_paths_unlocked_after_fkey"
            columns: ["unlocked_after"]
            isOneToOne: false
            referencedRelation: "topic_learning_paths"
            referencedColumns: ["id"]
          },
        ]
      }
      topics: {
        Row: {
          created_at: string
          description: string | null
          display_order: number | null
          id: string
          name: string
          slug: string
          subject_id: string
          syllabus_ref: string | null
        }
        Insert: {
          created_at?: string
          description?: string | null
          display_order?: number | null
          id?: string
          name: string
          slug: string
          subject_id: string
          syllabus_ref?: string | null
        }
        Update: {
          created_at?: string
          description?: string | null
          display_order?: number | null
          id?: string
          name?: string
          slug?: string
          subject_id?: string
          syllabus_ref?: string | null
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
      user_topic_progress: {
        Row: {
          completed_set_ids: string[] | null
          current_step: number
          last_activity: string | null
          sets_completed: number
          topic_id: string
          user_id: string
        }
        Insert: {
          completed_set_ids?: string[] | null
          current_step?: number
          last_activity?: string | null
          sets_completed?: number
          topic_id: string
          user_id: string
        }
        Update: {
          completed_set_ids?: string[] | null
          current_step?: number
          last_activity?: string | null
          sets_completed?: number
          topic_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_topic_progress_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_topic_progress_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics_with_set_counts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_topic_progress_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      active_disputes_view: {
        Row: {
          issue_types: Json | null
          oldest_report_date: string | null
          priority: string | null
          question_content: string | null
          question_id: string | null
          report_count: number | null
          set_id: string | null
          set_title: string | null
        }
        Relationships: [
          {
            foreignKeyName: "questions_set_id_fkey"
            columns: ["set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "reports_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      attempt_answers_enriched: {
        Row: {
          attempt_id: string | null
          attempt_set_id: string | null
          difficulty: number | null
          id: string | null
          is_correct: boolean | null
          question_id: string | null
          selected_option: string | null
          set_type: string | null
          subject_id: string | null
          subject_name: string | null
          topic_id: string | null
          topic_name: string | null
          user_id: string | null
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
          {
            foreignKeyName: "attempts_set_id_fkey"
            columns: ["attempt_set_id"]
            isOneToOne: false
            referencedRelation: "question_sets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_sets_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_sets_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics_with_set_counts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "topics_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
        ]
      }
      topics_with_set_counts: {
        Row: {
          created_at: string | null
          description: string | null
          display_order: number | null
          id: string | null
          name: string | null
          set_count: number | null
          subject_id: string | null
          syllabus_ref: string | null
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
    }
    Functions: {
      add_question_to_set: {
        Args: {
          p_set_id: string
          p_content: string
          p_option_a: string
          p_option_b: string
          p_option_c: string
          p_option_d: string
          p_correct_option: string
          p_explanation?: string | null
          p_exam_year?: number | null
          p_paper_ref?: string | null
          p_language?: string | null
        }
        Returns: Database["public"]["Tables"]["questions"]["Row"]
      }
      has_module_access: { Args: { p_module: string }; Returns: boolean }
      is_admin: { Args: never; Returns: boolean }
    }
    Enums: {
      disability_status: "not_submitted" | "pending" | "approved" | "rejected"
      enrollment_status: "pending" | "approved" | "rejected" | "revoked"
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
    Enums: {
      disability_status: ["not_submitted", "pending", "approved", "rejected"],
      enrollment_status: ["pending", "approved", "rejected", "revoked"],
    },
  },
} as const
