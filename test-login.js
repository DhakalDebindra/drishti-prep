const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

async function testLogin() {
  console.log('Attempting login...');
  const { data, error } = await supabase.auth.signInWithPassword({
    email: 'admin@dristiprep.com',
    password: 'password123',
  });

  if (error) {
    console.error('Login Error:', JSON.stringify(error, null, 2));
    process.exit(1);
  }

  console.log('Login successful!', data.user.email);
  
  console.log('Testing profile query...');
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', data.user.id)
    .single();

  if (profileError) {
    console.error('Profile Error:', JSON.stringify(profileError, null, 2));
    process.exit(1);
  }

  console.log('Profile retrieved:', profile);
  console.log('All tests passed!');
  process.exit(0);
}

testLogin();
