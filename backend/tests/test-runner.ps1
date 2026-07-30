#!/usr/bin/env pwsh

<#
.SYNOPSIS
Unified API Testing Framework for jobMap Backend
Handles error responses gracefully and documents all results

.DESCRIPTION
Tests API endpoints with proper error handling for 4xx/5xx responses.
Generates detailed reports for each test run.

.PARAMETER Module
The module to test (auth, jobs, companies, etc.)

.PARAMETER Verbose
Show detailed output
#>

param(
    [string]$Module = "auth",
    [switch]$Verbose
)

$ErrorActionPreference = "Continue"
$API_URL = "http://localhost:3000/api/v1"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$results = @()

# ============================================
# TEST INFRASTRUCTURE
# ============================================

function Write-TestHeader {
    param([string]$text)
    Write-Host "`n$('='*60)" -ForegroundColor Cyan
    Write-Host $text -ForegroundColor Cyan
    Write-Host $('='*60) -ForegroundColor Cyan
}

function Write-TestResult {
    param(
        [string]$name,
        [string]$status,
        [string]$details = ""
    )
    
    $colors = @{
        "PASS" = "Green"
        "FAIL" = "Red"
        "ERROR" = "Yellow"
    }
    
    $color = if ($status -eq "PASS") { "Green" } elseif ($status -eq "FAIL") { "Red" } else { "Yellow" }
    $icon = if ($status -eq "PASS") { "OK" } elseif ($status -eq "FAIL") { "XX" } else { "!!" }
    
    Write-Host "[$icon] $name : $status" -ForegroundColor $color
    if ($details -and $Verbose) {
        Write-Host "    └─ $details" -ForegroundColor Gray
    }
    
    $results += @{
        name = $name
        status = $status
        details = $details
        timestamp = Get-Date
    }
}

function Invoke-ApiRequest {
    param(
        [string]$method,
        [string]$endpoint,
        [psobject]$body = $null,
        [string]$token = $null,
        [int[]]$expectedStatus = @(200, 201)
    )
    
    $headers = @{"Content-Type" = "application/json"}
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
            $params["Body"] = $body | ConvertTo-Json -Depth 10
        }
        
        $response = Invoke-WebRequest @params
        $statusCode = $response.StatusCode
        $content = $response.Content
        $isError = $false
    }
    catch {
        if ($_.Exception.Response) {
            $statusCode = [int]$_.Exception.Response.StatusCode
            $stream = $_.Exception.Response.GetResponseStream()
            $reader = [System.IO.StreamReader]::new($stream)
            $content = $reader.ReadToEnd()
            $reader.Close()
            $isError = $false
        }
        else {
            return @{
                success = $false
                statusCode = 0
                content = $_.Exception.Message
                error = $true
            }
        }
    }
    
    return @{
        success = $statusCode -in $expectedStatus
        statusCode = $statusCode
        content = $content
        error = $false
    }
}

function Parse-JsonSafe {
    param([string]$json)
    try {
        return $json | ConvertFrom-Json
    }
    catch {
        return $null
    }
}

# ============================================
# AUTH MODULE TESTS
# ============================================

