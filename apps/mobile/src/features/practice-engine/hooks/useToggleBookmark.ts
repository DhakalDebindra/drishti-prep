import { useMutation, useQueryClient } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { useSession } from '../../../providers/SessionProvider'

export function useToggleBookmark() {
  const queryClient = useQueryClient()
  const { user } = useSession()

  return useMutation({
    mutationFn: async (questionId: string) => {
      if (!user) throw new Error('Not authenticated')

      // Check if bookmark exists
      const { data: existing, error: fetchError } = await supabaseMobile
        .from('bookmarks')
        .select('id')
        .eq('user_id', user.id)
        .eq('question_id', questionId)
        .single()

      if (fetchError && fetchError.code !== 'PGRST116') {
        throw new Error('Failed to check bookmark status')
      }

      if (existing) {
        // Remove bookmark
        const { error: deleteError } = await supabaseMobile
          .from('bookmarks')
          .delete()
          .eq('id', existing.id)

        if (deleteError) throw new Error('Failed to remove bookmark')
        return { action: 'removed', questionId }
      } else {
        // Add bookmark
        const { error: insertError } = await supabaseMobile
          .from('bookmarks')
          .insert({ user_id: user.id, question_id: questionId })

        if (insertError) throw new Error('Failed to add bookmark')
        return { action: 'added', questionId }
      }
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['bookmarks'] })
    },
  })
}
