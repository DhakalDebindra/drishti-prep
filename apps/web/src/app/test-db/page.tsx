import { createClient } from '@/lib/supabase/server';

export default async function TestDbPage() {
  const supabase = await createClient();
  const { data: { session }, error } = await supabase.auth.getSession();

  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold mb-4">Supabase Connection Test</h1>
      {error ? (
        <div className="bg-red-100 text-red-700 p-4 rounded">
          <p>Error connecting to Supabase:</p>
          <pre className="mt-2">{JSON.stringify(error, null, 2)}</pre>
        </div>
      ) : (
        <div className="bg-green-100 text-green-700 p-4 rounded">
          <p>Successfully connected to Supabase!</p>
          <p className="mt-2">Session status: {session ? 'Active' : 'No active session'}</p>
        </div>
      )}
    </div>
  );
}
