require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function listCoreData() {
    console.log('--- SUBJECTS ---');
    const { data: subjects, error: sError } = await supabase.from('subjects').select('id, name, syllabus_ref');
    if (sError) console.error(sError);
    else console.log(subjects);

    console.log('\n--- TOPICS (first 5) ---');
    const { data: topics, error: tError } = await supabase.from('topics').select('id, name, subject_id, syllabus_ref').limit(5);
    if (tError) console.error(tError);
    else console.log(topics);
}

listCoreData();
