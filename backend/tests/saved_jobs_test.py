#!/usr/bin/env python3
"""
Saved Jobs Module - Quick Test
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("SAVED JOBS MODULE - TEST")
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
    # Register user
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"saved-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN = r.json()["accessToken"]
    print("✓ User registered")
    
    # Create company
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Co-{uuid.uuid4().hex[:4]}", "slug": f"co-{uuid.uuid4().hex[:6]}", "industry": "Tech"},
        headers=h(TOKEN), timeout=5)
    COMPANY_ID = r.json()["id"]
    print(f"✓ Company created")
    
    # Create job
    r = requests.post(f"{BASE_URL}/jobs",
        json={
            "title": "Test Job",
            "companyId": COMPANY_ID,
            "description": "Test",
            "slug": f"job-{uuid.uuid4().hex[:6]}",
            "employmentType": "FULL_TIME",
            "experienceLevel": "JUNIOR"
        },
        headers=h(TOKEN), timeout=5)
    JOB_ID = r.json()["id"]
    print(f"✓ Job created")
    
    # Create career profile
    r = requests.post(f"{BASE_URL}/career-profiles/me",
        json={"headline": "Engineer"},
        headers=h(TOKEN), timeout=5)
    PROFILE_ID = r.json()["id"]
    print(f"✓ Career profile created")
    
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

# Tests
print("\n" + "="*70)
print("TESTS")
print("="*70)

# Test 1: POST /saved-jobs/save
try:
    r = requests.post(f"{BASE_URL}/saved-jobs/save",
        json={"careerProfileId": PROFILE_ID, "jobId": JOB_ID},
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code in [200, 201]
    if is_pass:
        saved_job_id = r.json().get("id")
        log("SJ1", "POST /saved-jobs/save", is_pass, f"Status: {r.status_code}")
    else:
        log("SJ1", "POST /saved-jobs/save", is_pass, f"Status: {r.status_code}, Response: {r.text[:100]}")
except Exception as e:
    log("SJ1", "POST /saved-jobs/save", False, str(e))

# Test 2: Duplicate save
try:
    r = requests.post(f"{BASE_URL}/saved-jobs/save",
        json={"careerProfileId": PROFILE_ID, "jobId": JOB_ID},
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code in [409, 400]  # Should fail
    log("SJ2", "Duplicate save returns 409", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("SJ2", "Duplicate save returns 409", False, str(e))

# Test 3: DELETE /saved-jobs/{profileId}/jobs/{jobId}/unsave
if 'saved_job_id' in locals():
    try:
        r = requests.post(f"{BASE_URL}/saved-jobs/{PROFILE_ID}/jobs/{JOB_ID}/unsave",
            headers=h(TOKEN), timeout=5)
        is_pass = r.status_code in [200, 204]
        log("SJ3", "POST /unsave", is_pass, f"Status: {r.status_code}")
    except Exception as e:
        log("SJ3", "POST /unsave", False, str(e))

# Test 4: 401 on unauthenticated
try:
    r = requests.post(f"{BASE_URL}/saved-jobs/save",
        json={"careerProfileId": PROFILE_ID, "jobId": JOB_ID},
        headers=HEADERS, timeout=5)
    is_pass = r.status_code == 401
    log("SJ4", "401 on unauthenticated", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("SJ4", "401 on unauthenticated", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
