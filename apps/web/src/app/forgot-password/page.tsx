import { Metadata } from 'next';
import ForgotPasswordForm from './ForgotPasswordForm';

export const metadata: Metadata = {
  title: 'Forgot Password - DrishtiPrep',
  description: 'Reset your DrishtiPrep password',
};

export default function ForgotPasswordPage() {
  return <ForgotPasswordForm />;
}
