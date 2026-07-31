#!/usr/bin/env python3
"""Debug test 4 setup"""

import requests
import json
import uuid
import time

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}
TIMESTAMP = str(int(time.time() * 1000))

# Create TWO users for test
USER_A_EMAIL = f"test4-a-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com"
USER_B_EMAIL = f"test4-b-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com"
PASSWORD = "TestPassword@123456"

print("="*70)
print("TEST 4 SETUP DEBUG")
print("="*70)

# Register USER_A
print("\n[1] Register USER_A...")
r = requests.post(f"{BASE_URL}/auth/register", json={"email": USER_A_EMAIL, "password": PASSWORD}, headers=HEADERS, timeout=5)
print(f"  Status: {r.status_code}")
token_a = r.json().get("accessToken")

# Register USER_B
print("\n[2] Register USER_B...")
r = requests.post(f"{BASE_URL}/auth/register", json={"email": USER_B_EMAIL, "password": PASSWORD}, headers=HEADERS, timeout=5)
print(f"  Status: {r.status_code}")
token_b = r.json().get("accessToken")

# Create profile for USER_A
print("\n[3] Create profile for USER_A...")
r = requests.post(
    f"{BASE_URL}/career-profiles/me",
    json={"headline": "Test Engineer"},
    headers={**HEADERS, "Authorization": f"Bearer {token_a}"},
    timeout=5
)
print(f"  Status: {r.status_code}")
if r.status_code in [200, 201]:
    profile_a = r.json()
    print(f"  Profile ID: {profile_a.get('id')[:8]}")
else:
    print(f"  ERROR: {r.text}")
    profile_a = None

# Try to create second profile for USER_A
print("\n[4] Try to create SECOND profile for USER_A (delete first)...")
r = requests.delete(
    f"{BASE_URL}/career-profiles/me",
    headers={**HEADERS, "Authorization": f"Bearer {token_a}"},
    timeout=5
)
print(f"  Delete status: {r.status_code}")

# Now try creating new profile for USER_A
print("\n[5] Create NEW profile for USER_A (after delete)...")
r = requests.post(
    f"{BASE_URL}/career-profiles/me",
    json={"headline": "New Profile"},
    headers={**HEADERS, "Authorization": f"Bearer {token_a}"},
    timeout=5
)
print(f"  Status: {r.status_code}")
if r.status_code in [200, 201]:
    print(f"  SUCCESS - Profile created: {r.json().get('id')[:8]}")
else:
    print(f"  ERROR: {r.text}")

print("\n" + "="*70)
