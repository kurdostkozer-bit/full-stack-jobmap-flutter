# Attachments API Endpoints

Base URL: `/v1/attachments`

## Overview
The Attachments system provides a comprehensive file management solution for career profiles. It supports multiple file types (Resume, Cover Letter, Certificates, Portfolio, Other) with built-in storage provider abstraction, allowing easy migration to cloud storage (S3, R2, Azure, GCS) in the future.

## Supported File Types

1. **RESUME** - Resume/CV documents
2. **COVER_LETTER** - Cover letters
3. **CERTIFICATE** - Certificate PDFs
4. **PORTFOLIO** - Portfolio documents
5. **OTHER** - Other file types

## Storage Providers

- **LOCAL** - Local filesystem (default, implemented)
- **S3** - AWS S3 (future)
- **R2** - Cloudflare R2 (future)
- **AZURE** - Azure Blob Storage (future)
- **GCS** - Google Cloud Storage (future)

## Endpoints

### 1. Upload File
**POST** `/v1/attachments/upload`

**Content-Type:** `multipart/form-data`

**Form Fields:**
- `file` (File, required) - The file to upload (max 50MB)
- `careerProfileId` (UUID, required) - Career profile identifier
- `type` (enum, required) - File type: `RESUME | COVER_LETTER | CERTIFICATE | PORTFOLIO | OTHER`
- `isDefault` (boolean, optional) - Set as default file (default: false)

**Response:**
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "type": "RESUME",
  "originalFileName": "resume.pdf",
  "storedFileName": "1690816200000-a1b2c3d4-resume.pdf",
  "mimeType": "application/pdf",
  "fileSize": 245000,
  "storageProvider": "LOCAL",
  "storagePath": "/uploads/550e8400-e29b-41d4-a716-446655440000/1690816200000-a1b2c3d4-resume.pdf",
  "fileUrl": "http://localhost:3000/uploads/550e8400-e29b-41d4-a716-446655440000/1690816200000-a1b2c3d4-resume.pdf",
  "isDefault": true,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Errors:**
- `400 Bad Request` - No file provided or file exceeds 50MB
- `400 Bad Request` - Invalid file type

---

### 2. Get All Attachments
**GET** `/v1/attachments`

**Query Parameters:**
- `careerProfileId` (UUID, optional) - Filter by career profile
- `type` (enum, optional) - Filter by type: `RESUME | COVER_LETTER | CERTIFICATE | PORTFOLIO | OTHER`
- `isDefault` (boolean, optional) - Filter by default status
- `sortBy` (enum, optional) - Sort field: `type | fileSize | createdAt | updatedAt`
- `sortOrder` (enum, optional) - Sort direction: `asc | desc`
- `page` (number, optional) - Page number (default: 1, min: 1)
- `limit` (number, optional) - Records per page (default: 20, min: 1, max: 100)

**Response:**
```json
[
  {
    "id": "uuid",
    "careerProfileId": "uuid",
    "type": "RESUME",
    "originalFileName": "resume.pdf",
    "storedFileName": "1690816200000-a1b2c3d4-resume.pdf",
    "mimeType": "application/pdf",
    "fileSize": 245000,
    "storageProvider": "LOCAL",
    "storagePath": "/uploads/550e8400-e29b-41d4-a716-446655440000/1690816200000-a1b2c3d4-resume.pdf",
    "fileUrl": "http://localhost:3000/uploads/550e8400-e29b-41d4-a716-446655440000/1690816200000-a1b2c3d4-resume.pdf",
    "isDefault": true,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

---

### 3. Get Attachments by Career Profile
**GET** `/v1/attachments/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:** Array of attachment objects (sorted by descending created date)

---

### 4. Get Attachments by Type
**GET** `/v1/attachments/career-profile/:careerProfileId/type/:type`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier
- `type` (string) - File type (e.g., RESUME, COVER_LETTER, etc.)

**Response:** Array of attachments of specified type (default first, then by recent)

---

### 5. Get Default Attachment
**GET** `/v1/attachments/career-profile/:careerProfileId/default`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:** Single default attachment object

**Errors:**
- `404 Not Found` - No default attachment found

---

### 6. Get Attachment by ID
**GET** `/v1/attachments/:id`

**Path Parameters:**
- `id` (UUID) - Attachment identifier

**Response:** Single attachment object

**Errors:**
- `404 Not Found` - Attachment not found

---

### 7. Update Attachment
**PATCH** `/v1/attachments/:id`

**Path Parameters:**
- `id` (UUID) - Attachment identifier

**Request Body:** (All fields optional)
```json
{
  "fileUrl": "https://storage.example.com/file.pdf",
  "isDefault": true
}
```

**Response:** Updated attachment object

**Errors:**
- `404 Not Found` - Attachment not found

---

### 8. Set as Default Attachment
**PATCH** `/v1/attachments/:id/default`

**Path Parameters:**
- `id` (UUID) - Attachment identifier

**Query Parameters:**
- `careerProfileId` (UUID, required) - Career profile identifier

**Response:** Updated attachment object (marked as default)

**Notes:**
- This endpoint automatically unsets the default flag from all other attachments in the same career profile
- Only one attachment per career profile can be default

**Errors:**
- `404 Not Found` - Attachment not found

---

### 9. Delete Attachment
**DELETE** `/v1/attachments/:id`

**Path Parameters:**
- `id` (UUID) - Attachment identifier

