#!/usr/bin/env python3
import requests
import json
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

# Create user
email = f"test-{uuid.uuid4().hex[:8]}@test.com"
password = "Test@123456"

print(f"[1] Register {email}")
r = requests.post(f"{BASE_URL}/auth/register", json={"email": email, "password": password}, headers=HEADERS, timeout=5)
print(f"  Status: {r.status_code}")
if r.status_code not in [200, 201]:
    print(f"  Error: {r.text}")
    exit(1)

token = r.json().get("accessToken")
print(f"  Token: {token[:30]}...")

# Create company
print(f"\n[2] Create company")
r = requests.post(
    f"{BASE_URL}/companies",
    json={"name": "TestCorp", "slug": "testcorp", "industry": "Tech"},
    headers={**HEADERS, "Authorization": f"Bearer {token}"},
    timeout=5
)
print(f"  Status: {r.status_code}")
print(f"  Response: {r.text}")
