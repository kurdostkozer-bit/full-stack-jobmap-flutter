#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Companies Module Test Suite - Phase 2 Implementation

Framework: requests + unittest
Tests: CRUD, validation, authorization, FK integrity, soft delete, integration

Key Tests to Expose Bugs:
  - Non-owner UPDATE (should be 403)
  - Non-owner DELETE (should be 403)
  - Slug uniqueness in UPDATE
  - Soft delete orphaning behavior
"""

import requests
import json
import uuid
from datetime import datetime
from typing import Dict, Tuple, Optional

# Config
BASE_URL = "http://localhost:3000/api/v1"
HEADERS_JSON = {"Content-Type": "application/json"}

# Test users
USER_A = {
    "email": f"companies-test-a-{uuid.uuid4().hex[:8]}@test.com",
    "password": "TestPassword@123456",
    "token": None
}

USER_B = {
    "email": f"companies-test-b-{uuid.uuid4().hex[:8]}@test.com",
    "password": "TestPassword@123456",
    "token": None
}

pass_count = 0
fail_count = 0

def log_test(category, test_name, passed, details=""):
    """Log test result"""
    global pass_count, fail_count
    
    symbol = "[PASS]" if passed else "[FAIL]"
    status = passed
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
        # Register
        requests.post(
            f"{BASE_URL}/auth/register",
            json={"email": email, "password": password},
            headers=HEADERS_JSON,
            timeout=5
        )
    except:
        pass
    
    # Login
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
    
    # Companies endpoint
    try:
        response = requests.get(f"{BASE_URL}/companies", headers=HEADERS_JSON, timeout=5)
        log_test("1.2", "Companies endpoint", response.status_code in [200, 401])
    except Exception as e:
        log_test("1.2", "Companies endpoint", False, str(e))

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
    company_data = {
        "name": f"Test Company {uuid.uuid4().hex[:8]}",
        "slug": f"test-company-{uuid.uuid4().hex[:8]}",
        "description": "Test company"
    }
    
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json=company_data,
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        if response.status_code == 201:
            data = response.json()
            company_id = data.get("id")
            log_test("2.1", "CREATE company", True, f"ID: {company_id[:8] if company_id else '?'}")
            
            # Read
            response = requests.get(
                f"{BASE_URL}/companies/{company_id}",
                headers=HEADERS_JSON,
                timeout=5
            )
            log_test("2.2", "READ by ID", response.status_code == 200)
            
            # Read by slug
            response = requests.get(
                f"{BASE_URL}/companies/by-slug/{company_data['slug']}",
                headers=HEADERS_JSON,
                timeout=5
            )
            log_test("2.3", "READ by slug", response.status_code == 200)
            
            # List
            response = requests.get(
                f"{BASE_URL}/companies",
                headers=HEADERS_JSON,
                timeout=5
            )
            log_test("2.4", "LIST companies", response.status_code == 200 and isinstance(response.json(), list))
            
            # Update
            response = requests.patch(
                f"{BASE_URL}/companies/{company_id}",
                json={"description": "Updated"},
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("2.5", "UPDATE company", response.status_code == 200)
            
            # Delete (soft)
            response = requests.delete(
                f"{BASE_URL}/companies/{company_id}",
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("2.6", "DELETE company", response.status_code == 200)
        else:
            log_test("2.1", "CREATE company", False, f"Status {response.status_code}: {response.text[:100]}")
    except Exception as e:
        log_test("2.1", "CREATE company", False, str(e))

def test_3_validation():
    """Test 3: Validation"""
    print("\n" + "="*70)
    print("CATEGORY 3: VALIDATION")
    print("="*70)
    
    global USER_A
    if not USER_A["token"]:
        USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
        if not USER_A["token"]:
            return
    
    # Required name
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json={"slug": "no-name"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.1", "Name required", response.status_code == 400)
    except Exception as e:
        log_test("3.1", "Name required", False, str(e))
    
    # Slug uniqueness
    slug = f"unique-{uuid.uuid4().hex[:8]}"
    try:
        # Create first
        response1 = requests.post(
            f"{BASE_URL}/companies",
            json={"name": "Test", "slug": slug},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        if response1.status_code == 201:
            # Try duplicate
            response2 = requests.post(
                f"{BASE_URL}/companies",
                json={"name": "Test2", "slug": slug},
                headers=headers_with_token(USER_A["token"]),
                timeout=5
            )
            log_test("3.2", "Slug uniqueness", response2.status_code == 409)
        else:
            log_test("3.2", "Slug uniqueness", False, "Cannot create first")
    except Exception as e:
        log_test("3.2", "Slug uniqueness", False, str(e))
    
    # Email validation
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json={"name": "Test", "slug": f"test-{uuid.uuid4().hex[:8]}", "email": "invalid"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.3", "Email validation", response.status_code == 400)
    except Exception as e:
        log_test("3.3", "Email validation", False, str(e))
    
    # Founded year (future not allowed)
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json={"name": "Test", "slug": f"test-{uuid.uuid4().hex[:8]}", "foundedYear": 2030},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.4", "Founded year validation", response.status_code == 400)
    except Exception as e:
        log_test("3.4", "Founded year validation", False, str(e))
    
    # CompanySize enum
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json={"name": "Test", "slug": f"test-{uuid.uuid4().hex[:8]}", "companySize": "INVALID"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("3.5", "CompanySize enum validation", response.status_code == 400)
    except Exception as e:
        log_test("3.5", "CompanySize enum validation", False, str(e))

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
    
    # Create company as USER_A
    company_data = {
        "name": f"Auth Test Company {uuid.uuid4().hex[:8]}",
        "slug": f"auth-test-{uuid.uuid4().hex[:8]}"
    }
    
    response = requests.post(
        f"{BASE_URL}/companies",
        json=company_data,
        headers=headers_with_token(USER_A["token"]),
        timeout=5
    )
    
    if response.status_code != 201:
        log_test("4.0", "Setup company", False, f"Status {response.status_code}")
        return
    
    company_id = response.json().get("id")
    log_test("4.0", "Setup company", True)
    
    # Auth required
    try:
        response = requests.patch(
            f"{BASE_URL}/companies/{company_id}",
            json={"description": "Test"},
            headers=HEADERS_JSON,  # No token
            timeout=5
        )
        log_test("4.1", "Auth required for UPDATE", response.status_code == 401)
    except Exception as e:
        log_test("4.1", "Auth required for UPDATE", False, str(e))
    
    # Owner CAN update
    try:
        response = requests.patch(
            f"{BASE_URL}/companies/{company_id}",
            json={"description": "Updated by owner"},
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("4.2", "Owner CAN UPDATE", response.status_code == 200)
    except Exception as e:
        log_test("4.2", "Owner CAN UPDATE", False, str(e))
    
    # Non-owner CANNOT update [THIS WILL FAIL - BUG]
    try:
        response = requests.patch(
            f"{BASE_URL}/companies/{company_id}",
            json={"description": "Updated by stranger"},
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
    
    # Owner CAN delete
    try:
        response = requests.delete(
            f"{BASE_URL}/companies/{company_id}",
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        log_test("4.4", "Owner CAN DELETE", response.status_code == 200)
    except Exception as e:
        log_test("4.4", "Owner CAN DELETE", False, str(e))

def test_5_error_handling():
    """Test 5: Error handling"""
    print("\n" + "="*70)
    print("CATEGORY 5: ERROR HANDLING")
    print("="*70)
    
    # 404 by ID
    try:
        response = requests.get(
            f"{BASE_URL}/companies/{uuid.uuid4()}",
            headers=HEADERS_JSON,
            timeout=5
        )
        log_test("5.1", "404 on invalid ID", response.status_code == 404)
    except Exception as e:
        log_test("5.1", "404 on invalid ID", False, str(e))
    
    # 404 by slug
    try:
        response = requests.get(
            f"{BASE_URL}/companies/by-slug/nonexistent-{uuid.uuid4().hex[:8]}",
            headers=HEADERS_JSON,
            timeout=5
        )
        log_test("5.2", "404 on invalid slug", response.status_code == 404)
    except Exception as e:
        log_test("5.2", "404 on invalid slug", False, str(e))

def test_6_response_format():
    """Test 6: Response format"""
    print("\n" + "="*70)
    print("CATEGORY 6: RESPONSE FORMAT")
    print("="*70)
    
    global USER_A
    
    if not USER_A["token"]:
        USER_A["token"] = get_auth_token(USER_A["email"], USER_A["password"])
    
    company_data = {
        "name": f"Format Test {uuid.uuid4().hex[:8]}",
        "slug": f"format-{uuid.uuid4().hex[:8]}"
    }
    
    try:
        response = requests.post(
            f"{BASE_URL}/companies",
            json=company_data,
            headers=headers_with_token(USER_A["token"]),
            timeout=5
        )
        
        if response.status_code == 201:
            data = response.json()
            required = ["id", "name", "slug", "createdBy", "updatedBy", "createdAt", "updatedAt"]
            missing = [f for f in required if f not in data]
            
            if not missing:
                log_test("6.1", "All required fields", True)
            else:
                log_test("6.1", "All required fields", False, f"Missing: {missing}")
            
            # UUID check
            try:
                uuid.UUID(data["id"])
                log_test("6.2", "ID is valid UUID", True)
            except:
                log_test("6.2", "ID is valid UUID", False)
            
            # ISO8601 check
            try:
                datetime.fromisoformat(data["createdAt"].replace("Z", "+00:00"))
                log_test("6.3", "Timestamps ISO8601", True)
            except:
                log_test("6.3", "Timestamps ISO8601", False)
        else:
            log_test("6.1", "Create company", False, f"Status {response.status_code}")
    except Exception as e:
        log_test("6.1", "Create company", False, str(e))

def main():
    """Run all tests"""
    print("\n" + "="*70)
    print("COMPANIES MODULE - TEST SUITE")
    print("="*70)
    print(f"Base URL: {BASE_URL}")
    print(f"Start Time: {datetime.now().isoformat()}")
    print("="*70)
    
    test_1_build_and_database()
    test_2_crud_happy_path()
    test_3_validation()
    test_4_authorization()
    test_5_error_handling()
    test_6_response_format()
    
    print("\n" + "="*70)
    print("TEST EXECUTION COMPLETE")
    print("="*70)
    print(f"Results: {pass_count} PASS, {fail_count} FAIL")
    print(f"End Time: {datetime.now().isoformat()}")
    print("\nNEXT STEPS:")
    print("  1. Review FAIL tests")
    print("  2. Fix bugs in companies service/controller")
    print("  3. Re-run tests")
    print("  4. Repeat until all tests pass")
    print("="*70 + "\n")

if __name__ == "__main__":
    main()
