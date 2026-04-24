import { Suspense } from 'react';
import { Metadata } from 'next';
import UpdatePasswordForm from './UpdatePasswordForm';

export const metadata: Metadata = {
  title: 'Update Password - Learning Hub',
  description: 'Set your new password',
};

export default function UpdatePasswordPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center bg-gray-50 p-4">Loading...</div>}>
      <UpdatePasswordForm />
    </Suspense>
  );
}
