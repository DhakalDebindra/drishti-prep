import { test, expect } from '@playwright/test';

test.describe('Authentication', () => {
  test('should navigate to login page', async ({ page }) => {
    await page.goto('http://localhost:3000/login');
    await expect(page.getByRole('heading', { name: 'DrishtiPrep Login' })).toBeVisible();
  });

  test('should show error on invalid login', async ({ page }) => {
    await page.goto('http://localhost:3000/login');
    await page.fill('input[type="email"]', 'wrong@example.com');
    await page.fill('input[type="password"]', 'wrongpassword');
    await page.click('button[type="submit"]');
    
    // Check for the mapped error message
    await expect(page.getByText('Incorrect email or password.')).toBeVisible();
  });

  test('should navigate to signup page', async ({ page }) => {
    await page.goto('http://localhost:3000/signup');
    await expect(page.getByRole('heading', { name: 'Create Account' })).toBeVisible();
  });

  test('should show error on mismatched passwords', async ({ page }) => {
    await page.goto('http://localhost:3000/signup');
    await page.fill('input[id="fullName"]', 'Test User');
    await page.fill('input[id="email"]', 'test@example.com');
    await page.fill('input[id="password"]', 'password123');
    await page.fill('input[id="confirmPassword"]', 'password321');
    await page.locator('input[id="confirmPassword"]').press('Enter');
    
    await expect(page.getByText('Passwords do not match.')).toBeVisible({ timeout: 10000 });
  });
});
