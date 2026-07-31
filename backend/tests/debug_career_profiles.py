#!/usr/bin/env python3
"""Debug script for Career Profiles error"""

import requests
import uuid
import time
import json

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

# Unique email
EMAIL = f"debug-user-{int(time.time() * 1000)}@test.com"
PASSWORD = "TestPassword@123456"

print("="*70)
print("CAREER PROFILES DEBUG - UNIQUE CONSTRAINT ERROR")
print("="*70)

# 1. Register
print("\n[1] Register user...")
response = requests.post(
    f"{BASE_URL}/auth/register",
    json={"email": EMAIL, "password": PASSWORD},
    headers=HEADERS,
    timeout=5
)
print(f"  Status: {response.status_code}")
print(f"  Response: {response.text[:200]}")

# 2. Login
print("\n[2] Login user...")
response = requests.post(
    f"{BASE_URL}/auth/login",
    json={"email": EMAIL, "password": PASSWORD},
    headers=HEADERS,
    timeout=5
)
print(f"  Status: {response.status_code}")
if response.status_code in [200, 201]:
    data = response.json()
    token = data.get("accessToken") or data.get("access_token") or data.get("token")
    print(f"  Token: {token[:30]}...")
else:
    print(f"  Error: {response.text[:200]}")
    exit(1)

# 3. Create first profile
print("\n[3] Create FIRST profile...")
response = requests.post(
    f"{BASE_URL}/career-profiles/me",
    json={"headline": "First Profile"},
    headers={**HEADERS, "Authorization": f"Bearer {token}"},
    timeout=5
)
print(f"  Status: {response.status_code}")
if response.status_code in [200, 201]:
    print(f"  Profile created: {response.json().get('id')[:8]}...")
else:
    print(f"  Error: {response.text}")

# 4. Try creating second profile (should get 409, not 500)
print("\n[4] Create SECOND profile (should be 409 or 400)...")
response = requests.post(
    f"{BASE_URL}/career-profiles/me",
    json={"headline": "Second Profile - Should fail"},
    headers={**HEADERS, "Authorization": f"Bearer {token}"},
    timeout=5
)
print(f"  Status: {response.status_code}")
print(f"  Expected: 409 (Conflict) or 400 (Bad Request)")
print(f"  Actual: {response.status_code}")
if response.status_code in [409, 400]:
    print(f"  ✅ CORRECT STATUS")
else:
    print(f"  ❌ WRONG STATUS (getting {response.status_code})")
    
print(f"  Response: {response.text}")

print("\n" + "="*70)
