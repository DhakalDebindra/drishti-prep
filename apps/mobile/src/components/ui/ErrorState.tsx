import { View } from 'react-native'
import { Text } from './Text'
import { Button } from './Button'

interface ErrorStateProps {
  message?: string
  onRetry?: () => void
}

export function ErrorState({
  message = 'Something went wrong. Please try again.',
  onRetry,
}: ErrorStateProps) {
  return (
    <View className="flex-1 items-center justify-center px-6">
      <Text variant="h3" color="danger" className="mb-2">
        Error
      </Text>
      <Text variant="body" color="muted" className="mb-6 text-center">
        {message}
      </Text>
      {onRetry && (
        <Button variant="secondary" size="sm" title="Retry" onPress={onRetry} />
      )}
    </View>
  )
}
