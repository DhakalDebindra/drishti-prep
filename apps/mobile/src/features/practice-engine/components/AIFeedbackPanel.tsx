import React from 'react'
import { View } from 'react-native'
import { Text } from '../../../components/ui/Text'
import { Card } from '../../../components/ui/Card'
import { Feather } from '@expo/vector-icons'
import { useAIFeedback } from '../hooks/useAIFeedback'
import { cssInterop } from 'nativewind'

cssInterop(Feather, { className: 'style' })

type Props = {
  attemptId: string
}

export function AIFeedbackPanel({ attemptId }: Props) {
  const { data: feedback, isLoading, isError } = useAIFeedback(attemptId)

  if (isLoading) {
    return (
      <Card 
        accessible={true}
        accessibilityRole="alert"
        accessibilityLabel="AI is analyzing your performance. Please wait."
        className="mb-6 items-center p-6 border-primary/20 bg-primary/5"
      >
        <Feather name="loader" size={24} className="text-primary mb-3" />
        <Text variant="h3" className="text-center">AI is analyzing...</Text>
        <Text variant="bodySmall" color="muted" className="text-center mt-2">
          Generating personalized insights from your attempt.
        </Text>
      </Card>
    )
  }

  if (isError || !feedback) {
    return (
      <Card 
        accessible={true}
        accessibilityRole="summary"
        className="mb-6 border-primary/20 bg-primary/5 p-5"
      >
        <View className="flex-row items-center mb-4">
          <View className="rounded-xl bg-primary/10 p-2 mr-3">
            <Feather name="cpu" size={24} className="text-primary" />
          </View>
          <View>
            <Text variant="h3">AI Analysis</Text>
            <Text variant="caption" color="muted">Powered by DrishtiPrep AI</Text>
          </View>
        </View>
        <Text variant="bodySmall" color="secondary">
          AI feedback has not been generated for this attempt yet.
        </Text>
      </Card>
    )
  }

  const parseWeakZones = (weakZones: Record<string, unknown> | null) => {
    if (!weakZones || typeof weakZones !== 'object') return []
    if (Array.isArray(weakZones)) return weakZones
    return Object.keys(weakZones)
  }

  const weakZones = parseWeakZones(feedback.weak_zones)

  return (
    <Card 
      accessible={true}
      accessibilityRole="summary"
      className="mb-6 border-primary/20 bg-primary/5 p-5"
    >
      <View className="flex-row items-center mb-4">
        <View className="rounded-xl bg-primary/10 p-2 mr-3">
          <Feather name="cpu" size={24} className="text-primary" />
        </View>
        <View>
          <Text variant="h3">AI Analysis</Text>
          <Text variant="caption" color="muted">Powered by DrishtiPrep AI</Text>
        </View>
      </View>

      {feedback.strengths && (
        <View className="mb-4 rounded-xl bg-card border border-border p-4">
          <View className="flex-row items-center mb-2">
            <Feather name="zap" size={16} className="text-success mr-2" />
            <Text variant="body" className="font-bold">Overall Performance</Text>
          </View>
          <Text variant="bodySmall" color="secondary" className="leading-5">
            {/* The web uses RichText, on mobile we'll strip basic markdown or just display raw for now */}
            {feedback.strengths.replace(/\*\*/g, '')}
          </Text>
        </View>
      )}

      {weakZones.length > 0 && (
        <View>
          <View className="flex-row items-center mb-2 mt-2">
            <Feather name="target" size={16} className="text-destructive mr-2" />
            <Text variant="body" className="font-bold">Focus Areas</Text>
          </View>
          {weakZones.map((zone, idx) => (
            <View key={idx} className="flex-row items-start mb-2 rounded-lg bg-card border border-border p-3">
              <View className="h-6 w-6 rounded-full bg-destructive/10 items-center justify-center mr-3 mt-0.5">
                <Text variant="caption" color="danger" className="font-bold">{idx + 1}</Text>
              </View>
              <Text variant="bodySmall" color="secondary" className="flex-1 leading-5">
                {typeof zone === 'string' ? zone.replace(/\*\*/g, '') : JSON.stringify(zone)}
              </Text>
            </View>
          ))}
        </View>
      )}
    </Card>
  )
}
