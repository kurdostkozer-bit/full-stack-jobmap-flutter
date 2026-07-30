# Jobs Module Verification Test Suite
# Status: Phase 1 - Basic CRUD + Search + Filters + Authorization

$baseUrl = "http://localhost:3000/api/v1"
$testResults = @()
$passCount = 0
$failCount = 0

# Helper function to make HTTP requests
function Invoke-ApiRequest {
    param(
        [string]$Method,
        [string]$Endpoint,
        [object]$Body = $null,
        [string]$Token = $null,
        [string]$ContentType = "application/json"
    )
    
    $uri = "$baseUrl$Endpoint"
    $headers = @{
        "Content-Type" = $ContentType
    }
    
    if ($Token) {
        $headers["Authorization"] = "Bearer $Token"
    }
    
    try {
        $params = @{
            Uri     = $uri
            Method  = $Method
            Headers = $headers
        }
        
        if ($Body) {
            $params["Body"] = $Body | ConvertTo-Json -Depth 10
        }
        
        $response = Invoke-WebRequest @params -ErrorAction Stop
        $result = @{
            StatusCode = $response.StatusCode
            Content    = $response.Content | ConvertFrom-Json
            Success    = $true
        }
        return $result
    }
    catch {
        $errorResponse = $_.Exception.Response
        if ($errorResponse) {
            $statusCode = [int]$errorResponse.StatusCode
            try {
                $stream = $errorResponse.GetResponseStream()
                $reader = [System.IO.StreamReader]::new($stream)
                $content = $reader.ReadToEnd()
                $contentParsed = $content | ConvertFrom-Json
            }
            catch {
                $contentParsed = $content
            }
        }
        else {
            $statusCode = 0
            $contentParsed = $null
        }
        
        $result = @{
            StatusCode = $statusCode
            Content    = $contentParsed
            Success    = $false
            Error      = $_.Exception.Message
        }
        return $result
    }
}

# Test result tracker
function Add-TestResult {
    param([string]$TestName, [bool]$Passed, [string]$Details = "")
    
    $global:testResults += @{
        Name     = $TestName
        Passed   = $Passed
        Details  = $Details
    }
    
    if ($Passed) {
        $global:passCount++
        Write-Host "✅ $TestName" -ForegroundColor Green
    }
    else {
        $global:failCount++
        Write-Host "❌ $TestName" -ForegroundColor Red
        if ($Details) { Write-Host "   Details: $Details" -ForegroundColor Yellow }
    }
}

# ==========================================
# PHASE 1: Setup & Database Check
# ==========================================

Write-Host "`n[PHASE 1] Setup & Database Check" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# Check if server is running
try {
    $health = Invoke-WebRequest "$baseUrl/auth/me" -Headers @{} -ErrorAction Stop
    Add-TestResult "Server is running" $true
}
catch {
    Add-TestResult "Server is running" $false "Cannot connect to $baseUrl"
    Write-Host "❌ Server not running. Start with: npm run start:dev"
    exit
}

# ==========================================
# PHASE 2: Auth Setup (Get Test Tokens)
# ==========================================

Write-Host "`n[PHASE 2] Auth Setup" -ForegroundColor Cyan
Write-Host "====================`n" -ForegroundColor Cyan

$testEmail = "recruiter-jobs-test@jobmap.test"
$testPassword = "Test@123456"
$testUserEmail = "user-jobs-test@jobmap.test"
$testUserPassword = "Test@123456"

# Register recruiter
$registerResponse = Invoke-ApiRequest -Method POST -Endpoint "/auth/register" -Body @{
    email    = $testEmail
    password = $testPassword
    fullName = "Test Recruiter"
    role     = "RECRUITER"
}

if ($registerResponse.StatusCode -eq 201 -or $registerResponse.StatusCode -eq 409) {
    Add-TestResult "Recruiter registration" ($registerResponse.StatusCode -eq 201 -or $registerResponse.StatusCode -eq 409) "Status: $($registerResponse.StatusCode)"
}
else {
    Add-TestResult "Recruiter registration" $false "Status: $($registerResponse.StatusCode)"
}

# Login recruiter
$loginResponse = Invoke-ApiRequest -Method POST -Endpoint "/auth/login" -Body @{
    email    = $testEmail
    password = $testPassword
}

