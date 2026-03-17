const { createClient } = require('@supabase/supabase-js');

// Direct Local keys from npx supabase status
const supabase = createClient(
  'http://127.0.0.1:54321',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp4eXh5d21xcnVwY3NxcWlkdHJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAyNjU0NDksImV4cCI6MjAyNTg0MTQ0OX0.4uX2dGqV7m7bA80NszVqI-2O5c3R4X7Q3VwW1x0Cq-M' 
);

async function testLogin() {
  console.log('Attempting login to local container...');
  const { data, error } = await supabase.auth.signInWithPassword({
    email: 'admin@dristiprep.com',
    password: 'password123',
  });

  if (error) {
    console.error('Login Error:', JSON.stringify(error, null, 2));
    process.exit(1);
  }

  console.log('Login successful!', data.user.email);
  process.exit(0);
}

testLogin();