**Response:** Deleted attachment object

**Errors:**
- `404 Not Found` - Attachment not found

---

## Query Examples

### Upload a resume
```bash
curl -X POST http://localhost:3000/v1/attachments/upload \
  -F "file=@resume.pdf" \
  -F "careerProfileId=550e8400-e29b-41d4-a716-446655440000" \
  -F "type=RESUME" \
  -F "isDefault=true"
```

### Get all attachments for a career profile
```
GET /v1/attachments/career-profile/550e8400-e29b-41d4-a716-446655440000
```

### Get all resumes for a profile
```
GET /v1/attachments/career-profile/550e8400-e29b-41d4-a716-446655440000/type/RESUME
```

### Get default resume
```
GET /v1/attachments/career-profile/550e8400-e29b-41d4-a716-446655440000/default
```

### List attachments by file size
```
GET /v1/attachments?careerProfileId=550e8400-e29b-41d4-a716-446655440000&sortBy=fileSize&sortOrder=desc
```

### Set specific attachment as default
```
PATCH /v1/attachments/{id}/default?careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

---

## Data Model

### AttachmentEntity
- `id` (UUID) - Primary key
- `careerProfileId` (UUID) - Foreign key to career profile
- `type` (enum) - File type (5 options)
- `originalFileName` (varchar, 255) - Original filename from upload
- `storedFileName` (varchar, 255) - Stored filename (timestamp-random-original)
- `mimeType` (varchar, 100) - MIME type (e.g., application/pdf)
- `fileSize` (integer) - File size in bytes
- `storageProvider` (enum) - Storage backend (5 options)
- `storagePath` (text) - Physical/logical storage path
- `fileUrl` (text) - Public URL to access file
- `isDefault` (boolean) - Whether this is the default file
- `createdAt` (timestamp) - Record creation time
- `updatedAt` (timestamp) - Last update time

### Indexes
- `attachments_career_profile_id_idx` - On `careerProfileId`
- `attachments_type_idx` - On `type`
- `attachments_storage_provider_idx` - On `storageProvider`
- `attachments_is_default_idx` - On `isDefault`

### Default Values
- `storageProvider` - LOCAL
- `isDefault` - false

---

## File Organization

**Local Storage Structure:**
```
uploads/
├── 550e8400-e29b-41d4-a716-446655440000/
│   ├── 1690816200000-a1b2c3d4-resume.pdf
│   ├── 1690816300000-b2c3d4e5-cover-letter.pdf
│   └── 1690816400000-c3d4e5f6-portfolio.pdf
├── 660e8400-e29b-41d4-a716-446655440001/
│   └── 1690816500000-d4e5f6g7-resume.pdf
```

---

## File Size Limits

- Maximum file size: **50MB**
- Recommended sizes:
  - Resume: 5-10MB
  - Cover Letter: 2-5MB
  - Certificate: 10-15MB
  - Portfolio: 20-50MB

---

## Supported MIME Types

| File Type | MIME Types |
|-----------|-----------|
| Documents | `application/pdf`, `application/msword`, `application/vnd.openxmlformats-officedocument.wordprocessingml.document` |
| Spreadsheets | `application/vnd.ms-excel`, `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet` |
| Text | `text/plain` |
| Images | `image/jpeg`, `image/png`, `image/webp` |
| Archives | `application/zip`, `application/x-rar-compressed` |

---

## API Usage Patterns

### Complete File Upload Flow
```bash
# 1. Upload resume
POST /v1/attachments/upload
{
  "file": <binary>,
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "type": "RESUME",
  "isDefault": true
}

# 2. Upload cover letter
POST /v1/attachments/upload
{
  "file": <binary>,
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "type": "COVER_LETTER"
}

# 3. Get all files for profile
GET /v1/attachments/career-profile/550e8400-e29b-41d4-a716-446655440000

# 4. Set cover letter as default
PATCH /v1/attachments/{cover-letter-id}/default?careerProfileId=550e8400-e29b-41d4-a716-446655440000

# 5. Delete old resume
DELETE /v1/attachments/{old-resume-id}
```

### Profile Completion with Multiple Attachments
```bash
# Upload resume
POST /v1/attachments/upload (RESUME)

# Upload cover letter
POST /v1/attachments/upload (COVER_LETTER)

# Upload portfolio
POST /v1/attachments/upload (PORTFOLIO)

# Get all to show profile completeness
GET /v1/attachments/career-profile/{careerProfileId}
```

---

## Storage Provider Migration

The system is designed to support storage provider migration without data loss:

1. **Add new provider** - Implement `StorageProvider` interface
2. **Update controller** - Handle provider selection
3. **Migrate data** - Use admin endpoint to migrate existing files
4. **Update fileUrl** - Generated based on storage provider

Example migration to S3:
```
1. Implement S3StorageProvider
2. Update LocalStorageProvider.upload() to call S3Provider
3. Background job migrates old LOCAL files to S3
4. Update storagePath and fileUrl for migrated files
```

---

## Future Enhancements

Potential improvements:
1. Virus scanning on upload
2. Document preview generation
3. OCR for resume parsing
4. File versioning
5. Bandwidth usage tracking
6. Storage quota per profile
7. Bulk upload support
8. Automatic format conversion (e.g., DOCX → PDF)
9. Integration with ATS systems
10. Credentials verification for uploaded documents