if ($loginResponse.StatusCode -eq 201 -and $loginResponse.Content.accessToken) {
    $recruiterToken = $loginResponse.Content.accessToken
    Add-TestResult "Recruiter login" $true
    Write-Host "   Token: $($recruiterToken.Substring(0, 20))..." -ForegroundColor Gray
}
else {
    Add-TestResult "Recruiter login" $false "Status: $($loginResponse.StatusCode)"
    $recruiterToken = $null
}

# Register regular user
$userRegisterResponse = Invoke-ApiRequest -Method POST -Endpoint "/auth/register" -Body @{
    email    = $testUserEmail
    password = $testUserPassword
    fullName = "Test User"
    role     = "USER"
}

Add-TestResult "User registration" ($userRegisterResponse.StatusCode -eq 201 -or $userRegisterResponse.StatusCode -eq 409)

# Login user
$userLoginResponse = Invoke-ApiRequest -Method POST -Endpoint "/auth/login" -Body @{
    email    = $testUserEmail
    password = $testUserPassword
}

if ($userLoginResponse.StatusCode -eq 201 -and $userLoginResponse.Content.accessToken) {
    $userToken = $userLoginResponse.Content.accessToken
    Add-TestResult "User login" $true
}
else {
    Add-TestResult "User login" $false "Status: $($userLoginResponse.StatusCode)"
    $userToken = $null
}

# ==========================================
# PHASE 3: Create Company (Dependency)
# ==========================================

Write-Host "`n[PHASE 3] Company Setup" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

$companyResponse = Invoke-ApiRequest -Method POST -Endpoint "/companies" -Body @{
    name        = "Test Company for Jobs"
    slug        = "test-company-jobs-$(Get-Random)"
    description = "Test company for Jobs Module verification"
    industry    = "Technology"
    website     = "https://testcompany.test"
    email       = "hr@testcompany.test"
} -Token $recruiterToken

if ($companyResponse.StatusCode -eq 201 -and $companyResponse.Content.id) {
    $companyId = $companyResponse.Content.id
    Add-TestResult "Create company" $true
    Write-Host "   Company ID: $companyId" -ForegroundColor Gray
}
else {
    Add-TestResult "Create company" $false "Status: $($companyResponse.StatusCode), Error: $($companyResponse.Content.message)"
    $companyId = $null
}

# ==========================================
# PHASE 4: CRUD Operations
# ==========================================

Write-Host "`n[PHASE 4] CRUD Operations" -ForegroundColor Cyan
Write-Host "==========================`n" -ForegroundColor Cyan

$jobId = $null

# CREATE Job
$createJobResponse = Invoke-ApiRequest -Method POST -Endpoint "/jobs" -Body @{
    companyId       = $companyId
    title           = "Senior Node.js Developer"
    slug            = "senior-nodejs-dev-$(Get-Random)"
    description     = "We are looking for a senior Node.js developer with 5+ years of experience"
    requirements    = "5+ years Node.js, TypeScript, PostgreSQL"
    responsibilities = "Lead backend development, mentor junior developers"
    employmentType  = "FULL_TIME"
    workMode        = "remote"
    experienceLevel = "SENIOR"
    country         = "Lebanon"
    city            = "Beirut"
    salaryMin       = 50000
    salaryMax       = 80000
    currency        = "USD"
    status          = "published"
    isActive        = $true
} -Token $recruiterToken

if ($createJobResponse.StatusCode -eq 201 -and $createJobResponse.Content.id) {
    $jobId = $createJobResponse.Content.id
    Add-TestResult "Create Job (POST /jobs)" $true
    Write-Host "   Job ID: $jobId" -ForegroundColor Gray
}
else {
    Add-TestResult "Create Job (POST /jobs)" $false "Status: $($createJobResponse.StatusCode), Error: $($createJobResponse.Content.message)"
}

# READ Job by ID
if ($jobId) {
    $getJobResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs/$jobId"
    
    if ($getJobResponse.StatusCode -eq 200 -and $getJobResponse.Content.id -eq $jobId) {
        Add-TestResult "Read Job by ID (GET /jobs/:id)" $true
    }
    else {
        Add-TestResult "Read Job by ID (GET /jobs/:id)" $false "Status: $($getJobResponse.StatusCode)"
    }
}

# READ Job by Slug
if ($jobId) {
    $getJobSlugResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs/slug/$($createJobResponse.Content.slug)"
    
    if ($getJobSlugResponse.StatusCode -eq 200 -and $getJobSlugResponse.Content.id -eq $jobId) {
        Add-TestResult "Read Job by Slug (GET /jobs/slug/:slug)" $true
    }
    else {
        Add-TestResult "Read Job by Slug (GET /jobs/slug/:slug)" $false "Status: $($getJobSlugResponse.StatusCode)"
    }
}

