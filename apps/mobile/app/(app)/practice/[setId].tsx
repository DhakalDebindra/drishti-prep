import { useState, useCallback, useRef } from 'react'
import { View, ScrollView, AccessibilityInfo } from 'react-native'
import { useRouter, useLocalSearchParams, Stack } from 'expo-router'
import { cssInterop } from 'nativewind'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../src/components/ui/Text'
import { Button } from '../../../src/components/ui/Button'
import { ErrorState } from '../../../src/components/ui/ErrorState'
import { usePracticeSession, useSubmitAnswer, useFinishAttempt, QuestionCard, SessionProgress, SessionSkeleton, QuestionNavigatorDrawer, ConfirmSubmitModal, type QuestionCardHandle } from '../../../src/features/practice-engine'
import { useSession } from '../../../src/providers/SessionProvider'
import { useAccessibilityFocus } from '../../../src/hooks/useAccessibilityFocus'
import { useModalFocusReturn } from '../../../src/hooks/useModalFocusReturn'
import { useAnswerFeedback } from '../../../src/hooks/useAnswerFeedback'

cssInterop(Feather, { className: 'style' })

export default function PracticeSessionScreen() {
  const { setId } = useLocalSearchParams<{ setId: string }>()
  const { user } = useSession()
  const router = useRouter()
  const { data, isLoading, isError, error, refetch } = usePracticeSession(setId, user?.id ?? '')
  const submitAnswer = useSubmitAnswer(setId)
  const finishAttempt = useFinishAttempt(setId)

  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<Record<string, string>>({})
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [showConfirmModal, setShowConfirmModal] = useState(false)
  const [showDrawer, setShowDrawer] = useState(false)
  const [showExplanation, setShowExplanation] = useState(false)

  const questionCardRef = useRef<QuestionCardHandle>(null)
  const jumpBtnRef = useRef<any>(null)
  const submitBtnRef = useRef<any>(null)
  const { ref: explanationRef, focus: focusExplanation } = useAccessibilityFocus()

  useModalFocusReturn(showDrawer, jumpBtnRef)
  useModalFocusReturn(showConfirmModal, submitBtnRef)
  const { playCorrect, playIncorrect } = useAnswerFeedback()

  const handleSelect = useCallback(async (optionKey: string) => {
    if (!data?.questions[currentIndex] || !data.activeAttempt) return
    const question = data.questions[currentIndex]
    const isCorrect = optionKey === question.correct_option

    if (isCorrect) {
      playCorrect()
    } else {
      playIncorrect()
    }

    AccessibilityInfo.announceForAccessibility(
      isCorrect 
        ? `Correct Answer. Option ${optionKey}` 
        : `Incorrect Answer. Option ${optionKey}`
    )

    setAnswers((prev) => ({ ...prev, [question.id]: optionKey }))
    submitAnswer.mutate({
      attemptId: data.activeAttempt.id,
      questionId: question.id,
      selectedOption: optionKey,
      isCorrect,
    })
  }, [data, currentIndex, submitAnswer, playCorrect, playIncorrect])

  const handleSubmit = useCallback(async () => {
    if (!data?.activeAttempt || !data.questions) return
    setIsSubmitting(true)
    setShowConfirmModal(false)
    try {
      const answered = data.questions.map((q) => ({
        questionId: q.id,
        selectedOption: answers[q.id] ?? 'skipped',
        isCorrect: (answers[q.id] ?? '') === q.correct_option,
      }))
      const scoreRaw = answered.filter((a) => a.isCorrect).length
      const scorePct = Math.round((scoreRaw / data.questions.length) * 100)

      await finishAttempt.mutateAsync({
        attemptId: data.activeAttempt.id,
        scoreRaw,
        scorePct,
        setId: data.activeAttempt.set_id,
      })

      router.replace(`/(app)/practice/${setId}/review?attemptId=${data.activeAttempt.id}`)
    } finally {
      setIsSubmitting(false)
    }
  }, [data, answers, finishAttempt, router, setId])

  if (!user || !data) return null
  if (isLoading) return <SessionSkeleton />
  if (isError) return <ErrorState message={error?.message} onRetry={() => refetch()} />

  const questions = data?.questions ?? []
  const activeAttempt = data?.activeAttempt
  const currentQuestion = questions[currentIndex]
  
  if (!currentQuestion) return null

  const existingAnswers = data?.existingAnswers ?? []

  const existingAnswerForCurrent = existingAnswers.find(
    (ea) => ea.question_id === currentQuestion?.id
  )
  const currentSelected = answers[currentQuestion?.id ?? ''] ?? existingAnswerForCurrent?.selected_option ?? null

  const answeredIndices = new Set<number>()
  let answeredCount = 0

  questions.forEach((q, i) => {
    const ea = existingAnswers.find((e) => e.question_id === q.id)
    const hasAnswer = !!answers[q.id] || (!!ea && ea.selected_option !== 'skipped')
    if (hasAnswer) {
      answeredIndices.add(i)
      answeredCount++
    }
  })

  const isLastQuestion = currentIndex === questions.length - 1
  const MIN_ATTEMPTED_TO_SUBMIT = Math.min(10, questions.length)
  const canSubmit = answeredCount >= MIN_ATTEMPTED_TO_SUBMIT

  const options = currentQuestion
    ? [
        { key: 'A', text: currentQuestion.option_a },
        { key: 'B', text: currentQuestion.option_b },
        { key: 'C', text: currentQuestion.option_c },
        { key: 'D', text: currentQuestion.option_d },
      ]
    : []

  // Single entry point for changing question, used by Previous / Next / Jump.
  // Announces the new position for screen-reader users and moves accessibility
  // focus to the question header. setTimeout (not rAF) is more reliable on
  // Xiaomi/Samsung where setAccessibilityFocus fired too early is dropped.
  const goToIndex = (target: number) => {
    if (target < 0 || target >= questions.length || target === currentIndex) return
    setShowExplanation(false)
    setCurrentIndex(target)
    setTimeout(() => questionCardRef.current?.focus(), 150)
    setTimeout(() => questionCardRef.current?.focus(), 500)
  }



  return (
    <View className="flex-1 bg-background">
      <Stack.Screen options={{ headerShown: false }} />

      <SessionProgress
        title={data.setTitle}
        answeredCount={answeredCount}
        totalCount={questions.length}
        currentNumber={currentIndex + 1}
        onBack={() => router.back()}
      />

      <ScrollView className="flex-1">
        <QuestionCard
          ref={questionCardRef}
          questionNumber={currentIndex + 1}
          totalQuestions={questions.length}
          content={currentQuestion.content}
          options={options}
          selectedOption={currentSelected}
          onSelect={handleSelect}
          showResult={!!currentSelected}
          correctOption={currentQuestion.correct_option}
        />

        {/* Explanation Section */}
        {currentQuestion.explanation && !!currentSelected ? (
          <View className="px-4 pb-6">
            <Button
              onPress={() => {
                const wasVisible = showExplanation
                setShowExplanation(!wasVisible)
                if (!wasVisible) {
                  requestAnimationFrame(() => focusExplanation())
                }
              }}
              accessibilityLabel={showExplanation ? 'Hide explanation' : 'View explanation'}
              variant="tonal"
              className="w-full mt-2"
              leftIcon={<Feather name={showExplanation ? "eye-off" : "eye"} size={20} className="text-accent-foreground" />}
              title={showExplanation ? "Hide Explanation" : "View Explanation"}
            />
            
            {showExplanation && (
              <View
                ref={explanationRef}
                accessible={true}
                className="mt-3 rounded-xl bg-card p-4 border border-border"
              >
                <Text variant="body" className="text-foreground leading-6">
                  {currentQuestion.explanation}
                </Text>
              </View>
            )}
          </View>
        ) : null}
      </ScrollView>

      {/* Bottom Action Dock — using our standard reusable Button mechanism */}
      <View className="border-t border-border bg-card px-4 pb-8 pt-4">
        <View className="flex-row gap-3">
          <Button
            onPress={() => goToIndex(currentIndex - 1)}
            disabled={currentIndex === 0}
            accessibilityLabel="Previous question"
            variant="tonal"
            className="flex-1"
            leftIcon={<Feather name="chevron-left" size={20} className={currentIndex === 0 ? 'text-muted-foreground' : 'text-accent-foreground'} />}
            title="Previous"
          />

          {isLastQuestion && canSubmit ? (
            <Button
              ref={submitBtnRef}
              onPress={() => setShowConfirmModal(true)}
              disabled={isSubmitting}
              accessibilityLabel="Submit test"
              variant="primary"
              className="flex-1"
              title={isSubmitting ? 'Submitting…' : 'Submit'}
              rightIcon={<Feather name="check-circle" size={18} className="text-primary-foreground" />}
            />
          ) : (
            <Button
              onPress={() => goToIndex(currentIndex + 1)}
              disabled={isLastQuestion}
              accessibilityLabel="Next question"
              variant="primary"
              className="flex-1"
              title="Next"
              rightIcon={<Feather name="chevron-right" size={20} className={isLastQuestion ? 'text-primary-foreground/50' : 'text-primary-foreground'} />}
            />
          )}
        </View>

        <Button
          ref={jumpBtnRef}
          onPress={() => setShowDrawer(true)}
          accessibilityLabel={`Jump to a question. ${answeredCount} of ${questions.length} answered.`}
          variant="tonal"
          className="mt-3 w-full"
          leftIcon={<Feather name="grid" size={18} className="text-accent-foreground" />}
          title={`Jump to question (${answeredCount}/${questions.length})`}
        />
      </View>

      {showDrawer && (
        <QuestionNavigatorDrawer
          visible={showDrawer}
          onClose={() => setShowDrawer(false)}
          totalQuestions={questions.length}
          currentIndex={currentIndex}
          answeredIndices={answeredIndices}
          onSelect={(idx) => goToIndex(idx)}
        />
      )}

      {showConfirmModal && (
        <ConfirmSubmitModal
          visible={showConfirmModal}
          answeredCount={answeredCount}
          totalCount={questions.length}
          onConfirm={handleSubmit}
          onCancel={() => setShowConfirmModal(false)}
          submitting={isSubmitting}
        />
      )}
    </View>
  )
}
