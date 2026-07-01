import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { useSession } from '../../../providers/SessionProvider'

/**
 * Returns the set of question ids (from the supplied list) that the current
 * user has already bookmarked. Used to hydrate the review screen so saved
 * questions render as "Saved" on load instead of always starting empty.
 */
export function useBookmarkedIds(questionIds: string[]) {
  const { user } = useSession()
  // Stable key independent of array order.
  const sortedKey = [...questionIds].sort().join(',')

  return useQuery({
    queryKey: ['bookmarks', 'ids', user?.id ?? 'anon', sortedKey],
    enabled: !!user && questionIds.length > 0,
    staleTime: 60 * 1000,
    queryFn: async (): Promise<Set<string>> => {
      if (!user) return new Set()
      const { data, error } = await supabaseMobile
        .from('bookmarks')
        .select('question_id')
        .eq('user_id', user.id)
        .in('question_id', questionIds)

      if (error) throw error
      return new Set((data ?? []).map((row: { question_id: string }) => row.question_id))
    },
  })
}
