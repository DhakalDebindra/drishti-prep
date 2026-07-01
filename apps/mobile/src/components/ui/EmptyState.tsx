import { View } from 'react-native'
import { Text } from './Text'

interface EmptyStateProps {
  icon?: string
  title: string
  description?: string
}

export function EmptyState({ icon, title, description }: EmptyStateProps) {
  return (
    <View className="flex-1 items-center justify-center px-6 py-12">
      {icon && <Text className="mb-3 text-4xl">{icon}</Text>}
      <Text variant="h3" color="secondary" className="mb-1">
        {title}
      </Text>
      {description && (
        <Text variant="body" color="muted" className="text-center">
          {description}
        </Text>
      )}
    </View>
  )
}
