import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'
import { QUERY_STALE_TIME, QUERY_RETRY_COUNT } from '../../../config/constants'

export type SetWithAttempt = {
  id: string
  title: string
  difficulty_level: number
  set_type: string
  question_count: number
  attempt_id: string | null
  attempt_status: string | null
  score_pct: number | null
  score_raw: number | null
}

export type TopicWithSets = {
  id: string
  name: string
  slug: string
  question_sets: SetWithAttempt[]
}

export type SubjectWithTopics = {
  id: string
  name: string
  slug: string
  topics: TopicWithSets[]
}

export type CourseDetailData = {
  module: {
    id: string
    name: string
    slug: string
    description: string | null
    is_universal: boolean
    price_paisa: number | null
  }
  subjects: SubjectWithTopics[]
  total_sets: number
  completed_sets: number
}

async function fetchCourseDetail(moduleSlug: string, userId: string): Promise<CourseDetailData> {
  const moduleRes = await supabaseMobile
    .from('modules')
    .select('id, name, slug, description, is_universal, price_paisa')
    .eq('slug', moduleSlug)
    .single()

  if (moduleRes.error) throw moduleRes.error
  const module = moduleRes.data as CourseDetailData['module']

  const [subjectsRes, attemptsRes] = await Promise.all([
    supabaseMobile
      .from('subjects')
      .select(`
        id, name, slug,
        topics (
          id, name, slug,
          question_sets (
            id, title, difficulty_level, set_type
          )
        )
      `)
      .eq('module_id', module.id)
      .order('display_order', { ascending: true }),
    supabaseMobile
      .from('attempts')
      .select('set_id, id, status, score_pct, score_raw')
      .eq('user_id', userId)
      .in('status', ['submitted', 'in_progress']),
  ])

  if (subjectsRes.error) throw subjectsRes.error
  if (attemptsRes.error) throw attemptsRes.error

  const subjects = (subjectsRes.data ?? []) as unknown as SubjectWithTopics[]

  // Only the attempt-specific fields — merging the whole object would clobber
  // each set's real title/difficulty/set_type (this was a bug: attempted sets
  // rendered with an empty title).
  type AttemptFields = Pick<SetWithAttempt, 'attempt_id' | 'attempt_status' | 'score_pct' | 'score_raw'>
  const attemptMap = new Map<string, AttemptFields>()

  for (const a of (attemptsRes.data ?? []) as Array<{
    set_id: string; id: string; status: string; score_pct: number | null; score_raw: number | null
  }>) {
    attemptMap.set(a.set_id, {
      attempt_id: a.id,
      attempt_status: a.status,
      score_pct: a.score_pct,
      score_raw: a.score_raw,
    })
  }

  let totalSets = 0
  let completedSets = 0

  for (const subject of subjects) {
    for (const topic of subject.topics || []) {
      for (const set of (topic.question_sets || []) as SetWithAttempt[]) {
        totalSets++
        const attempt = attemptMap.get(set.id)
        set.attempt_id = attempt?.attempt_id ?? null
        set.attempt_status = attempt?.attempt_status ?? null
        set.score_pct = attempt?.score_pct ?? null
        set.score_raw = attempt?.score_raw ?? null
        if (attempt?.attempt_status === 'submitted') completedSets++
      }
    }
  }

  return { module, subjects, total_sets: totalSets, completed_sets: completedSets }
}

export function useCourseDetail(moduleSlug: string, userId: string) {
  return useQuery({
    queryKey: queryKeys.courses.detail(moduleSlug),
    queryFn: () => fetchCourseDetail(moduleSlug, userId),
    enabled: !!moduleSlug && !!userId,
    staleTime: QUERY_STALE_TIME,
    retry: QUERY_RETRY_COUNT,
  })
}
