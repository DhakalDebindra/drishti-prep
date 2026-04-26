import { Suspense } from 'react';
import { Metadata } from 'next';
import ForgotPasswordForm from './ForgotPasswordForm';

export const metadata: Metadata = {
  title: 'Forgot Password - DrishtiPrep',
  description: 'Reset your DrishtiPrep password',
};

export default function ForgotPasswordPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center bg-gray-50 p-4">Loading...</div>}>
      <ForgotPasswordForm />
    </Suspense>
  );
}
