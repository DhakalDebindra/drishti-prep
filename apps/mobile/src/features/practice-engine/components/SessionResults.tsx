import React, { useState, useEffect, useRef, useMemo } from 'react'
import { View, ScrollView, Pressable, AccessibilityInfo } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { Card } from '../../../components/ui/Card'
import { Badge } from '../../../components/ui/Badge'
import { Button } from '../../../components/ui/Button'
import { Feather } from '@expo/vector-icons'
import { useToggleBookmark } from '../hooks/useToggleBookmark'
import { useBookmarkedIds } from '../hooks/useBookmarkedIds'
import { AIFeedbackPanel } from './AIFeedbackPanel'
import { ReportIssueModal } from './ReportIssueModal'
import { toLatinNumerals } from '../../../lib/devanagari'

type AnswerResult = {
  questionId: string
  position: number
  content: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correctOption: string
  selectedOption: string | null
  isCorrect: boolean
  explanation: string | null
}

type SessionResultsProps = {
  attemptId: string
  scoreRaw: number
  scorePct: number
  questionCount: number
  answers: AnswerResult[]
  onBackToDashboard: () => void
  onRetry: () => void
}

function getOptionText(answer: AnswerResult, key: string): string {
  const map: Record<string, string> = {
    A: answer.option_a,
    B: answer.option_b,
    C: answer.option_c,
    D: answer.option_d,
  }
  return map[key] ?? key
}

