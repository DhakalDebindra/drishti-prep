require('dotenv').config({ path: '.env.local' });
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function checkSchema() {
    const { data: modules, error: modError } = await supabase.from('modules').select('*');
    if (modError) console.error('Modules Error:', modError);
    else console.log('Modules:', JSON.stringify(modules, null, 2));

    const { data: subjects, error: subError } = await supabase.from('subjects').select('*');
    if (subError) console.error('Subjects Error:', subError);
    else console.log('Subjects:', JSON.stringify(subjects, null, 2));
}

checkSchema();
