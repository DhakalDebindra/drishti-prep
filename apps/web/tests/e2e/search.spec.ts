import { test, expect } from "@playwright/test";

/**
 * Search is logged-in only, so an unauthenticated visit must land on /login
 * rather than leaking the catalogue. These tests cover the gate and the shape
 * of the redirect for every entry point into the feature.
 *
 * The signed-in rendering of /search is not covered here: this suite has no
 * authenticated fixture. The retrieval layer underneath is verified directly
 * against the database, and the query normaliser has unit tests.
 */
test.describe("Search access", () => {
  test("redirects an anonymous visitor to login", async ({ page }) => {
    await page.goto("/search");
    await expect(page).toHaveURL(/\/login/);
    await expect(page.getByRole("heading", { name: "Log in" })).toBeVisible();
  });

  test("redirects to login even with a query attached", async ({ page }) => {
    await page.goto("/search?q=" + encodeURIComponent("नेपालको भूगोल"));
    await expect(page).toHaveURL(/\/login/);
  });

  test("does not expose set titles to an anonymous visitor", async ({ page }) => {
    const response = await page.goto(
      "/search?q=" + encodeURIComponent("संविधान")
    );
    const body = (await response?.text()) ?? "";
    // A real set title from the live catalogue must never appear pre-auth.
    expect(body).not.toContain("मौलिक हक");
  });
});
