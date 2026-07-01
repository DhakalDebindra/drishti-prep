# Mobile Push Notifications — Design Note (Phase 7)

> Status: **design only**. No code or infrastructure was built in Phase 6. This note scopes the work
> so it can be picked up as its own phase, since it touches the database (protected `main`) and a
> server-side sender, unlike the rest of Phase 6 which was client-only.

## Goal

Re-engage learners with timely, low-noise reminders:

1. **Daily study reminder** — nudge if the user hasn't practiced today (protects the streak).
2. **Spaced-repetition due** — when questions are due for review (ties into the Manana / memory-heat
   model already used on web). Lower priority; depends on the review-scheduling data being available.
3. (Later) **Report resolved / identity verification status changed** — transactional.

## Why this is a separate phase

- Requires a **new table + RLS migration** applied to production Supabase (per project memory, `main`
  is protected and migrations run via the `scratch/_pgrun` runner — coordinate, don't push to `main`).
- Requires a **server-side sender** (a Next.js route or Supabase scheduled function) holding the Expo
  push tickets/receipts loop — the mobile app cannot send to itself.
- Permission UX and token lifecycle need care to avoid being an OS-notification nuisance.

## Architecture

```
Expo app  ──register──>  expo-notifications.getExpoPushTokenAsync()
   │                                   │
   │  upsert {user_id, token, platform}│
   ▼                                   ▼
Supabase: device_tokens table  <── RLS: user can only see/insert/delete own rows
   ▲
   │ service-role read (server only)
Sender (cron) ── builds messages ──> Expo Push API (https://exp.host/--/api/v2/push/send)
   ▲                                   │
   │  reads attempts/streaks/due       │ store receipts, prune invalid tokens
   └───────────────────────────────────┘
```

### 1. Client (`apps/mobile`)

- Add dependency: `expo-notifications` (+ `expo-device` to gate on physical devices).
- `src/features/notifications/registerForPush.ts`:
  - On **authenticated app start** (inside `SessionProvider`, after session resolves), request
    permission (`Notifications.getPermissionsAsync` → `requestPermissionsAsync`). Do **not** prompt on
    first launch / login screen — prompt contextually (e.g. a "Turn on reminders" card in Profile) so
    acceptance rates stay high and we respect users who decline.
  - On grant: `getExpoPushTokenAsync({ projectId })` → upsert into `device_tokens`.
  - Android: create a notification channel (`Notifications.setNotificationChannelAsync`).
- Add a **toggle in Profile → Accessibility/Preferences** ("Study reminders") that controls a
  `notifications_enabled` flag and registers/unregisters the token.
- Handle taps: `Notifications.addNotificationResponseReceivedListener` → deep-link via Expo Router
  (e.g. to `/(app)/(tabs)/practice` or a specific set).

### 2. Database (migration)

```sql
create table public.device_tokens (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  token       text not null,
  platform    text not null check (platform in ('ios','android','web')),
  created_at  timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  unique (user_id, token)
);
alter table public.device_tokens enable row level security;
create policy "own tokens select" on public.device_tokens for select using (auth.uid() = user_id);
create policy "own tokens insert" on public.device_tokens for insert with check (auth.uid() = user_id);
create policy "own tokens delete" on public.device_tokens for delete using (auth.uid() = user_id);
-- (optional) add profiles.notifications_enabled boolean default true;
```

Apply via `scratch/_pgrun/run.mjs` (no Supabase CLI/psql locally — see project memory).

### 3. Sender (server, service-role only)

- A cron-triggered route, modeled on the existing `apps/web/src/app/api/cron/manana-worker/route.ts`.
- Daily reminder pass: find users with `notifications_enabled` who have no `attempts` row today and a
  `current_streak > 0`; build one message each.
- Batch to the **Expo Push API** in chunks of ≤100; persist receipts; on `DeviceNotRegistered` delete
  the offending `device_tokens` row.
- Rate-limit to one reminder/user/day; respect a quiet-hours window (e.g. 8am–9pm Nepal time).

## Testing

- Physical Android device (push doesn't work in emulators without Play services / dev build).
- Verify token upsert, a manual send via Expo's push tool, tap-to-deep-link, and invalid-token pruning.
- TalkBack: ensure notification text is plain and any in-app "enable reminders" card is properly
  labeled (and any Devanagari numerals run through `toLatinNumerals`).

## Out of scope for this note

Rich/scheduled local-only notifications, iOS APNs specifics (project is Android-first), and the
Manana review-scheduling source of truth (assumed available before priority-2 reminders ship).
