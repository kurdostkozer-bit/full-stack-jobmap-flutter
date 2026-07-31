# Certificates API Endpoints

Base URL: `/v1/certificates`

## Endpoints

### 1. Get All Certificates
**GET** `/v1/certificates`

**Query Parameters:**
- `careerProfileId` (UUID, optional) - Filter by career profile
- `search` (string, optional) - Search in name and issuer (max 100 chars)
- `verificationStatus` (enum, optional) - Filter by status: `PENDING | VERIFIED | REJECTED`
- `doesNotExpire` (boolean, optional) - Filter by expiration status
- `sortBy` (enum, optional) - Sort field: `name | issuer | issueDate | displayOrder | verificationStatus | createdAt | updatedAt`
- `sortOrder` (enum, optional) - Sort direction: `asc | desc`
- `page` (number, optional) - Page number (default: 1, min: 1)
- `limit` (number, optional) - Records per page (default: 20, min: 1, max: 100)

**Response:**
```json
[
  {
    "id": "uuid",
    "careerProfileId": "uuid",
    "name": "AWS Certified Solutions Architect",
    "issuer": "Amazon Web Services",
    "credentialId": "LLYR-K9JM8T",
    "credentialUrl": "https://aws.amazon.com/verification",
    "issueDate": "2023-06-15T00:00:00Z",
    "expiryDate": "2026-06-15T00:00:00Z",
    "doesNotExpire": false,
    "verificationStatus": "VERIFIED",
    "displayOrder": 0,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

---

### 2. Get Certificates by Career Profile ID
**GET** `/v1/certificates/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:**
```json
[
  {
    "id": "uuid",
    "careerProfileId": "uuid",
    "name": "AWS Certified Solutions Architect",
    "issuer": "Amazon Web Services",
    "credentialId": "LLYR-K9JM8T",
    "credentialUrl": "https://aws.amazon.com/verification",
    "issueDate": "2023-06-15T00:00:00Z",
    "expiryDate": "2026-06-15T00:00:00Z",
    "doesNotExpire": false,
    "verificationStatus": "VERIFIED",
    "displayOrder": 0,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

**Sorting:** By `displayOrder` (ASC) then `issueDate` (DESC)

---

### 3. Get Certificate by ID
**GET** `/v1/certificates/:id`

**Path Parameters:**
- `id` (UUID) - Certificate identifier

**Response:**
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "name": "AWS Certified Solutions Architect",
  "issuer": "Amazon Web Services",
  "credentialId": "LLYR-K9JM8T",
  "credentialUrl": "https://aws.amazon.com/verification",
  "issueDate": "2023-06-15T00:00:00Z",
  "expiryDate": "2026-06-15T00:00:00Z",
  "doesNotExpire": false,
  "verificationStatus": "VERIFIED",
  "displayOrder": 0,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Errors:**
- `404 Not Found` - Certificate not found

---

### 4. Create Certificate
**POST** `/v1/certificates`

**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "name": "AWS Certified Solutions Architect",
  "issuer": "Amazon Web Services",
  "credentialId": "LLYR-K9JM8T",
  "credentialUrl": "https://aws.amazon.com/verification",
  "issueDate": "2023-06-15",
  "expiryDate": "2026-06-15",
  "doesNotExpire": false,
  "displayOrder": 0
}
```

**Validation Rules:**
- `careerProfileId` - Required UUID
- `name` - Required string (max 200 chars)
- `issuer` - Required string (max 200 chars)
- `credentialId` - Optional string (max 200 chars)
- `credentialUrl` - Optional valid URL
- `issueDate` - Required ISO date string
- `expiryDate` - Optional ISO date string
- `doesNotExpire` - Optional boolean (default: false)
- `displayOrder` - Optional number (default: 0, min: 0)

**Response:** Certificate object (same as Get by ID)

**Errors:**
- `400 Bad Request` - Validation error

---

### 5. Update Certificate
**PATCH** `/v1/certificates/:id`

**Path Parameters:**
- `id` (UUID) - Certificate identifier

**Request Body:** (All fields optional)
```json
{
  "name": "AWS Certified Solutions Architect - Professional",
  "issuer": "Amazon Web Services",
  "credentialId": "LLYR-K9JM8T",
  "credentialUrl": "https://aws.amazon.com/verification",
  "issueDate": "2023-06-15",
  "expiryDate": "2026-06-15",
  "doesNotExpire": false,
  "displayOrder": 1
}
```

**Response:** Updated certificate object

**Errors:**
- `404 Not Found` - Certificate not found
- `400 Bad Request` - Validation error

---

### 6. Delete Certificate
**DELETE** `/v1/certificates/:id`

**Path Parameters:**
- `id` (UUID) - Certificate identifier

**Response:** Deleted certificate object

**Errors:**
- `404 Not Found` - Certificate not found

---

## Query Examples

### Search Certificates
```
GET /v1/certificates?search=AWS&careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

### Filter by Verification Status
```
GET /v1/certificates?verificationStatus=VERIFIED&careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

### Get Non-Expiring Certificates
```
GET /v1/certificates?doesNotExpire=true&careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

### Pagination and Sorting
```
GET /v1/certificates?page=2&limit=10&sortBy=issueDate&sortOrder=desc&careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

---

## Data Model

### CertificateEntity
- `id` (UUID) - Primary key
- `careerProfileId` (UUID) - Foreign key to career profile
- `name` (string, max 200) - Certificate name
- `issuer` (string, max 200) - Issuing organization
- `credentialId` (string, max 200, nullable) - Credential identifier for verification
- `credentialUrl` (text, nullable) - URL to verify credential
- `issueDate` (timestamp) - When certificate was issued
- `expiryDate` (timestamp, nullable) - When certificate expires
- `doesNotExpire` (boolean) - Whether certificate doesn't expire
- `verificationStatus` (enum) - PENDING | VERIFIED | REJECTED
- `displayOrder` (integer) - Display order on profile
- `createdAt` (timestamp) - Record creation time
- `updatedAt` (timestamp) - Last update time

### Indexes
- `certificates_career_profile_id_idx` - On `careerProfileId`
- `certificates_verification_status_idx` - On `verificationStatus`
- `certificates_display_order_idx` - On `displayOrder`

### Default Values
- `doesNotExpire` - false
- `verificationStatus` - PENDING
- `displayOrder` - 0

---

## Notes

1. **Verification Status**: Used to track certificate verification progress
   - `PENDING` - Awaiting verification
   - `VERIFIED` - Credential verified
   - `REJECTED` - Verification failed

2. **Display Order**: Lower values appear first in profiles (0 is highest priority)

3. **Expiration**: When `doesNotExpire` is true, `expiryDate` can be null

4. **Search**: Searches across `name` and `issuer` fields using case-insensitive LIKE

5. **Sorting**: Default sort is by `createdAt` ascending. When fetching by career profile, sorts by `displayOrder` ascending, then `issueDate` descending
