import { useEffect, useState } from 'react'
import {
  View,
  FlatList,
  Pressable,
  RefreshControl,
  ActivityIndicator,
  AccessibilityInfo,
} from 'react-native'
import { useRouter } from 'expo-router'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'
import { Badge } from '../../../components/ui/Badge'
import { Button } from '../../../components/ui/Button'
import { EmptyState } from '../../../components/ui/EmptyState'
import { ErrorState } from '../../../components/ui/ErrorState'
import { useToggleBookmark } from '../../practice-engine/hooks/useToggleBookmark'
import { toLatinNumerals } from '../../../lib/devanagari'
import { useBookmarks, BOOKMARKS_PER_PAGE, type BookmarkedQuestion } from '../hooks/useBookmarks'

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

function formatSavedDate(iso: string): string {
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return ''
  return `${MONTHS[d.getMonth()]} ${d.getDate()}, ${d.getFullYear()}`
}

const OPTION_KEYS = ['A', 'B', 'C', 'D'] as const

function getOptionText(item: BookmarkedQuestion, key: string): string {
  const map: Record<string, string> = {
    A: item.option_a,
    B: item.option_b,
    C: item.option_c,
    D: item.option_d,
  }
  return map[key] ?? ''
}

type BookmarkCardProps = {
  item: BookmarkedQuestion
  expanded: boolean
  onToggleExpand: () => void
  onUnbookmark: () => void
}

function BookmarkCard({ item, expanded, onToggleExpand, onUnbookmark }: BookmarkCardProps) {
  const savedOn = formatSavedDate(item.createdAt)
  const headerLabel = toLatinNumerals(
    `${item.setTitle}. Saved ${savedOn}. ${item.content}. ${expanded ? 'Expanded' : 'Collapsed'}. Double tap to ${expanded ? 'collapse' : 'expand'}.`,
  )

  return (
    <View className="mb-3 overflow-hidden rounded-2xl border border-border bg-card">
      <View className="flex-row items-start">
        <Pressable
          onPress={onToggleExpand}
          accessible
          accessibilityRole="button"
          accessibilityLabel={headerLabel}
          accessibilityState={{ expanded }}
          className="flex-1 flex-row items-start p-4 active:bg-secondary/40"
        >
          <Feather name="bookmark" size={18} color="#2563EB" style={{ marginTop: 2, marginRight: 12 }} />
          <View className="flex-1 pr-2">
            <View className="mb-1.5 flex-row flex-wrap items-center gap-2">
              <Badge variant="submitted" label={item.setTitle} />
              {!!savedOn && (
                <Text variant="caption" color="muted">
                  Saved {savedOn}
                </Text>
              )}
            </View>
            <Text
              variant="body"
              numberOfLines={expanded ? undefined : 2}
              className="font-medium leading-6"
            >
              {item.content}
            </Text>
          </View>
          <Feather
            name={expanded ? 'chevron-up' : 'chevron-down'}
            size={20}
            color="#94a3b8"
            style={{ marginTop: 2 }}
          />
        </Pressable>

        <Pressable
          onPress={onUnbookmark}
          accessible
          accessibilityRole="button"
          accessibilityLabel="Remove bookmark"
          hitSlop={8}
          className="m-2 h-9 w-9 items-center justify-center rounded-full border border-border bg-background active:opacity-70"
        >
          <Feather name="trash-2" size={16} color="#ef4444" />
        </Pressable>
      </View>

      {expanded && (
        <View
          accessibilityRole="summary"
          className="border-t border-border bg-background/50 p-4"
        >
          {OPTION_KEYS.map((key) => {
            const isCorrect = item.correctOption === key
            const optionA11y = toLatinNumerals(
              `Option ${key}: ${getOptionText(item, key)}.${isCorrect ? ' Correct answer.' : ''}`,
            )
            return (
              <View
                key={key}
                accessible
                accessibilityLabel={optionA11y}
                className={`mb-2 flex-row items-start rounded-lg border px-3 py-3 ${
                  isCorrect ? 'border-primary/30 bg-primary/10' : 'border-border bg-card'
                }`}
              >
                <Text
                  variant="bodySmall"
                  className="mr-2 font-bold"
                  color={isCorrect ? 'success' : 'muted'}
                >
                  {key}.
                </Text>
                <Text
                  variant="bodySmall"
                  className="flex-1 leading-5"
                  color={isCorrect ? 'success' : 'default'}
                >
                  {getOptionText(item, key)}
                  {isCorrect ? ' ✓' : ''}
                </Text>
              </View>
            )
          })}

          <View
            accessible
            accessibilityLabel={toLatinNumerals(
              `Explanation: ${item.explanation ?? 'No explanation provided.'}`,
            )}
            className="mt-2 rounded-xl bg-muted px-4 py-3"
          >
            <Text variant="caption" className="mb-1 font-semibold text-foreground">
              Explanation
            </Text>
            <Text variant="bodySmall" color="secondary" className="leading-5">
              {item.explanation ?? 'No explanation provided.'}
            </Text>
          </View>
        </View>
      )}
    </View>
  )
}

