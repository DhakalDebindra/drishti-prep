import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'

export type ProfileData = {
  disability_status: string
  disability_rejection_reason: string | null
  xp_points: number
  current_streak: number
  best_streak: number
}

async function fetchProfile(userId: string): Promise<ProfileData | null> {
  const { data, error } = await supabaseMobile
    .from('profiles')
    .select('disability_status, disability_rejection_reason, xp_points, current_streak, best_streak')
    .eq('id', userId)
    .single()

  if (error && error.code !== 'PGRST116') throw error
  return (data as ProfileData) ?? null
}

export function useProfile(userId: string) {
  return useQuery({
    queryKey: queryKeys.profile.detail(userId),
    queryFn: () => fetchProfile(userId),
    enabled: !!userId,
    staleTime: 5 * 60 * 1000,
    retry: 1,
  })
}
