#!/usr/bin/env pwsh

# Comprehensive Auth Module Testing

$API_URL = "http://localhost:3000/api/v1"
$testResults = @()

function Test-AuthEndpoint {
    param(
        [string]$testName,
        [string]$method,
        [string]$endpoint,
        [hashtable]$body,
        [string]$token,
        [int[]]$expectedStatus
    )
    
    $headers = @{"Content-Type"="application/json"}
    if ($token) {
        $headers["Authorization"] = "Bearer $token"
    }
    
    try {
        $params = @{
            Uri = "$API_URL$endpoint"
            Method = $method
            Headers = $headers
            UseBasicParsing = $true
            ErrorAction = "SilentlyContinue"
        }
        
        if ($body) {
            $params["Body"] = $body | ConvertTo-Json -Depth 10
        }
        
        $response = Invoke-WebRequest @params 2>&1
        $statusCode = $response.StatusCode
        $content = $response.Content
    }
    catch {
        if ($_.Exception.Response) {
            $statusCode = [int]$_.Exception.Response.StatusCode
            $stream = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $content = $reader.ReadToEnd()
            $reader.Close()
        }
    }
    
    $passed = $statusCode -in $expectedStatus
    $status = if ($passed) { "PASS" } else { "FAIL" }
    
    $result = @{
        name = $testName
        status = $status
        statusCode = $statusCode
        expected = $expectedStatus -join ","
        details = $content
    }
    
    $global:testResults += $result
    
    $color = if ($passed) { "Green" } else { "Red" }
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $testName : $status (Status: $statusCode)" -ForegroundColor $color
    
    return $response
}

Write-Host "`nAuth Module Comprehensive Testing`n" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Gray

# Generate unique test emails
$email1 = "test-$(Get-Random)@example.com"
$pass1 = "TestPassword123!"
$email2 = "test-$(Get-Random)@example.com"
$pass2 = "TestPassword456!"

Write-Host "Test Email 1: $email1`n" -ForegroundColor Gray

# ========== HAPPY PATH ==========
Write-Host "HAPPY PATH TESTS" -ForegroundColor Green
Write-Host "================`n"

$resp1 = Test-AuthEndpoint "Register User 1" "POST" "/auth/register" @{
    email = $email1
    password = $pass1
} "" @(200, 201)

if ($resp1.StatusCode -in @(200, 201)) {
    $user1 = $resp1.Content | ConvertFrom-Json
    $user1_id = $user1.user.id
    $token1_access = $user1.accessToken
    $token1_refresh = $user1.refreshToken
}

$resp2 = Test-AuthEndpoint "Register User 2" "POST" "/auth/register" @{
    email = $email2
    password = $pass2
} "" @(200, 201)

$resp3 = Test-AuthEndpoint "Login User 1" "POST" "/auth/login" @{
    email = $email1
    password = $pass1
} "" @(200)

$resp4 = Test-AuthEndpoint "Get Me (Protected)" "GET" "/auth/me" $null $token1_access @(200)

$resp5 = Test-AuthEndpoint "Refresh Token" "POST" "/auth/refresh-token" @{
    refreshToken = $token1_refresh
} "" @(200)

if ($resp5.StatusCode -eq 200) {
    $refreshed = $resp5.Content | ConvertFrom-Json
    $token1_access = $refreshed.accessToken
}

$resp6 = Test-AuthEndpoint "Change Password" "PATCH" "/auth/change-password" @{
    currentPassword = $pass1
    newPassword = "NewPassword789!"
    confirmPassword = "NewPassword789!"
} $token1_access @(200)

$resp7 = Test-AuthEndpoint "Login with New Password" "POST" "/auth/login" @{
    email = $email1
    password = "NewPassword789!"
} "" @(200)

$resp8 = Test-AuthEndpoint "Logout" "POST" "/auth/logout" $null $token1_access @(200)

# ========== VALIDATION TESTS ==========
Write-Host "`nVALIDATION TESTS" -ForegroundColor Yellow
Write-Host "================`n"

Test-AuthEndpoint "Invalid Email Format" "POST" "/auth/register" @{
    email = "invalid-email"
    password = "TestPassword123!"
} "" @(400)

Test-AuthEndpoint "Password Too Short" "POST" "/auth/register" @{
    email = "short@example.com"
    password = "short"
} "" @(400)

Test-AuthEndpoint "Empty Password" "POST" "/auth/register" @{
    email = "empty@example.com"
    password = ""
} "" @(400)

Test-AuthEndpoint "Duplicate Email" "POST" "/auth/register" @{
    email = $email1
    password = "AnotherPassword123!"
} "" @(409)

Test-AuthEndpoint "Wrong Password" "POST" "/auth/login" @{
    email = $email2
    password = "WrongPassword123!"
} "" @(401)

Test-AuthEndpoint "User Not Found" "POST" "/auth/login" @{
    email = "notfound@example.com"
    password = "AnyPassword123!"
} "" @(401)

# ========== AUTHORIZATION TESTS ==========
Write-Host "`nAUTHORIZATION TESTS" -ForegroundColor Magenta
Write-Host "===================`n"

Test-AuthEndpoint "Get Me - No Token" "GET" "/auth/me" $null "" @(401)

Test-AuthEndpoint "Get Me - Invalid Token" "GET" "/auth/me" $null "invalid.token.here" @(401)

Test-AuthEndpoint "Change Password - No Token" "PATCH" "/auth/change-password" @{
    currentPassword = $pass1
    newPassword = "NewPassword123!"
    confirmPassword = "NewPassword123!"
} "" @(401)

Test-AuthEndpoint "Change Password - Wrong Current" "PATCH" "/auth/change-password" @{
    currentPassword = "WrongPassword123!"
    newPassword = "NewPassword123!"
    confirmPassword = "NewPassword123!"
} $token1_access @(401)

# ========== SUMMARY ==========
Write-Host "`nSUMMARY" -ForegroundColor Cyan
Write-Host "=======" -ForegroundColor Gray

$passed = ($testResults | Where-Object { $_.status -eq "PASS" }).Count
$failed = ($testResults | Where-Object { $_.status -eq "FAIL" }).Count
$total = $testResults.Count

Write-Host "`nTotal Tests: $total"
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Failed: $failed" -ForegroundColor Red

if ($failed -eq 0) {
    Write-Host "`nALL TESTS PASSED!" -ForegroundColor Green
} else {
    Write-Host "`nFailed tests:" -ForegroundColor Red
    $testResults | Where-Object { $_.status -eq "FAIL" } | ForEach-Object {
        Write-Host "  - $($_.name): Expected $($_.expected), got $($_.statusCode)" -ForegroundColor Red
    }
}
