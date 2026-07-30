$json = '{"email":"testuser1@example.com","password":"TestPassword123!"}'

$response = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/register" `
    -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body $json `
    -UseBasicParsing

Write-Host "=== TEST 1: REGISTER ===" -ForegroundColor Green
Write-Host "Status Code: $($response.StatusCode)"
$jsonResponse = $response.Content | ConvertFrom-Json
Write-Host "Response:"
$jsonResponse | ConvertTo-Json -Depth 10

# Save tokens for next tests
$script:accessToken = $jsonResponse.accessToken
$script:refreshToken = $jsonResponse.refreshToken
$script:userId = $jsonResponse.user.id

Write-Host ""
Write-Host "=== TEST 2: LOGIN ===" -ForegroundColor Green

$loginJson = '{"email":"testuser1@example.com","password":"TestPassword123!"}'

$loginResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/login" `
    -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body $loginJson `
    -UseBasicParsing

Write-Host "Status Code: $($loginResponse.StatusCode)"
$loginJsonResponse = $loginResponse.Content | ConvertFrom-Json
Write-Host "Response:"
$loginJsonResponse | ConvertTo-Json -Depth 10

# Update tokens
$script:accessToken = $loginJsonResponse.accessToken
$script:refreshToken = $loginJsonResponse.refreshToken

Write-Host ""
Write-Host "=== TEST 3: GET ME ===" -ForegroundColor Green

$getMeResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/me" `
    -Method GET `
    -Headers @{"Authorization"="Bearer $($script:accessToken)"} `
    -UseBasicParsing

Write-Host "Status Code: $($getMeResponse.StatusCode)"
$getMeJsonResponse = $getMeResponse.Content | ConvertFrom-Json
Write-Host "Response:"
$getMeJsonResponse | ConvertTo-Json -Depth 10

Write-Host ""
Write-Host "=== TEST 4: INVALID EMAIL ===" -ForegroundColor Red

$invalidEmailJson = '{"email":"invalid-email","password":"TestPassword123!"}'

$invalidEmailResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/register" `
    -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body $invalidEmailJson `
    -ErrorAction SilentlyContinue `
    -UseBasicParsing

Write-Host "Status Code: $($invalidEmailResponse.StatusCode)"
Write-Host "Response:"
$invalidEmailResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10

Write-Host ""
Write-Host "=== TEST 5: DUPLICATE EMAIL ===" -ForegroundColor Red

$duplicateJson = '{"email":"testuser1@example.com","password":"AnotherPassword123!"}'

$duplicateResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/register" `
    -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body $duplicateJson `
    -ErrorAction SilentlyContinue `
    -UseBasicParsing

Write-Host "Status Code: $($duplicateResponse.StatusCode)"
Write-Host "Response:"
$duplicateResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10

Write-Host ""
Write-Host "=== TEST 6: WRONG PASSWORD ===" -ForegroundColor Red

$wrongPasswordJson = '{"email":"testuser1@example.com","password":"WrongPassword123!"}'

$wrongPasswordResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/login" `
    -Method POST `
    -Headers @{"Content-Type"="application/json"} `
    -Body $wrongPasswordJson `
    -ErrorAction SilentlyContinue `
    -UseBasicParsing

Write-Host "Status Code: $($wrongPasswordResponse.StatusCode)"
Write-Host "Response:"
$wrongPasswordResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10

Write-Host ""
Write-Host "=== TEST 7: NO TOKEN ===" -ForegroundColor Red

$noTokenResponse = Invoke-WebRequest -Uri "http://localhost:3000/api/v1/auth/me" `
    -Method GET `
    -ErrorAction SilentlyContinue `
    -UseBasicParsing

Write-Host "Status Code: $($noTokenResponse.StatusCode)"
Write-Host "Response:"
$noTokenResponse.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10

Write-Host ""
Write-Host "=== SUMMARY ===" -ForegroundColor Yellow
Write-Host "Access Token: $($script:accessToken.Substring(0, 30))..."
Write-Host "User ID: $($script:userId)"
