import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'

type AttemptWithSet = {
  id: string
  set_id: string
  status: string
  score_raw: number | null
  score_pct: number | null
  question_count: number | null
  submitted_at: string | null
  started_at: string | null
  question_sets: {
    title: string
    topic: {
      name: string
      slug: string
      subject: {
        name: string
        slug: string
        module: {
          slug: string
        }
      }
    }
  } | null
}

type DashboardData = {
  attempts: AttemptWithSet[]
  profile: {
    disability_status: string
    disability_rejection_reason: string | null
    xp_points: number
    current_streak: number
    best_streak: number
  } | null
  enrollments: Array<{ name: string; slug: string; description: string | null }>
}

async function fetchDashboardData(userId: string): Promise<DashboardData> {
  const [attemptsRes, profileRes, enrollmentsRes] = await Promise.all([
    supabaseMobile
      .from('attempts')
      .select(`
        id,
        set_id,
        status,
        score_raw,
        score_pct,
        question_count,
        submitted_at,
        started_at,
        question_sets (
          title,
          topic:topics (
            name,
            slug,
            subject:subjects (
              name,
              slug,
              module:modules (
                slug
              )
            )
          )
        )
      `)
      .eq('user_id', userId)
      .order('started_at', { ascending: false }),
    supabaseMobile
      .from('profiles')
      .select('disability_status, disability_rejection_reason, xp_points, current_streak, best_streak')
      .eq('id', userId)
      .single(),
    supabaseMobile
      .from('enrollments')
      .select('module_id, modules(name, slug, description)')
      .eq('user_id', userId)
      .eq('status', 'approved'),
  ])

  if (attemptsRes.error) throw attemptsRes.error
  if (profileRes.error && profileRes.error.code !== 'PGRST116') throw profileRes.error
  if (enrollmentsRes.error) throw enrollmentsRes.error

  return {
    attempts: (attemptsRes.data ?? []) as unknown as AttemptWithSet[],
    profile: profileRes.data as DashboardData['profile'],
    enrollments: ((enrollmentsRes.data ?? []) as Array<{ modules: { name: string; slug: string; description: string | null } | null }>)
      .map((e) => e.modules)
      .filter(Boolean) as DashboardData['enrollments'],
  }
}

export function useDashboardData(userId: string) {
  return useQuery({
    queryKey: queryKeys.attempts.list(userId),
    queryFn: () => fetchDashboardData(userId),
    staleTime: 5 * 60 * 1000,
    retry: 1,
  })
}
