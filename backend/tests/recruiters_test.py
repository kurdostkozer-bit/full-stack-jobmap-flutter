#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Recruiters Module Test Suite - Fast Track

Simplified version focusing on core bugs:
- Authorization (non-owner can't UPDATE/DELETE)
- Relationships (duplicate user+company)
- Error handling
"""

import requests
import json
import uuid
from datetime import datetime

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

PASS_COUNT = 0
FAIL_COUNT = 0

def log_test(test_id: str, name: str, passed: bool, details: str = ""):
    global PASS_COUNT, FAIL_COUNT
    status = "[PASS]" if passed else "[FAIL]"
    print(f"{status} [{test_id}] {name}")
    if details:
        print(f"    Details: {details}")
    if passed:
        PASS_COUNT += 1
    else:
        FAIL_COUNT += 1

def h(token: str = None) -> dict:
    """Helper for headers with token"""
    h = dict(HEADERS)
    if token:
        h["Authorization"] = f"Bearer {token}"
    return h

print("="*70)
print("RECRUITERS MODULE - FAST TEST SUITE")
print("="*70)
print(f"Start: {datetime.now().isoformat()}")
print("="*70)

# Setup: Create users + companies
USER_A_ID = str(uuid.uuid4())
USER_B_ID = str(uuid.uuid4())
USER_C_ID = str(uuid.uuid4())

# Create company A (owned by USER_A)
print("\n[SETUP] Creating test data...")
try:
    # Register USER_A
    r = requests.post(f"{BASE_URL}/auth/register", 
        json={"email": f"recruiter-a-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_A = r.json().get("accessToken")
    
    # Register USER_B
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"recruiter-b-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_B = r.json().get("accessToken")
    
    # Register USER_C
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"recruiter-c-{uuid.uuid4().hex[:4]}@test.com", "password": "Test@123"},
        headers=HEADERS, timeout=5)
    TOKEN_C = r.json().get("accessToken")
    
    # Create company A
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Company-{uuid.uuid4().hex[:4]}", "slug": f"company-{uuid.uuid4().hex[:4]}", "industry": "Tech"},
        headers=h(TOKEN_A), timeout=5)
    COMPANY_A = r.json().get("id")
    
    # Create company B
    r = requests.post(f"{BASE_URL}/companies",
        json={"name": f"Company-{uuid.uuid4().hex[:4]}", "slug": f"company-{uuid.uuid4().hex[:4]}", "industry": "Tech"},
        headers=h(TOKEN_B), timeout=5)
    COMPANY_B = r.json().get("id")
    
    print(f"  Users: A={TOKEN_A[:20]}..., B={TOKEN_B[:20]}..., C={TOKEN_C[:20]}...")
    print(f"  Companies: A={COMPANY_A[:8]}, B={COMPANY_B[:8]}")
except Exception as e:
    print(f"  Setup failed: {e}")
    exit(1)

# Tests
print("\n" + "="*70)
print("CATEGORY 1: CRUD")
print("="*70)

# Create recruiter
try:
    r = requests.post(f"{BASE_URL}/recruiters",
        json={"companyId": COMPANY_A, "userId": USER_B_ID, "title": "Recruiter 1"},
        headers=h(TOKEN_A), timeout=5)
    log_test("1.1", "CREATE recruiter", r.status_code in [200, 201], f"Status {r.status_code}")
    RECRUITER_ID = r.json().get("id") if r.status_code in [200, 201] else None
except Exception as e:
    log_test("1.1", "CREATE recruiter", False, str(e))
    RECRUITER_ID = None

if RECRUITER_ID:
    # READ
    try:
        r = requests.get(f"{BASE_URL}/recruiters/{RECRUITER_ID}", headers=HEADERS, timeout=5)
        log_test("1.2", "READ by ID", r.status_code == 200)
    except Exception as e:
        log_test("1.2", "READ by ID", False, str(e))
    
    # LIST by company
    try:
        r = requests.get(f"{BASE_URL}/recruiters/company/{COMPANY_A}", headers=HEADERS, timeout=5)
        log_test("1.3", "LIST by company", r.status_code == 200 and isinstance(r.json(), list))
    except Exception as e:
        log_test("1.3", "LIST by company", False, str(e))
    
    # UPDATE by owner
    try:
        r = requests.patch(f"{BASE_URL}/recruiters/{RECRUITER_ID}",
            json={"title": "Updated"}, headers=h(TOKEN_A), timeout=5)
        log_test("1.4", "UPDATE by owner", r.status_code == 200, f"Status {r.status_code}")
    except Exception as e:
        log_test("1.4", "UPDATE by owner", False, str(e))

print("\n" + "="*70)
print("CATEGORY 2: AUTHORIZATION (CRITICAL)")
print("="*70)

if RECRUITER_ID:
    # Non-owner CANNOT UPDATE
    try:
        r = requests.patch(f"{BASE_URL}/recruiters/{RECRUITER_ID}",
            json={"title": "Hacked"}, headers=h(TOKEN_C), timeout=5)
        is_pass = r.status_code in [403, 404]
        log_test("2.1", "Non-owner CANNOT UPDATE [BUG]", is_pass, f"Status {r.status_code} (expected 403)")
    except Exception as e:
        log_test("2.1", "Non-owner CANNOT UPDATE [BUG]", False, str(e))
    
    # Non-owner CANNOT DELETE
    try:
        r = requests.delete(f"{BASE_URL}/recruiters/{RECRUITER_ID}", headers=h(TOKEN_C), timeout=5)
        is_pass = r.status_code in [403, 404]
        log_test("2.2", "Non-owner CANNOT DELETE [BUG]", is_pass, f"Status {r.status_code} (expected 403)")
    except Exception as e:
        log_test("2.2", "Non-owner CANNOT DELETE [BUG]", False, str(e))

print("\n" + "="*70)
print("CATEGORY 3: RELATIONSHIPS")
print("="*70)

# Duplicate recruiter (same user+company)
try:
    # First
    r1 = requests.post(f"{BASE_URL}/recruiters",
        json={"companyId": COMPANY_A, "userId": USER_C_ID, "title": "R1"},
        headers=h(TOKEN_A), timeout=5)
    
    if r1.status_code in [200, 201]:
        # Second (should fail with 409)
        r2 = requests.post(f"{BASE_URL}/recruiters",
            json={"companyId": COMPANY_A, "userId": USER_C_ID, "title": "R2"},
            headers=h(TOKEN_A), timeout=5)
        log_test("3.1", "Duplicate (user+company) returns 409", r2.status_code in [409, 400], 
            f"Status {r2.status_code} (expected 409)")
    else:
        log_test("3.1", "Duplicate (user+company) returns 409", False, f"First create: {r1.status_code}")
except Exception as e:
    log_test("3.1", "Duplicate (user+company) returns 409", False, str(e))

print("\n" + "="*70)
print("CATEGORY 4: ERROR HANDLING")
print("="*70)

# 404 on invalid ID
try:
    r = requests.get(f"{BASE_URL}/recruiters/{uuid.uuid4()}", headers=HEADERS, timeout=5)
    log_test("4.1", "404 on invalid ID", r.status_code == 404)
except Exception as e:
    log_test("4.1", "404 on invalid ID", False, str(e))

# 400 on missing required fields
try:
    r = requests.post(f"{BASE_URL}/recruiters",
        json={"title": "No company/user"}, headers=h(TOKEN_A), timeout=5)
    log_test("4.2", "400 on missing required fields", r.status_code == 400)
except Exception as e:
    log_test("4.2", "400 on missing required fields", False, str(e))

# 401 on unauthenticated POST
try:
    r = requests.post(f"{BASE_URL}/recruiters",
        json={"companyId": COMPANY_A, "userId": USER_B_ID, "title": "Test"},
        headers=HEADERS, timeout=5)  # No auth
    log_test("4.3", "401 on unauthenticated POST", r.status_code == 401)
except Exception as e:
    log_test("4.3", "401 on unauthenticated POST", False, str(e))

# Summary
print("\n" + "="*70)
print("TEST SUMMARY")
print("="*70)
print(f"Results: {PASS_COUNT} PASS, {FAIL_COUNT} FAIL")
print(f"End: {datetime.now().isoformat()}")
if FAIL_COUNT == 0:
    print("✅ ALL TESTS PASSED")
else:
    print(f"❌ {FAIL_COUNT} tests failed - fix bugs and re-run")
print("="*70)