export function SessionResults({ attemptId, scoreRaw, scorePct, questionCount, answers, onBackToDashboard, onRetry }: SessionResultsProps) {
  const [filter, setFilter] = useState<'all' | 'correct' | 'wrong' | 'skipped'>('all')
  const [expandedId, setExpandedId] = useState<string | null>(null)
  const [reportingQuestionId, setReportingQuestionId] = useState<string | null>(null)

  // Bookmarks: local set for optimistic toggling, hydrated once from the server
  // so questions saved in earlier sessions show as "Saved" on load.
  const [bookmarkedIds, setBookmarkedIds] = useState<Set<string>>(new Set())
  const toggleBookmark = useToggleBookmark()

  const questionIds = useMemo(() => answers.map((a) => a.questionId), [answers])
  const { data: savedIds } = useBookmarkedIds(questionIds)
  const hydratedRef = useRef(false)
  useEffect(() => {
    if (!hydratedRef.current && savedIds) {
      hydratedRef.current = true
      setBookmarkedIds(new Set(savedIds))
    }
  }, [savedIds])

  const handleBookmark = (id: string) => {
    const isBookmarked = bookmarkedIds.has(id)
    setBookmarkedIds(prev => {
      const next = new Set(prev)
      if (isBookmarked) next.delete(id)
      else next.add(id)
      return next
    })
    
    AccessibilityInfo.announceForAccessibility(isBookmarked ? 'Bookmark removed' : 'Question bookmarked')
    
    toggleBookmark.mutate(id, {
      onError: () => {
        // Revert on error
        setBookmarkedIds(prev => {
          const next = new Set(prev)
          if (isBookmarked) next.add(id)
          else next.delete(id)
          return next
        })
        AccessibilityInfo.announceForAccessibility('Failed to update bookmark')
      }
    })
  }

  const handleReport = (id: string) => {
    setReportingQuestionId(id)
  }

  const correctCount = answers.filter((a) => a.isCorrect).length
  const wrongCount = answers.filter((a) => a.selectedOption && !a.isCorrect).length
  const skippedCount = answers.filter((a) => !a.selectedOption || a.selectedOption === 'skipped').length
  const passed = scorePct >= 60

  const filteredAnswers = answers.filter((a) => {
    const isSkipped = !a.selectedOption || a.selectedOption === 'skipped'
    if (filter === 'all') return true
    if (filter === 'correct') return a.isCorrect
    if (filter === 'wrong') return !a.isCorrect && !isSkipped
    if (filter === 'skipped') return isSkipped
    return true
  })

  return (
    <>
    <ScrollView className="flex-1 bg-background" contentContainerClassName="px-4 pb-8 pt-14">
      <View 
        accessible={true}
        accessibilityRole="header"
        accessibilityLabel={`Score ${scorePct}%. ${scoreRaw} out of ${questionCount} correct. ${passed ? 'Passed' : 'Needs Improvement'}`}
      >
        <Card variant={passed ? 'success' : 'default'} className="mb-6 items-center py-6">
          <Text variant={passed ? 'h1' : 'h1'} color={passed ? 'success' : 'danger'}>
            {scorePct}%
          </Text>
          <Text variant="h3" color="default" className="mt-1">
            {scoreRaw}/{questionCount} correct
          </Text>
          {passed ? (
            <Badge variant="submitted" label="Passed" />
          ) : (
            <Badge variant="default" label="Needs Improvement" />
          )}
        </Card>
      </View>

      <View 
        accessible={true}
        accessibilityRole="summary"
        accessibilityLabel={`${correctCount} Correct, ${wrongCount} Wrong, ${skippedCount} Skipped`}
        className="mb-6 flex-row justify-around rounded-2xl border border-border bg-card p-4"
      >
        <View className="items-center">
          <Text variant="h3" color="success">{correctCount}</Text>
          <Text variant="caption" color="muted">Correct</Text>
        </View>
        <View className="items-center">
          <Text variant="h3" color="danger">{wrongCount}</Text>
          <Text variant="caption" color="muted">Wrong</Text>
        </View>
        <View className="items-center">
          <Text variant="h3" color="muted">{skippedCount}</Text>
          <Text variant="caption" color="muted">Skipped</Text>
        </View>
      </View>

      <AIFeedbackPanel attemptId={attemptId} />

      <Text variant="h3" className="mb-4">
        Question Review
      </Text>

      {/* Filter Bar */}
      <View className="mb-4 flex-row flex-wrap gap-2">
        {(['all', 'correct', 'wrong', 'skipped'] as const).map((f) => (
          <Pressable
            key={f}
            onPress={() => setFilter(f)}
            accessible={true}
            accessibilityRole="button"
            accessibilityState={{ selected: filter === f }}
            className={`rounded-full px-4 py-2 border ${
              filter === f 
                ? 'bg-primary border-primary' 
                : 'bg-card border-border'
            }`}
          >
            <Text className={`font-semibold ${filter === f ? 'text-primary-foreground' : 'text-foreground'}`}>
              {f.charAt(0).toUpperCase() + f.slice(1)}
            </Text>
          </Pressable>
        ))}
      </View>

      {/* Review List */}
      <View className="mb-6">
        {filteredAnswers.length === 0 ? (
          <View className="items-center justify-center py-8">
            <Text variant="body" color="muted">No questions match this filter.</Text>
          </View>
        ) : (
          filteredAnswers.map((answer) => {
            const isCorrect = answer.isCorrect
            const isSkipped = !answer.selectedOption || answer.selectedOption === 'skipped'
            const isExpanded = expandedId === answer.questionId
            const isBookmarked = bookmarkedIds.has(answer.questionId)

            const badgeLabel = isCorrect ? 'Correct' : isSkipped ? 'Skipped' : 'Wrong'
            const a11ySummary = toLatinNumerals(`Question ${answer.position}: ${answer.content}. ${badgeLabel}. ${isExpanded ? 'Expanded' : 'Collapsed'}. Double tap to ${isExpanded ? 'collapse' : 'expand'}.`)

            return (
              <View key={answer.questionId} className="mb-3 rounded-2xl border border-border bg-card overflow-hidden">
                {/* Accordion Header */}
                <Pressable
                  onPress={() => setExpandedId(isExpanded ? null : answer.questionId)}
                  accessible={true}
                  accessibilityRole="button"
                  accessibilityLabel={a11ySummary}
                  className="flex-row items-center justify-between p-4 active:bg-secondary/50"
                >
                  <View className="flex-row items-center flex-1 pr-4">
                    <Text variant="h3" className="mr-3">Q{answer.position}</Text>
                    <Text variant="bodySmall" numberOfLines={isExpanded ? undefined : 1} className="flex-1" color="secondary">
                      {answer.content}
                    </Text>
                  </View>
                  <View className="flex-row items-center">
                    {isCorrect && <Badge variant="submitted" label="Correct" />}
                    {!isCorrect && isSkipped && <Badge variant="inProgress" label="Skipped" />}
                    {!isCorrect && !isSkipped && <Badge variant="default" label="Wrong" />}
                    <Feather name={isExpanded ? "chevron-up" : "chevron-down"} size={20} className="text-muted-foreground ml-2" />
                  </View>
                </Pressable>

                {/* Expanded Content */}
                {isExpanded && (
                  <View className="border-t border-border p-4 bg-background/50">
                    
                    {/* Action Bar */}
                    <View className="flex-row justify-end gap-3 mb-4">
                      <Pressable 
                        onPress={() => handleBookmark(answer.questionId)}
                        accessible={true}
                        accessibilityRole="button"
                        accessibilityLabel={isBookmarked ? "Remove Bookmark" : "Add Bookmark"}
                        className="flex-row items-center gap-1 p-2"
                      >
                        <Feather name="bookmark" size={16} color={isBookmarked ? "#0ea5e9" : "#64748b"} />
                        <Text variant="caption" style={{ color: isBookmarked ? '#0ea5e9' : '#64748b' }}>
                          {isBookmarked ? 'Saved' : 'Save'}
                        </Text>
                      </Pressable>
                      <Pressable 
                        onPress={() => handleReport(answer.questionId)}
                        accessible={true}
                        accessibilityRole="button"
                        accessibilityLabel="Report Question Issue"
                        className="flex-row items-center gap-1 p-2"
                      >
                        <Feather name="flag" size={16} color="#64748b" />
                        <Text variant="caption" color="muted">Report</Text>
                      </Pressable>
                    </View>

                    {/* Options */}
                    {['A', 'B', 'C', 'D'].map((key) => {
                      const isSelected = answer.selectedOption === key
                      const isCorrectOpt = key === answer.correctOption
                      const optionA11y = toLatinNumerals(`Option ${key}: ${getOptionText(answer, key)}. ${isCorrectOpt ? 'Correct Answer' : ''} ${isSelected && !isCorrectOpt ? 'Your Incorrect Answer' : ''}`)

                      return (
                        <View 
                          key={key} 
                          accessible={true}
                          accessibilityLabel={optionA11y}
                          className={`mb-2 rounded-lg px-3 py-3 ${
                            isCorrectOpt ? 'bg-primary/10 border border-primary/20' : isSelected && !isCorrect ? 'bg-destructive/10 border border-destructive/20' : 'bg-card border border-border'
                          }`}
                        >
                          <Text variant="bodySmall" color={isCorrectOpt ? 'success' : isSelected && !isCorrect ? 'danger' : 'default'}>
                            <Text className="font-bold">{key}.</Text> {getOptionText(answer, key)}
                            {isCorrectOpt && ' \u2713'}
                            {isSelected && !isCorrectOpt && ' \u2717'}
                          </Text>
                        </View>
                      )
                    })}

                    {/* Explanation */}
                    {answer.explanation && (
                      <View 
                        accessible={true}
                        accessibilityLabel={toLatinNumerals(`Explanation: ${answer.explanation}`)}
                        className="mt-3 rounded-xl bg-muted px-4 py-3"
                      >
                        <Text variant="caption" className="font-medium text-foreground mb-1">Explanation</Text>
                        <Text variant="bodySmall" color="secondary" className="leading-5">{answer.explanation}</Text>
                      </View>
                    )}
                  </View>
                )}
              </View>
            )
          })
        )}
      </View>

      <View className="mb-4 gap-3">
        <Button title="Back to Dashboard" onPress={onBackToDashboard} variant="outline" size="lg" />
        <Button title="Try Again" onPress={onRetry} size="lg" />
      </View>
    </ScrollView>

    <ReportIssueModal
      visible={reportingQuestionId !== null}
      questionId={reportingQuestionId}
      onClose={() => setReportingQuestionId(null)}
    />
    </>
  )
}
