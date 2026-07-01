import { useMutation, useQueryClient } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'

type SubmitAnswerInput = {
  attemptId: string
  questionId: string
  selectedOption: string
  isCorrect: boolean
}

async function submitAnswer({ attemptId, questionId, selectedOption, isCorrect }: SubmitAnswerInput) {
  const { error } = await supabaseMobile
    .from('attempt_answers')
    .upsert({
      attempt_id: attemptId,
      question_id: questionId,
      selected_option: selectedOption,
      is_correct: isCorrect,
    }, { onConflict: 'attempt_id,question_id' })

  if (error) throw error
}

export function useSubmitAnswer(setId: string) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: submitAnswer,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.practice.session(setId) })
    },
  })
}
