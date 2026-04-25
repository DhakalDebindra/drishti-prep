const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

async function moveSubject() {
  console.log('Attempting login...');
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email: 'admin@drishtiprep.com',
    password: 'password123',
  });

  if (authError) {
    console.error('Login Error:', JSON.stringify(authError, null, 2));
    process.exit(1);
  }

  console.log('Login successful!');

  // 1. Get GK module ID
  const { data: gkModule, error: gkError } = await supabase
    .from('modules')
    .select('id')
    .eq('slug', 'gk')
    .single();

  if (gkError) {
    console.error('GK module find error:', gkError);
    process.exit(1);
  }

  // 2. Update Nepal Constitution subject
  console.log('Moving Nepal Constitution to GK module...');
  const { error: updateError } = await supabase
    .from('subjects')
    .update({ 
      module_id: gkModule.id,
      syllabus_ref: '1.12', // Change from 2.1 to 1.12 to fit in GK
      display_order: 12
    })
    .eq('slug', 'nepal-constitution');

  if (updateError) {
    console.error('Subject update error:', updateError);
    process.exit(1);
  }

  // 3. Update topics for this subject (their syllabus refs start with the subject's ref)
  console.log('Updating topics syllabus references...');
  const { data: subjects, error: subFindError } = await supabase
    .from('subjects')
    .select('id')
    .eq('slug', 'nepal-constitution')
    .single();
  
  if (subFindError) {
    console.error('Subject find error:', subFindError);
    process.exit(1);
  }

  const { data: topics, error: topicsError } = await supabase
    .from('topics')
    .select('id, syllabus_ref')
    .eq('subject_id', subjects.id);

  if (topicsError) {
    console.error('Topics find error:', topicsError);
    process.exit(1);
  }

  for (const topic of topics) {
    const newRef = topic.syllabus_ref.replace(/^2\.1\./, '1.12.');
    await supabase.from('topics').update({ syllabus_ref: newRef }).eq('id', topic.id);
  }

  // 4. Delete the empty module
  console.log('Deleting empty Governance module...');
  const { error: deleteError } = await supabase
    .from('modules')
    .delete()
    .eq('slug', 'governance-management');

  if (deleteError) {
    console.warn('Module delete error (might still have contents):', deleteError);
  }

  console.log('Successfully moved Nepal Constitution to GK module!');
  process.exit(0);
}

moveSubject();
