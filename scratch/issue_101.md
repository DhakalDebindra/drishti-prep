# Refactor PublicHeader theme initialization to avoid hydration-triggered setState

The component currently uses a `useEffect` to read `localStorage` and `window.matchMedia` on mount, then setStates the result. This violates React Compiler's no-effect-setState rule and causes an extra render on every page load.

Proper fix: Migrate to `useSyncExternalStore` for the theme subscription, or adopt the `next-themes` package which handles this correctly with SSR/hydration. The `next-themes` route is probably faster — drop-in replacement, ~5 packages of usage to update.

**Files affected:**
- `apps/web/src/components/layout/PublicHeader.tsx` (lines 16, 19 currently disabled)

**Acceptance:**
- Remove both `eslint-disable-next-line` comments and pass `pnpm lint` cleanly.
