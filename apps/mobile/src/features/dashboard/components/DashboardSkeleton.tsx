import { View } from 'react-native'
import { Skeleton } from '../../../components/ui'

export function DashboardSkeleton() {
  return (
    <View className="flex-1 bg-background px-4 pt-12">
      <Skeleton className="mb-2 h-8 w-48" />
      <Skeleton className="mb-6 h-4 w-64" />

      <View className="mb-6 flex-row gap-3">
        <Skeleton className="flex-1 h-28" />
        <Skeleton className="flex-1 h-28" />
        <Skeleton className="flex-1 h-28" />
      </View>

      <View className="mb-6 flex-row gap-3">
        <Skeleton className="flex-1 h-40" />
        <Skeleton className="flex-1 h-40" />
      </View>

      <Skeleton className="mb-2 h-6 w-48" />
      <View className="gap-3">
        <Skeleton className="h-20 w-full" />
        <Skeleton className="h-20 w-full" />
        <Skeleton className="h-20 w-full" />
      </View>
    </View>
  )
}
