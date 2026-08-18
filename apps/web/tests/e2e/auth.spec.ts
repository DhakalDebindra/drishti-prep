import { test, expect } from '@playwright/test';

test.describe('Authentication', () => {
  test('should navigate to login page', async ({ page }) => {
    await page.goto('http://localhost:3000/login');
    await expect(page.getByRole('heading', { name: 'Log in' })).toBeVisible();
  });

  test('should show error on invalid login', async ({ page }) => {
    await page.goto('http://localhost:3000/login');
    await page.fill('input[type="email"]', 'wrong@example.com');
    await page.fill('input[type="password"]', 'wrongpassword');
    await page.click('button[type="submit"]');
    
    // Check for the mapped error message
    await expect(page.getByText('Incorrect email or password.')).toBeVisible();
  });

  // A dead confirmation link used to land here with no message at all: the
  // form only recognised ?error=unverified, so /auth/callback's redirect
  // rendered a blank login page and the user had no idea what went wrong.
  test('should offer a resend prompt when the confirmation link is dead', async ({ page }) => {
    await page.goto('http://localhost:3000/login?error=link_expired');

    // Match on the text, not getByRole('alert'): Next mounts its own
    // __next-route-announcer__ with role="alert", so the role selector hits two
    // elements and fails strict mode.
    await expect(page.getByText('That confirmation link is no longer valid')).toBeVisible();

    const resend = page.getByRole('button', { name: 'Resend confirmation email' });
    await expect(resend).toBeVisible();

    // No email typed yet: the button must ask for one rather than fire a
    // request that would fail (and eat the hourly email allowance).
    await resend.click();
    await expect(page.getByText('Please enter your email address above, then tap resend.')).toBeVisible();
  });

  test('should navigate to signup page', async ({ page }) => {
    await page.goto('http://localhost:3000/signup');
    await expect(page.getByRole('heading', { name: 'Create account' })).toBeVisible();
  });

  test('should show error on mismatched passwords', async ({ page }) => {
    await page.goto('http://localhost:3000/signup');
    await page.fill('input[id="fullName"]', 'Test User');
    await page.fill('input[id="email"]', 'test@example.com');
    await page.fill('input[id="password"]', 'password123');
    await page.fill('input[id="confirmPassword"]', 'password321');
    // Click submit button instead of pressing Enter
    await page.click('button[type="submit"]');
    
    await expect(page.getByText('Passwords do not match.')).toBeVisible({ timeout: 10000 });
  });
});
