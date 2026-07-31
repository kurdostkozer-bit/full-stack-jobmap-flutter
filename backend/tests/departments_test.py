#!/usr/bin/env python3
"""
Departments Module - Quick Test
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("DEPARTMENTS MODULE - TEST")
print("="*70)

PASS = 0
FAIL = 0

def log(test_id, name, passed, details=""):
    global PASS, FAIL
    status = "[✓]" if passed else "[✗]"
    print(f"{status} [{test_id}] {name}")
    if details:
        print(f"   → {details}")
    if passed:
        PASS += 1
    else:
        FAIL += 1

def h(token=""):
    headers = dict(HEADERS)
    if token:
        headers["Authorization"] = f"Bearer {token}"
    return headers

# Setup
print("\n[SETUP]")
try:
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"dept-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN = r.json()["accessToken"]
    
    # Create company
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Co-{uuid.uuid4().hex[:4]}", "slug": f"co-{uuid.uuid4().hex[:6]}", "industry": "Tech"},
        headers=h(TOKEN), timeout=5)
    COMPANY_ID = r.json()["id"]
    print(f"✓ Setup done")
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

# Tests
print("\n" + "="*70)
print("TESTS")
print("="*70)

# Test 1: GET /departments
try:
    r = requests.get(f"{BASE_URL}/departments", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("D1", "GET /departments", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("D1", "GET /departments", False, str(e))

# Test 2: POST /departments (create)
try:
    r = requests.post(f"{BASE_URL}/departments",
        json={"name": "Engineering", "slug": "engineering", "companyId": COMPANY_ID},
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code in [200, 201]
    if is_pass:
        dept_id = r.json().get("id")
        log("D2", "POST /departments", is_pass, f"Status: {r.status_code}, ID: {dept_id[:8]}")
    else:
        log("D2", "POST /departments", is_pass, f"Status: {r.status_code}, Response: {r.text[:100]}")
except Exception as e:
    log("D2", "POST /departments", False, str(e))

# Test 3: GET /departments/:id
if 'dept_id' in locals():
    try:
        r = requests.get(f"{BASE_URL}/departments/{dept_id}", headers=HEADERS, timeout=5)
        is_pass = r.status_code == 200
        log("D3", "GET /departments/:id", is_pass, f"Status: {r.status_code}")
    except Exception as e:
        log("D3", "GET /departments/:id", False, str(e))

# Test 4: 404 on invalid ID
try:
    r = requests.get(f"{BASE_URL}/departments/{uuid.uuid4()}", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 404
    log("D4", "404 on invalid ID", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("D4", "404 on invalid ID", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
