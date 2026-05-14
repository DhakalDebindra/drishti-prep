import 'expo-dev-client';
import "react-native-url-polyfill/auto";
import "../global.css";
import { useEffect } from 'react';
import { Stack } from "expo-router";
import * as SplashScreen from 'expo-splash-screen';
import { 
  useFonts, 
  NotoSansDevanagari_400Regular, 
  NotoSansDevanagari_700Bold 
} from '@expo-google-fonts/noto-sans-devanagari';
import { SessionProvider } from '../src/providers/SessionProvider';
import { QueryProvider } from '../src/providers/QueryProvider';

SplashScreen.preventAutoHideAsync();

export default function RootLayout() {
  const [fontsLoaded] = useFonts({
    NotoSansDevanagari_400Regular,
    NotoSansDevanagari_700Bold,
  });

  useEffect(() => {
    if (fontsLoaded) {
      SplashScreen.hideAsync();
    }
  }, [fontsLoaded]);

  if (!fontsLoaded) return null;

  return (
    <QueryProvider>
      <SessionProvider>
        <Stack screenOptions={{ headerShown: false }} />
      </SessionProvider>
    </QueryProvider>
  );
}
