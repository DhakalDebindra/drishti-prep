import { useRouter, useLocalSearchParams, Stack } from 'expo-router'
import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { Text } from '../../../../src/components/ui/Text'
import { ErrorState } from '../../../../src/components/ui/ErrorState'
import { SessionResults, SessionSkeleton } from '../../../../src/features/practice-engine'
import { queryKeys } from '../../../../src/lib/query-keys'

type ReviewData = {
  attempt: {
    id: string
    set_id: string
    status: string
    question_count: number
    score_raw: number
    score_pct: number
    submitted_at: string | null
  }
  questions: Array<{
    position: number
    id: string
    content: string
    option_a: string
    option_b: string
    option_c: string
    option_d: string
    correct_option: string
    explanation: string | null
  }>
  answers: Array<{
    question_id: string
    selected_option: string | null
    is_correct: boolean
  }>
}

async function fetchReview(attemptId: string): Promise<ReviewData> {
  const attemptRes = await supabaseMobile
    .from('attempts')
    .select('id, set_id, status, question_count, score_raw, score_pct, submitted_at')
    .eq('id', attemptId)
    .single()

  if (attemptRes.error) throw attemptRes.error

  const attempt = attemptRes.data as ReviewData['attempt']

  const [qsqResponse, answersRes] = await Promise.all([
    supabaseMobile
      .from('question_set_questions')
      .select(`
        position,
        questions!inner (
          id, content, option_a, option_b, option_c, option_d,
          correct_option, explanation
        )
      `)
      .eq('question_set_id', attempt.set_id)
      .order('position', { ascending: true }),
    supabaseMobile
      .from('attempt_answers')
      .select('question_id, selected_option, is_correct')
      .eq('attempt_id', attemptId),
  ])

  if (qsqResponse.error) throw qsqResponse.error
  if (answersRes.error) throw answersRes.error

  const questions = ((qsqResponse.data ?? []) as Array<{
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
  }>).map((q) => ({ ...q.questions, position: q.position }))

  const answers = (answersRes.data ?? []) as ReviewData['answers']

  return { attempt, questions, answers }
}

export default function ReviewScreen() {
  const { attemptId } = useLocalSearchParams<{ attemptId: string }>()
  const router = useRouter()

  const { data, isLoading, isError, error, refetch } = useQuery({
    queryKey: queryKeys.practice.review(attemptId),
    queryFn: () => fetchReview(attemptId),
    staleTime: 5 * 60 * 1000,
  })

  if (isLoading) return <SessionSkeleton />
  if (isError || !data) return <ErrorState message={error?.message} onRetry={() => refetch()} />

  const answerResults = data.questions.map((q) => {
    const answer = data.answers.find((a) => a.question_id === q.id)
    return {
      questionId: q.id,
      position: q.position,
      content: q.content,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      correctOption: q.correct_option,
      selectedOption: answer?.selected_option ?? null,
      isCorrect: answer?.is_correct ?? false,
      explanation: q.explanation,
    }
  })

  return (
    <>
      <Stack.Screen options={{ headerShown: false }} />
      <SessionResults
        attemptId={attemptId}
        scoreRaw={data.attempt.score_raw}
        scorePct={data.attempt.score_pct}
        questionCount={data.attempt.question_count}
        answers={answerResults}
        onBackToDashboard={() => router.push('/(app)/(tabs)/dashboard')}
        onRetry={() => router.push(`/(app)/practice/${data.attempt.set_id}`)}
      />
    </>
  )
}
