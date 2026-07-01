import { useState } from 'react'
import { Alert } from 'react-native'
import { Button } from '../../../components/ui/Button'
import { useSession } from '../../../providers/SessionProvider'

export function SignOutButton() {
  const { signOut } = useSession()
  const [signingOut, setSigningOut] = useState(false)

  const confirmSignOut = () => {
    Alert.alert('Sign out', 'Are you sure you want to sign out?', [
      { text: 'Cancel', style: 'cancel' },
      {
        text: 'Sign out',
        style: 'destructive',
        onPress: async () => {
          setSigningOut(true)
          try {
            // The (app) layout redirects to /login once the session clears.
            await signOut()
          } catch {
            setSigningOut(false)
            Alert.alert('Sign out failed', 'Please try again.')
          }
        },
      },
    ])
  }

  return (
    <Button
      title="Sign out"
      variant="outline"
      size="lg"
      loading={signingOut}
      onPress={confirmSignOut}
      accessibilityRole="button"
      accessibilityLabel="Sign out of your account"
    />
  )
}
