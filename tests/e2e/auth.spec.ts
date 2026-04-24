import { test, expect } from '@playwright/test';

test.describe('Authentication', () => {
  test('should navigate to login page', async ({ page }) => {
    await page.goto('/login');
    await expect(page.locator('h1')).toContainText('Learning Hub Login');
  });

  test('should show error on invalid login', async ({ page }) => {
    await page.goto('/login');
    await page.fill('input[type="email"]', 'wrong@example.com');
    await page.fill('input[type="password"]', 'wrongpassword');
    await page.click('button[type="submit"]');
    
    // Check for the mapped error message
    await expect(page.locator('[role="alert"]')).toContainText('Incorrect email or password');
  });

  test('should navigate to signup page', async ({ page }) => {
    await page.goto('/signup');
    await expect(page.locator('h1')).toContainText('Create Account');
  });

  test('should show error on mismatched passwords', async ({ page }) => {
    await page.goto('/signup');
    await page.fill('input[id="fullName"]', 'Test User');
    await page.fill('input[id="email"]', 'test@example.com');
    await page.fill('input[id="password"]', 'password123');
    await page.fill('input[id="confirmPassword"]', 'password321');
    await page.click('button[type="submit"]');
    
    await expect(page.locator('[role="alert"]')).toContainText('Passwords do not match');
  });
});
