import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'

type AIFeedback = {
  attempt_id: string
  strengths: string | null
  weak_zones: Record<string, unknown> | null
}

export function useAIFeedback(attemptId: string) {
  return useQuery({
    queryKey: [...queryKeys.practice.review(attemptId), 'feedback'],
    queryFn: async (): Promise<AIFeedback | null> => {
      // 1. Try to fetch existing from DB
      const { data, error } = await supabaseMobile
        .from('ai_feedback')
        .select('*')
        .eq('attempt_id', attemptId)
        .single()

      if (data) {
        return (data as unknown) as AIFeedback
      }

      if (error && error.code !== 'PGRST116') {
        throw error
      }

      // 2. If it doesn't exist, trigger generation via Next.js backend
      // We assume port 3000 is accessible via adb reverse or EXPO_PUBLIC_API_URL
      const API_URL = process.env.EXPO_PUBLIC_API_URL || 'http://localhost:3000'
      const { data: { session } } = await supabaseMobile.auth.getSession()

      const response = await fetch(`${API_URL}/api/attempts/${attemptId}/feedback`, {
        headers: {
          'Authorization': session?.access_token ? `Bearer ${session.access_token}` : ''
        }
      })
      
      if (!response.ok) {
        throw new Error('Failed to generate AI feedback dynamically.')
      }

      const generatedData = await response.json()
      return (generatedData as unknown) as AIFeedback
    },
    staleTime: 5 * 60 * 1000,
  })
}
