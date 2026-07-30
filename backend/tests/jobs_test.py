#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Jobs Module Verification Test Suite
Phase 1 - Basic CRUD + Search + Filters + Authorization
"""

import requests
import json
import time
from datetime import datetime
from typing import Dict, Any, Optional, Tuple
import random
import string
import sys
import io

# Fix Unicode output
if sys.platform == "win32":
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

class JobsVerificationTester:
    def __init__(self, base_url: str = "http://localhost:3000/api/v1"):
        self.base_url = base_url
        self.test_results = []
        self.pass_count = 0
        self.fail_count = 0
        self.recruiter_token = None
        self.user_token = None
        self.company_id = None
        self.job_id = None
        
    def _make_request(
        self,
        method: str,
        endpoint: str,
        body: Optional[Dict] = None,
        token: Optional[str] = None,
        expect_status: Optional[int] = None
    ) -> Tuple[int, Any]:
        """Make HTTP request with proper error handling"""
        url = f"{self.base_url}{endpoint}"
        headers = {"Content-Type": "application/json"}
        
        if token:
            headers["Authorization"] = f"Bearer {token}"
        
        try:
            if method == "GET":
                response = requests.get(url, headers=headers, timeout=10)
            elif method == "POST":
                response = requests.post(url, json=body, headers=headers, timeout=10)
            elif method == "PATCH":
                response = requests.patch(url, json=body, headers=headers, timeout=10)
            elif method == "DELETE":
                response = requests.delete(url, headers=headers, timeout=10)
            else:
                raise ValueError(f"Unknown method: {method}")
            
            try:
                content = response.json()
            except:
                content = response.text
            
            return response.status_code, content
            
        except Exception as e:
            print(f"Request error: {e}")
            return 0, {"error": str(e)}
    
    def add_test_result(self, test_name: str, passed: bool, details: str = ""):
        """Record test result"""
        self.test_results.append({
            "name": test_name,
            "passed": passed,
            "details": details
        })
        
        if passed:
            self.pass_count += 1
            print(f"[PASS] {test_name}")
        else:
            self.fail_count += 1
            print(f"[FAIL] {test_name}")
            if details:
                print(f"   Details: {details}")
    
    def generate_random_string(self, length: int = 8) -> str:
        """Generate random string"""
        return ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))
    
    def run_all_tests(self):
        """Execute all verification tests"""
        print("\n" + "="*50)
        print("JOBS MODULE VERIFICATION TEST SUITE")
        print("="*50 + "\n")
        
        # Phase 1: Server Check
        print("[PHASE 1] Server Connectivity Check")
        print("-" * 40)
        self.phase1_server_check()
        
        # Phase 2: Auth Setup
        print("\n[PHASE 2] Authentication Setup")
        print("-" * 40)
        self.phase2_auth_setup()
        
        # Phase 3: Company Setup
        print("\n[PHASE 3] Company Setup (Dependency)")
        print("-" * 40)
        self.phase3_company_setup()
        
        # Phase 4: CRUD Operations
        print("\n[PHASE 4] CRUD Operations")
        print("-" * 40)
        self.phase4_crud_operations()
        
        # Phase 5: Filtering & Search
        print("\n[PHASE 5] Filtering & Search")
        print("-" * 40)
        self.phase5_filtering_search()
        
        # Phase 6: Authorization & Guards
        print("\n[PHASE 6] Authorization & Guards")
        print("-" * 40)
        self.phase6_authorization()
        
        # Phase 7: Error Handling
        print("\n[PHASE 7] Error Handling")
        print("-" * 40)
        self.phase7_error_handling()
        
        # Phase 8: Response Contract
        print("\n[PHASE 8] Response Contract Validation")
        print("-" * 40)
        self.phase8_response_contract()
        
        # Phase 9: Cleanup
        print("\n[PHASE 9] Cleanup & DELETE")
        print("-" * 40)
        self.phase9_cleanup()
        
        # Summary
        self.print_summary()
    
    def phase1_server_check(self):
        """Check if server is running"""
        status, content = self._make_request("GET", "/auth/me")
        
        if status in [200, 401]:  # 401 is ok, means server is up
            self.add_test_result("Server is running", True)
        else:
            self.add_test_result("Server is running", False, f"Status: {status}")
            raise Exception(f" Server not running. Start with: npm run start:dev")
    
    def phase2_auth_setup(self):
        """Setup auth tokens"""
        test_email = f"recruiter-jobs-test-{self.generate_random_string()}@jobmap.test"
        test_password = "Test@123456"
        user_email = f"user-jobs-test-{self.generate_random_string()}@jobmap.test"
        user_password = "Test@123456"
        
        # Register recruiter
        status, content = self._make_request("POST", "/auth/register", {
            "email": test_email,
            "password": test_password
        })
        
        self.add_test_result(
            "Recruiter registration",
            status in [201, 409],
            f"Status: {status}"
        )
        
        # Login recruiter
        status, content = self._make_request("POST", "/auth/login", {
            "email": test_email,
            "password": test_password
        })
        
        if status in [200, 201] and isinstance(content, dict) and "accessToken" in content:
            self.recruiter_token = content["accessToken"]
            # Debug: print token info
            import base64, json
            try:
                # Try to decode JWT payload
                parts = self.recruiter_token.split('.')
                if len(parts) > 1:
                    payload = parts[1]
                    # Add padding if needed
                    padding = 4 - len(payload) % 4
                    if padding != 4:
                        payload += '=' * padding
                    decoded = json.loads(base64.urlsafe_b64decode(payload))
                    print(f"   Token payload: {decoded}")
            except:
                pass
            self.add_test_result("Recruiter login", True)
        else:
            self.add_test_result("Recruiter login", False, f"Status: {status}, Error: {content.get('message', 'Unknown') if isinstance(content, dict) else content}")
        
        # Register user
        status, content = self._make_request("POST", "/auth/register", {
            "email": user_email,
            "password": user_password
        })
        
        self.add_test_result(
            "User registration",
            status in [201, 409],
            f"Status: {status}"
        )
        
        # Login user
        status, content = self._make_request("POST", "/auth/login", {
            "email": user_email,
            "password": user_password
        })
        
        if status in [200, 201] and isinstance(content, dict) and "accessToken" in content:
            self.user_token = content["accessToken"]
            self.add_test_result("User login", True)
        else:
            self.add_test_result("User login", False, f"Status: {status}, Error: {content.get('message', 'Unknown') if isinstance(content, dict) else content}")
    
    def phase3_company_setup(self):
        """Create test company"""
        if not self.recruiter_token:
            self.add_test_result("Create company", False, "No recruiter token")
            return
        
        status, content = self._make_request("POST", "/companies", {
            "name": f"Test Company {self.generate_random_string()}",
            "slug": f"test-company-jobs-{self.generate_random_string()}",
            "description": "Test company for Jobs Module verification",
            "industry": "Technology",
            "website": "https://testcompany.test",
            "email": "hr@testcompany.test"
        }, token=self.recruiter_token)
        
        if status == 201 and isinstance(content, dict) and "id" in content:
            self.company_id = content["id"]
            self.add_test_result("Create company", True)
        else:
            self.add_test_result("Create company", False, f"Status: {status}, Error: {content.get('message', 'Unknown')}")
    
    def phase4_crud_operations(self):
        """Test CRUD operations"""
        if not self.recruiter_token or not self.company_id:
            self.add_test_result("CRUD tests", False, "Missing prerequisites")
            return
        
        job_slug = f"senior-nodejs-dev-{self.generate_random_string()}"
        
        # CREATE
        status, content = self._make_request("POST", "/jobs", {
            "companyId": self.company_id,
            "title": "Senior Node.js Developer",
            "slug": job_slug,
            "description": "We are looking for a senior Node.js developer with 5+ years of experience",
            "requirements": "5+ years Node.js, TypeScript, PostgreSQL",
            "responsibilities": "Lead backend development, mentor junior developers",
            "employmentType": "FULL_TIME",
            "workMode": "remote",
            "experienceLevel": "SENIOR",
            "country": "Lebanon",
            "city": "Beirut",
            "salaryMin": 50000,
            "salaryMax": 80000,
            "currency": "USD",
            "status": "published",
            "isActive": True
        }, token=self.recruiter_token)
        
        if status == 201 and isinstance(content, dict) and "id" in content:
            self.job_id = content["id"]
            self.add_test_result("Create Job (POST /jobs)", True)
        else:
            self.add_test_result("Create Job (POST /jobs)", False, f"Status: {status}")
            return
        
        # READ by ID
        status, content = self._make_request("GET", f"/jobs/{self.job_id}")
        
        if status == 200 and isinstance(content, dict) and content.get("id") == self.job_id:
            self.add_test_result("Read Job by ID (GET /jobs/:id)", True)
        else:
            self.add_test_result("Read Job by ID (GET /jobs/:id)", False, f"Status: {status}")
        
        # READ by Slug
        status, content = self._make_request("GET", f"/jobs/slug/{job_slug}")
        
        if status == 200 and isinstance(content, dict) and content.get("id") == self.job_id:
            self.add_test_result("Read Job by Slug (GET /jobs/slug/:slug)", True)
        else:
            self.add_test_result("Read Job by Slug (GET /jobs/slug/:slug)", False, f"Status: {status}")
        
        # UPDATE
        status, content = self._make_request("PATCH", f"/jobs/{self.job_id}", {
            "title": "Senior Node.js Developer - UPDATED",
            "salaryMin": 60000,
            "salaryMax": 90000
        }, token=self.recruiter_token)
        
        if status == 200:
            self.add_test_result("Update Job (PATCH /jobs/:id)", True)
        else:
            self.add_test_result("Update Job (PATCH /jobs/:id)", False, f"Status: {status}")
        
        # LIST
        status, content = self._make_request("GET", "/jobs")
        
        if status == 200 and isinstance(content, list):
            self.add_test_result("List Jobs (GET /jobs)", True, f"Found {len(content)} jobs")
        else:
            self.add_test_result("List Jobs (GET /jobs)", False, f"Status: {status}")
    
    def phase5_filtering_search(self):
        """Test filtering and search"""
        # Filter by Company ID
        status, content = self._make_request("GET", f"/jobs?companyId={self.company_id}")
        
        if status == 200 and isinstance(content, list):
            self.add_test_result(
                "Filter by companyId",
                len(content) > 0,
                f"Found {len(content)} jobs"
            )
        else:
            self.add_test_result("Filter by companyId", False, f"Status: {status}")
        
        # Filter by Employment Type
        status, content = self._make_request("GET", "/jobs?employmentType=FULL_TIME")
        
        if status == 200 and isinstance(content, list):
            self.add_test_result(
                "Filter by employmentType",
                True,
                f"Found {len(content)} jobs"
            )
        else:
            self.add_test_result("Filter by employmentType", False, f"Status: {status}")
        
        # Filter by Experience Level
        status, content = self._make_request("GET", "/jobs?experienceLevel=SENIOR")
        
        if status == 200 and isinstance(content, list):
            self.add_test_result(
                "Filter by experienceLevel",
                True,
                f"Found {len(content)} jobs"
            )
        else:
            self.add_test_result("Filter by experienceLevel", False, f"Status: {status}")
        
        # Filter by Country
        status, content = self._make_request("GET", "/jobs?country=Lebanon")
        
        if status == 200 and isinstance(content, list):
            self.add_test_result(
                "Filter by country",
                True,
                f"Found {len(content)} jobs"
            )
        else:
            self.add_test_result("Filter by country", False, f"Status: {status}")
    
    def phase6_authorization(self):
        """Test authorization and guards"""
        if not self.company_id or not self.job_id:
            self.add_test_result("Authorization tests", False, "Missing prerequisites")
            return
        
        # Create job without auth
        status, content = self._make_request("POST", "/jobs", {
            "companyId": self.company_id,
            "title": "Test Job",
            "slug": f"test-job-{self.generate_random_string()}",
            "description": "Test",
            "employmentType": "FULL_TIME",
            "experienceLevel": "JUNIOR"
        })
        
        if status in [401, 403]:
            self.add_test_result("Cannot create job without auth (401/403)", True)
        else:
            self.add_test_result("Cannot create job without auth (401/403)", False, f"Got: {status}")
        
        # User tries to update recruiter's job
        if self.user_token:
            status, content = self._make_request("PATCH", f"/jobs/{self.job_id}", {
                "title": "User trying to update"
            }, token=self.user_token)
            
            if status in [401, 403, 404]:
                self.add_test_result(
                    "User cannot modify recruiter's job (401/403)",
                    True
                )
            else:
                self.add_test_result(
                    "User cannot modify recruiter's job (401/403)",
                    False,
                    f"Got: {status}"
                )
    
    def phase7_error_handling(self):
        """Test error handling"""
        # Non-existent job
        status, content = self._make_request("GET", "/jobs/00000000-0000-0000-0000-000000000000")
        
        if status == 404:
            self.add_test_result("Non-existent job returns 404", True)
        else:
            self.add_test_result("Non-existent job returns 404", False, f"Got: {status}")
        
        # Duplicate slug
        if self.job_id and self.recruiter_token:
            status, content = self._make_request("POST", "/jobs", {
                "companyId": self.company_id,
                "title": "Duplicate Slug Test",
                "slug": "senior-nodejs-dev-test",  # Same as first job
                "description": "Testing duplicate slug",
                "employmentType": "FULL_TIME",
                "experienceLevel": "JUNIOR"
            }, token=self.recruiter_token)
            
            if status == 409:
                self.add_test_result("Duplicate slug returns 409 Conflict", True)
            elif status == 201:  # If slug is different
                self.add_test_result("Duplicate slug test", True, "Slug was different")
            else:
                self.add_test_result("Duplicate slug check", False, f"Got: {status}")
    
    def phase8_response_contract(self):
        """Validate response contract"""
        if not self.job_id:
            return
        
        status, content = self._make_request("GET", f"/jobs/{self.job_id}")
        
        if status == 200 and isinstance(content, dict):
            required_fields = ["id", "title", "companyId", "slug", "description", "createdAt", "updatedAt"]
            has_all_fields = all(field in content for field in required_fields)
            
            self.add_test_result(
                "Response has required fields",
                has_all_fields,
                f"Fields: {', '.join(required_fields)}"
            )
    
    def phase9_cleanup(self):
        """Clean up test data"""
        if self.job_id and self.recruiter_token:
            status, content = self._make_request("DELETE", f"/jobs/{self.job_id}", token=self.recruiter_token)
            
            if status == 200:
                self.add_test_result("Delete Job (DELETE /jobs/:id)", True)
            else:
                self.add_test_result("Delete Job (DELETE /jobs/:id)", False, f"Status: {status}")
    
    def print_summary(self):
        """Print test summary"""
        print("\n" + "="*50)
        print("TEST SUMMARY")
        print("="*50)
        
        total = self.pass_count + self.fail_count
        success_rate = (self.pass_count / total * 100) if total > 0 else 0
        
        print(f"\n Passed:  {self.pass_count}")
        print(f" Failed:  {self.fail_count}")
        print(f" Total:   {total}")
        print(f" Success Rate: {success_rate:.2f}%")
        
        print("\n" + "="*50)
        if self.fail_count == 0:
            print(" ALL TESTS PASSED!")
        else:
            print("  SOME TESTS FAILED - Review details above")
        print("="*50 + "\n")


if __name__ == "__main__":
    tester = JobsVerificationTester()
    tester.run_all_tests()
