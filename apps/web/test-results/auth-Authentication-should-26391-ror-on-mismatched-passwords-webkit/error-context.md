# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: auth.spec.ts >> Authentication >> should show error on mismatched passwords
- Location: tests\e2e\auth.spec.ts:24:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: getByText('Passwords do not match.')
Expected: visible
Timeout: 10000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 10000ms
  - waiting for getByText('Passwords do not match.')

```

# Page snapshot

```yaml
- generic [ref=e1]:
  - link "Skip to content" [ref=e2]:
    - /url: "#main"
  - generic [ref=e4]:
    - generic [ref=e5]:
      - heading "Create Account" [level=1] [ref=e7]
      - generic [ref=e8]: Join the Learning Hub to track your progress
    - form "Create Account" [ref=e9]:
      - generic [ref=e10]:
        - generic [ref=e11]:
          - generic [ref=e12]: Full Name
          - textbox "Full Name" [active] [ref=e13]:
            - /placeholder: John Doe
        - generic [ref=e14]:
          - generic [ref=e15]: Email
          - textbox "Email" [ref=e16]:
            - /placeholder: learner@example.com
            - text: test@example.com
        - generic [ref=e17]:
          - generic [ref=e18]: Password
          - generic [ref=e19]:
            - textbox "Password" [ref=e20]: password123
            - button "Show password" [ref=e21]:
              - img [ref=e22]
          - generic [ref=e28]: Fair
        - generic [ref=e29]:
          - generic [ref=e30]: Confirm Password
          - generic [ref=e31]:
            - textbox "Confirm Password" [ref=e32]: password321
            - button "Show confirm password" [ref=e33]:
              - img [ref=e34]
      - generic [ref=e37]:
        - button "Sign Up" [ref=e38]
        - generic [ref=e39]:
          - text: Already have an account?
          - link "Log in" [ref=e40]:
            - /url: /login
  - alert [ref=e41]
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Authentication', () => {
  4  |   test('should navigate to login page', async ({ page }) => {
  5  |     await page.goto('/login');
  6  |     await expect(page.getByRole('heading', { name: 'Learning Hub Login' })).toBeVisible();
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
  25 |     await page.goto('/signup');
  26 |     await page.fill('input[id="fullName"]', 'Test User');
  27 |     await page.fill('input[id="email"]', 'test@example.com');
  28 |     await page.fill('input[id="password"]', 'password123');
  29 |     await page.fill('input[id="confirmPassword"]', 'password321');
  30 |     await page.getByRole('button', { name: 'Sign Up' }).click();
  31 |     
> 32 |     await expect(page.getByText('Passwords do not match.')).toBeVisible({ timeout: 10000 });
     |                                                             ^ Error: expect(locator).toBeVisible() failed
  33 |   });
  34 | });
  35 | 
```