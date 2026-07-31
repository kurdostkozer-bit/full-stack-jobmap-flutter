#!/usr/bin/env python3
"""
Applications Module - Fast Test Suite

Focus: Authorization bugs discovery
"""

import requests
import uuid
from datetime import datetime

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

PASS = 0
FAIL = 0

def log(test_id, name, passed, details=""):
    global PASS, FAIL
    status = "[PASS]" if passed else "[FAIL]"
    print(f"{status} [{test_id}] {name}")
    if details:
        print(f"    Details: {details}")
    if passed:
        PASS += 1
    else:
        FAIL += 1

def h(token=""):
    h = dict(HEADERS)
    if token:
        h["Authorization"] = f"Bearer {token}"
    return h

print("="*70)
print("APPLICATIONS MODULE - TEST SUITE")
print("="*70)
print(f"Start: {datetime.now().isoformat()}")

# Setup
print("\n[SETUP] Creating test data...")
try:
    # Register 3 users
    r1 = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"app-a-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_A = r1.json().get("accessToken")
    
    r2 = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"app-b-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_B = r2.json().get("accessToken")
    
    r3 = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"app-c-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_C = r3.json().get("accessToken")
    
    # Create companies
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Co-{uuid.uuid4().hex[:4]}", "slug": f"co-{uuid.uuid4().hex[:4]}", "industry": "Tech"},
        headers=h(TOKEN_A), timeout=5)
    COMPANY_A = r.json().get("id")
    
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Co-{uuid.uuid4().hex[:4]}", "slug": f"co-{uuid.uuid4().hex[:4]}", "industry": "Tech"},
        headers=h(TOKEN_B), timeout=5)
    COMPANY_B = r.json().get("id")
    
    # Create jobs
    r = requests.post(f"{BASE_URL}/jobs",
        json={
            "title": "Job A",
            "companyId": COMPANY_A,
            "description": "Test",
            "slug": "job-a",
            "employmentType": "FULL_TIME",
            "experienceLevel": "JUNIOR"
        },
        headers=h(TOKEN_A), timeout=5)
    print(f"  Job A create: {r.status_code}")
    JOB_A = r.json().get("id")
    if not JOB_A:
        print(f"    Response: {r.text[:200]}")
    
    r = requests.post(f"{BASE_URL}/jobs",
        json={
            "title": "Job B",
            "companyId": COMPANY_B,
            "description": "Test",
            "slug": "job-b",
            "employmentType": "FULL_TIME",
            "experienceLevel": "JUNIOR"
        },
        headers=h(TOKEN_B), timeout=5)
    JOB_B = r.json().get("id")
    
    # Create career profiles
    r = requests.post(f"{BASE_URL}/career-profiles/me",
        json={"title": "Profile A", "bio": "Bio A", "skills": ["Skill1"]},
        headers=h(TOKEN_A), timeout=5)
    print(f"  Profile A create: {r.status_code}")
    PROFILE_A = r.json().get("id")
    if not PROFILE_A:
        print(f"    Response: {r.text[:200]}")
    
    r = requests.post(f"{BASE_URL}/career-profiles/me",
        json={"title": "Profile B", "bio": "Bio B", "skills": ["Skill2"]},
        headers=h(TOKEN_B), timeout=5)
    PROFILE_B = r.json().get("id")
    
    print(f"  Users: A={TOKEN_A[:20]}..., B={TOKEN_B[:20]}..., C={TOKEN_C[:20]}...")
    print(f"  Companies: A={COMPANY_A[:8]}, B={COMPANY_B[:8]}")
    print(f"  Jobs: A={JOB_A[:8]}, B={JOB_B[:8]}")
    print(f"  Profiles: A={PROFILE_A[:8] if PROFILE_A else 'NONE'}, B={PROFILE_B[:8] if PROFILE_B else 'NONE'}")
except Exception as e:
    print(f"  Setup failed: {e}")
    import traceback
    traceback.print_exc()
    exit(1)

print("\n" + "="*70)
print("CATEGORY 1: CRUD")
print("="*70)

# Create application
try:
    r = requests.post(f"{BASE_URL}/applications/apply",
        json={"careerProfileId": PROFILE_A, "jobId": JOB_A},
        headers=h(TOKEN_A), timeout=5)
    log("1.1", "POST /apply", r.status_code in [200, 201], f"Status {r.status_code}")
    APP_ID = r.json().get("id") if r.status_code in [200, 201] else None
except Exception as e:
    log("1.1", "POST /apply", False, str(e))
    APP_ID = None

