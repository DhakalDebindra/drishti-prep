# @repo/mobile — DrishtiPrep Mobile App

Expo SDK 54 · expo-router v6 · React Native 0.81 · pnpm monorepo

---

## ⚠️ Risk Register — Read Before Touching Anything

These are the decisions made under pressure that you will be tempted to skip.
Don't. They exist because someone anticipated that you'd be mid-sprint with a broken build.

| Risk | Severity | What to do |
|---|---|---|
| **Metro / pnpm resolution failure** | 🔴 Project-stopper | If Metro can't resolve a dep, check `.npmrc` for `shamefully-hoist=true`. See `metro.config.js` header comments. |
| **Devanagari rendering on real Android** | 🔴 Must validate early | Run the smoke test screen (`app/smoke-test.tsx`) on a real device before building any product screen. Emulator is not enough. |
| **Supabase RLS gaps — mobile hits PostgREST directly** | 🔴 Data exposure | No server layer catches a missing `WITH CHECK`. Before shipping Phase 1, audit: `bookmarks`, `module_enrollments`, `notification_preferences`, `question_set_attempts`. |
| **Never use Expo Go** | 🟡 Auth will break silently | `expo-secure-store` requires the custom dev client. Always use `npx expo run:android`, never the Play Store Expo Go app. |
| **React 19 + RN library compatibility** | 🟡 Build failure | Before `pnpm add`-ing `react-native-reanimated` or `nativewind`, check their changelogs for React 19 support. |
| **IAP return — scope the `AppState` listener** | 🟡 Excess Supabase reads | `AppState` fires on every foreground (lock screen, notifications). Only call `invalidateQueries` when `pendingPaymentReturn.current === true`. See Phase 4 in the implementation plan. |
| **`shamefully-hoist` tech debt** | 🟢 Scheduled | Remove when a second Expo/RN app joins the monorepo. Task: "Revisit Metro config and remove shamefully-hoist". |
| **Push notification schema** | 🟢 Already stubbed | `notification_preferences` table must be migrated before first user is onboarded (Phase 2). Don't wait until Phase 8. |

---

## Phase Status

| Phase | Description | Status |
|---|---|---|
| **0** | Metro / pnpm resolution — bundler must start cleanly | 🔴 Not started |
| **0.5** | EAS dev client + Noto Sans Devanagari + NativeWind + Unicode smoke test | ⬜ Blocked on Phase 0 |
| **1** | Auth screens, SecureStore, SessionProvider, TanStack Query | ⬜ Blocked on Phase 0.5 |
| **2** | Tab shell + notification schema migration stub | ⬜ |
| **3** | Dashboard screen | ⬜ |
| **5** | Practice Engine (MCQ session, review) | ⬜ |
| **4** | Courses & enrollment deep-link flow | ⬜ |
| **6** | Bookmarks | ⬜ |
| **7** | Profile & settings | ⬜ |
| **8** | Push notifications, offline cache, store submission | ⬜ |

---

## Quick Start

```bash
# From monorepo root — install all deps
pnpm install

# Start Metro (web target first — fastest feedback loop)
pnpm --filter @repo/mobile web

# Start on Android (requires custom dev client build, NOT Expo Go)
pnpm --filter @repo/mobile android

# Build and install dev client on connected device/emulator (run once)
npx expo run:android --project-root apps/mobile
```

> **First time?** You must build the custom dev client before `pnpm android` will work.
> Run `npx expo run:android` once. This compiles native code and installs the `.apk`.
> After that, `pnpm android` starts Metro only.

---

## Architecture Decisions

| Decision | Rationale |
|---|---|
| **NativeWind v4** | Shares Tailwind design tokens with the web app |
| **TanStack Query** | All Supabase fetches go through `useQuery`/`useMutation`. Never `useEffect` for data. Enables offline caching in Phase 8. |
| **expo-secure-store** (not AsyncStorage) for auth | AsyncStorage is unencrypted. Auth tokens must be stored securely. |
| **`packages/supabase/src/mobile.ts`** | Separate Supabase client from the web client — uses SecureStore adapter, not cookies. |
| **No in-app purchases** | Paid enrollment deep-links to the web. Avoids 30% Apple/Google cut and IAP complexity. Revisit post-launch. |
| **Notification schema in Phase 2** | Stubbing early prevents a live-app migration in Phase 8. Cost: one migration. Value: no downtime risk. |

---

## Key Files

| File | Purpose |
|---|---|
| `metro.config.js` | Metro bundler config — monorepo `watchFolders`, resolver paths, web blocklist |
| `app/_layout.tsx` | Root layout — font loading, dev client import, URL polyfill, SessionProvider, QueryClientProvider |
| `app/(auth)/` | Login, signup, forgot-password screens |
| `app/(app)/` | Tab shell + all authenticated screens |
| `app/smoke-test.tsx` | Nepali Unicode rendering validation screen — **delete after Phase 0.5 gate passes** |
| `packages/supabase/src/mobile.ts` | Supabase client with SecureStore storage adapter |

---

## Full Plan

See the [implementation plan](../../../.gemini/antigravity/brain/44343a49-e762-4802-852a-afd367795ece/implementation_plan.md) for the complete phase-by-phase breakdown.
