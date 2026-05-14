import { Redirect, Slot } from "expo-router";
import { ActivityIndicator, View } from "react-native";
import { useSession } from "../../src/providers/SessionProvider";

export default function AppLayout() {
  const { session, isLoading } = useSession();

  if (isLoading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', backgroundColor: '#0f172a' }}>
        <ActivityIndicator size="large" color="#6366f1" />
      </View>
    );
  }

  // Not authenticated — redirect to login
  if (!session) {
    return <Redirect href="/(auth)/login" />;
  }

  // Authenticated — render child routes
  return <Slot />;
}
