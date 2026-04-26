import { Suspense } from 'react';
import { Metadata } from 'next';
import LoginForm from './LoginForm';

export const metadata: Metadata = {
  title: 'Login - Learning Hub',
  description: 'Sign in to your learner account',
};

export default function LoginPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center bg-gray-50 p-4">Loading...</div>}>
      <LoginForm />
    </Suspense>
  );
}
