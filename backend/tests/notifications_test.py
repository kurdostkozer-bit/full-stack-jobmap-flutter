#!/usr/bin/env python3
"""
Notifications Module - Quick Test
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("NOTIFICATIONS MODULE - TEST")
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
        json={"email": f"notif-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN = r.json()["accessToken"]
    USER_ID = r.json()["user"]["id"]
    print(f"✓ User registered: {USER_ID[:8]}")
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

# Tests
print("\n" + "="*70)
print("TESTS")
print("="*70)

# Test 1: GET /notifications/user/:userId
try:
    r = requests.get(f"{BASE_URL}/notifications/user/{USER_ID}",
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("N1", "GET /notifications/user/:userId", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("N1", "GET /notifications/user/:userId", False, str(e))

# Test 2: POST /notifications (create)
try:
    r = requests.post(f"{BASE_URL}/notifications",
        json={
            "userId": USER_ID,
            "type": "JOB_ALERT",
            "title": "Test Notification",
            "message": "You have a new job match",
            "data": {"jobId": str(uuid.uuid4())}
        },
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code in [200, 201]
    if is_pass:
        notif_id = r.json().get("id")
        log("N2", "POST /notifications", is_pass, f"Status: {r.status_code}, ID: {notif_id[:8]}")
    else:
        log("N2", "POST /notifications", is_pass, f"Status: {r.status_code}, Response: {r.text[:100]}")
except Exception as e:
    log("N2", "POST /notifications", False, str(e))

# Test 3: 401 on unauthenticated
try:
    r = requests.get(f"{BASE_URL}/notifications/user/{USER_ID}",
        headers=HEADERS, timeout=5)
    is_pass = r.status_code == 401
    log("N3", "401 on unauthenticated", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("N3", "401 on unauthenticated", False, str(e))

# Test 4: GET /notifications/user/:userId/unread
try:
    r = requests.get(f"{BASE_URL}/notifications/user/{USER_ID}/unread",
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("N4", "GET /notifications/user/:userId/unread", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("N4", "GET /notifications/user/:userId/unread", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
