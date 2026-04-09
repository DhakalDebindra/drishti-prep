require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function test() {
    
    const { data: attempts, error } = await supabase
    .from('attempts')
    .select(`
      id, 
      status, 
      score_raw, 
      score_pct, 
      question_count, 
      submitted_at,
      question_sets (
        title,
        topic:topics (
          name,
          subject:subjects (
            name
          )
        )
      )
    `)
    .limit(1);
    
    console.log('Error:', JSON.stringify(error, null, 2));
}

test();
