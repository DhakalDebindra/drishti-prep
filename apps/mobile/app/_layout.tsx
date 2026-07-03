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
  NotoSansDevanagari_400Regular,
  NotoSansDevanagari_700Bold
} from '@expo-google-fonts/noto-sans-devanagari';
import { useFonts } from 'expo-font';
import { SessionProvider } from '../src/providers/SessionProvider';
import { QueryProvider } from '../src/providers/QueryProvider';
import { PreferencesProvider, usePreferences } from '../src/providers/PreferencesProvider';
import { DrawerProvider, useDrawer } from '../src/providers/DrawerProvider';
import { ActiveCourseProvider } from '../src/providers/ActiveCourseProvider';
import { AppDrawer } from '../src/components/ui';
import {
  normalLightVars,
  normalDarkVars,
  highContrastLightVars,
  highContrastDarkVars,
} from '../src/config/highContrastTheme';

// Let Feather icons accept Tailwind/NativeWind `className` (maps to style) so
// icon colours can be token-based app-wide, not just on the practice screen.
// cssInterop(Feather, { className: 'style' });

SplashScreen.preventAutoHideAsync();

// Applies the active colour palette over the whole navigator subtree by
// overriding the theme CSS variables.
//
// ⚠️ ALWAYS pass a vars() object — never `undefined`. Switching this View's
// style between a plain object and a vars() object changes the css-interop
// wrapper structure and remounts the subtree; since this View wraps <Stack>,
// that rips the navigation context out from under mounted screens and crashes
// with "Couldn't find a navigation context". With a vars() object in both
// states, toggling contrast only changes variable values (re-render only).
function ThemedRoot() {
  const { contrast } = usePreferences();
  const { colorScheme } = useColorScheme();
  const { isOpen } = useDrawer();

  const themeVars =
    contrast === 'high-contrast'
      ? colorScheme === 'dark'
        ? highContrastDarkVars
        : highContrastLightVars
      : colorScheme === 'dark'
        ? normalDarkVars
        : normalLightVars;

  return (
    <View style={[{ flex: 1 }, themeVars]}>
      <View style={{ flex: 1 }} importantForAccessibility={isOpen ? 'no-hide-descendants' : 'auto'}>
        <Stack screenOptions={{ headerShown: false }} />
      </View>
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
