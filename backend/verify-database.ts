import 'dotenv/config';
import { db } from './src/database/database';
import { users } from './src/database/schema';
import { desc } from 'drizzle-orm';

async function verifyDatabase() {
  try {
    console.log('\n=== Database Verification ===\n');

    // Get last 3 registered users
    const recentUsers = await db
      .select({
        id: users.id,
        email: users.email,
        passwordHash: users.passwordHash,
        isEmailVerified: users.isEmailVerified,
        createdAt: users.createdAt,
      })
      .from(users)
      .orderBy(desc(users.createdAt))
      .limit(3);

    if (recentUsers.length === 0) {
      console.log('❌ No users found in database');
      process.exit(1);
    }

    console.log(`✓ Found ${recentUsers.length} users in database\n`);

    recentUsers.forEach((user, idx) => {
      const hashPrefix = user.passwordHash?.substring(0, 4) || 'NULL';
      const hashLength = user.passwordHash?.length || 0;
      const isBcrypt = user.passwordHash?.startsWith('$2b$');

      console.log(`${idx + 1}. Email: ${user.email}`);
      console.log(`   ID: ${user.id}`);
      console.log(`   Password Hash Prefix: ${hashPrefix}...`);
      console.log(`   Hash Length: ${hashLength} chars`);
      console.log(`   Is Bcrypt: ${isBcrypt ? '✓ YES' : '✗ NO'}`);
      console.log(`   Email Verified: ${user.isEmailVerified}`);
      console.log(`   Created: ${user.createdAt?.toISOString()}`);
      console.log('');
    });

    // Verify all are hashed
    const allHashed = recentUsers.every((u) =>
      u.passwordHash?.startsWith('$2b$'),
    );

    console.log('=== Password Hashing Verification ===');
    console.log(`All passwords are bcrypt-hashed: ${allHashed ? '✓ YES' : '✗ NO'}`);

    if (allHashed) {
      console.log('✓ Database integrity: VERIFIED');
      console.log('\nConclusion: Auth module properly stores hashed passwords in database');
    } else {
      console.log('✗ WARNING: Some passwords are not properly hashed');
    }

    process.exit(allHashed ? 0 : 1);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

verifyDatabase();
