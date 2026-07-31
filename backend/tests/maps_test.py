#!/usr/bin/env python3
"""
Maps Module - Quick Test
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("MAPS MODULE - QUICK TEST")
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
        json={"email": f"maps-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN = r.json()["accessToken"]
    print("✓ User registered")
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

# Test 1: GET /maps/locations (list)
try:
    r = requests.get(f"{BASE_URL}/maps/locations", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("M1", "GET /maps/locations (list)", is_pass, f"Status: {r.status_code}, items: {len(r.json())}")
except Exception as e:
    log("M1", "GET /maps/locations (list)", False, str(e))

# Test 2: POST /maps/locations (create) - should need auth
try:
    r = requests.post(f"{BASE_URL}/maps/locations",
        json={"address": "123 Main St", "city": "New York", "state": "NY", "latitude": 40.7128, "longitude": -74.0060},
        headers=HEADERS, timeout=5)  # No auth
    is_pass = r.status_code in [401, 403]
    log("M2", "POST /maps/locations (401 unauthorized)", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("M2", "POST /maps/locations (401 unauthorized)", False, str(e))

# Test 3: POST /maps/locations (create) - with auth
try:
    r = requests.post(f"{BASE_URL}/maps/locations",
        json={"address": "456 Elm St", "city": "Boston", "state": "MA", "latitude": 42.3601, "longitude": -71.0589},
        headers=h(TOKEN), timeout=5)
    is_pass = r.status_code in [200, 201]
    if is_pass:
        location_id = r.json().get("id")
        log("M3", "POST /maps/locations (authenticated)", is_pass, f"Status: {r.status_code}, ID: {location_id[:8]}")
    else:
        log("M3", "POST /maps/locations (authenticated)", is_pass, f"Status: {r.status_code}, Response: {r.text[:100]}")
except Exception as e:
    log("M3", "POST /maps/locations (authenticated)", False, str(e))

# Test 4: GET /maps/locations/:id
if 'location_id' in locals():
    try:
        r = requests.get(f"{BASE_URL}/maps/locations/{location_id}", headers=HEADERS, timeout=5)
        is_pass = r.status_code == 200 and r.json().get("id") == location_id
        log("M4", "GET /maps/locations/:id", is_pass, f"Status: {r.status_code}")
    except Exception as e:
        log("M4", "GET /maps/locations/:id", False, str(e))

# Test 5: GET /maps/locations/:id (invalid)
try:
    r = requests.get(f"{BASE_URL}/maps/locations/{uuid.uuid4()}", headers=HEADERS, timeout=5)
    is_pass = r.status_code == 404
    log("M5", "GET /maps/locations/:id (404)", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("M5", "GET /maps/locations/:id (404)", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All maps tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
