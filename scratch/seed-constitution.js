const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
);

async function seed() {
  console.log('Attempting login...');
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email: 'admin@dristiprep.com',
    password: 'password123',
  });

  if (authError) {
    console.error('Login Error:', JSON.stringify(authError, null, 2));
    process.exit(1);
  }

  console.log('Login successful!', authData.user.email);

  // 1. Ensure Governance Module exists
  console.log('Checking for Governance module...');
  let { data: moduleData, error: moduleError } = await supabase
    .from('modules')
    .select('id')
    .eq('slug', 'governance-management')
    .single();

  if (moduleError && moduleError.code !== 'PGRST116') {
    console.error('Module check error:', moduleError);
    process.exit(1);
  }

  let moduleId;
  if (!moduleData) {
    console.log('Creating Governance module...');
    const { data: newModule, error: createModError } = await supabase
      .from('modules')
      .insert({
        name: 'Governance & Management',
        name_np: 'शासन र व्यवस्थापन',
        slug: 'governance-management',
        display_order: 2
      })
      .select()
      .single();
    
    if (createModError) {
      console.error('Module creation error:', createModError);
      process.exit(1);
    }
    moduleId = newModule.id;
  } else {
    moduleId = moduleData.id;
  }

  // 2. Ensure Subject exists
  console.log('Checking for Nepal Constitution subject...');
  let { data: subjectData, error: subjectError } = await supabase
    .from('subjects')
    .select('id')
    .eq('syllabus_ref', '2.1')
    .single();

  let subjectId;
  if (!subjectData) {
    console.log('Creating Nepal Constitution subject...');
    const { data: newSubject, error: createSubError } = await supabase
      .from('subjects')
      .insert({
        module_id: moduleId,
        name: 'Nepal Constitution',
        name_np: 'नेपालको संविधान',
        syllabus_ref: '2.1',
        display_order: 1,
        slug: 'nepal-constitution'
      })
      .select()
      .single();

    if (createSubError) {
      console.error('Subject creation error:', createSubError);
      process.exit(1);
    }
    subjectId = newSubject.id;
  } else {
    subjectId = subjectData.id;
  }

  // 3. Insert Topics
  const topicSeeds = [
    { name: 'नेपालको संवैधानिक इतिहास (Sovereign Development of Nepal)', syllabus_ref: '2.1.1', slug: 'nepal-constitutional-history', display_order: 1 },
    { name: 'वर्तमान संविधानको सामान्य परिचय र प्रारम्भिक (Preliminary)', syllabus_ref: '2.1.2', slug: 'preliminary-constitution-intro', display_order: 2 },
    { name: 'नागरिकता सम्बन्धी व्यवस्था (Citizenship)', syllabus_ref: '2.1.3', slug: 'citizenship-provisions', display_order: 3 },
    { name: 'मौलिक हक र कर्तव्य (Fundamental Rights and Duties)', syllabus_ref: '2.1.4', slug: 'fundamental-rights-duties', display_order: 4 },
    { name: 'राज्यका निर्देशक सिद्धान्त, नीति र दायित्व (Directive Principles and Policies)', syllabus_ref: '2.1.5', slug: 'directive-principles-policies', display_order: 5 },
    { name: 'राज्यको संरचना र राज्य शक्तिको बाँडफाँड (State Structure and Power Sharing)', syllabus_ref: '2.1.6', slug: 'state-structure-power-sharing', display_order: 6 },
    { name: 'संघीय, प्रादेशिक र स्थानीय कार्यपालिका (Executives)', syllabus_ref: '2.1.7', slug: 'executives-federal-provincial-local', display_order: 7 },
    { name: 'व्यवस्थापिका र आर्थिक कार्यप्रणाली (Legislative and Financial Procedures)', syllabus_ref: '2.1.8', slug: 'legislative-financial-procedures', display_order: 8 },
    { name: 'न्यायपालिका (Judiciary)', syllabus_ref: '2.1.9', slug: 'judiciary', display_order: 9 },
    { name: 'संवैधानिक निकायहरू (Constitutional Bodies)', syllabus_ref: '2.1.10', slug: 'constitutional-bodies', display_order: 10 },
    { name: 'विविध व्यवस्थाहरू (Miscellaneous)', syllabus_ref: '2.1.11', slug: 'miscellaneous-provisions', display_order: 11 }
  ];

  const topics = topicSeeds.map(t => ({ ...t, subject_id: subjectId }));

  console.log('Inserting topics...');
  const { error: topicsError } = await supabase
    .from('topics')
    .upsert(topics, { onConflict: 'subject_id,syllabus_ref' });

  if (topicsError) {
    console.error('Topics insertion error:', topicsError);
    process.exit(1);
  }

  console.log('Successfully seeded Nepal Constitution subjects and topics!');
  process.exit(0);
}

seed();
