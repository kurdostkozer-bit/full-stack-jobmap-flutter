# Job Preferences API Endpoints

Base URL: `/v1/job-preferences`

## Overview
The Job Preferences feature captures what users are looking for in their next role. This data forms the foundation for the Matching Engine, enabling intelligent job recommendations and candidate-job fit scoring.

## Supported Values

### Work Environments
- **ON_SITE** - Office/On-premise work
- **REMOTE** - Work from home
- **HYBRID** - Mix of office and remote

### Employment Types
- **FULL_TIME** - Full-time employment
- **PART_TIME** - Part-time employment
- **CONTRACT** - Contract/Temporary work
- **INTERNSHIP** - Internship positions
- **FREELANCE** - Freelance/Project-based
- **TEMPORARY** - Temporary positions

### Currencies
```
USD (US Dollar)          EUR (Euro)              GBP (British Pound)
AED (UAE Dirham)         SAR (Saudi Riyal)       KWD (Kuwaiti Dinar)
QAR (Qatari Riyal)       OMR (Omani Rial)        BHD (Bahraini Dinar)
JOD (Jordanian Dinar)    EGP (Egyptian Pound)    IQD (Iraqi Dinar)
LBP (Lebanese Pound)
```

## Endpoints

### 1. Create Job Preferences
**POST** `/v1/job-preferences`

**Request Body:**
```json
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "desiredJobTitles": ["Senior Software Engineer", "Tech Lead", "Staff Engineer"],
  "preferredJobCategories": ["Technology", "Software Development"],
  "workEnvironments": ["REMOTE", "HYBRID"],
  "employmentTypes": ["FULL_TIME"],
  "minimumSalary": 120000,
  "maximumSalary": 200000,
  "currency": "USD",
  "preferredCities": ["San Francisco", "New York", "Remote"],
  "preferredCountries": ["United States"],
  "openToRelocation": false,
  "availableImmediately": true,
  "noticePeriodDays": 0,
  "willingToTravel": false,
  "openToInternationalJobs": false
}
```

**Validation Rules:**
- `careerProfileId` - Required UUID (one-to-one with job preferences)
- `desiredJobTitles` - Optional array of strings
- `preferredJobCategories` - Optional array of strings
- `workEnvironments` - Optional array of enums
- `employmentTypes` - Optional array of enums
- `minimumSalary` - Optional integer (min: 0)
- `maximumSalary` - Optional integer (min: 0)
- `currency` - Optional enum (default: USD)
- `preferredCities` - Optional array of strings
- `preferredCountries` - Optional array of strings
- `openToRelocation` - Optional boolean (default: false)
- `availableImmediately` - Optional boolean (default: false)
- `noticePeriodDays` - Optional integer >= 0 (default: 0)
- `willingToTravel` - Optional boolean (default: false)
- `openToInternationalJobs` - Optional boolean (default: false)

**Response:**
```json
{
  "id": "uuid",
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "desiredJobTitles": ["Senior Software Engineer", "Tech Lead", "Staff Engineer"],
  "preferredJobCategories": ["Technology", "Software Development"],
  "workEnvironments": ["REMOTE", "HYBRID"],
  "employmentTypes": ["FULL_TIME"],
  "minimumSalary": 120000,
  "maximumSalary": 200000,
  "currency": "USD",
  "preferredCities": ["San Francisco", "New York", "Remote"],
  "preferredCountries": ["United States"],
  "openToRelocation": false,
  "availableImmediately": true,
  "noticePeriodDays": 0,
  "willingToTravel": false,
  "openToInternationalJobs": false,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

**Errors:**
- `400 Bad Request` - Invalid career profile ID or validation error
- `409 Conflict` - Job preferences already exist for this career profile

---

### 2. Get Job Preferences by Career Profile
**GET** `/v1/job-preferences/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:** Job preference object

**Errors:**
- `404 Not Found` - No job preferences found for this career profile

---

### 3. Get Job Preferences by ID
**GET** `/v1/job-preferences/:id`

**Path Parameters:**
- `id` (UUID) - Job preferences identifier

**Response:** Job preference object

**Errors:**
- `404 Not Found` - Job preferences not found

---

### 4. Update Job Preferences
**PATCH** `/v1/job-preferences/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Request Body:** (All fields optional)
```json
{
  "desiredJobTitles": ["Senior Engineer", "Tech Lead"],
  "minimumSalary": 130000,
  "currency": "EUR",
  "openToRelocation": true
}
```

**Response:** Updated job preference object

**Errors:**
- `404 Not Found` - Job preferences not found
- `400 Bad Request` - Validation error

---

### 5. Delete Job Preferences
**DELETE** `/v1/job-preferences/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:** Deleted job preference object

**Errors:**
- `404 Not Found` - Job preferences not found

---

## Query Examples

### Create basic preferences
```bash
POST /v1/job-preferences
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "desiredJobTitles": ["Backend Engineer"],
  "workEnvironments": ["REMOTE"],
  "employmentTypes": ["FULL_TIME"]
}
```

### Update salary expectations
```bash
PATCH /v1/job-preferences/career-profile/550e8400-e29b-41d4-a716-446655440000
{
  "minimumSalary": 100000,
  "maximumSalary": 150000,
  "currency": "USD"
}
```

