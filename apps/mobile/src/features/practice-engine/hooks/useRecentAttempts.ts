import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { QUERY_STALE_TIME, QUERY_RETRY_COUNT } from '../../../config/constants'

export type RecentAttempt = {
  id: string
  set_id: string
  status: string
  score_pct: number | null
  question_count: number | null
  submitted_at: string | null
  started_at: string | null
  question_sets: { title: string } | null
}

async function fetchRecentAttempts(userId: string): Promise<RecentAttempt[]> {
  const { data, error } = await supabaseMobile
    .from('attempts')
    .select('id, set_id, status, score_pct, question_count, submitted_at, started_at, question_sets(title)')
    .eq('user_id', userId)
    .order('started_at', { ascending: false })
    .limit(15)

  if (error) throw error
  return (data ?? []) as unknown as RecentAttempt[]
}

export function useRecentAttempts(userId: string) {
  return useQuery({
    queryKey: ['attempts', 'recent', userId],
    queryFn: () => fetchRecentAttempts(userId),
    enabled: !!userId,
    staleTime: QUERY_STALE_TIME,
    retry: QUERY_RETRY_COUNT,
  })
}
