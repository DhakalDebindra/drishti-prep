import type { ReactNode } from 'react'
import { View } from 'react-native'
import { Text } from './Text'

type SettingRowProps = {
  label: string
  description?: string
  /** Control rendered on the right (Switch, value text, etc.). */
  right?: ReactNode
}

/** A standard settings row: label + optional description on the left, control on the right. */
export function SettingRow({ label, description, right }: SettingRowProps) {
  return (
    <View className="flex-row items-center justify-between rounded-2xl border-2 border-border bg-card px-4 py-3.5">
      <View className="flex-1 pr-3">
        <Text variant="body" className="font-semibold">
          {label}
        </Text>
        {description && (
          <Text variant="caption" color="muted" className="mt-0.5 leading-4">
            {description}
          </Text>
        )}
      </View>
      {right}
    </View>
  )
}
