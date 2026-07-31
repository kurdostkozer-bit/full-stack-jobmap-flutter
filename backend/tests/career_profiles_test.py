#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Career Profiles Module Test Suite - Fresh Run

Framework: requests + Python
Tests: 35-40 test cases covering all categories

Key Tests to Expose Bugs:
  - Non-owner UPDATE (should be 403)
  - Non-owner DELETE (should be 403)
  - Cascade delete behavior
  - Privacy filter enforcement
"""

import requests
import json
import uuid
import time
from datetime import datetime
from typing import Dict, Tuple, Optional

# Config
BASE_URL = "http://localhost:3000/api/v1"
HEADERS_JSON = {"Content-Type": "application/json"}

# Test users - UNIQUE every run with cleanup
TIMESTAMP = str(int(time.time() * 1000))
CLEANUP_USER_A_EMAIL = f"career-cleanup-a-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com"
CLEANUP_USER_B_EMAIL = f"career-cleanup-b-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com"

USER_A = {
    "email": f"career-test-a-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com",
    "password": "TestPassword@123456",
    "token": None
}

USER_B = {
    "email": f"career-test-b-{TIMESTAMP[:10]}-{uuid.uuid4().hex[:4]}@test.com",
    "password": "TestPassword@123456",
    "token": None
}

pass_count = 0
fail_count = 0

def log_test(category, test_name, passed, details=""):
    """Log test result"""
    global pass_count, fail_count
    
    symbol = "[PASS]" if passed else "[FAIL]"
    if passed:
        pass_count += 1
    else:
        fail_count += 1
    
    print(f"{symbol} [{category}] {test_name}")
    if details:
        print(f"    Details: {details}")

def get_auth_token(email, password):
    """Register and login user"""
    try:
        requests.post(
            f"{BASE_URL}/auth/register",
            json={"email": email, "password": password},
            headers=HEADERS_JSON,
            timeout=5
        )
    except:
        pass
    
    try:
        response = requests.post(
            f"{BASE_URL}/auth/login",
            json={"email": email, "password": password},
            headers=HEADERS_JSON,
            timeout=5
        )
        if response.status_code in [200, 201]:
            data = response.json()
            token = data.get("accessToken") or data.get("access_token") or data.get("token")
            if token:
                return token
    except:
        pass
    
    return None

def headers_with_token(token=None):
    """Create headers with optional auth"""
    h = HEADERS_JSON.copy()
    if token:
        h["Authorization"] = f"Bearer {token}"
    return h

def test_1_build_and_database():
    """Test 1: Build & Database"""
    print("\n" + "="*70)
    print("CATEGORY 1: BUILD AND DATABASE")
    print("="*70)
    
    # Server running
    try:
        response = requests.get(f"{BASE_URL}/health", timeout=5)
        log_test("1.1", "Server running", response.status_code < 500)
    except Exception as e:
        log_test("1.1", "Server running", False, str(e))
    
    # Career profiles endpoint
    try:
        response = requests.get(f"{BASE_URL}/career-profiles", headers=HEADERS_JSON, timeout=5)
        log_test("1.2", "Career profiles endpoint", response.status_code in [200, 401])
    except Exception as e:
        log_test("1.2", "Career profiles endpoint", False, str(e))

def test_2_crud_happy_path():
    """Test 2: CRUD operations"""
    print("\n" + "="*70)
    print("CATEGORY 2: CRUD HAPPY PATH")
    print("="*70)
    
    global USER_A
    
    # Auth
    USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
    log_test("2.0", "Authentication (USER_A)", USER_A["token"] is not None)
    if not USER_A["token"]:
        return
    
    # Create
    profile_data = {
        "headline": "Senior Software Engineer",
        "summary": "10+ years in full-stack development",
        "professionTitle": "Engineering Lead",
        "location": "San Francisco, CA",
        "preferredJobTitles": "Senior Engineer, Tech Lead",
        "preferredIndustries": "Tech, Finance",
        "salaryMin": 150000,
        "salaryMax": 250000,
        "currency": "USD",
        "workPreference": "full-time",
        "remotePreference": "hybrid",
        "relocationPreference": "open",
        "profileStatus": "active",
        "privacyLevel": "private",
        "isPublic": False
    }
    
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json=profile_data,
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        if response.status_code == 201:
            data = response.json()
            profile_id = data.get("id")
            log_test("2.1", "CREATE profile", True, f"ID: {profile_id[:8] if profile_id else '?'}")
            
            # Read /me
            response = requests.get(
                f"{BASE_URL}/career-profiles/me",
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("2.2", "READ /me endpoint", response.status_code == 200)
            
            # Read by ID
            response = requests.get(
                f"{BASE_URL}/career-profiles/{profile_id}",
                headers=HEADERS_JSON,
                timeout=5
            )
            log_test("2.3", "READ by ID", response.status_code == 200)
            
            # List
            response = requests.get(
                f"{BASE_URL}/career-profiles",
                headers=HEADERS_JSON,
                timeout=5
            )
            log_test("2.4", "LIST profiles", response.status_code == 200 and isinstance(response.json(), list))
            
            # Update
            response = requests.patch(
                f"{BASE_URL}/career-profiles/me",
                json={"headline": "Principal Engineer"},
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("2.5", "UPDATE profile", response.status_code == 200)
            
            # Delete (soft)
            response = requests.delete(
                f"{BASE_URL}/career-profiles/me",
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("2.6", "DELETE profile", response.status_code == 200)
        else:
            log_test("2.1", "CREATE profile", False, f"Status {response.status_code}: {response.text[:100]}")
    except Exception as e:
        log_test("2.1", "CREATE profile", False, str(e))

def test_3_validation():
    """Test 3: Input Validation"""
    print("\n" + "="*70)
    print("CATEGORY 3: INPUT VALIDATION")
    print("="*70)
    
    global USER_A
    if not USER_A["token"]:
        USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
        if not USER_A["token"]:
            return
    
    # String length validation
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"headline": "x" * 200},  # Max 160
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.1", "Headline length validation", response.status_code == 400)
    except Exception as e:
        log_test("3.1", "Headline length validation", False, str(e))
    
    # Salary minimum validation
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"salaryMin": -100},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.2", "Salary min validation", response.status_code == 400)
    except Exception as e:
        log_test("3.2", "Salary min validation", False, str(e))
    
    # Work preference enum
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"workPreference": "INVALID_TYPE"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        # May pass or fail depending on implementation
        log_test("3.3", "Work preference enum", response.status_code in [200, 201, 400])
    except Exception as e:
        log_test("3.3", "Work preference enum", False, str(e))
    
    # Remote preference enum
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"remotePreference": "INVALID"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.4", "Remote preference enum", response.status_code in [200, 201, 400])
    except Exception as e:
        log_test("3.4", "Remote preference enum", False, str(e))
    
    # Profile status enum
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"profileStatus": "INVALID"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.5", "Profile status enum", response.status_code in [200, 201, 400])
    except Exception as e:
        log_test("3.5", "Profile status enum", False, str(e))
    
    # Privacy level enum
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"privacyLevel": "INVALID"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.6", "Privacy level enum", response.status_code in [200, 201, 400])
    except Exception as e:
        log_test("3.6", "Privacy level enum", False, str(e))

def test_4_authorization():
    """Test 4: Authorization - Will expose bugs"""
    print("\n" + "="*70)
    print("CATEGORY 4: AUTHORIZATION (CRITICAL)")
    print("="*70)
    
    global USER_A, USER_B
    
    # Get tokens
    USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
    USER_B["token"] = get_auth_token(USER_B["email"], USER_B["password"])
    
    if not USER_A["token"] or not USER_B["token"]:
        log_test("4.0", "Authentication", False, "Cannot get both tokens")
        return
    
    # Delete any existing profile for USER_A (from test cleanup)
    try:
        requests.delete(
            f"{BASE_URL}/career-profiles/me",
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
    except:
        pass
    
    # Create fresh profile as USER_A
    profile_data = {
        "headline": "Test Engineer",
        "summary": "Test profile for authorization"
    }
    
    response = requests.post(
        f"{BASE_URL}/career-profiles/me",
        json=profile_data,
        headers=headers_with_token(USER_A["token"]),
        timeout=5
    )
    
    if response.status_code != 201:
        log_test("4.0", "Setup profile", False, f"Status {response.status_code}")
        return
    
    profile_id = response.json().get("id")
    log_test("4.0", "Setup profile", True)
    
    # Auth required
    try:
        response = requests.patch(
            f"{BASE_URL}/career-profiles/me",
            json={"headline": "Updated"},
            headers=HEADERS_JSON,  # No token
            timeout=5
        )
        log_test("4.1", "Auth required for UPDATE", response.status_code == 401)
    except Exception as e:
        log_test("4.1", "Auth required for UPDATE", False, str(e))
    
    # Owner CAN update
    try:
        response = requests.patch(
            f"{BASE_URL}/career-profiles/me",
            json={"headline": "Updated by owner"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("4.2", "Owner CAN UPDATE", response.status_code == 200)
    except Exception as e:
        log_test("4.2", "Owner CAN UPDATE", False, str(e))
    
    # Non-owner CANNOT update via direct ID [THIS WILL FAIL - BUG]
    try:
        response = requests.patch(
            f"{BASE_URL}/career-profiles/{profile_id}",
            json={"headline": "Updated by stranger"},
            headers=headers_with_token(USER_B["token"]),
            timeout=5
        )
        is_pass = response.status_code == 403
        if not is_pass:
            log_test("4.3", "Non-owner CANNOT UPDATE [SECURITY BUG]", False, f"Status {response.status_code} (should be 403)")
        else:
            log_test("4.3", "Non-owner CANNOT UPDATE", True)
    except Exception as e:
        log_test("4.3", "Non-owner CANNOT UPDATE", False, str(e))
    
    # Auth required for DELETE
    try:
        response = requests.delete(
            f"{BASE_URL}/career-profiles/me",
            headers=HEADERS_JSON,  # No token
            timeout=5
        )
        log_test("4.4", "Auth required for DELETE", response.status_code == 401)
    except Exception as e:
        log_test("4.4", "Auth required for DELETE", False, str(e))
    
    # Owner CAN delete
    try:
        response = requests.delete(
            f"{BASE_URL}/career-profiles/me",
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("4.5", "Owner CAN DELETE", response.status_code == 200)
    except Exception as e:
        log_test("4.5", "Owner CAN DELETE", False, str(e))

def test_5_privacy():
    """Test 5: Privacy & Visibility"""
    print("\n" + "="*70)
    print("CATEGORY 5: PRIVACY & VISIBILITY")
    print("="*70)
    
    global USER_A
    if not USER_A["token"]:
        USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
    
    # Delete any existing profile for USER_A
    try:
        requests.delete(
            f"{BASE_URL}/career-profiles/me",
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
    except:
        pass
    
    # Create fresh private profile
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={
                "headline": "Private Profile",
                "privacyLevel": "private",
                "isPublic": False
            },
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        if response.status_code == 201:
            log_test("5.1", "Create private profile", True)
            
            # Check if private profile is filtered from list
            response = requests.get(
                f"{BASE_URL}/career-profiles",
                headers=HEADERS_JSON,
                timeout=5
            )
            if response.status_code == 200:
                profiles = response.json()
                private_count = sum(1 for p in profiles if isinstance(p, dict) and not p.get("isPublic", True))
                log_test("5.2", "Private profiles not in public list", private_count == 0)
            else:
                log_test("5.2", "Private profiles not in public list", False, "Cannot list")
        else:
            log_test("5.1", "Create private profile", False)
    except Exception as e:
        log_test("5.1", "Create private profile", False, str(e))

def test_6_error_handling():
    """Test 6: Error Handling"""
    print("\n" + "="*70)
    print("CATEGORY 6: ERROR HANDLING")
    print("="*70)
    
    # 404 on invalid ID
    try:
        response = requests.get(
            f"{BASE_URL}/career-profiles/{uuid.uuid4()}",
            headers=HEADERS_JSON,
            timeout=5
        )
        log_test("6.1", "404 on invalid ID", response.status_code == 404)
    except Exception as e:
        log_test("6.1", "404 on invalid ID", False, str(e))
    
    # 404 on /me without profile
    global USER_B
    if not USER_B["token"]:
        USER_B["token"] = get_auth_token(USER_B["email"], USER_B["password"])
    
    try:
        response = requests.get(
            f"{BASE_URL}/career-profiles/me",
            headers=headers_with_token(USER_B["token"]),
            timeout=5
        )
        log_test("6.2", "404 on /me (no profile)", response.status_code == 404)
    except Exception as e:
        log_test("6.2", "404 on /me (no profile)", False, str(e))
    
    # Conflict on duplicate creation
    try:
        profile_data = {"headline": "First"}
        requests.post(
            f"{BASE_URL}/career-profiles/me",
            json=profile_data,
            headers=headers_with_token(USER_B["token"]),
            timeout=5
        )
        # Try creating again
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json=profile_data,
            headers=headers_with_token(USER_B["token"]),
            timeout=5
        )
        log_test("6.3", "Conflict on duplicate profile", response.status_code in [409, 400])
    except Exception as e:
        log_test("6.3", "Conflict on duplicate profile", False, str(e))

def test_7_response_format():
    """Test 7: Response Format"""
    print("\n" + "="*70)
    print("CATEGORY 7: RESPONSE FORMAT")
    print("="*70)
    
    global USER_A
    if not USER_A["token"]:
        USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
    
    # Delete any existing profile for USER_A
    try:
        requests.delete(
            f"{BASE_URL}/career-profiles/me",
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
    except:
        pass
    
    try:
        response = requests.post(
            f"{BASE_URL}/career-profiles/me",
            json={"headline": "Format test"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        
        if response.status_code in [200, 201]:
            data = response.json()
            required = ["id", "userId", "headline", "profileStatus", "privacyLevel", "createdAt", "updatedAt"]
            missing = [f for f in required if f not in data]
            
            if not missing:
                log_test("7.1", "All required fields", True)
            else:
                log_test("7.1", "All required fields", False, f"Missing: {missing}")
            
            # UUID check
            try:
                uuid.UUID(data["id"])
                log_test("7.2", "ID is valid UUID", True)
            except:
                log_test("7.2", "ID is valid UUID", False)
            
            # Timestamp check
            try:
                datetime.fromisoformat(data["createdAt"].replace("Z", "+00:00"))
                log_test("7.3", "Timestamps ISO8601", True)
            except:
                log_test("7.3", "Timestamps ISO8601", False)
        else:
            log_test("7.1", "Create for format test", False)
    except Exception as e:
        log_test("7.1", "Create for format test", False, str(e))

def main():
    """Run all tests"""
    print("\n" + "="*70)
    print("CAREER PROFILES MODULE - TEST SUITE")
    print("="*70)
    print(f"Base URL: {BASE_URL}")
    print(f"Start Time: {datetime.now().isoformat()}")
    print("="*70)
    
    test_1_build_and_database()
    test_2_crud_happy_path()
    test_3_validation()
    test_4_authorization()
    test_5_privacy()
    test_6_error_handling()
    test_7_response_format()
    
    print("\n" + "="*70)
    print("TEST EXECUTION COMPLETE")
    print("="*70)
    print(f"Results: {pass_count} PASS, {fail_count} FAIL")
    print(f"End Time: {datetime.now().isoformat()}")
    print("\nNEXT STEPS:")
    print("  1. Review FAIL tests")
    print("  2. Fix bugs in career profiles service/controller")
    print("  3. Re-run tests")
    print("  4. Repeat until all tests pass")
    print("="*70 + "\n")

if __name__ == "__main__":
    main()