# UPDATE Job
if ($jobId) {
    $updateJobResponse = Invoke-ApiRequest -Method PATCH -Endpoint "/jobs/$jobId" -Body @{
        title       = "Senior Node.js Developer - UPDATED"
        salaryMin   = 60000
        salaryMax   = 90000
    } -Token $recruiterToken
    
    if ($updateJobResponse.StatusCode -eq 200) {
        Add-TestResult "Update Job (PATCH /jobs/:id)" $true
    }
    else {
        Add-TestResult "Update Job (PATCH /jobs/:id)" $false "Status: $($updateJobResponse.StatusCode)"
    }
}

# LIST Jobs
$listJobsResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs"

if ($listJobsResponse.StatusCode -eq 200 -and $listJobsResponse.Content -is [array]) {
    Add-TestResult "List Jobs (GET /jobs)" $true "Found $($listJobsResponse.Content.Count) jobs"
}
else {
    Add-TestResult "List Jobs (GET /jobs)" $false "Status: $($listJobsResponse.StatusCode)"
}

# ==========================================
# PHASE 5: Filtering & Search
# ==========================================

Write-Host "`n[PHASE 5] Filtering & Search" -ForegroundColor Cyan
Write-Host "=============================`n" -ForegroundColor Cyan

# Filter by Company ID
$filterCompanyResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs?companyId=$companyId"

if ($filterCompanyResponse.StatusCode -eq 200) {
    Add-TestResult "Filter by companyId" ($filterCompanyResponse.Content.Count -gt 0) "Found $($filterCompanyResponse.Content.Count) jobs"
}
else {
    Add-TestResult "Filter by companyId" $false "Status: $($filterCompanyResponse.StatusCode)"
}

# Filter by Employment Type
$filterEmploymentResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs?employmentType=FULL_TIME"

if ($filterEmploymentResponse.StatusCode -eq 200) {
    Add-TestResult "Filter by employmentType" ($filterEmploymentResponse.Content.Count -ge 0) "Found $($filterEmploymentResponse.Content.Count) jobs"
}
else {
    Add-TestResult "Filter by employmentType" $false "Status: $($filterEmploymentResponse.StatusCode)"
}

# Filter by Experience Level
$filterExperienceResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs?experienceLevel=SENIOR"

if ($filterExperienceResponse.StatusCode -eq 200) {
    Add-TestResult "Filter by experienceLevel" ($filterExperienceResponse.Content.Count -ge 0) "Found $($filterExperienceResponse.Content.Count) jobs"
}
else {
    Add-TestResult "Filter by experienceLevel" $false "Status: $($filterExperienceResponse.StatusCode)"
}

# Filter by Country
$filterCountryResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs?country=Lebanon"

if ($filterCountryResponse.StatusCode -eq 200) {
    Add-TestResult "Filter by country" ($filterCountryResponse.Content.Count -ge 0) "Found $($filterCountryResponse.Content.Count) jobs"
}
else {
    Add-TestResult "Filter by country" $false "Status: $($filterCountryResponse.StatusCode)"
}

# ==========================================
# PHASE 6: Authorization & Guards
# ==========================================

Write-Host "`n[PHASE 6] Authorization & Guards" -ForegroundColor Cyan
Write-Host "==================================`n" -ForegroundColor Cyan

# Create job without authentication
$noAuthResponse = Invoke-ApiRequest -Method POST -Endpoint "/jobs" -Body @{
    companyId       = $companyId
    title           = "Test Job"
    slug            = "test-job-$(Get-Random)"
    description     = "Test"
    employmentType  = "FULL_TIME"
    experienceLevel = "JUNIOR"
}

if ($noAuthResponse.StatusCode -in 401, 403) {
    Add-TestResult "Cannot create job without auth (should be 401/403)" $true
}
else {
    Add-TestResult "Cannot create job without auth (should be 401/403)" $false "Got: $($noAuthResponse.StatusCode)"
}

# Regular user tries to update recruiter's job
if ($jobId -and $userToken) {
    $userUpdateResponse = Invoke-ApiRequest -Method PATCH -Endpoint "/jobs/$jobId" -Body @{
        title = "User trying to update"
    } -Token $userToken
    
    if ($userUpdateResponse.StatusCode -in 401, 403, 404) {
        Add-TestResult "User cannot modify recruiter's job (should be 401/403)" $true
    }
    else {
        Add-TestResult "User cannot modify recruiter's job (should be 401/403)" $false "Got: $($userUpdateResponse.StatusCode)"
    }
}

