# Social Links API Endpoints

Base URL: `/v1/social-links`

## Overview
The Social Links feature allows users to manage their portfolio and social media profiles. It supports 12 different platforms with visibility controls (Public/Private) and custom display ordering.

## Supported Platforms

1. **LINKEDIN** - LinkedIn Profile
2. **GITHUB** - GitHub Account
3. **GITLAB** - GitLab Account
4. **STACKOVERFLOW** - Stack Overflow Profile
5. **BEHANCE** - Behance Portfolio
6. **DRIBBBLE** - Dribbble Portfolio
7. **PERSONAL_WEBSITE** - Personal Website/Blog
8. **X** - X (Twitter)
9. **FACEBOOK** - Facebook Profile
10. **INSTAGRAM** - Instagram Profile
11. **YOUTUBE** - YouTube Channel
12. **TELEGRAM** - Telegram Channel

## Endpoints

### 1. Get All Social Links
**GET** `/v1/social-links`

**Query Parameters:**
- `careerProfileId` (UUID, optional) - Filter by career profile
- `platform` (enum, optional) - Filter by platform (see supported platforms above)
- `visibility` (enum, optional) - Filter by visibility: `PUBLIC | PRIVATE`
- `sortBy` (enum, optional) - Sort field: `platform | displayOrder | visibility | createdAt | updatedAt`
- `sortOrder` (enum, optional) - Sort direction: `asc | desc`
- `page` (number, optional) - Page number (default: 1, min: 1)
- `limit` (number, optional) - Records per page (default: 20, min: 1, max: 100)

**Response:**
```json
[
  {
    "id": "uuid",
    "careerProfileId": "uuid",
    "platform": "GITHUB",
    "url": "https://github.com/username",
    "displayName": "My GitHub",
    "visibility": "PUBLIC",
    "displayOrder": 0,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

---

### 2. Get Social Links by Career Profile ID
**GET** `/v1/social-links/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:** Array of social link objects

**Note:** Results are automatically sorted by `displayOrder` (ascending)

---

### 3. Get Social Link by Career Profile and Platform
**GET** `/v1/social-links/career-profile/:careerProfileId/platform/:platform`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier
- `platform` (string) - Platform name (e.g., GITHUB, LINKEDIN, etc.)

**Response:**
```json
{
  "id": "uuid",
  "careerProfileId": "uuid",
  "platform": "GITHUB",
  "url": "https://github.com/username",
  "displayName": "My GitHub",
  "visibility": "PUBLIC",
  "displayOrder": 0,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Errors:**
- `404 Not Found` - Social link not found

---

### 4. Get Social Link by ID
**GET** `/v1/social-links/:id`

**Path Parameters:**
- `id` (UUID) - Social link identifier

**Response:** Social link object (same as above)

**Errors:**
- `404 Not Found` - Social link not found

---

### 5. Create Social Link
**POST** `/v1/social-links`

**Request Body:**
```json
{
  "careerProfileId": "uuid",
  "platform": "GITHUB",
  "url": "https://github.com/username",
  "displayName": "My GitHub Profile",
  "visibility": "PUBLIC",
  "displayOrder": 0
}
```

**Validation Rules:**
- `careerProfileId` - Required UUID
- `platform` - Required enum (must be one of the 12 supported platforms)
- `url` - Required valid URL
- `displayName` - Optional string (max 100 chars)
- `visibility` - Optional enum: `PUBLIC | PRIVATE` (default: PUBLIC)
- `displayOrder` - Optional number (default: 0, min: 0)

**Response:** Created social link object

**Errors:**
- `400 Bad Request` - Validation error (invalid platform, malformed URL, etc.)

---

### 6. Update Social Link
**PATCH** `/v1/social-links/:id`

**Path Parameters:**
- `id` (UUID) - Social link identifier

**Request Body:** (All fields optional)
```json
{
  "url": "https://github.com/newusername",
  "displayName": "Updated GitHub Profile",
  "visibility": "PRIVATE",
  "displayOrder": 1
}
```

**Response:** Updated social link object

**Errors:**
- `404 Not Found` - Social link not found
- `400 Bad Request` - Validation error

---

### 7. Delete Social Link
**DELETE** `/v1/social-links/:id`

**Path Parameters:**
- `id` (UUID) - Social link identifier

**Response:** Deleted social link object

**Errors:**
- `404 Not Found` - Social link not found

---

## Query Examples

### Get all public links for a career profile
```
GET /v1/social-links?careerProfileId=550e8400-e29b-41d4-a716-446655440000&visibility=PUBLIC
```

### Filter by specific platform
```
GET /v1/social-links?careerProfileId=550e8400-e29b-41d4-a716-446655440000&platform=GITHUB
```

### Pagination with sorting
```
GET /v1/social-links?page=2&limit=10&sortBy=displayOrder&sortOrder=asc&careerProfileId=550e8400-e29b-41d4-a716-446655440000
```

### Get link by platform for a profile
```
GET /v1/social-links/career-profile/550e8400-e29b-41d4-a716-446655440000/platform/LINKEDIN
```

---

## Data Model

### SocialLinkEntity
- `id` (UUID) - Primary key
- `careerProfileId` (UUID) - Foreign key to career profile
- `platform` (enum) - Social platform identifier (12 options)
- `url` (text) - Full URL to the social profile
- `displayName` (varchar, 100, nullable) - Custom display name for the link
- `visibility` (enum) - PUBLIC or PRIVATE
- `displayOrder` (integer) - Display priority on profile (lower = higher priority)
- `createdAt` (timestamp) - Record creation time
- `updatedAt` (timestamp) - Last update time

### Indexes
- `social_links_career_profile_id_idx` - On `careerProfileId`
- `social_links_platform_idx` - On `platform`
- `social_links_visibility_idx` - On `visibility`
- `social_links_display_order_idx` - On `displayOrder`

### Default Values
- `visibility` - PUBLIC
- `displayOrder` - 0

---

## API Usage Patterns

### Portfolio Setup Flow
```bash
# 1. Create GitHub link
POST /v1/social-links
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "platform": "GITHUB",
  "url": "https://github.com/johndoe",
  "displayName": "GitHub Portfolio",
  "visibility": "PUBLIC",
  "displayOrder": 0
}

