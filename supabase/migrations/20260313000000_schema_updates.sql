-- Drop old policies that reference the role column before we drop the column itself
DROP POLICY IF EXISTS "Admins can insert subjects" ON public.subjects;
DROP POLICY IF EXISTS "Admins can update subjects" ON public.subjects;
DROP POLICY IF EXISTS "Admins can delete subjects" ON public.subjects;

DROP POLICY IF EXISTS "Admins can insert topics" ON public.topics;
DROP POLICY IF EXISTS "Admins can update topics" ON public.topics;
DROP POLICY IF EXISTS "Admins can delete topics" ON public.topics;

DROP POLICY IF EXISTS "Admins can insert question_sets" ON public.question_sets;
DROP POLICY IF EXISTS "Admins can update question_sets" ON public.question_sets;
DROP POLICY IF EXISTS "Admins can delete question_sets" ON public.question_sets;

DROP POLICY IF EXISTS "Admins can insert questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can update questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can delete questions" ON public.questions;

-- Update profiles table
ALTER TABLE public.profiles ADD COLUMN is_admin BOOLEAN DEFAULT false;
ALTER TABLE public.profiles ADD COLUMN full_name TEXT;

-- Drop obsolete columns
ALTER TABLE public.profiles DROP COLUMN IF EXISTS first_name;
ALTER TABLE public.profiles DROP COLUMN IF EXISTS last_name;
ALTER TABLE public.profiles DROP COLUMN IF EXISTS role;

-- Update the user trigger
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, is_admin)
    VALUES (
      new.id, 
      new.raw_user_meta_data->>'full_name', 
      false
    );
    RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create new RLS policies for subjects
CREATE POLICY "Admins can insert subjects" ON public.subjects FOR INSERT WITH CHECK (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can update subjects" ON public.subjects FOR UPDATE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can delete subjects" ON public.subjects FOR DELETE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- Create new RLS policies for topics
CREATE POLICY "Admins can insert topics" ON public.topics FOR INSERT WITH CHECK (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can update topics" ON public.topics FOR UPDATE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can delete topics" ON public.topics FOR DELETE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- Update question_sets table
ALTER TABLE public.question_sets RENAME COLUMN is_published TO is_verified;

-- Create new RLS policies for question_sets
CREATE POLICY "Admins can insert question_sets" ON public.question_sets FOR INSERT WITH CHECK (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can update question_sets" ON public.question_sets FOR UPDATE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can delete question_sets" ON public.question_sets FOR DELETE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- Recreate questions table
DROP TABLE IF EXISTS public.questions CASCADE;

CREATE TABLE public.questions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    set_id UUID REFERENCES public.question_sets(id) ON DELETE CASCADE NOT NULL,
    order_number INT NOT NULL,
    content TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    feedback_a TEXT,
    feedback_b TEXT,
    feedback_c TEXT,
    feedback_d TEXT,
    general_explanation TEXT,
    correct_option CHAR(1) CHECK (correct_option IN ('A', 'B', 'C', 'D')) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

-- RLS policies for questions
CREATE POLICY "Public questions are viewable by everyone" ON public.questions FOR SELECT USING (true);
CREATE POLICY "Admins can insert questions" ON public.questions FOR INSERT WITH CHECK (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can update questions" ON public.questions FOR UPDATE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "Admins can delete questions" ON public.questions FOR DELETE USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
