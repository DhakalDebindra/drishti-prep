const http = require('http');

async function debugLogin() {
  const url = 'https://nrizmljcdhinbyleyuzb.supabase.co/auth/v1/token?grant_type=password';
  const apiKey = 'sb_publishable_oR-h9fgCQhWM6rO4USObqw_lGIRJ5eA';
  
  try {
    console.log('Sending raw POST request to GoTrue...');
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'apikey': apiKey,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email: 'admin@dristiprep.com',
        password: 'password123'
      })
    });
    
    const text = await response.text();
    console.log('--- RAW HTTP STATUS ---');
    console.log(response.status);
    console.log('--- RAW HTTP BODY ---');
    console.log(text);
    
  } catch (err) {
    console.error('Fetch failed completely:', err);
  }
}

debugLogin();
