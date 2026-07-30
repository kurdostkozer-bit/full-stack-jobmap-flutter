# Backend API Quick Reference Guide

## Base URL
```
http://localhost:3000/v1
```

## Authentication

All protected endpoints require JWT token in header:
```
Authorization: Bearer <token>
```

### Get Token
```bash
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "message": "Login successful.",
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "isEmailVerified": false,
    "createdAt": "2026-07-31T..."
  }
}
```

---

## Authentication Endpoints

### Register
```
POST /auth/register
```

### Login
```
POST /auth/login
```

### Refresh Token
```
POST /auth/refresh-token
Content-Type: application/json

{
  "refreshToken": "..."
}
```

### Change Password
```
PATCH /auth/change-password (Protected)
```

### Verify Email
```
POST /auth/verify-email
```

---

## Jobs Endpoints

### List Jobs
```
GET /jobs?limit=20&offset=0
```

### Get Job by ID
```
GET /jobs/{id}
```

### Get Job by Slug
```
GET /jobs/slug/{slug}
```

### Create Job
```
POST /jobs (Protected - Admin/Company)
```

### Update Job
```
PATCH /jobs/{id} (Protected)
```

### Delete Job
```
DELETE /jobs/{id} (Protected)
```

---

## Companies Endpoints

### List Companies
```
GET /companies?limit=20&offset=0
```

### Get Company by ID
```
GET /companies/{id}
```

### Get Company by Slug
```
GET /companies/by-slug/{slug}
```

### Create Company
```
POST /companies (Protected)
```

### Update Company
```
PATCH /companies/{id} (Protected)
```

### Delete Company
```
DELETE /companies/{id} (Protected)
```

---

## Applications Endpoints

### Apply to Job
```
POST /applications/apply (Protected)

{
  "careerProfileId": "uuid",
  "jobId": "uuid",
  "notes": "optional"
}
```

### Get User Applications
```
GET /applications/career-profile/{careerProfileId} (Protected)
```

### Get Application Details
```
GET /applications/{id} (Protected)
```

### Update Application Status
```
PATCH /applications/{id}/status (Protected)

{
  "status": "UNDER_REVIEW|SHORTLISTED|REJECTED|WITHDRAWN",
  "notes": "optional"
}
```

### Withdraw Application
```
POST /applications/{id}/withdraw (Protected)
```

---

## Saved Jobs Endpoints

### Save Job
```
POST /saved-jobs/save (Protected)

{
  "careerProfileId": "uuid",
  "jobId": "uuid"
}
```

### Get Saved Jobs
```
GET /saved-jobs/{careerProfileId} (Protected)
```

### Check if Job is Saved
```
GET /saved-jobs/{careerProfileId}/jobs/{jobId}/check (Protected)
```

### Unsave Job
```
POST /saved-jobs/{careerProfileId}/jobs/{jobId}/unsave (Protected)
```

### Delete Saved Job
```
DELETE /saved-jobs/{id} (Protected)
```

---

## Notifications Endpoints

### Create Notification
```
POST /notifications (Protected)

{
  "userId": "uuid",
  "type": "JOB_ALERT|APPLICATION_UPDATE|MESSAGE|PROFILE_VIEW|SYSTEM",
  "title": "Notification title",
  "message": "Notification message",
  "data": {} (optional)
}
```

### Get User Notifications
```
GET /notifications/user/{userId}?limit=50&offset=0 (Protected)
```

### Get Unread Notifications
```
GET /notifications/user/{userId}/unread (Protected)
```

### Get Unread Count
```
GET /notifications/user/{userId}/unread-count (Protected)
```

### Mark as Read
```
POST /notifications/{id}/mark-as-read (Protected)
```

### Mark All as Read
```
POST /notifications/user/{userId}/mark-all-as-read (Protected)
```

### Delete Notification
```
DELETE /notifications/{id} (Protected)
```

---

## Chat Endpoints

### Create Conversation
```
POST /chat/conversations (Protected)

{
  "participantIds": ["uuid1", "uuid2"],
  "title": "optional"
}
```

### Get User Conversations
```
GET /chat/conversations/user/{userId}?limit=50 (Protected)
```

### Get Conversation Details
```
GET /chat/conversations/{id} (Protected)
```

### Send Message
```
POST /chat/messages (Protected)

{
  "conversationId": "uuid",
  "senderId": "uuid",
  "content": "message text",
  "attachmentUrl": "optional"
}
```

### Get Messages
```
GET /chat/messages/conversation/{conversationId}?limit=50&offset=0 (Protected)
```

### Edit Message
```
PATCH /chat/messages/{id} (Protected)

{
  "content": "updated message"
}
```

### Delete Message
```
DELETE /chat/messages/{id} (Protected)
```

---

## Search Endpoints

### Global Search
```
GET /search?query=search+term&type=ALL|JOBS|COMPANIES|PROFILES&limit=20&offset=0
```

### Search Jobs
```
GET /search/jobs?query=developer&limit=20
```

### Search Companies
```
GET /search/companies?query=google&limit=20
```

### Search Profiles
```
GET /search/profiles?query=john+doe&limit=20
```

---

## Uploads Endpoints

