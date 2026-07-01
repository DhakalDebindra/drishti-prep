import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'
import { QUERY_STALE_TIME, QUERY_RETRY_COUNT } from '../../../config/constants'

export type SessionQuestion = {
  id: string
  content: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_option: string
  explanation: string | null
  position: number
}

export type ActiveAttempt = {
  id: string
  set_id: string
  status: string
  question_count: number
  score_raw: number | null
  started_at: string
} | null

export type ExistingAnswer = {
  question_id: string
  selected_option: string | null
  is_correct: boolean
}

export type PracticeSessionData = {
  setTitle: string
  questions: SessionQuestion[]
  activeAttempt: ActiveAttempt
  existingAnswers: ExistingAnswer[]
}

async function fetchPracticeSession(setId: string, userId: string): Promise<PracticeSessionData> {
  const [setRes, qsqRes, attemptRes, answersRes] = await Promise.all([
    supabaseMobile
      .from('question_sets')
      .select('title')
      .eq('id', setId)
      .single(),
    supabaseMobile
      .from('question_set_questions')
      .select(`
        position,
        questions!inner (
          id, content, option_a, option_b, option_c, option_d,
          correct_option, explanation
        )
      `)
      .eq('question_set_id', setId)
      .order('position', { ascending: true }),
    supabaseMobile
      .from('attempts')
      .select('id, set_id, status, question_count, score_raw, started_at')
      .eq('set_id', setId)
      .eq('user_id', userId)
      .eq('status', 'in_progress')
      .order('started_at', { ascending: false })
      .limit(1)
      .maybeSingle(),
    Promise.resolve(null) as Promise<null>,
  ])

  if (setRes.error) throw setRes.error
  if (qsqRes.error) throw qsqRes.error
  if (attemptRes.error) throw attemptRes.error

  const questions: SessionQuestion[] = ((qsqRes.data ?? []) as Array<{
    position: number
    questions: {
      id: string
      content: string
      option_a: string
      option_b: string
      option_c: string
      option_d: string
      correct_option: string
      explanation: string | null
    }
  }>).map((q) => ({
    ...q.questions,
    position: q.position,
  }))

  let activeAttempt = attemptRes.data as ActiveAttempt
  let existingAnswers: ExistingAnswer[] = []

  if (!activeAttempt) {
    const count = questions.length
    const { data: newAttempt, error: createErr } = await supabaseMobile
      .from('attempts')
      .insert({
        set_id: setId,
        user_id: userId,
        status: 'in_progress',
        question_count: count,
      })
      .select('id, set_id, status, question_count, score_raw, started_at')
      .single()

    if (createErr) throw createErr
    activeAttempt = newAttempt as ActiveAttempt
  } else {
    const { data: answers, error: answersErr } = await supabaseMobile
      .from('attempt_answers')
      .select('question_id, selected_option, is_correct')
      .eq('attempt_id', activeAttempt.id)

    if (answersErr) throw answersErr
    existingAnswers = (answers ?? []) as ExistingAnswer[]
  }

  return {
    setTitle: setRes.data.title,
    questions,
    activeAttempt,
    existingAnswers,
  }
}

export function usePracticeSession(setId: string, userId: string) {
  return useQuery({
    queryKey: queryKeys.practice.session(setId),
    queryFn: () => fetchPracticeSession(setId, userId),
    staleTime: 0,
    retry: QUERY_RETRY_COUNT,
  })
}
