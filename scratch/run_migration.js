const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const dbUrl = "postgresql://postgres:vuFAwCVZD1Cv6NW9@db.nrizmljcdhinbyleyuzb.supabase.co:5432/postgres";
const migrationPath = path.join(__dirname, '../supabase/migrations/20260426191730_add_subtopics_layer.sql');
const sql = fs.readFileSync(migrationPath, 'utf8');

const commands = sql
  .split(';')
  .map(c => c.replace(/--.*$/gm, '').trim()) // Remove comments first
  .filter(c => c && c.toLowerCase() !== 'begin' && c.toLowerCase() !== 'commit');

console.log(`Running ${commands.length} commands...`);

for (const cmd of commands) {
  const displayCmd = cmd.substring(0, 50).replace(/\n/g, ' ');
  console.log(`Executing: ${displayCmd}...`);
  try {
    // In PowerShell/Windows, double quotes are better. We need to escape double quotes inside the SQL.
    const escapedSql = cmd.replace(/"/g, '""').replace(/\n/g, ' ');
    const finalCmd = `npx supabase db query --db-url "${dbUrl}" "${escapedSql}"`;
    execSync(finalCmd, { encoding: 'utf8' });
    console.log('Success');
  } catch (err) {
    console.error('Error executing command:', cmd);
    console.error(err.stdout || err.stderr || err.message);
    process.exit(1);
  }
}

console.log('Migration completed successfully.');