function Test-AuthModule {
    Write-TestHeader "Authentication Module Tests"
    
    # Setup test data
    $email1 = "test-$(Get-Random)@example.com"
    $password1 = "TestPassword123!"
    $email2 = "test-$(Get-Random)@example.com"
    $password2 = "TestPassword456!"
    
    Write-Host "Test Users:" -ForegroundColor Gray
    Write-Host "  1: $email1" -ForegroundColor Gray
    Write-Host "  2: $email2`n" -ForegroundColor Gray
    
    # ========== HAPPY PATH ==========
    Write-TestHeader "HAPPY PATH TESTS"
    
    # Test 1: Register
    $resp = Invoke-ApiRequest "POST" "/auth/register" @{
        email = $email1
        password = $password1
    }
    
    if ($resp.statusCode -in @(200, 201)) {
        $data = Parse-JsonSafe $resp.content
        $script:user1_id = $data.user.id
        $script:token1_access = $data.accessToken
        $script:token1_refresh = $data.refreshToken
        Write-TestResult "1. Register User 1" "PASS"
    }
    else {
        Write-TestResult "1. Register User 1" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 2: Register Second User
    $resp = Invoke-ApiRequest "POST" "/auth/register" @{
        email = $email2
        password = $password2
    }
    
    if ($resp.statusCode -in @(200, 201)) {
        $data = Parse-JsonSafe $resp.content
        $script:user2_id = $data.user.id
        Write-TestResult "2. Register User 2" "PASS"
    }
    else {
        Write-TestResult "2. Register User 2" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 3: Login
    $resp = Invoke-ApiRequest "POST" "/auth/login" @{
        email = $email1
        password = $password1
    } "" @(200)
    
    if ($resp.statusCode -eq 200) {
        $data = Parse-JsonSafe $resp.content
        $script:token1_access = $data.accessToken
        Write-TestResult "3. Login" "PASS"
    }
    else {
        Write-TestResult "3. Login" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 4: Get Me
    $resp = Invoke-ApiRequest "GET" "/auth/me" $null $script:token1_access @(200)
    
    if ($resp.statusCode -eq 200) {
        Write-TestResult "4. Get Me (Protected)" "PASS"
    }
    else {
        Write-TestResult "4. Get Me (Protected)" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 5: Refresh Token
    $resp = Invoke-ApiRequest "POST" "/auth/refresh-token" @{
        refreshToken = $script:token1_refresh
    } "" @(200)
    
    if ($resp.statusCode -eq 200) {
        Write-TestResult "5. Refresh Token" "PASS"
    }
    else {
        Write-TestResult "5. Refresh Token" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 6: Change Password
    $newPassword = "NewPassword789!"
    $resp = Invoke-ApiRequest "PATCH" "/auth/change-password" @{
        currentPassword = $password1
        newPassword = $newPassword
        confirmPassword = $newPassword
    } $script:token1_access @(200)
    
    if ($resp.statusCode -eq 200) {
        Write-TestResult "6. Change Password" "PASS"
    }
    else {
        Write-TestResult "6. Change Password" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 7: Login with New Password
    $resp = Invoke-ApiRequest "POST" "/auth/login" @{
        email = $email1
        password = $newPassword
    } "" @(200)
    
    if ($resp.statusCode -eq 200) {
        Write-TestResult "7. Login with New Password" "PASS"
    }
    else {
        Write-TestResult "7. Login with New Password" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 8: Logout
    $resp = Invoke-ApiRequest "POST" "/auth/logout" $null $script:token1_access @(200)
    
    if ($resp.statusCode -eq 200) {
        Write-TestResult "8. Logout" "PASS"
    }
    else {
        Write-TestResult "8. Logout" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # ========== VALIDATION TESTS ==========
    Write-TestHeader "VALIDATION TESTS"
    
    # Test 9: Invalid Email
    $resp = Invoke-ApiRequest "POST" "/auth/register" @{
        email = "invalid"
        password = "TestPassword123!"
    } "" @(400)
    
    if ($resp.statusCode -eq 400) {
        Write-TestResult "9. Invalid Email Format" "PASS"
    }
    else {
        Write-TestResult "9. Invalid Email Format" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 10: Short Password
    $resp = Invoke-ApiRequest "POST" "/auth/register" @{
        email = "newuser@example.com"
        password = "short"
    } "" @(400)
    
    if ($resp.statusCode -eq 400) {
        Write-TestResult "10. Password Too Short" "PASS"
    }
    else {
        Write-TestResult "10. Password Too Short" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 11: Duplicate Email
    $resp = Invoke-ApiRequest "POST" "/auth/register" @{
        email = $email1
        password = "AnotherPassword123!"
    } "" @(409)
    
    if ($resp.statusCode -eq 409) {
        Write-TestResult "11. Duplicate Email" "PASS"
    }
    else {
        Write-TestResult "11. Duplicate Email" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 12: Wrong Password
    $resp = Invoke-ApiRequest "POST" "/auth/login" @{
        email = $email2
        password = "WrongPassword123!"
    } "" @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "12. Wrong Password" "PASS"
    }
    else {
        Write-TestResult "12. Wrong Password" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 13: User Not Found
    $resp = Invoke-ApiRequest "POST" "/auth/login" @{
        email = "nonexistent@example.com"
        password = "AnyPassword123!"
    } "" @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "13. User Not Found" "PASS"
    }
    else {
        Write-TestResult "13. User Not Found" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # ========== AUTHORIZATION TESTS ==========
    Write-TestHeader "AUTHORIZATION TESTS"
    
    # Test 14: No Token
    $resp = Invoke-ApiRequest "GET" "/auth/me" $null "" @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "14. Get Me - No Token" "PASS"
    }
    else {
        Write-TestResult "14. Get Me - No Token" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 15: Invalid Token
    $resp = Invoke-ApiRequest "GET" "/auth/me" $null "invalid.token.here" @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "15. Get Me - Invalid Token" "PASS"
    }
    else {
        Write-TestResult "15. Get Me - Invalid Token" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 16: Change Password - No Token
    $resp = Invoke-ApiRequest "PATCH" "/auth/change-password" @{
        currentPassword = "AnyPassword123!"
        newPassword = "NewPassword123!"
        confirmPassword = "NewPassword123!"
    } "" @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "16. Change Password - No Token" "PASS"
    }
    else {
        Write-TestResult "16. Change Password - No Token" "FAIL" "Status: $($resp.statusCode)"
    }
    
    # Test 17: Change Password - Wrong Current
    $resp = Invoke-ApiRequest "PATCH" "/auth/change-password" @{
        currentPassword = "WrongPassword123!"
        newPassword = "NewPassword123!"
        confirmPassword = "NewPassword123!"
    } $script:token1_access @(401)
    
    if ($resp.statusCode -eq 401) {
        Write-TestResult "17. Change Password - Wrong Current" "PASS"
    }
    else {
        Write-TestResult "17. Change Password - Wrong Current" "FAIL" "Status: $($resp.statusCode)"
    }
}

# ============================================
# RESULTS SUMMARY
# ============================================

function Show-Summary {
    Write-TestHeader "TEST SUMMARY"
    
    $passed = ($results | Where-Object { $_.status -eq "PASS" }).Count
    $failed = ($results | Where-Object { $_.status -eq "FAIL" }).Count
    $errors = ($results | Where-Object { $_.status -eq "ERROR" }).Count
    $total = $results.Count
    
    Write-Host "Total:  $total" -ForegroundColor White
    Write-Host "Passed: $passed" -ForegroundColor Green
    Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
    Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -gt 0) { "Yellow" } else { "Green" })
    
    $successRate = if ($total -gt 0) { [math]::Round(($passed / $total) * 100, 1) } else { 0 }
    Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($successRate -eq 100) { "Green" } else { "Yellow" })
    
    if ($failed -eq 0 -and $errors -eq 0) {
        Write-Host "`n✓ ALL TESTS PASSED!" -ForegroundColor Green
    }
    else {
        Write-Host "`n✗ Some tests failed" -ForegroundColor Red
        if ($failed -gt 0) {
            Write-Host "`nFailed Tests:" -ForegroundColor Red
            $results | Where-Object { $_.status -eq "FAIL" } | ForEach-Object {
                Write-Host "  - $($_.name): $($_.details)" -ForegroundColor Red
            }
        }
    }
    
    # Save results to file
    $reportFile = "test-results-$Module-$timestamp.json"
    @{
        module = $Module
        timestamp = Get-Date -Format "o"
        summary = @{
            total = $total
            passed = $passed
            failed = $failed
            errors = $errors
            successRate = $successRate
        }
        results = $results
    } | ConvertTo-Json -Depth 10 | Out-File $reportFile
    
    Write-Host "`nResults saved to: $reportFile" -ForegroundColor Gray
}

# ============================================
# MAIN
# ============================================

Write-Host "`n🧪 jobMap API Test Runner" -ForegroundColor Cyan
Write-Host "Module: $Module" -ForegroundColor Gray
Write-Host "Server: $API_URL" -ForegroundColor Gray

switch ($Module.ToLower()) {
    "auth" { Test-AuthModule }
    default { Write-Host "Unknown module: $Module" -ForegroundColor Red; exit 1 }
}

Show-Summary

# Exit with appropriate code
$failed = ($results | Where-Object { $_.status -eq "FAIL" }).Count
exit $failed
