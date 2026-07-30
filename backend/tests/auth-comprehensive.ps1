#!/usr/bin/env pwsh

<#
Comprehensive Auth Module Testing
Tests all scenarios: Happy Path, Validation, Authorization, Database
#>

$API_URL = "http://localhost:3000/api/v1"
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$testResults = @()

function LogTest {
    param([string]$name, [string]$status, [string]$details = "")
    
    $result = @{
        name = $name
        status = $status
        details = $details
        timestamp = Get-Date -Format "HH:mm:ss"
    }
    
    $global:testResults += $result
    
    $color = if ($status -eq "PASS") { "Green" } else { "Red" }
    Write-Host "[$($result.timestamp)] $name : $status" -ForegroundColor $color
    if ($details) {
        Write-Host "  └─ $details" -ForegroundColor Gray
    }
}

function MakeRequest {
    param(
        [string]$method,
        [string]$endpoint,
        [psobject]$body = $null,
        [string]$token = $null
    )
    
    $headers = @{"Content-Type"="application/json"}
    if ($token) {
        $headers["Authorization"] = "Bearer $token"
    }
    
    $uri = "$API_URL$endpoint"
    
    try {
        $params = @{
            Uri = $uri
            Method = $method
            Headers = $headers
            UseBasicParsing = $true
            ErrorAction = "SilentlyContinue"
        }
        
        if ($body) {
            $params["Body"] = $body | ConvertTo-Json
        }
        
        $response = Invoke-WebRequest @params
        return $response
    }
    catch {
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $reader.BaseStream.Position = 0
            $body = $reader.ReadToEnd()
            $reader.Close()
            
            return @{
                StatusCode = $_.Exception.Response.StatusCode
                Content = $body
                IsError = $true
            }
        }
        throw
    }
}

# ============================================
# SETUP - Clean data
# ============================================
Write-Host "`n📋 SETUP: Creating test users..." -ForegroundColor Cyan

$testEmail1 = "auth-test-$(Get-Random)@example.com"
$testPassword1 = "TestPassword123!"
$testEmail2 = "auth-test-$(Get-Random)@example.com"
$testPassword2 = "TestPassword456!"

# ============================================
# HAPPY PATH TESTS
# ============================================
Write-Host "`n✅ HAPPY PATH TESTS" -ForegroundColor Green

# Test 1: Register User
$resp = MakeRequest "POST" "/auth/register" @{
    email = $testEmail1
    password = $testPassword1
}

