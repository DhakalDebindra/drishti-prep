import { useQuery } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'
import { QUERY_STALE_TIME, QUERY_RETRY_COUNT } from '../../../config/constants'

export type ModuleWithEnrollment = {
  id: string
  name: string
  slug: string
  description: string | null
  is_universal: boolean
  price_paisa: number | null
  display_order: number
  subject_count: number
  enrollment_status: 'approved' | 'pending' | 'rejected' | 'revoked' | null
}

type CoursesData = {
  enrolled: ModuleWithEnrollment[]
  available: ModuleWithEnrollment[]
}

async function fetchCourses(userId: string): Promise<CoursesData> {
  const [modulesRes, enrollmentsRes] = await Promise.all([
    supabaseMobile
      .from('modules')
      .select(`
        id, name, slug, description, is_universal, price_paisa, display_order
      `)
      .eq('is_active', true)
      .order('display_order', { ascending: true }),
    supabaseMobile
      .from('enrollments')
      .select('module_id, status')
      .eq('user_id', userId)
      .in('status', ['approved', 'pending', 'rejected', 'revoked']),
  ])

  if (modulesRes.error) throw modulesRes.error
  if (enrollmentsRes.error) throw enrollmentsRes.error

  const modules = (modulesRes.data ?? []) as ModuleWithEnrollment[]
  const enrollMap = new Map(
    (enrollmentsRes.data ?? []).map((e: { module_id: string; status: string }) => [
      e.module_id, e.status as ModuleWithEnrollment['enrollment_status'],
    ])
  )

  const enrolled: ModuleWithEnrollment[] = []
  const available: ModuleWithEnrollment[] = []

  for (const mod of modules) {
    const enrollmentStatus = enrollMap.get(mod.id) ?? null
    if (enrollmentStatus === 'approved' || mod.is_universal) {
      enrolled.push({ ...mod, enrollment_status: enrollmentStatus })
    } else if (!enrollmentStatus) {
      available.push({ ...mod, enrollment_status: enrollmentStatus })
    }
  }

  return { enrolled, available }
}

export function useCourses(userId: string) {
  return useQuery({
    queryKey: queryKeys.courses.list(userId),
    queryFn: () => fetchCourses(userId),
    staleTime: QUERY_STALE_TIME,
    retry: QUERY_RETRY_COUNT,
  })
}
