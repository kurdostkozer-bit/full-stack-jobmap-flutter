import psycopg2

conn = psycopg2.connect('postgresql://postgres:123456@localhost:5432/jobmap')
cur = conn.cursor()
cur.execute("SELECT column_name FROM information_schema.columns WHERE table_name='jobs'")
cols = [row[0] for row in cur.fetchall()]
print('Jobs columns:', cols)
print('recruiter_id exists:', 'recruiter_id' in cols)
conn.close()
