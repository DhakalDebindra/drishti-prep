import { View, Text, Pressable } from 'react-native';
import { useSession } from '../../src/providers/SessionProvider';

export default function DashboardScreen() {
  const { user, signOut } = useSession();

  return (
    <View style={{ flex: 1, backgroundColor: '#0f172a', justifyContent: 'center', alignItems: 'center', padding: 24 }}>
      <Text style={{ fontSize: 24, fontWeight: '700', color: '#f8fafc', marginBottom: 8 }}>
        Dashboard
      </Text>
      <Text style={{ fontSize: 14, color: '#94a3b8', marginBottom: 32 }}>
        Welcome, {user?.user_metadata?.full_name || user?.email}
      </Text>

      <Pressable
        onPress={signOut}
        style={({ pressed }) => ({
          backgroundColor: pressed ? '#dc2626' : '#ef4444',
          borderRadius: 12,
          paddingVertical: 12,
          paddingHorizontal: 24,
        })}
      >
        <Text style={{ color: '#fff', fontSize: 14, fontWeight: '600' }}>
          Sign Out
        </Text>
      </Pressable>
    </View>
  );
}
