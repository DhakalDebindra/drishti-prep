import { Redirect, Slot } from "expo-router";
import { ActivityIndicator, View } from "react-native";
import { useSession } from "../../src/providers/SessionProvider";

export default function AppLayout() {
  const { session, isLoading } = useSession();

  if (isLoading) {
    return (
      <View className="flex-1 justify-center items-center bg-background">
        <ActivityIndicator size="large" className="text-primary" />
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