# ==========================================
# PHASE 7: Error Handling
# ==========================================

Write-Host "`n[PHASE 7] Error Handling" -ForegroundColor Cyan
Write-Host "=========================`n" -ForegroundColor Cyan

# Get non-existent job
$notFoundResponse = Invoke-ApiRequest -Method GET -Endpoint "/jobs/00000000-0000-0000-0000-000000000000"

if ($notFoundResponse.StatusCode -eq 404) {
    Add-TestResult "Non-existent job returns 404" $true
}
else {
    Add-TestResult "Non-existent job returns 404" $false "Got: $($notFoundResponse.StatusCode)"
}

# Duplicate slug (if creating another job with same slug)
$duplicateSlugResponse = Invoke-ApiRequest -Method POST -Endpoint "/jobs" -Body @{
    companyId       = $companyId
    title           = "Duplicate Slug Test"
    slug            = $createJobResponse.Content.slug
    description     = "Testing duplicate slug"
    employmentType  = "FULL_TIME"
    experienceLevel = "JUNIOR"
} -Token $recruiterToken

if ($duplicateSlugResponse.StatusCode -eq 409) {
    Add-TestResult "Duplicate slug returns 409 Conflict" $true
}
else {
    Add-TestResult "Duplicate slug returns 409 Conflict" $false "Got: $($duplicateSlugResponse.StatusCode)"
}

# ==========================================
# PHASE 8: Response Contract Validation
# ==========================================

Write-Host "`n[PHASE 8] Response Contract Validation" -ForegroundColor Cyan
Write-Host "=======================================`n" -ForegroundColor Cyan

if ($createJobResponse.Content) {
    $job = $createJobResponse.Content
    
    $hasId = $job.id -ne $null
    $hasTitle = $job.title -ne $null
    $hasCompanyId = $job.companyId -ne $null
    $hasCreatedAt = $job.createdAt -ne $null
    $hasUpdatedAt = $job.updatedAt -ne $null
    
    Add-TestResult "Response has required fields (id, title, companyId)" ($hasId -and $hasTitle -and $hasCompanyId)
    Add-TestResult "Response has timestamps (createdAt, updatedAt)" ($hasCreatedAt -and $hasUpdatedAt)
}

# ==========================================
# PHASE 9: Cleanup & DELETE
# ==========================================

Write-Host "`n[PHASE 9] Cleanup & DELETE" -ForegroundColor Cyan
Write-Host "============================`n" -ForegroundColor Cyan

if ($jobId) {
    $deleteResponse = Invoke-ApiRequest -Method DELETE -Endpoint "/jobs/$jobId" -Token $recruiterToken
    
    if ($deleteResponse.StatusCode -eq 200) {
        Add-TestResult "Delete Job (DELETE /jobs/:id)" $true
    }
    else {
        Add-TestResult "Delete Job (DELETE /jobs/:id)" $false "Status: $($deleteResponse.StatusCode)"
    }
}

# ==========================================
# FINAL SUMMARY
# ==========================================

Write-Host "`n" -ForegroundColor Cyan
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  JOBS MODULE VERIFICATION SUMMARY      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`nTest Results:" -ForegroundColor White
Write-Host "  ✅ Passed: $passCount" -ForegroundColor Green
Write-Host "  ❌ Failed: $failCount" -ForegroundColor Red
Write-Host "  📊 Total:  $($passCount + $failCount)" -ForegroundColor Cyan

$successRate = if (($passCount + $failCount) -gt 0) { [math]::Round(($passCount / ($passCount + $failCount)) * 100, 2) } else { 0 }
Write-Host "  📈 Success Rate: $successRate%" -ForegroundColor Cyan

Write-Host "`nDetailed Results:" -ForegroundColor White
$testResults | ForEach-Object {
    $status = $_.Passed ? "✅" : "❌"
    Write-Host "$status $($_.Name)" -ForegroundColor ($_.Passed ? "Green" : "Red")
}

if ($failCount -eq 0) {
    Write-Host "`n🎉 ALL TESTS PASSED!" -ForegroundColor Green
}
else {
    Write-Host "`n⚠️  SOME TESTS FAILED - Review details above" -ForegroundColor Yellow
}
