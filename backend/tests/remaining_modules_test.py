#!/usr/bin/env python3
"""
Remaining Modules - Fast Smoke Tests
Tests: Notifications, Chat, Saved Jobs, Departments
"""

import requests
import uuid

BASE_URL = "http://localhost:3000/api/v1"
HEADERS = {"Content-Type": "application/json"}

def test_module(name, endpoints):
    """Test a module's key endpoints"""
    print(f"\n{name}:")
    passed = 0
    for method, endpoint, should_exist in endpoints:
        try:
            if method == "GET":
                r = requests.get(f"{BASE_URL}{endpoint}", headers=HEADERS, timeout=5)
            elif method == "POST":
                r = requests.post(f"{BASE_URL}{endpoint}", json={}, headers=HEADERS, timeout=5)
            else:
                r = requests.patch(f"{BASE_URL}{endpoint}", json={}, headers=HEADERS, timeout=5)
            
            if should_exist:
                is_ok = r.status_code in [200, 201, 400, 401, 403]  # Any response except 404
                symbol = "✓" if is_ok else "✗"
                print(f"  {symbol} {method} {endpoint}: {r.status_code}")
                if is_ok:
                    passed += 1
            else:
                # Should not exist
                is_ok = r.status_code == 404
                symbol = "✓" if is_ok else "✗"
                print(f"  {symbol} {method} {endpoint}: {r.status_code} (should be 404)")
                if is_ok:
                    passed += 1
        except Exception as e:
            print(f"  ✗ {method} {endpoint}: ERROR - {str(e)[:50]}")
    
    return passed, len(endpoints)

print("="*70)
print("REMAINING MODULES - SMOKE TEST")
print("="*70)

results = {}

# Notifications
results["Notifications"] = test_module("Notifications", [
    ("GET", "/notifications", True),
    ("GET", "/notifications/123e4567-e89b-12d3-a456-426614174000", True),
    ("POST", "/notifications", True),
])

# Chat
results["Chat"] = test_module("Chat", [
    ("GET", "/chat/conversations", True),
    ("POST", "/chat/conversations", True),
    ("GET", "/chat/messages/conv-123", True),
])

# Saved Jobs
results["Saved Jobs"] = test_module("Saved Jobs", [
    ("GET", "/saved-jobs", True),
    ("POST", "/saved-jobs", True),
    ("DELETE", "/saved-jobs/123e4567-e89b-12d3-a456-426614174000", True),
])

# Departments
results["Departments"] = test_module("Departments", [
    ("GET", "/departments", True),
    ("GET", "/departments/123e4567-e89b-12d3-a456-426614174000", True),
    ("POST", "/departments", True),
])

print("\n" + "="*70)
print("SUMMARY")
print("="*70)
total_pass = 0
total_tests = 0
for module, (passed, total) in results.items():
    total_pass += passed
    total_tests += total
    pct = (passed / total * 100) if total > 0 else 0
    print(f"{module}: {passed}/{total} ({pct:.0f}%)")

print(f"\nTotal: {total_pass}/{total_tests} ({total_pass/total_tests*100:.0f}%)")
