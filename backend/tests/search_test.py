#!/usr/bin/env python3
"""
Search Module - Quick Test
"""

import requests

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("SEARCH MODULE - QUICK TEST")
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

# Test 1: GET /search (general)
try:
    r = requests.get(f"{BASE_URL}/search?query=software", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), dict)
    log("S1", "GET /search (general)", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("S1", "GET /search (general)", False, str(e))

# Test 2: GET /search/jobs
try:
    r = requests.get(f"{BASE_URL}/search/jobs?query=python", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("S2", "GET /search/jobs", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("S2", "GET /search/jobs", False, str(e))

# Test 3: GET /search/companies
try:
    r = requests.get(f"{BASE_URL}/search/companies?query=tech", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("S3", "GET /search/companies", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("S3", "GET /search/companies", False, str(e))

# Test 4: GET /search with pagination
try:
    r = requests.get(f"{BASE_URL}/search/jobs?q=engineer&limit=5", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and len(r.json()) <= 5
    log("S4", "GET /search/jobs with limit", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("S4", "GET /search/jobs with limit", False, str(e))

# Test 5: Empty query
try:
    r = requests.get(f"{BASE_URL}/search/jobs?q=", headers=HEADERS, timeout=5)
    is_pass = r.status_code in [200, 400]  # May or may not require query
    log("S5", "GET /search/jobs with empty query", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("S5", "GET /search/jobs with empty query", False, str(e))

# Test 6: Invalid endpoint (should 404)
try:
    r = requests.post(f"{BASE_URL}/search/jobs",
        json={"q": "test"}, headers=HEADERS, timeout=5)  # POST not allowed
    is_pass = r.status_code in [404, 405]
    log("S6", "POST /search (not allowed)", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("S6", "POST /search (not allowed)", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All search tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
