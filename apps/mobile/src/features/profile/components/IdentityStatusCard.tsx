import { View } from 'react-native'
import { Feather } from '@expo/vector-icons'
import { Text } from '../../../components/ui/Text'

type IdentityStatusCardProps = {
  status: string
  rejectionReason: string | null
}

type StatusConfig = {
  icon: keyof typeof Feather.glyphMap
  color: string
  containerClass: string
  title: string
  description: string
}

const CONFIG: Record<string, StatusConfig> = {
  approved: {
    icon: 'check-circle',
    color: '#2563EB',
    containerClass: 'border-emerald-500/50 bg-emerald-500/10',
    title: 'Disability verified',
    description: 'All accessibility features are active on your account.',
  },
  pending: {
    icon: 'clock',
    color: '#f59e0b',
    containerClass: 'border-amber-500/50 bg-amber-500/10',
    title: 'Verification pending',
    description: "We'll notify you once your submission has been reviewed.",
  },
  rejected: {
    icon: 'alert-triangle',
    color: '#ef4444',
    containerClass: 'border-red-500/50 bg-red-500/10',
    title: 'Verification rejected',
    description: 'Please re-submit your disability card from the web app.',
  },
  not_submitted: {
    icon: 'shield',
    color: '#0ea5e9',
    containerClass: 'border-cyan-500/50 bg-cyan-500/10',
    title: 'Verify your disability status',
    description: 'Submit your disability card on the DrishtiPrep web app to unlock accessibility features.',
  },
}

export function IdentityStatusCard({ status, rejectionReason }: IdentityStatusCardProps) {
  const config = CONFIG[status] ?? CONFIG.not_submitted

  return (
    <View
      accessible
      accessibilityLabel={`Identity verification: ${config.title}. ${config.description}${
        status === 'rejected' && rejectionReason ? ` Reason: ${rejectionReason}.` : ''
      }`}
      className={`rounded-2xl border px-4 py-4 ${config.containerClass}`}
    >
      <View className="flex-row items-start gap-3">
        <Feather name={config.icon} size={20} color={config.color} style={{ marginTop: 2 }} />
        <View className="flex-1">
          <Text variant="bodySmall" className="font-semibold">
            {config.title}
          </Text>
          <Text variant="caption" color="muted" className="mt-1 leading-5">
            {config.description}
          </Text>
          {status === 'rejected' && rejectionReason && (
            <Text variant="caption" color="muted" className="mt-2">
              Reason: {rejectionReason}
            </Text>
          )}
        </View>
      </View>
    </View>
  )
}
