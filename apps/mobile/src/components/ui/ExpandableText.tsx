import { useState, type ComponentProps } from 'react'
import { View, Pressable } from 'react-native'
import { Text } from './Text'

type ExpandableTextProps = Pick<ComponentProps<typeof Text>, 'variant' | 'color' | 'className'> & {
  children: string
  /** Lines shown when collapsed. */
  numberOfLines?: number
}

// Long blocks (e.g. course descriptions) get a length threshold rather than an
// onTextLayout measurement (which is unreliable with numberOfLines on Android).
// ~140 chars ≈ 3 lines on a phone — enough to decide whether a toggle is useful.
const TOGGLE_THRESHOLD = 140

/**
 * Clamps a long string to `numberOfLines` with a high-contrast See more / See
 * less toggle. Keeps descriptions from filling the screen.
 */
export function ExpandableText({
  children,
  numberOfLines = 3,
  variant = 'body',
  color = 'muted',
  className,
}: ExpandableTextProps) {
  const [expanded, setExpanded] = useState(false)
  const canToggle = children.length > TOGGLE_THRESHOLD

  return (
    <View>
      <Text
        variant={variant}
        color={color}
        className={className}
        numberOfLines={expanded ? undefined : numberOfLines}
      >
        {children}
      </Text>
      {canToggle && (
        <Pressable
          onPress={() => setExpanded((v) => !v)}
          accessibilityRole="button"
          accessibilityLabel={expanded ? 'See less' : 'See more'}
          hitSlop={6}
          className="mt-1 self-start"
        >
          <Text variant="caption" className="font-bold text-primary">
            {expanded ? 'See less' : 'See more'}
          </Text>
        </Pressable>
      )}
    </View>
  )
}
