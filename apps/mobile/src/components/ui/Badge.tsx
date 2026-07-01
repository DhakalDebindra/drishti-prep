import { View, Text } from 'react-native'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from './cn'

const badgeVariants = cva('self-start rounded-full px-3 py-1', {
  variants: {
    variant: {
      submitted: 'bg-primary/20',
      inProgress: 'bg-cyan-500/20',
      free: 'bg-primary/20',
      paid: 'bg-blue-500/20',
      enrolled: 'bg-primary/20',
      default: 'bg-muted',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

const badgeTextVariants = cva('text-[11px] font-semibold uppercase tracking-wide', {
  variants: {
    variant: {
      submitted: 'text-primary',
      inProgress: 'text-cyan-600 dark:text-cyan-400',
      free: 'text-primary',
      paid: 'text-blue-600 dark:text-blue-400',
      enrolled: 'text-primary',
      default: 'text-foreground',
    },
  },
  defaultVariants: {
    variant: 'default',
  },
})

type BadgeVariants = VariantProps<typeof badgeVariants>

interface BadgeProps {
  variant?: BadgeVariants['variant']
  label: string
}

export function Badge({ variant, label }: BadgeProps) {
  return (
    <View className={cn(badgeVariants({ variant }))}>
      <Text className={cn(badgeTextVariants({ variant }))}>{label}</Text>
    </View>
  )
}