### Get preferences for matching
```bash
GET /v1/job-preferences/career-profile/550e8400-e29b-41d4-a716-446655440000
```

---

## Data Model

### JobPreferenceEntity
- `id` (UUID) - Primary key
- `careerProfileId` (UUID) - Foreign key, unique (one-to-one with career profile)
- `desiredJobTitles` (JSONB array) - Target job titles
- `preferredJobCategories` (JSONB array) - Job categories/industries
- `workEnvironments` (JSONB array) - Work location preferences
- `employmentTypes` (JSONB array) - Employment type preferences
- `minimumSalary` (integer, nullable) - Minimum salary expectation
- `maximumSalary` (integer, nullable) - Maximum salary expectation
- `currency` (enum) - Salary currency (default: USD)
- `preferredCities` (JSONB array) - Preferred cities
- `preferredCountries` (JSONB array) - Preferred countries
- `openToRelocation` (boolean) - Open to relocation (default: false)
- `availableImmediately` (boolean) - Available immediately (default: false)
- `noticePeriodDays` (integer) - Notice period in days (default: 0)
- `willingToTravel` (boolean) - Willing to travel (default: false)
- `openToInternationalJobs` (boolean) - Open to international jobs (default: false)
- `createdAt` (timestamp) - Record creation time
- `updatedAt` (timestamp) - Last update time

### Indexes
- `job_preferences_career_profile_id_idx` - On `careerProfileId` (unique)

---

## API Usage Patterns

### Minimal Job Preferences
```bash
POST /v1/job-preferences
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "desiredJobTitles": ["Software Engineer"]
}
```

### Comprehensive Preferences
```bash
POST /v1/job-preferences
{
  "careerProfileId": "550e8400-e29b-41d4-a716-446655440000",
  "desiredJobTitles": ["Senior Engineer", "Tech Lead"],
  "preferredJobCategories": ["Technology", "FinTech"],
  "workEnvironments": ["REMOTE", "HYBRID"],
  "employmentTypes": ["FULL_TIME", "CONTRACT"],
  "minimumSalary": 100000,
  "maximumSalary": 200000,
  "currency": "USD",
  "preferredCities": ["New York", "San Francisco", "Remote"],
  "preferredCountries": ["United States", "Canada"],
  "openToRelocation": false,
  "availableImmediately": true,
  "noticePeriodDays": 30,
  "willingToTravel": true,
  "openToInternationalJobs": true
}
```

### Progressive Preference Building
```bash
# 1. Create initial preferences
POST /v1/job-preferences
{
  "careerProfileId": "...",
  "desiredJobTitles": ["Engineer"]
}

# 2. Add salary expectations
PATCH /v1/job-preferences/career-profile/...
{
  "minimumSalary": 100000,
  "maximumSalary": 150000
}

# 3. Refine work environment
PATCH /v1/job-preferences/career-profile/...
{
  "workEnvironments": ["REMOTE", "HYBRID"]
}

# 4. Get final preferences for profile
GET /v1/job-preferences/career-profile/...
```

---

## Integration with Matching Engine

The Job Preferences API provides the data needed for matching:

1. **Candidate Profile** → Job Preferences (via careerProfileId)
2. **Job Posting** → Compare against preferences
3. **Scoring Algorithm** →
   - Title match: Compare job title with `desiredJobTitles`
   - Salary match: Check `minimumSalary` and `maximumSalary`
   - Location match: Compare job location with `preferredCities` and `preferredCountries`
   - Work type match: Compare with `workEnvironments` and `employmentTypes`
   - Availability match: Check `availableImmediately` and `noticePeriodDays`
   - Travel/International: Consider `willingToTravel` and `openToInternationalJobs`

---

## Notes for Matching Engine Implementation

**Priority Fields** (for MVP matching):
1. `desiredJobTitles` - High priority
2. `workEnvironments` - High priority
3. `employmentTypes` - High priority
4. `minimumSalary` / `maximumSalary` - High priority

**Secondary Fields** (for scoring):
5. `preferredCities` / `preferredCountries` - Medium priority
6. `openToRelocation` - Medium priority
7. `availableImmediately` - Low priority

**Advanced Fields** (future use):
8. `preferredJobCategories` - For category-based recommendations
9. `willingToTravel` - For travel-intensive roles
10. `openToInternationalJobs` - For global opportunities

---

## Best Practices

1. **Complete Profile First** - Encourage users to fill job preferences as part of profile completion
2. **Flexible Ranges** - Allow null salary values for users open to negotiation
3. **Multi-select** - Support multiple values for titles, locations, and employment types
4. **Regular Updates** - Prompt users to update preferences when job market changes
5. **Default Values** - Initialize with sensible defaults to reduce friction

---

## Future Enhancements

Potential improvements:
1. Preferred company sizes
2. Industry exclusions (not interested in)
3. Technology stack preferences
4. Company culture preferences
5. Compensation components (stock, bonus, benefits)
6. Time zone preferences
7. Role-specific requirements (senior level, team size, etc.)
8. Visibility settings (public/private preferences)
9. Preference templates for common roles
10. Preference history/versioning