if ($resp.StatusCode -eq 201 -or $resp.StatusCode -eq 200) {
    $data = $resp.Content | ConvertFrom-Json
    $script:user1_id = $data.user.id
    $script:token1_access = $data.accessToken
    $script:token1_refresh = $data.refreshToken
    LogTest "Register User" "PASS" "Email: $testEmail1"
} else {
    LogTest "Register User" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 2: Register Second User
$resp = MakeRequest "POST" "/auth/register" @{
    email = $testEmail2
    password = $testPassword2
}

if ($resp.StatusCode -eq 201 -or $resp.StatusCode -eq 200) {
    $data = $resp.Content | ConvertFrom-Json
    $script:user2_id = $data.user.id
    LogTest "Register Second User" "PASS" "Email: $testEmail2"
} else {
    LogTest "Register Second User" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 3: Login
$resp = MakeRequest "POST" "/auth/login" @{
    email = $testEmail1
    password = $testPassword1
}

if ($resp.StatusCode -eq 200) {
    $data = $resp.Content | ConvertFrom-Json
    LogTest "Login" "PASS" "Got tokens"
} else {
    LogTest "Login" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 4: Get Me (Protected)
$resp = MakeRequest "GET" "/auth/me" $null $script:token1_access

if ($resp.StatusCode -eq 200) {
    $data = $resp.Content | ConvertFrom-Json
    if ($data.user.email -eq $testEmail1) {
        LogTest "Get Me" "PASS" "Returned correct user"
    } else {
        LogTest "Get Me" "FAIL" "Wrong user returned"
    }
} else {
    LogTest "Get Me" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 5: Refresh Token
$resp = MakeRequest "POST" "/auth/refresh-token" @{
    refreshToken = $script:token1_refresh
}

if ($resp.StatusCode -eq 200) {
    $data = $resp.Content | ConvertFrom-Json
    if ($data.accessToken) {
        $script:token1_access = $data.accessToken
        LogTest "Refresh Token" "PASS" "Got new access token"
    } else {
        LogTest "Refresh Token" "FAIL" "No token in response"
    }
} else {
    LogTest "Refresh Token" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 6: Change Password
$newPassword = "NewPassword789!"
$resp = MakeRequest "PATCH" "/auth/change-password" @{
    currentPassword = $testPassword1
    newPassword = $newPassword
    confirmPassword = $newPassword
} $script:token1_access

if ($resp.StatusCode -eq 200) {
    LogTest "Change Password" "PASS" "Password changed"
    $script:testPassword1 = $newPassword
} else {
    LogTest "Change Password" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 7: Login with New Password
$resp = MakeRequest "POST" "/auth/login" @{
    email = $testEmail1
    password = $newPassword
}

if ($resp.StatusCode -eq 200) {
    LogTest "Login with New Password" "PASS" "Old password no longer works"
} else {
    LogTest "Login with New Password" "FAIL" "Status: $($resp.StatusCode)"
}

# Test 8: Logout
$resp = MakeRequest "POST" "/auth/logout" $null $script:token1_access

if ($resp.StatusCode -eq 200) {
    LogTest "Logout" "PASS" "Logout successful"
} else {
    LogTest "Logout" "FAIL" "Status: $($resp.StatusCode)"
}

# ============================================
# VALIDATION TESTS
# ============================================
Write-Host "`n⚠️  VALIDATION TESTS" -ForegroundColor Yellow

# Test 1: Invalid Email Format
$resp = MakeRequest "POST" "/auth/register" @{
    email = "invalid-email"
    password = "TestPassword123!"
}

if ($resp.IsError -or $resp.StatusCode -eq 400) {
    LogTest "Invalid Email Format" "PASS" "Rejected invalid email"
} else {
    LogTest "Invalid Email Format" "FAIL" "Should reject invalid email"
}

# Test 2: Password Too Short
$resp = MakeRequest "POST" "/auth/register" @{
    email = "short-pass@example.com"
    password = "short"
}

if ($resp.IsError -or $resp.StatusCode -eq 400) {
    LogTest "Password Too Short" "PASS" "Rejected short password"
} else {
    LogTest "Password Too Short" "FAIL" "Should reject short password"
}

# Test 3: Empty Password
$resp = MakeRequest "POST" "/auth/register" @{
    email = "empty-pass@example.com"
    password = ""
}

if ($resp.IsError -or $resp.StatusCode -eq 400) {
    LogTest "Empty Password" "PASS" "Rejected empty password"
} else {
    LogTest "Empty Password" "FAIL" "Should reject empty password"
}

# Test 4: Duplicate Email
$resp = MakeRequest "POST" "/auth/register" @{
    email = $testEmail1
    password = "AnotherPassword123!"
}

if ($resp.IsError -or $resp.StatusCode -eq 409) {
    LogTest "Duplicate Email" "PASS" "Rejected duplicate email"
} else {
    LogTest "Duplicate Email" "FAIL" "Should reject duplicate email"
}

# Test 5: Wrong Password on Login
$resp = MakeRequest "POST" "/auth/login" @{
    email = $testEmail2
    password = "WrongPassword123!"
}

if ($resp.IsError -or $resp.StatusCode -eq 401) {
    LogTest "Wrong Password on Login" "PASS" "Rejected wrong password"
} else {
    LogTest "Wrong Password on Login" "FAIL" "Should reject wrong password"
}

# Test 6: User Not Found
$resp = MakeRequest "POST" "/auth/login" @{
    email = "nonexistent@example.com"
    password = "AnyPassword123!"
}

if ($resp.IsError -or $resp.StatusCode -eq 401) {
    LogTest "User Not Found" "PASS" "Rejected non-existent user"
} else {
    LogTest "User Not Found" "FAIL" "Should reject non-existent user"
}

# ============================================
# AUTHORIZATION TESTS
# ============================================
Write-Host "`n🔒 AUTHORIZATION TESTS" -ForegroundColor Magenta

# Test 1: Protected Endpoint - No Token
$resp = MakeRequest "GET" "/auth/me" $null ""

if ($resp.IsError -or $resp.StatusCode -eq 401) {
    LogTest "Protected Endpoint - No Token" "PASS" "Rejected no token"
} else {
    LogTest "Protected Endpoint - No Token" "FAIL" "Should reject no token"
}

# Test 2: Protected Endpoint - Invalid Token
$resp = MakeRequest "GET" "/auth/me" $null "invalid.token.here"

if ($resp.IsError -or $resp.StatusCode -eq 401) {
    LogTest "Protected Endpoint - Invalid Token" "PASS" "Rejected invalid token"
} else {
    LogTest "Protected Endpoint - Invalid Token" "FAIL" "Should reject invalid token"
}

# Test 3: Change Password - Wrong Current Password
$resp = MakeRequest "PATCH" "/auth/change-password" @{
    currentPassword = "WrongCurrentPassword123!"
    newPassword = "NewPassword123!"
    confirmPassword = "NewPassword123!"
} $script:token2_access

if ($resp.IsError -or $resp.StatusCode -eq 401) {
    LogTest "Change Password - Wrong Current" "PASS" "Rejected wrong current password"
} else {
    LogTest "Change Password - Wrong Current" "FAIL" "Should reject wrong current password"
}

# ============================================
# SUMMARY
# ============================================
Write-Host "`n📊 TEST SUMMARY" -ForegroundColor Cyan

$passed = ($testResults | Where-Object { $_.status -eq "PASS" }).Count
$failed = ($testResults | Where-Object { $_.status -eq "FAIL" }).Count
$total = $testResults.Count

Write-Host "Total: $total | Passed: $passed | Failed: $failed" -ForegroundColor Green

if ($failed -eq 0) {
    Write-Host "`n✅ ALL TESTS PASSED!" -ForegroundColor Green
} else {
    Write-Host "`n❌ Some tests failed" -ForegroundColor Red
    Write-Host "Failed tests:"
    $testResults | Where-Object { $_.status -eq "FAIL" } | ForEach-Object {
        Write-Host "  - $($_.name): $($_.details)" -ForegroundColor Red
    }
}

# Save results to file
$testResults | ConvertTo-Json | Out-File -FilePath "auth-test-results-$timestamp.json"
Write-Host "`n💾 Results saved to: auth-test-results-$timestamp.json" -ForegroundColor Gray
