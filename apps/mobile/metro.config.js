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

// ── Single React instance (pnpm + Metro) ────────────────────────────────────
// pnpm hoists a real copy of react to the workspace root AND keeps one in the
// store; Metro resolves them via different symlink paths and ends up with TWO
// react module instances. react-native's renderer binds to one, while the app
// and react-native-css-interop resolve the other -> "Cannot read property
// 'useContext' of null" (crash) OR, more subtly, css-interop creates its styled
// elements against a react whose tree the renderer never sees, so className
// silently produces no styles. Deduping ONLY bare `react` fixes the crash but
// NOT the styling, because css-interop builds elements via `react/jsx-runtime`.
// So we must pin react AND its jsx runtimes to the same single copy.
const reactRoot = path.resolve(workspaceRoot, 'node_modules/react');
const reactAliases = {
  react: path.join(reactRoot, 'index.js'),
  'react/jsx-runtime': path.join(reactRoot, 'jsx-runtime.js'),
  'react/jsx-dev-runtime': path.join(reactRoot, 'jsx-dev-runtime.js'),
};

// ── Single react-native-css-interop instance ────────────────────────────────
// The .npmrc pattern `public-hoist-pattern[]=*react-native*` ALSO matches
// react-native-css-interop, so pnpm places a physical copy at the workspace
// root while nativewind resolves the store copy. Two instances => the CSS
// registry populated by `import "./global.css"` (registerCSS) lives in one
// copy, while the jsx runtime that reads it lives in the other. Net effect:
// styles compile and register but never apply — no crash, just an unstyled UI.
// Pin every `react-native-css-interop[/subpath]` request to the single copy
// that nativewind uses. Resolved dynamically (no fragile pnpm hash).
const CSS_INTEROP = 'react-native-css-interop';
const cssInteropPkgJson = require.resolve(`${CSS_INTEROP}/package.json`, {
  paths: [path.dirname(require.resolve('nativewind/package.json'))],
});
// A file that lives INSIDE the canonical package dir; Metro walks up from its
// directory, so any subpath resolves within this same copy.
const cssInteropOrigin = cssInteropPkgJson;

config.resolver.resolveRequest = (context, moduleName, platform) => {
  const alias = reactAliases[moduleName];
  if (alias) {
    return { filePath: alias, type: 'sourceFile' };
  }
  if (moduleName === CSS_INTEROP || moduleName.startsWith(`${CSS_INTEROP}/`)) {
    return context.resolveRequest(
      { ...context, originModulePath: cssInteropOrigin },
      moduleName,
      platform,
    );
  }
  return context.resolveRequest(context, moduleName, platform);
};

module.exports = withNativeWind(config, { input: "./global.css" });