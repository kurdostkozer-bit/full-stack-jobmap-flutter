#!/usr/bin/env node
/**
 * Run SQL migration for career profiles unique constraint fix
 */

const fs = require('fs');
const path = require('path');
const postgres = require('postgres');
require('dotenv').config();

const DATABASE_URL = process.env.DATABASE_URL;

if (!DATABASE_URL) {
  console.error('ERROR: DATABASE_URL not set');
  process.exit(1);
}

async function runMigration() {
  console.log('Running migration: fix_career_profiles_unique_constraint.sql');
  console.log('Database:', DATABASE_URL.split('@')[1] || 'unknown');
  
  const sql = postgres(DATABASE_URL);
  
  try {
    // Read migration file
    const migrationPath = path.join(__dirname, 'migrations', 'fix_career_profiles_unique_constraint.sql');
    const migrationSql = fs.readFileSync(migrationPath, 'utf-8');
    
    // Execute each statement
    const statements = migrationSql
      .split(';')
      .map(s => s.trim())
      .filter(s => s && !s.startsWith('--'));
    
    for (const statement of statements) {
      console.log(`\n[EXECUTE] ${statement.substring(0, 60)}...`);
      await sql.unsafe(statement);
      console.log('  ✓ Success');
    }
    
    console.log('\n✅ Migration completed successfully');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ Migration failed:', error.message);
    console.error('Details:', error);
    process.exit(1);
  }
}

runMigration();
