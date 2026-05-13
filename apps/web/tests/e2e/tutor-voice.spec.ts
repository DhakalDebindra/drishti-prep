import { test, expect } from "@playwright/test";

// Phase 1 smoke tests for tutor-voice feature.
//
// The full end-to-end flow (logged-in user → practice set with cached audio →
// hotkey-driven playback) requires fixture infrastructure (test users + seeded
// question sets with pre-generated audio) that doesn't exist in this repo yet.
// Those tests come in Phase 1.5 alongside a real test seed.
//
// For now we cover the public-facing contracts and the route surface to catch
// regressions in route wiring, API shapes, and the unauthenticated paths.

test.describe("Tutor voice — public contracts", () => {
  test("GET /api/me/preferences returns defaults for guests", async ({ request }) => {
    const res = await request.get("http://localhost:3000/api/me/preferences");
    expect(res.ok()).toBeTruthy();
    const body = await res.json();
    expect(body.tutor_voice_enabled).toBe(false);
  });

  test("GET /api/questions/[bad-id]/audio rejects invalid uuid", async ({ request }) => {
    const res = await request.get("http://localhost:3000/api/questions/not-a-uuid/audio");
    expect(res.status()).toBe(400);
  });

  test("POST /api/admin/questions/[id]/audio rejects guests", async ({ request }) => {
    const res = await request.post(
      "http://localhost:3000/api/admin/questions/00000000-0000-0000-0000-000000000000/audio"
    );
    expect([401, 403, 429]).toContain(res.status());
  });

  test("/profile/preferences requires auth", async ({ page }) => {
    await page.goto("http://localhost:3000/profile/preferences");
    await expect(page).toHaveURL(/\/login/);
  });

  test("/admin/audio-batch requires admin", async ({ page }) => {
    await page.goto("http://localhost:3000/admin/audio-batch");
    // Either redirected to login (no session) or to home (non-admin) — both
    // are valid gate behaviors. We just need to be off the admin page.
    await expect(page).not.toHaveURL(/\/admin\/audio-batch/);
  });
});
