import { useMutation, useQueryClient } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'

type FinishAttemptInput = {
  attemptId: string
  scoreRaw: number
  scorePct: number
  setId: string
}

async function finishAttempt({ attemptId, scoreRaw, scorePct }: FinishAttemptInput) {
  const { error } = await supabaseMobile
    .from('attempts')
    .update({
      status: 'submitted',
      score_raw: scoreRaw,
      score_pct: scorePct,
      submitted_at: new Date().toISOString(),
    })
    .eq('id', attemptId)

  if (error) throw error
}

export function useFinishAttempt(setId: string) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: finishAttempt,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: queryKeys.practice.session(setId) })
      queryClient.invalidateQueries({ queryKey: queryKeys.attempts.all })
    },
  })
}
