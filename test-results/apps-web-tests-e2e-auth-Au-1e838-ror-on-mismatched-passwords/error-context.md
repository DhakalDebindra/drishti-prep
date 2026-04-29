# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: apps\web\tests\e2e\auth.spec.ts >> Authentication >> should show error on mismatched passwords
- Location: apps\web\tests\e2e\auth.spec.ts:24:7

# Error details

```
Error: page.goto: Protocol error (Page.navigate): Cannot navigate to invalid URL
Call log:
  - navigating to "/signup", waiting until "load"

```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Authentication', () => {
  4  |   test('should navigate to login page', async ({ page }) => {
  5  |     await page.goto('/login');
  6  |     await expect(page.getByRole('heading', { name: 'DrishtiPrep Login' })).toBeVisible();
  7  |   });
  8  | 
  9  |   test('should show error on invalid login', async ({ page }) => {
  10 |     await page.goto('/login');
  11 |     await page.fill('input[type="email"]', 'wrong@example.com');
  12 |     await page.fill('input[type="password"]', 'wrongpassword');
  13 |     await page.click('button[type="submit"]');
  14 |     
  15 |     // Check for the mapped error message
  16 |     await expect(page.getByText('Incorrect email or password.')).toBeVisible();
  17 |   });
  18 | 
  19 |   test('should navigate to signup page', async ({ page }) => {
  20 |     await page.goto('/signup');
  21 |     await expect(page.getByRole('heading', { name: 'Create Account' })).toBeVisible();
  22 |   });
  23 | 
  24 |   test('should show error on mismatched passwords', async ({ page }) => {
> 25 |     await page.goto('/signup');
     |                ^ Error: page.goto: Protocol error (Page.navigate): Cannot navigate to invalid URL
  26 |     await page.fill('input[id="fullName"]', 'Test User');
  27 |     await page.fill('input[id="email"]', 'test@example.com');
  28 |     await page.fill('input[id="password"]', 'password123');
  29 |     await page.fill('input[id="confirmPassword"]', 'password321');
  30 |     // Click submit button instead of pressing Enter
  31 |     await page.click('button[type="submit"]');
  32 |     
  33 |     await expect(page.getByText('Passwords do not match.')).toBeVisible({ timeout: 10000 });
  34 |   });
  35 | });
  36 | 
```