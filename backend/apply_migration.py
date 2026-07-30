import psycopg2

conn = psycopg2.connect('postgresql://postgres:123456@localhost:5432/jobmap')
cur = conn.cursor()

try:
    # Check recruiters table
    cur.execute("SELECT COUNT(*) FROM recruiters")
    count = cur.fetchone()[0]
    print(f"Recruiters count: {count}")
    
    # Check users
    cur.execute("SELECT COUNT(*) FROM users")
    count = cur.fetchone()[0]
    print(f"Users count: {count}")
    
    if count > 0:
        # Get a user to use as recruiter
        cur.execute('SELECT id FROM users LIMIT 1')
        user_id = cur.fetchone()[0]
        print(f"Using user {user_id} as recruiter default")
        
        # Now add column with this user as default
        cur.execute('ALTER TABLE "jobs" ADD COLUMN "recruiter_id" uuid')
        cur.execute('UPDATE "jobs" SET "recruiter_id" = %s', (user_id,))
        cur.execute('ALTER TABLE "jobs" ALTER COLUMN "recruiter_id" SET NOT NULL')
        
        # Create index
        cur.execute('CREATE INDEX "jobs_recruiter_id_idx" ON "jobs" ("recruiter_id")')
        
        # Add FK (won't use strict FK for now)
        print("Added recruiter_id column successfully")
        conn.commit()
        
except Exception as e:
    conn.rollback()
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()
finally:
    cur.close()
    conn.close()
