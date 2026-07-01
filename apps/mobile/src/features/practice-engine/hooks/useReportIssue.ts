import { useMutation } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { useSession } from '../../../providers/SessionProvider'

type ReportIssueInput = {
  questionId: string
  issueType: string
  description: string
}

export function useReportIssue() {
  const { user } = useSession()

  return useMutation({
    mutationFn: async ({ questionId, issueType, description }: ReportIssueInput) => {
      if (!user) throw new Error('Not authenticated')

      // Check if user already reported this question recently or pending
      const { data: existingReports, error: checkError } = await supabaseMobile
        .from('reports')
        .select('status, created_at')
        .eq('user_id', user.id)
        .eq('question_id', questionId)
        .order('created_at', { ascending: false })
        .limit(1)

      if (checkError) {
        throw new Error('Failed to submit report. Try again.')
      }

      if (existingReports && existingReports.length > 0) {
        const lastReport = existingReports[0]
        if (lastReport.status === 'pending') {
          throw new Error('You already have a pending report for this question.')
        }
        
        // Check if it was less than 24 hours ago
        const hoursSinceLastReport = (new Date().getTime() - new Date(lastReport.created_at).getTime()) / (1000 * 60 * 60)
        if (hoursSinceLastReport < 24) {
          throw new Error('Please wait before reporting the same question again.')
        }
      }

      const { error: insertError } = await supabaseMobile
        .from('reports')
        .insert({
          user_id: user.id,
          question_id: questionId,
          issue_type: issueType,
          description,
        })

      if (insertError) {
        throw new Error('Failed to submit report.')
      }

      return { success: true }
    },
  })
}
