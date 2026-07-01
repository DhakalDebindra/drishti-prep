import { useQuery, keepPreviousData } from '@tanstack/react-query'
import { supabaseMobile } from '@repo/supabase/mobile'
import { queryKeys } from '../../../lib/query-keys'
import { BOOKMARK_PAGE_SIZE } from '../../../config/constants'

export type BookmarkedQuestion = {
  bookmarkId: string
  questionId: string
  content: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correctOption: string
  explanation: string | null
  setTitle: string
  createdAt: string
}

export type BookmarksPage = {
  items: BookmarkedQuestion[]
  totalCount: number
}

type BookmarkRow = {
  id: string
  created_at: string
  question_id: string
  questions: {
    id: string
    content: string
    option_a: string
    option_b: string
    option_c: string
    option_d: string
    correct_option: string
    explanation: string | null
    question_sets: { title: string } | null
  } | null
}

async function fetchBookmarks(userId: string, page: number): Promise<BookmarksPage> {
  const offset = (page - 1) * BOOKMARK_PAGE_SIZE

  const { data, error, count } = await supabaseMobile
    .from('bookmarks')
    .select(
      `
      id,
      created_at,
      question_id,
      questions (
        id,
        content,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_option,
        explanation,
        question_sets ( title )
      )
    `,
      { count: 'exact' },
    )
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .range(offset, offset + BOOKMARK_PAGE_SIZE - 1)

  if (error) throw error

  const items: BookmarkedQuestion[] = ((data ?? []) as unknown as BookmarkRow[]).map((row) => ({
    bookmarkId: row.id,
    questionId: row.question_id,
    content: row.questions?.content ?? 'Deleted question',
    option_a: row.questions?.option_a ?? '',
    option_b: row.questions?.option_b ?? '',
    option_c: row.questions?.option_c ?? '',
    option_d: row.questions?.option_d ?? '',
    correctOption: row.questions?.correct_option ?? '',
    explanation: row.questions?.explanation ?? null,
    setTitle: row.questions?.question_sets?.title ?? 'Unknown set',
    createdAt: row.created_at,
  }))

  return { items, totalCount: count ?? 0 }
}

export function useBookmarks(userId: string, page: number) {
  return useQuery({
    queryKey: queryKeys.bookmarks.list(userId, page),
    queryFn: () => fetchBookmarks(userId, page),
    enabled: !!userId,
    staleTime: 60 * 1000,
    placeholderData: keepPreviousData,
  })
}

export const BOOKMARKS_PER_PAGE = BOOKMARK_PAGE_SIZE
