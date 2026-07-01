import { useEffect, useRef } from 'react'
import { View, Pressable, AccessibilityInfo, findNodeHandle } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { toLatinNumerals } from '../../../lib/devanagari'

type QuestionCardProps = {
  questionNumber: number
  totalQuestions: number
  content: string
  options: Array<{ key: string; text: string }>
  selectedOption: string | null
  onSelect: (optionKey: string) => void
  showResult?: boolean
  correctOption?: string
}

export function QuestionCard({
  questionNumber,
  totalQuestions,
  content,
  options,
  selectedOption,
  onSelect,
  showResult,
  correctOption,
}: QuestionCardProps) {
  const headerRef = useRef(null)

  useEffect(() => {
    let timeoutId: NodeJS.Timeout
    timeoutId = setTimeout(() => {
      if (headerRef.current) {
        const reactTag = findNodeHandle(headerRef.current)
        if (reactTag) {
          AccessibilityInfo.setAccessibilityFocus(reactTag)
        }
      }
    }, 150)

    return () => clearTimeout(timeoutId)
  }, [questionNumber])

  return (
    <View className="flex-1 px-4 pt-4 pb-8">
      <View 
        ref={headerRef}
        accessible={true}
        focusable={true}
        accessibilityRole="header"
        accessibilityLabel={toLatinNumerals(`Question ${questionNumber}. ${content}`)}
        importantForAccessibility="yes"
        className="mb-6"
      >
        <Text variant="h3" className="leading-7">
          {content}
        </Text>
      </View>

      {options.map((opt) => {
        const isSelected = selectedOption === opt.key
        const isCorrect = showResult && opt.key === correctOption
        const isWrong = showResult && isSelected && opt.key !== correctOption

        let borderColor = 'border-foreground/25'
        let bgColor = 'bg-card'
        // Filled badge by default so the A-D letters pop (was a faint grey outline).
        let badgeClass = 'border-muted-foreground bg-muted-foreground'
        let letterClass = 'text-background'

        let a11yStatus = ''
        if (isCorrect) {
          borderColor = 'border-primary'
          bgColor = 'bg-primary/15'
          badgeClass = 'border-primary bg-primary'
          letterClass = 'text-primary-foreground'
          a11yStatus = 'Correct Answer'
        } else if (isWrong) {
          borderColor = 'border-destructive'
          bgColor = 'bg-destructive/15'
          badgeClass = 'border-destructive bg-destructive'
          letterClass = 'text-background'
          a11yStatus = 'Incorrect Answer'
        } else if (isSelected && !showResult) {
          borderColor = 'border-primary'
          bgColor = 'bg-primary/15'
          badgeClass = 'border-primary bg-primary'
          letterClass = 'text-primary-foreground'
          a11yStatus = 'Selected'
        }

        const accessibilityLabel = toLatinNumerals(`Option ${opt.key}: ${opt.text}. ${a11yStatus}`)

        return (
          <Pressable
            key={`opt-${questionNumber}-${opt.key}`}
            onPress={() => onSelect(opt.key)}
            disabled={showResult}
            accessible={true}
            accessibilityRole="radio"
            accessibilityState={{ selected: isSelected }}
            accessibilityLabel={accessibilityLabel}
            className={`mb-3 flex-row items-center rounded-xl border-2 px-4 py-4 ${borderColor} ${bgColor} active:opacity-80`}
          >
            <View
              importantForAccessibility="no-hide-descendants"
              accessibilityElementsHidden={true}
              className={`mr-3 h-8 w-8 items-center justify-center rounded-full border-2 ${badgeClass}`}
            >
              <Text className={`font-bold ${letterClass}`}>
                {opt.key}
              </Text>
            </View>
            <Text 
              importantForAccessibility="no-hide-descendants"
              accessibilityElementsHidden={true}
              variant="body" 
              className={`flex-1 ${isSelected || isCorrect ? 'font-semibold text-foreground' : 'text-foreground'}`}
            >
              {opt.text}
            </Text>
          </Pressable>
        )
      })}
    </View>
  )
}