# 2. Create LinkedIn link
POST /v1/social-links
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "platform": "LINKEDIN",
  "url": "https://linkedin.com/in/johndoe",
  "displayName": "LinkedIn Profile",
  "visibility": "PUBLIC",
  "displayOrder": 1
}

# 3. Create personal website link
POST /v1/social-links
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "platform": "PERSONAL_WEBSITE",
  "url": "https://johndoe.com",
  "displayName": "Personal Portfolio",
  "visibility": "PUBLIC",
  "displayOrder": 2
}

# 4. Retrieve all public links for the profile
GET /v1/social-links/career-profile/550e8400-e29b-41d4-a716-446655440000?visibility=PUBLIC

# 5. Update GitHub link
PATCH /v1/social-links/{id}
{
  "displayOrder": 1
}

# 6. Get all links by visibility
GET /v1/social-links?careerProfileId=550e8400-e29b-41d4-a716-446655440000&visibility=PUBLIC
```

### Visibility Management
```bash
# Make Twitter private
PATCH /v1/social-links/{id}
{
  "visibility": "PRIVATE"
}

# Filter only public links
GET /v1/social-links/career-profile/550e8400-e29b-41d4-a716-446655440000?visibility=PUBLIC
```

---

## Notes

1. **URL Validation**: All URLs are validated using standard URL validation rules. Ensure URLs are complete (e.g., `https://github.com/username`)

2. **Platform Uniqueness**: A career profile can have multiple links per platform (each with different URLs), but typically you'd have one per platform

3. **Display Order**: Lower numbers appear first. You can reorder links by updating `displayOrder`

4. **Visibility Control**: 
   - `PUBLIC` - Visible in public profile preview
   - `PRIVATE` - Only visible to the profile owner and recruiters with access

5. **Display Names**: Optional custom labels for links (e.g., "My Portfolio" instead of just "PERSONAL_WEBSITE")

6. **Default Sorting**: When fetching by career profile, links are automatically sorted by `displayOrder` ascending

7. **Platform Icons**: Frontend can map platform enum to appropriate icons (GitHub icon, LinkedIn logo, etc.)

---

## Integration with Career Profile

The Social Links module is designed to work seamlessly with the Career Profile feature:

- Each social link belongs to one career profile
- Used to build a comprehensive portfolio view
- Supports future features like:
  - Profile completeness scoring
  - Recruiter profile preview
  - Portfolio showcase page
  - Social verification

---

## Future Enhancements

Potential future improvements:
1. Platform-specific validation (e.g., validate GitHub username format)
2. Platform-specific icon/metadata mapping
3. Link preview/verification (fetch meta tags, validate live)
4. Most viewed platform analytics
5. Suggested platforms based on profile data
6. Platform connection/disconnection workflow
