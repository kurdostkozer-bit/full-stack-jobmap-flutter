#!/usr/bin/env python3
"""
Applications Module - Authorization Test

Focused on discovering authorization bugs
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

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

print("="*70)
print("APPLICATIONS MODULE - AUTHORIZATION TEST")
print("="*70)

# Simple setup
print("\n[SETUP]")
try:
    # User A - creator
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"user-a-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN_A = r.json()["accessToken"]
    print("✓ User A registered")
    
    # User C - attacker
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"user-c-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN_C = r.json()["accessToken"]
    print("✓ User C registered")
    
    # Create company (for Job)
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Co-{uuid.uuid4().hex[:4]}", "slug": f"co-{uuid.uuid4().hex[:6]}", "industry": "Tech"},
        headers=h(TOKEN_A), timeout=5)
    COMPANY_ID = r.json()["id"]
    print(f"✓ Company created: {COMPANY_ID[:8]}")
    
    # Create Job
    r = requests.post(f"{BASE_URL}/jobs",
        json={
            "title": "Test Job",
            "companyId": COMPANY_ID,
            "description": "Test",
            "slug": f"job-{uuid.uuid4().hex[:6]}",
            "employmentType": "FULL_TIME",
            "experienceLevel": "JUNIOR"
        },
        headers=h(TOKEN_A), timeout=5)
    JOB_ID = r.json()["id"]
    print(f"✓ Job created: {JOB_ID[:8]}")
    
    # Create Career Profile for User A
    r = requests.post(f"{BASE_URL}/career-profiles/me",
        json={"headline": "Software Engineer"},
        headers=h(TOKEN_A), timeout=5)
    PROFILE_ID = r.json()["id"]
    print(f"✓ Career profile created: {PROFILE_ID[:8]}")
    
    # Create Application
    r = requests.post(f"{BASE_URL}/applications/apply",
        json={"careerProfileId": PROFILE_ID, "jobId": JOB_ID},
        headers=h(TOKEN_A), timeout=5)
    if r.status_code in [200, 201]:
        APP_ID = r.json()["id"]
        print(f"✓ Application created: {APP_ID[:8]}")
    else:
        print(f"✗ Application create failed: {r.status_code}")
        print(f"   Response: {r.text[:100]}")
        exit(1)
        
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

print("\n" + "="*70)
print("AUTHORIZATION TESTS (CRITICAL)")
print("="*70)

# Test 1: Non-owner cannot update status
try:
    r = requests.patch(f"{BASE_URL}/applications/{APP_ID}/status",
        json={"status": "REJECTED"},
        headers=h(TOKEN_C),  # User C (not owner)
        timeout=5)
    is_pass = r.status_code in [403, 404]
    log("A1", "Non-owner CANNOT PATCH /status", is_pass,
        f"Status: {r.status_code} (expected 403 or 404)")
except Exception as e:
    log("A1", "Non-owner CANNOT PATCH /status", False, str(e))

# Test 2: Non-owner cannot withdraw
try:
    r = requests.post(f"{BASE_URL}/applications/{APP_ID}/withdraw",
        headers=h(TOKEN_C),  # User C (not owner)
        timeout=5)
    is_pass = r.status_code in [403, 404]
    log("A2", "Non-owner CANNOT POST /withdraw", is_pass,
        f"Status: {r.status_code} (expected 403 or 404)")
except Exception as e:
    log("A2", "Non-owner CANNOT POST /withdraw", False, str(e))

# Test 3: Non-owner cannot delete
try:
    r = requests.delete(f"{BASE_URL}/applications/{APP_ID}",
        headers=h(TOKEN_C),  # User C (not owner)
        timeout=5)
    is_pass = r.status_code in [403, 404]
    log("A3", "Non-owner CANNOT DELETE", is_pass,
        f"Status: {r.status_code} (expected 403 or 404)")
except Exception as e:
    log("A3", "Non-owner CANNOT DELETE", False, str(e))

# Test 4: Owner CAN update status
try:
    r = requests.patch(f"{BASE_URL}/applications/{APP_ID}/status",
        json={"status": "UNDER_REVIEW"},
        headers=h(TOKEN_A),  # User A (owner)
        timeout=5)
    log("A4", "Owner CAN PATCH /status", r.status_code == 200,
        f"Status: {r.status_code}")
except Exception as e:
    log("A4", "Owner CAN PATCH /status", False, str(e))

# Test 5: 401 on unauthenticated request
try:
    r = requests.patch(f"{BASE_URL}/applications/{APP_ID}/status",
        json={"status": "REJECTED"},
        headers=HEADERS,  # No auth
        timeout=5)
    log("A5", "401 on unauthenticated PATCH", r.status_code == 401,
        f"Status: {r.status_code}")
except Exception as e:
    log("A5", "401 on unauthenticated PATCH", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL > 0:
    print(f"\n⚠️  AUTHORIZATION BUGS FOUND!")
else:
    print(f"\n✅ All authorization tests passed!")
