/**
 * ⚠️  METRO CONFIG — READ BEFORE EDITING
 *
 * This config exists because pnpm's symlink structure (node_modules/.pnpm/)
 * is not what Metro's default resolver expects. Removing or simplifying any
 * of the options below will likely cause "Unable to resolve module" errors.
 *
 * KNOWN RISK: If you see an `@expo/metro-runtime` resolution error:
 *   1. Check that `shamefully-hoist=true` is in the root `.npmrc`
 *   2. If not, add it and run `pnpm install` from the monorepo root
 *   3. As a last resort, pin the dep directly:
 *      `pnpm --filter @repo/mobile add @expo/metro-runtime`
 *
 * NEVER USE EXPO GO: expo-secure-store requires the custom dev client.
 *   Use `npx expo run:android` — not the Play Store Expo Go app.
 *
 * TECH DEBT: `shamefully-hoist=true` in .npmrc makes pnpm behave like npm.
 *   Remove it when a second Expo/RN app joins the monorepo — then fix this
 *   config properly with explicit resolver paths instead.
 *
 * See apps/mobile/README.md for the full risk register.
 */
const { getDefaultConfig } = require("expo/metro-config");
const { withNativeWind } = require("nativewind/metro");
const path = require("path");

const projectRoot = __dirname;
const workspaceRoot = path.resolve(projectRoot, "../..");

const config = getDefaultConfig(projectRoot);

// Watch all packages in the monorepo
config.watchFolders = [workspaceRoot];

// Resolve packages from mobile app first, then workspace root
config.resolver.nodeModulesPaths = [
  path.resolve(projectRoot, "node_modules"),
  path.resolve(workspaceRoot, "node_modules"),
];

// Block react-dom from being bundled — React Native doesn't need it
config.resolver.blockList = [
  /apps\/web\/.*/,  // exclude the entire web app from mobile bundle
];

module.exports = withNativeWind(config, { input: "./global.css" });