export function BookmarkedQuestionList({ userId }: { userId: string }) {
  const router = useRouter()
  const [page, setPage] = useState(1)
  const [expandedId, setExpandedId] = useState<string | null>(null)
  const [removingIds, setRemovingIds] = useState<Set<string>>(new Set())

  const { data, isLoading, isError, error, refetch, isRefetching, isPlaceholderData } =
    useBookmarks(userId, page)
  const toggleBookmark = useToggleBookmark()

  // Clear optimistic-removal markers whenever a fresh page of data arrives, so
  // the set never holds ids that the server has already dropped.
  useEffect(() => {
    setRemovingIds(new Set())
  }, [data])

  const handleUnbookmark = (questionId: string) => {
    setRemovingIds((prev) => new Set(prev).add(questionId))
    AccessibilityInfo.announceForAccessibility('Bookmark removed')
    toggleBookmark.mutate(questionId, {
      onError: () => {
        setRemovingIds((prev) => {
          const next = new Set(prev)
          next.delete(questionId)
          return next
        })
        AccessibilityInfo.announceForAccessibility('Failed to remove bookmark')
      },
    })
  }

  if (isLoading) {
    return (
      <View className="flex-1 items-center justify-center bg-background">
        <ActivityIndicator size="large" color="#2563EB" />
      </View>
    )
  }

  if (isError) {
    return (
      <ErrorState
        message={error instanceof Error ? error.message : 'Failed to load bookmarks.'}
        onRetry={() => refetch()}
      />
    )
  }

  const items = (data?.items ?? []).filter((item) => !removingIds.has(item.questionId))
  const totalCount = data?.totalCount ?? 0
  const totalPages = Math.max(1, Math.ceil(totalCount / BOOKMARKS_PER_PAGE))

  if (totalCount === 0) {
    return (
      <View className="flex-1 bg-background">
        <EmptyState
          icon={'📋'}
          title="No bookmarks yet"
          description="Questions you save during practice will appear here, ready for a calmer second look."
        />
        <View className="px-6 pb-10">
          <Button title="Start practicing" onPress={() => router.push('/(app)/(tabs)/practice')} size="lg" />
        </View>
      </View>
    )
  }

  return (
    <FlatList
      className="flex-1 bg-background"
      contentContainerClassName="px-4 pb-10 pt-4"
      data={items}
      keyExtractor={(item) => item.questionId}
      refreshControl={
        <RefreshControl refreshing={isRefetching && !isPlaceholderData} onRefresh={() => refetch()} tintColor="#2563EB" />
      }
      ListHeaderComponent={
        <View className="mb-3">
          <Text variant="body" color="muted">
            {totalCount} saved {totalCount === 1 ? 'question' : 'questions'}
          </Text>
        </View>
      }
      renderItem={({ item }) => (
        <BookmarkCard
          item={item}
          expanded={expandedId === item.questionId}
          onToggleExpand={() => setExpandedId((cur) => (cur === item.questionId ? null : item.questionId))}
          onUnbookmark={() => handleUnbookmark(item.questionId)}
        />
      )}
      ListFooterComponent={
        totalPages > 1 ? (
          <View className="mt-2 flex-row items-center justify-center gap-4">
            <Pressable
              onPress={() => setPage((p) => Math.max(1, p - 1))}
              disabled={page <= 1}
              accessibilityRole="button"
              accessibilityLabel="Previous page"
              accessibilityState={{ disabled: page <= 1 }}
              className={`h-11 w-11 items-center justify-center rounded-full border border-border bg-card ${page <= 1 ? 'opacity-40' : 'active:opacity-70'}`}
            >
              <Feather name="chevron-left" size={20} color="#64748b" />
            </Pressable>
            <Text variant="bodySmall" color="muted" accessibilityLabel={`Page ${page} of ${totalPages}`}>
              Page {page} of {totalPages}
            </Text>
            <Pressable
              onPress={() => setPage((p) => Math.min(totalPages, p + 1))}
              disabled={page >= totalPages}
              accessibilityRole="button"
              accessibilityLabel="Next page"
              accessibilityState={{ disabled: page >= totalPages }}
              className={`h-11 w-11 items-center justify-center rounded-full border border-border bg-card ${page >= totalPages ? 'opacity-40' : 'active:opacity-70'}`}
            >
              <Feather name="chevron-right" size={20} color="#64748b" />
            </Pressable>
          </View>
        ) : null
      }
    />
  )
}
