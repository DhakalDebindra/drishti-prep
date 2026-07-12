import { Metadata } from 'next';
import SignupForm from './SignupForm';

export const metadata: Metadata = {
  title: 'Sign Up - DrishtiPrep',
  description: 'Join DrishtiPrep to track your progress',
};

export default function SignupPage() {
  return <SignupForm />;
}
