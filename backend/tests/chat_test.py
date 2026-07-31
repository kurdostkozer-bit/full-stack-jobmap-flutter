#!/usr/bin/env python3
"""
Chat Module - Quick Test
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

print("="*70)
print("CHAT MODULE - TEST")
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
    # User 1
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"chat-a-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN_A = r.json()["accessToken"]
    USER_A = r.json()["user"]["id"]
    
    # User 2
    r = requests.post(f"{BASE_URL}/auth/register",
        json={"email": f"chat-b-{uuid.uuid4().hex[:6]}@test.com", "password": "TestPass1234"},
        headers=HEADERS, timeout=5)
    TOKEN_B = r.json()["accessToken"]
    USER_B = r.json()["user"]["id"]
    
    print(f"✓ Users registered")
except Exception as e:
    print(f"✗ Setup failed: {e}")
    exit(1)

# Tests
print("\n" + "="*70)
print("TESTS")
print("="*70)

# Test 1: POST /chat/conversations (create)
try:
    r = requests.post(f"{BASE_URL}/chat/conversations",
        json={"participantIds": [USER_A, USER_B]},
        headers=h(TOKEN_A), timeout=5)
    is_pass = r.status_code in [200, 201]
    if is_pass:
        conv_id = r.json().get("id")
        log("C1", "POST /chat/conversations", is_pass, f"Status: {r.status_code}, ID: {conv_id[:8]}")
    else:
        log("C1", "POST /chat/conversations", is_pass, f"Status: {r.status_code}, Response: {r.text[:100]}")
except Exception as e:
    log("C1", "POST /chat/conversations", False, str(e))

# Test 2: GET /chat/conversations/user/:userId
try:
    r = requests.get(f"{BASE_URL}/chat/conversations/user/{USER_A}",
        headers=h(TOKEN_A), timeout=5)
    is_pass = r.status_code == 200 and isinstance(r.json(), list)
    log("C2", "GET /chat/conversations/user/:userId", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("C2", "GET /chat/conversations/user/:userId", False, str(e))

# Test 3: GET /chat/conversations/:id
if 'conv_id' in locals():
    try:
        r = requests.get(f"{BASE_URL}/chat/conversations/{conv_id}",
            headers=h(TOKEN_A), timeout=5)
        is_pass = r.status_code == 200
        log("C3", "GET /chat/conversations/:id", is_pass, f"Status: {r.status_code}")
    except Exception as e:
        log("C3", "GET /chat/conversations/:id", False, str(e))

# Test 4: POST /chat/messages (send message)
if 'conv_id' in locals():
    try:
        r = requests.post(f"{BASE_URL}/chat/messages",
            json={"conversationId": conv_id, "content": "Hello!"},
            headers=h(TOKEN_A), timeout=5)
        is_pass = r.status_code in [200, 201]
        log("C4", "POST /chat/messages", is_pass, f"Status: {r.status_code}")
    except Exception as e:
        log("C4", "POST /chat/messages", False, str(e))

# Test 5: 401 on unauthenticated
try:
    r = requests.get(f"{BASE_URL}/chat/conversations/user/{USER_A}",
        headers=HEADERS, timeout=5)
    is_pass = r.status_code == 401
    log("C5", "401 on unauthenticated", is_pass, f"Status: {r.status_code}")
except Exception as e:
    log("C5", "401 on unauthenticated", False, str(e))

print("\n" + "="*70)
print(f"SUMMARY: {PASS} pass, {FAIL} fail")
print("="*70)
if FAIL == 0:
    print("✅ All tests passed!")
else:
    print(f"⚠️  {FAIL} failures")
