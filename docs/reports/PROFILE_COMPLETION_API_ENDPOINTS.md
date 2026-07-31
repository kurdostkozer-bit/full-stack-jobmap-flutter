# Profile Completion API Endpoints

Base URL: `/v1/profile-completion`

## Overview
The Profile Completion feature calculates the completion percentage of a user's career profile dynamically based on existing data. This system incentivizes users to fill out their complete profile and provides actionable suggestions for improvement.

## Weighted Scoring System

The completion score is calculated based on 10 sections, each with a specific weight:

| Section | Weight | Criteria |
|---------|--------|----------|
| **Career Profile** | 15% | Headline/Summary + Profession Title filled |
| **Skills** | 10% | At least 1 skill added |
| **Experience** | 15% | At least 1 experience entry added |
| **Education** | 10% | At least 1 education entry added |
| **Languages** | 10% | At least 1 language added |
| **Projects** | 10% | At least 1 project added |
| **Certificates** | 5% | At least 1 certificate added |
| **Social Links** | 5% | At least 1 social link added |
| **Attachments** | 10% | At least 1 document uploaded |
| **Job Preferences** | 10% | Job preferences configured |

**Total: 100%**

## Endpoints

### Get Profile Completion Status
**GET** `/v1/profile-completion/career-profile/:careerProfileId`

**Path Parameters:**
- `careerProfileId` (UUID) - Career profile identifier

**Response:**
```json
{
  "percentage": 82,
  "completedSections": 8,
  "totalSections": 10,
  "sections": {
    "careerProfile": true,
    "skills": true,
    "experience": true,
    "education": true,
    "languages": true,
    "projects": false,
    "certificates": true,
    "socialLinks": true,
    "attachments": true,
    "jobPreferences": false
  },
  "nextSuggestions": [
    "Add your projects",
    "Set your job preferences"
  ]
}
```

**Response Fields:**
- `percentage` (number, 0-100) - Overall profile completion percentage
- `completedSections` (number) - Number of completed sections
- `totalSections` (number) - Total number of sections (always 10)
- `sections` (object) - Boolean flags for each section's completion status
- `nextSuggestions` (array) - Prioritized list of suggestions to improve profile

**Errors:**
- `400 Bad Request` - Invalid career profile ID format
- `404 Not Found` - Career profile not found

---

## Query Examples

### Check profile completion
```bash
GET /v1/profile-completion/career-profile/550e8400-e29b-41d4-a716-446655440000
```

### Response for incomplete profile
```json
{
  "percentage": 30,
  "completedSections": 3,
  "totalSections": 10,
  "sections": {
    "careerProfile": true,
    "skills": true,
    "experience": false,
    "education": false,
    "languages": false,
    "projects": false,
    "certificates": false,
    "socialLinks": false,
    "attachments": false,
    "jobPreferences": false
  },
  "nextSuggestions": [
    "Add your work experience",
    "Add your education history",
    "Add languages you speak",
    "Add your projects",
    "Add your certifications",
    "Add your portfolio and social links",
    "Upload your resume and documents",
    "Set your job preferences"
  ]
}
```

---

## Completion Milestones

Users can work towards these milestones:

| Percentage | Status | Milestone |
|-----------|--------|-----------|
| 0-25% | Starting | Beginning to build profile |
| 26-50% | In Progress | Basic profile structure in place |
| 51-75% | Almost There | Most sections filled |
| 76-99% | Nearly Complete | Just a few sections to go |
| 100% | Complete | Fully optimized profile |

---

## Data Completeness Criteria

### Career Profile (15%)
- **Required:** Headline/Summary AND Profession Title
- **Examples:**
  - ✅ Headline: "Senior Software Engineer with 10 years experience"
  - ✅ Profession Title: "Engineering Manager"
  - ❌ Only headline, no profession title

### Skills (10%)
- **Required:** At least 1 skill
- **Example:** JavaScript, Leadership, Project Management

### Experience (15%)
- **Required:** At least 1 work experience entry
- **Example:** Senior Engineer at Google, 2020-2023

### Education (10%)
- **Required:** At least 1 education entry
- **Example:** BS Computer Science, Stanford University

### Languages (10%)
- **Required:** At least 1 language
- **Example:** English (Fluent), Arabic (Native)

### Projects (10%)
- **Required:** At least 1 project
- **Example:** E-commerce Platform, built with React and Node.js

### Certificates (5%)
- **Required:** At least 1 certificate
- **Example:** AWS Certified Solutions Architect

### Social Links (5%)
- **Required:** At least 1 social link
- **Example:** GitHub profile, LinkedIn, Personal website

### Attachments (10%)
- **Required:** At least 1 document
- **Example:** Resume, Portfolio PDF, Cover Letter

