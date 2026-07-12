import { Metadata } from 'next';
import UpdatePasswordForm from './UpdatePasswordForm';

export const metadata: Metadata = {
  title: 'Update Password - DrishtiPrep',
  description: 'Set your new password',
};

export default function UpdatePasswordPage() {
  return <UpdatePasswordForm />;
}