if APP_ID:
    # GET application
    try:
        r = requests.get(f"{BASE_URL}/applications/{APP_ID}", headers=h(TOKEN_A), timeout=5)
        log("1.2", "GET /:id", r.status_code == 200)
    except Exception as e:
        log("1.2", "GET /:id", False, str(e))
    
    # LIST applications
    try:
        r = requests.get(f"{BASE_URL}/applications/career-profile/{PROFILE_A}", headers=h(TOKEN_A), timeout=5)
        log("1.3", "GET /career-profile/:id", r.status_code == 200 and isinstance(r.json(), list))
    except Exception as e:
        log("1.3", "GET /career-profile/:id", False, str(e))
    
    # Update status
    try:
        r = requests.patch(f"{BASE_URL}/applications/{APP_ID}/status",
            json={"status": "UNDER_REVIEW"},
            headers=h(TOKEN_A), timeout=5)
        log("1.4", "PATCH /:id/status", r.status_code == 200, f"Status {r.status_code}")
    except Exception as e:
        log("1.4", "PATCH /:id/status", False, str(e))

print("\n" + "="*70)
print("CATEGORY 2: AUTHORIZATION (CRITICAL BUG)")
print("="*70)

if APP_ID:
    # Non-owner SHOULD NOT be able to update status
    try:
        r = requests.patch(f"{BASE_URL}/applications/{APP_ID}/status",
            json={"status": "REJECTED"},
            headers=h(TOKEN_C), timeout=5)  # User C (non-owner)
        is_pass = r.status_code in [403, 404]
        log("2.1", "Non-owner CANNOT PATCH status [BUG]", is_pass, f"Status {r.status_code} (expected 403)")
    except Exception as e:
        log("2.1", "Non-owner CANNOT PATCH status [BUG]", False, str(e))
    
    # Non-owner SHOULD NOT be able to withdraw
    try:
        r = requests.post(f"{BASE_URL}/applications/{APP_ID}/withdraw",
            headers=h(TOKEN_C), timeout=5)
        is_pass = r.status_code in [403, 404]
        log("2.2", "Non-owner CANNOT withdraw [BUG]", is_pass, f"Status {r.status_code} (expected 403)")
    except Exception as e:
        log("2.2", "Non-owner CANNOT withdraw [BUG]", False, str(e))
    
    # Non-owner SHOULD NOT be able to delete
    try:
        r = requests.delete(f"{BASE_URL}/applications/{APP_ID}",
            headers=h(TOKEN_C), timeout=5)
        is_pass = r.status_code in [403, 404]
        log("2.3", "Non-owner CANNOT DELETE [BUG]", is_pass, f"Status {r.status_code} (expected 403)")
    except Exception as e:
        log("2.3", "Non-owner CANNOT DELETE [BUG]", False, str(e))

print("\n" + "="*70)
print("CATEGORY 3: RELATIONSHIPS")
print("="*70)

# Duplicate application
try:
    r1 = requests.post(f"{BASE_URL}/applications/apply",
        json={"careerProfileId": PROFILE_B, "jobId": JOB_B},
        headers=h(TOKEN_B), timeout=5)
    
    if r1.status_code in [200, 201]:
        r2 = requests.post(f"{BASE_URL}/applications/apply",
            json={"careerProfileId": PROFILE_B, "jobId": JOB_B},
            headers=h(TOKEN_B), timeout=5)
        log("3.1", "Duplicate application returns 409", r2.status_code in [409, 400],
            f"Status {r2.status_code} (expected 409)")
    else:
        log("3.1", "Duplicate application returns 409", False, f"First apply failed: {r1.status_code}")
except Exception as e:
    log("3.1", "Duplicate application returns 409", False, str(e))

print("\n" + "="*70)
print("CATEGORY 4: ERROR HANDLING")
print("="*70)

# 404 on invalid ID
try:
    r = requests.get(f"{BASE_URL}/applications/{uuid.uuid4()}", headers=h(TOKEN_A), timeout=5)
    log("4.1", "404 on invalid ID", r.status_code == 404)
except Exception as e:
    log("4.1", "404 on invalid ID", False, str(e))

# 400 on missing required fields
try:
    r = requests.post(f"{BASE_URL}/applications/apply",
        json={"careerProfileId": PROFILE_A},  # Missing jobId
        headers=h(TOKEN_A), timeout=5)
    log("4.2", "400 on missing fields", r.status_code == 400)
except Exception as e:
    log("4.2", "400 on missing fields", False, str(e))

# 401 on unauthenticated
try:
    r = requests.post(f"{BASE_URL}/applications/apply",
        json={"careerProfileId": PROFILE_A, "jobId": JOB_A},
        headers=HEADERS, timeout=5)  # No auth
    log("4.3", "401 on unauthenticated", r.status_code == 401)
except Exception as e:
    log("4.3", "401 on unauthenticated", False, str(e))

# Summary
print("\n" + "="*70)
print("TEST SUMMARY")
print("="*70)
print(f"Results: {PASS} PASS, {FAIL} FAIL")
print(f"End: {datetime.now().isoformat()}")
if FAIL == 0:
    print("✅ ALL TESTS PASSED")
else:
    print(f"❌ {FAIL} tests failed - FIX AUTHORIZATION BUGS")
print("="*70)
