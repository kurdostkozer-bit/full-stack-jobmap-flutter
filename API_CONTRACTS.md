# API Contracts - Quick Reference

## Base URL
```
http://localhost:3000/v1  (development)
https://api.example.com/v1 (production)
```

## Common Headers
```
Authorization: Bearer <JWT_TOKEN>
Content-Type: application/json
```

---

## Education API

### GET /education
Returns paginated list of all education records.

**Query Parameters:**
- `limit` (number, default: 10) - Records per page
- `offset` (number, default: 0) - Starting position
- `sort` (string, default: "createdAt") - Sort field
- `order` (string: "ASC"/"DESC", default: "DESC") - Sort direction

**Response:**
```json
{
  "data": [
    {
      "id": "uuid",
      "careerProfileId": "uuid",
      "school": "string",
      "degree": "string",
      "fieldOfStudy": "string",
      "startDate": "2024-01-15",
      "endDate": "2025-05-30",
      "currentlyStudying": false,
      "description": "string",
      "displayOrder": 1,
      "createdAt": "2024-01-15T10:00:00Z",
      "updatedAt": "2024-01-15T10:00:00Z"
    }
  ],
  "total": 5,
  "limit": 10,
  "offset": 0
}
```

---

### GET /education/career-profile/{careerProfileId}
Returns education records for specific career profile.

**Response:**
```json
[
  {
    "id": "uuid",
    "careerProfileId": "uuid",
    "school": "string",
    "degree": "string",
    "fieldOfStudy": "string",
    "startDate": "2024-01-15",
    "endDate": "2025-05-30",
    "currentlyStudying": false,
    "description": "string",
    "displayOrder": 1,
    "createdAt": "2024-01-15T10:00:00Z",
    "updatedAt": "2024-01-15T10:00:00Z"
  }
]
```

---

### GET /education/{id}
Returns single education record.

**Response:**
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "school": "string",
  "degree": "string",
  "fieldOfStudy": "string",
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "currentlyStudying": false,
  "description": "string",
  "displayOrder": 1,
  "createdAt": "2024-01-15T10:00:00Z",
  "updatedAt": "2024-01-15T10:00:00Z"
}
```

---

### POST /education
Creates new education record.

**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "school": "string (required)",
  "degree": "string (required)",
  "fieldOfStudy": "string",
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "currentlyStudying": false,
  "description": "string",
  "displayOrder": 1
}
```

**Response:** 201 Created
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "school": "string",
  "degree": "string",
  "fieldOfStudy": "string",
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "currentlyStudying": false,
  "description": "string",
  "displayOrder": 1,
  "createdAt": "2024-01-15T10:00:00Z",
  "updatedAt": "2024-01-15T10:00:00Z"
}
```

---

### PATCH /education/{id}
Updates education record.

**Request Body:** (all fields optional)
```json
{
  "school": "string",
  "degree": "string",
  "fieldOfStudy": "string",
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "currentlyStudying": false,
  "description": "string",
  "displayOrder": 2
}
```

**Response:** 200 OK - Returns updated record

---

### DELETE /education/{id}
Soft deletes education record.

**Response:** 200 OK
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "school": "string",
  "degree": "string",
  "fieldOfStudy": "string",
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "currentlyStudying": false,
  "description": "string",
  "displayOrder": 1,
  "createdAt": "2024-01-15T10:00:00Z",
  "updatedAt": "2024-01-15T10:00:00Z",
  "deletedAt": "2024-01-20T15:30:00Z"
}
```

---

## Languages API

### GET /languages
```
Same structure as Education
```

---

### POST /languages
**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "name": "string (required)",
  "proficiency": "BEGINNER|INTERMEDIATE|ADVANCED|FLUENT",
  "displayOrder": 1
}
```

---

## Projects API

### GET /projects
```
Same structure as Education
```

---

### POST /projects
**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "title": "string (required)",
  "description": "string",
  "role": "string",
  "technologies": ["string"],
  "startDate": "2024-01-15",
  "endDate": "2025-05-30",
  "isCurrently": false,
  "imageUrl": "https://...",
  "displayOrder": 1
}
```

---

## Certificates API

### GET /certificates
```
Same structure as Education
```

---

### POST /certificates
**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "name": "string (required)",
  "issuer": "string (required)",
  "credentialId": "string",
  "credentialUrl": "https://...",
  "issueDate": "2024-01-15",
  "expiryDate": "2026-01-15",
  "doesNotExpire": false,
  "verificationStatus": "PENDING",
  "displayOrder": 1
}
```

---

## Error Responses

### 400 Bad Request
```json
{
  "statusCode": 400,
  "message": "Validation failed",
  "errors": [
    {
      "field": "school",
      "message": "school should not be empty"
    }
  ]
}
```

### 401 Unauthorized
```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Education record not found."
}
```

### 500 Internal Server Error
```json
{
  "statusCode": 500,
  "message": "Internal server error"
}
```

---

## Implementation Order for Flutter

1. **Education** (most complex with date handling)
2. **Languages** (simpler, enum for proficiency)
3. **Projects** (medium, array handling for technologies)
4. **Certificates** (enum for verification status)

---

## Testing Endpoints with cURL

### Create Education
```bash
curl -X POST http://localhost:3000/v1/education \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "careerProfileId": "uuid",
    "school": "University Name",
    "degree": "Bachelor",
    "fieldOfStudy": "Computer Science",
    "startDate": "2020-01-15",
    "endDate": "2024-05-30",
    "currentlyStudying": false,
    "description": "Focused on AI and ML",
    "displayOrder": 1
  }'
```

### Get All Education
```bash
curl -X GET "http://localhost:3000/v1/education?limit=10&offset=0&sort=createdAt&order=DESC" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Get Single Education
```bash
curl -X GET http://localhost:3000/v1/education/{id} \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Update Education
```bash
curl -X PATCH http://localhost:3000/v1/education/{id} \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "school": "Updated University Name"
  }'
```

### Delete Education
```bash
curl -X DELETE http://localhost:3000/v1/education/{id} \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

## Flutter Dio Configuration

```dart
// Add to your Dio instance headers
dio.options.headers['Authorization'] = 'Bearer $token';

// Base URL
dio.options.baseUrl = 'http://localhost:3000/v1';

// Error handling
try {
  final response = await dio.get('/education');
  // Handle 200 response
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  } else if (e.response?.statusCode == 400) {
    // Handle validation error
  } else if (e.response?.statusCode == 404) {
    // Handle not found
  }
}
```

---

## Summary

✅ All 4 APIs follow the same pattern  
✅ All support CRUD operations  
✅ All require JWT authentication  
✅ All support pagination and sorting  
✅ All use soft deletes  
✅ All support displayOrder for custom sorting  

**Ready to build Flutter models and repositories!**