### Upload File
```
POST /attachments/upload (Protected)
Content-Type: multipart/form-data

Form Fields:
- file: (binary file, max 50MB)
- careerProfileId: uuid (required)
- type: RESUME|COVER_LETTER|CERTIFICATE|PORTFOLIO|OTHER
- isDefault: boolean (optional)
```

### Get Attachments
```
GET /attachments?limit=50&offset=0
```

### Get Career Profile Attachments
```
GET /attachments/career-profile/{careerProfileId}
```

### Get Attachments by Type
```
GET /attachments/career-profile/{careerProfileId}/type/{type}
```

### Get Default Attachment
```
GET /attachments/career-profile/{careerProfileId}/default
```

### Set Default Attachment
```
PATCH /attachments/{id}/default?careerProfileId={uuid} (Protected)
```

### Delete Attachment
```
DELETE /attachments/{id} (Protected)
```

---

## Maps Endpoints

### Create Location
```
POST /maps/locations

{
  "latitude": 40.7128,
  "longitude": -74.0060,
  "locationName": "New York Office",
  "city": "New York",
  "state": "NY",
  "country": "USA",
  "postalCode": "10001",
  "address": "123 Main St"
}
```

### Search Locations
```
GET /maps/search?query=New+York&city=&state=&limit=20
```

### Find Locations by Geo-Radius
```
POST /maps/geo-filter

{
  "latitude": 40.7128,
  "longitude": -74.0060,
  "radiusKm": 10,
  "limit": 20
}
```

### Find by City
```
GET /maps/by-city/{city}?limit=20
```

### Find by Country
```
GET /maps/by-country/{country}?limit=20
```

---

## Profile Completion Endpoints

### Calculate Profile Completion
```
GET /profile-completion/career-profile/{careerProfileId} (Protected)

Response:
{
  "percentage": 65,
  "completedSections": 6,
  "totalSections": 10,
  "sections": {
    "careerProfile": true,
    "skills": true,
    "experience": true,
    ...
  },
  "nextSuggestions": [
    "Add your education history",
    "Add languages you speak"
  ]
}
```

---

## Social Links Endpoints

### Create Social Link
```
POST /social-links

{
  "careerProfileId": "uuid",
  "platform": "linkedin",
  "profileUrl": "https://linkedin.com/in/user"
}
```

### Get Profile Social Links
```
GET /social-links/career-profile/{careerProfileId}
```

### Get Social Link by Platform
```
GET /social-links/career-profile/{careerProfileId}/platform/{platform}
```

### Update Social Link
```
PATCH /social-links/{id}
```

### Delete Social Link
```
DELETE /social-links/{id}
```

---

## Error Responses

### 400 Bad Request
```json
{
  "statusCode": 400,
  "message": "Validation failed",
  "error": "Bad Request"
}
```

### 401 Unauthorized
```json
{
  "statusCode": 401,
  "message": "Unauthorized",
  "error": "Unauthorized"
}
```

### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Resource not found",
  "error": "Not Found"
}
```

### 409 Conflict
```json
{
  "statusCode": 409,
  "message": "Email is already registered",
  "error": "Conflict"
}
```

### 500 Internal Server Error
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "Internal Server Error"
}
```

---

## Status Codes

- `200 OK` - Successful request
- `201 Created` - Resource created
- `204 No Content` - Successful deletion
- `400 Bad Request` - Invalid request
- `401 Unauthorized` - Missing/invalid token
- `403 Forbidden` - Permission denied
- `404 Not Found` - Resource not found
- `409 Conflict` - Resource conflict (duplicate)
- `500 Internal Server Error` - Server error

---

## Common Request Headers

```
Content-Type: application/json
Authorization: Bearer <token>
```

---

## Example: Complete User Flow

### 1. Register
```bash
curl -X POST http://localhost:3000/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "SecurePassword123!"
  }'
```

### 2. Login
```bash
curl -X POST http://localhost:3000/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "SecurePassword123!"
  }'
```

### 3. Save Job
```bash
curl -X POST http://localhost:3000/v1/saved-jobs/save \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "careerProfileId": "profile-uuid",
    "jobId": "job-uuid"
  }'
```

### 4. Apply to Job
```bash
curl -X POST http://localhost:3000/v1/applications/apply \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "careerProfileId": "profile-uuid",
    "jobId": "job-uuid",
    "notes": "I am interested in this position"
  }'
```

---

## Environment Variables

```
NODE_ENV=development
PORT=3000
APP_NAME=JobMap API

DATABASE_URL=postgres://user:password@localhost:5432/jobmap

JWT_SECRET=your-secret-key-here
JWT_REFRESH_SECRET=your-refresh-secret-key
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d

MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USER=your-email@gmail.com
MAIL_PASS=your-app-password
MAIL_FROM=noreply@jobmap.com
```

---

## Useful Links

- 📚 [NestJS Documentation](https://docs.nestjs.com)
- 🗄️ [Drizzle ORM Documentation](https://orm.drizzle.team)
- 🔐 [JWT Introduction](https://jwt.io/introduction)
- 📖 [REST API Best Practices](https://restfulapi.net)

---

*Last Updated: July 31, 2026*  
*API Version: 1.0*  
*Status: Production Ready ✅*
