import { Suspense } from 'react';
import { Metadata } from 'next';
import SignupForm from './SignupForm';

export const metadata: Metadata = {
  title: 'Sign Up - DrishtiPrep',
  description: 'Join DrishtiPrep to track your progress',
};

export default function SignupPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center bg-gray-50 p-4">Loading...</div>}>
      <SignupForm />
    </Suspense>
  );
}
