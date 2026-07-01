import { Redirect, Stack } from "expo-router";
import { useSession } from "../../src/providers/SessionProvider";

export default function AuthLayout() {
  const { session } = useSession();

  // Already authenticated — send to app
  if (session) {
    return <Redirect href="/(app)/(tabs)/dashboard" />;
  }

  return (
    <Stack
      screenOptions={{
        headerShown: false,
        animation: 'slide_from_right',
      }}
    />
  );
}
