import 'expo-dev-client';
import "react-native-url-polyfill/auto";
import "../global.css";
import { useEffect } from 'react';
import { View } from 'react-native';
import { Stack } from "expo-router";
import { Feather } from '@expo/vector-icons';
import { cssInterop, useColorScheme } from 'nativewind';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import * as SplashScreen from 'expo-splash-screen';
import {
  useFonts,
  NotoSansDevanagari_400Regular,
  NotoSansDevanagari_700Bold
} from '@expo-google-fonts/noto-sans-devanagari';
import { SessionProvider } from '../src/providers/SessionProvider';
import { QueryProvider } from '../src/providers/QueryProvider';
import { PreferencesProvider, usePreferences } from '../src/providers/PreferencesProvider';
import { DrawerProvider } from '../src/providers/DrawerProvider';
import { ActiveCourseProvider } from '../src/providers/ActiveCourseProvider';
import { AppDrawer } from '../src/components/ui';
import { highContrastLightVars, highContrastDarkVars } from '../src/config/highContrastTheme';

// Let Feather icons accept Tailwind/NativeWind `className` (maps to style) so
// icon colours can be token-based app-wide, not just on the practice screen.
cssInterop(Feather, { className: 'style' });

SplashScreen.preventAutoHideAsync();

// Applies the in-app high-contrast palette over the whole navigator subtree by
// overriding the theme CSS variables (no remount — just inherited new values).
function ThemedRoot() {
  const { contrast } = usePreferences();
  const { colorScheme } = useColorScheme();

  const contrastStyle =
    contrast === 'high-contrast'
      ? colorScheme === 'dark'
        ? highContrastDarkVars
        : highContrastLightVars
      : undefined;

  return (
    <View style={[{ flex: 1 }, contrastStyle]}>
      <Stack screenOptions={{ headerShown: false }} />
      <AppDrawer />
    </View>
  );
}

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
    <SafeAreaProvider>
      <QueryProvider>
        <SessionProvider>
          <PreferencesProvider>
            <ActiveCourseProvider>
              <DrawerProvider>
                <ThemedRoot />
              </DrawerProvider>
            </ActiveCourseProvider>
          </PreferencesProvider>
        </SessionProvider>
      </QueryProvider>
    </SafeAreaProvider>
  );
}