### Job Preferences (10%)
- **Required:** Job preferences configured
- **Example:** Desired job titles, work environment, employment type

---

## Suggestions Algorithm

The API provides smart suggestions by:

1. **Checking Incomplete Sections** - Identifying sections with 0% completion
2. **Prioritizing by Weight** - Showing highest-weighted incomplete sections first
3. **Actionable Messages** - Providing clear next steps

**Suggestion Priority Order:**
1. Career Profile (15%) - Foundation for profile
2. Experience (15%) - Most valuable for recruiters
3. Attachments (10%) - Resume is critical
4. Job Preferences (10%) - For matching
5. Skills (10%)
6. Education (10%)
7. Languages (10%)
8. Projects (10%)
9. Certificates (5%)
10. Social Links (5%)

---

## Use Cases

### Profile Onboarding
```bash
# Step 1: User creates profile
POST /v1/career-profiles
→ completion: 15%

# Step 2: User adds skills
POST /v1/skills
GET /v1/profile-completion/career-profile/{id}
→ completion: 25%

# Step 3: Continue filling sections...
```

### Dashboard Widget
Display completion status on user dashboard:
```
Profile Completion: 72%
████████░░ 8/10 sections

Next steps:
- Add your projects
- Upload your resume
```

### Gamification
```
Achievement: "Profile 50% Complete!" 🎉
Achievement: "Profile 100% Complete!" 🏆
```

### Incentive System
Link profile completion to:
- Feature unlock (e.g., unlock job matching at 50%)
- Priority in searches (higher completion = higher visibility)
- Referral rewards (bonus for completing profile)

---

## Performance Considerations

**Queries Performed:**
- 1 query to CareerProfile (header/title check)
- 1 query per section (9 total queries)
- **Total: 10 queries per request**

**Optimization Strategies:**

1. **Client-side Caching**
   - Cache results for 5 minutes
   - Invalidate on data updates

2. **Database Indexing** (Already in place)
   - Index on `careerProfileId` for each table

3. **Future: Materialized View**
   - Store completion score in database
   - Update on section changes
   - Reduces query count to 1

4. **Parallel Queries** (Future)
   - Query all sections simultaneously
   - Use Promise.all() for performance

---

## Integration Points

### User Onboarding
- Show completion percentage after each section
- Display suggestions to encourage profile building

### Profile Page
- Widget showing overall completion
- Progress bar with completion percentage
- List of suggested next actions

### Search/Discovery
- Prioritize candidates with higher completion
- Filter by completion threshold

### Matching Engine
- Use completion score as quality metric
- Better matches for more complete profiles

### Admin Dashboard
- Monitor average profile completion
- Identify sections users skip most
- Optimize onboarding based on completion patterns

---

## Future Enhancements

Potential improvements:

1. **Weighted Suggestions**
   - Show highest-impact sections first
   - Calculate "effort vs. reward"

2. **Milestone Notifications**
   - Alert user at 25%, 50%, 75%, 100%
   - Celebrate achievements

3. **Time-based Insights**
   - Days since profile started
   - Average days to 50% completion
   - Predict completion date

4. **A/B Testing**
   - Test different weights
   - Test different suggestions
   - Optimize for completion

5. **Section-specific Tips**
   - "Good skills include: JavaScript, React, Node.js"
   - "Recommended experience length: 3-5 entries"
   - "Upload both resume and cover letter"

6. **Competitive Benchmarking**
   - Compare to industry average
   - Show percentile ranking
   - "You're ahead of 75% of candidates"

7. **Historical Tracking**
   - Track completion changes over time
   - Show progress graph
   - Identify stalled profiles

8. **Predictive Analytics**
   - ML model predicting likelihood of hire based on completion
   - Section impact scoring
   - Personalized recommendations

---

## Notes

- **No Database Table** - Completion is calculated dynamically from existing data
- **Real-time Calculation** - Always reflects current profile state
- **Extensible Weights** - Easy to adjust section weights in future
- **Caching Ready** - Can add caching layer without schema changes
- **Async Operations** - All database queries can be parallelized
- **Performance** - ~50-100ms for complete calculation with proper indexing

---

## Example Implementation

### Display Completion on Frontend
```javascript
// Get completion status
const completion = await fetch(
  `/v1/profile-completion/career-profile/${profileId}`
);

// Display suggestions
completion.nextSuggestions.forEach(suggestion => {
  showToast(`Next step: ${suggestion}`);
});

// Show progress
updateProgressBar(completion.percentage);
```

### Trigger on Profile Updates
```javascript
// When user adds experience, refresh completion
await addExperience(data);
const updated = await refreshCompletion();

// Show improvement
if (updated.percentage > previous.percentage) {
  showNotification('Great! Your profile is now 45% complete!');
}
```
