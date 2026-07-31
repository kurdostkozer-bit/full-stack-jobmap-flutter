# JobMap MVP Roadmap

**Objective**: Build a complete, working job marketplace MVP that users can test end-to-end.

**Timeline**: 5 Sprints (2-3 weeks)

---

## Current State

| Component | Status | Notes |
|-----------|--------|-------|
| Backend Foundation | ✅ 100% | All infrastructure ready |
| Flutter Foundation | ✅ 100% | Design System + Architecture complete |
| Auth System | ✅ 100% | Register → Login → Auto-Login working |
| Career Profile Backend | ✅ 100% | All APIs built and tested |
| Career Profile Frontend | 🟡 60% | Profile + Skills + Experience done, 4 features remaining |
| Dashboard | ⏳ 0% | Ready to build with real data |
| Jobs Backend | ✅ 100% | APIs built |
| Jobs Frontend | ⏳ 0% | Ready to build |
| Applications Backend | ✅ 100% | APIs built |
| Applications Frontend | ⏳ 0% | Ready to build |
| **MVP Readiness** | **🟡 50%** | **Halfway there** |

---

## Definition of MVP Success

A user can complete this **End-to-End User Journey**:

```
1. Register                    ✅ (Auth done)
2. Verify Email               ✅ (Auth done)
3. Login                       ✅ (Auth done)
4. Create Career Profile      🟡 (In Progress - 60% done)
5. Complete Skills/Experience  🟡 (In Progress - 60% done)
6. Browse Jobs                ⏳ (Next: Sprint 3)
7. Search & Filter            ⏳ (Next: Sprint 3)
8. View Job Details           ⏳ (Next: Sprint 3)
9. Apply to Job               ⏳ (Next: Sprint 3)
10. Track Application Status  ⏳ (Next: Sprint 4)
11. Receive Notification      ⏳ (Next: Sprint 5)
```

**MVP is ready when:** All 11 steps work flawlessly end-to-end.

---

## Sprint Breakdown

### Sprint 1: Complete Career Profile (1 week)

**Goal**: 100% Career Profile backend + UI

**Remaining Backend Work** (If any):
- [ ] Verify all 10 endpoints working
- [ ] Test caching logic
- [ ] Test error scenarios

**Frontend Work** (New):
- [ ] Build Education screen (copy Experience template)
- [ ] Build Languages screen (simpler, no description)
- [ ] Build Projects screen (add technologies array)
- [ ] Build Certificates screen (add verification status)
- [ ] Build Profile Completion % display
- [ ] Test all 6 screens with real API

**Register Services** (Already partially done):
- [x] Profile feature registered
- [x] Skills feature registered
- [ ] Experience feature registered ← Complete today
- [ ] Education feature registered ← Build this sprint
- [ ] Languages feature registered ← Build this sprint
- [ ] Projects feature registered ← Build this sprint
- [ ] Certificates feature registered ← Build this sprint

**Definition of Done**:
- [ ] All 10 features fully operational
- [ ] All CRUD operations working (Create, Read, Update, Delete)
- [ ] Caching working (offline access)
- [ ] Error handling verified
- [ ] Can complete steps 1-5 of user journey
- [ ] Zero crashes
- [ ] UI responsive on all screen sizes

**Deliverable**: Career Profile module 100% complete, ready to show users

---

### Sprint 2: Dashboard with Real Data (4-5 days)

**Goal**: Transform Home screen into real dashboard showing user data

**Backend Requirements** (Already exist):
- [ ] GET /profile (user basic info)
- [ ] GET /profile/skills (list skills)
- [ ] GET /profile/experience (list experience)
- [ ] GET /jobs/recommended (for this user)
- [ ] GET /applications (user's applications)
- [ ] GET /jobs/saved (saved jobs)
- [ ] GET /notifications (recent)

**Frontend Work**:
1. **Profile Section**
   - [ ] Display user name + profile image
   - [ ] Show profile completion % (0-100%)
   - [ ] Show "Complete Profile" CTA if < 100%

2. **Career Summary**
   - [ ] Show latest job title + company
   - [ ] Show number of skills
   - [ ] Show years of experience

3. **Jobs Section**
   - [ ] "Recommended Jobs for You" (5-10 jobs)
   - [ ] "Recent Job Postings" (5-10 jobs)
   - [ ] "Applied Jobs" (count)
   - [ ] "Saved Jobs" (count)

4. **Quick Actions**
   - [ ] "View Profile" button
   - [ ] "Browse Jobs" button
   - [ ] "View Applications" button

5. **Notifications** (if backend ready)
   - [ ] Recent notifications (3-5)
   - [ ] "View All" link

**Definition of Done**:
- [ ] Dashboard loads with real user data
- [ ] All cards are populated with actual data from backend
- [ ] Responsive design (small, medium, large screens)
- [ ] Smooth pull-to-refresh
- [ ] Error states handled (no internet, server error)
- [ ] Can complete step 6 of user journey (but from home, not jobs screen yet)

**Deliverable**: Real-time dashboard that reflects user's career profile

---

### Sprint 3: Jobs Module - Discovery & Browsing (1 week)

**Goal**: Users can discover, search, filter, and apply to jobs

**Backend Requirements** (Verify they exist):
- [ ] GET /jobs (list with pagination)
- [ ] GET /jobs?search=keyword (search)
- [ ] GET /jobs?filter=... (filters)
- [ ] GET /jobs/:id (job details)
- [ ] POST /applications (apply to job)
- [ ] POST /jobs/:id/save (save job)
- [ ] GET /jobs/saved (saved jobs list)

**Frontend Work**:

1. **Jobs List Screen**
   ```
   Header: Search bar + Filter button
   Content: Cards showing:
     - Company logo
     - Job title
     - Company name
     - Location
     - Salary (if available)
     - Posted time
   Footer: Pagination/infinite scroll
   ```

2. **Search & Filter**
   - [ ] Search by job title
   - [ ] Filter by:
     - Location
     - Experience level
     - Job type (Full-time, Part-time, etc.)
     - Salary range
     - Industry

3. **Job Details Screen**
   ```
   Header: Back button + Save/Unsave button
   Content:
     - Company info
     - Job title
     - Location
     - Salary
     - Posted date
     - Full job description
     - Requirements
     - Benefits
   Action: "Apply Now" button
   ```

4. **Apply Flow**
   - [ ] Show "Apply" dialog
   - [ ] Pre-populate with user's profile info
   - [ ] Allow adding cover letter
   - [ ] Show confirmation
   - [ ] Redirect to applications page

5. **Saved Jobs**
   - [ ] List of user's saved jobs
   - [ ] Unsave option
   - [ ] Apply directly from saved list

**Definition of Done**:
- [ ] Users can search for jobs
- [ ] Users can filter results
- [ ] Users can view job details
- [ ] Users can apply (with confirmation)
- [ ] Users can save/unsave jobs
- [ ] Can complete steps 6-9 of user journey

**Deliverable**: Fully functional job discovery and application system

---

### Sprint 4: Application Tracking (4-5 days)

**Goal**: Users can track applications and see their status

**Backend Requirements** (Verify they exist):
- [ ] GET /applications (list with status)
- [ ] GET /applications/:id (details)
- [ ] GET /applications/:id/timeline (status updates)
- [ ] PATCH /applications/:id (withdraw)
- [ ] GET /applications/stats (count by status)

**Frontend Work**:

1. **Applications List Screen**
   ```
   Header: Filter by status (All, Applied, In Review, Interview, Rejected, Offered)
   Content: Cards showing:
     - Job title
     - Company name
     - Applied date
     - Current status (badge)
     - Last update
   ```

2. **Application Details Screen**
   ```
   Header: Job title + Company
   Sections:
     - Job Overview (title, company, location)
     - Application Status
     - Timeline (when status changed)
     - Actions (Withdraw, Message)
   ```

3. **Application Timeline**
   - [ ] Show when application was submitted
   - [ ] Show status changes over time
   - [ ] Show any messages/feedback from recruiter (if available)

4. **Statistics**
   - [ ] Total applications
   - [ ] Count by status (Applied, In Review, Interview, Offered, Rejected)
   - [ ] Success rate (if enough data)

5. **Notifications** (Integrated)
   - [ ] Notify when status changes
   - [ ] Show in-app notification
   - [ ] Optional push notification

**Definition of Done**:
- [ ] Users can see all their applications
- [ ] Users can view application details
- [ ] Users can see application timeline
- [ ] Users can withdraw applications
- [ ] Notifications work (at least in-app)
- [ ] Can complete steps 1-10 of user journey

**Deliverable**: Complete application tracking system

---

### Sprint 5: Notifications (Optional, Polish)

**Goal**: Keep users informed of important events

**Features**:
1. **In-App Notifications**
   - [ ] New job recommendations
   - [ ] Application status updates
   - [ ] New messages
   - [ ] Profile updates

2. **Push Notifications** (Optional)
   - [ ] Firebase Cloud Messaging setup
   - [ ] Send notifications to device
   - [ ] Deep linking (tap notification → app)

3. **Notification Center**
   - [ ] List of all notifications
   - [ ] Mark as read
   - [ ] Delete
   - [ ] Group by type

**Definition of Done**:
- [ ] In-app notifications working
- [ ] Notification center accessible
- [ ] Can complete step 11 of user journey
- [ ] All 11 steps of user journey work end-to-end

**Deliverable**: MVP Complete! 🎉

---

## Sprint Summary

| Sprint | Duration | Focus | Delivery |
|--------|----------|-------|----------|
| 1 | 1 week | Career Profile (100%) | User can complete profile |
| 2 | 4-5 days | Dashboard + Real Data | User sees personalized home |
| 3 | 1 week | Jobs Discovery | User can find & apply to jobs |
| 4 | 4-5 days | Application Tracking | User can track applications |
| 5 | 2-3 days | Notifications | User stays informed |
| **Total** | **~3-4 weeks** | **Complete MVP** | **Ready for Users** |

---

## What NOT to Do During MVP Phase

❌ Add new infrastructure layers  
❌ Refactor existing code  
❌ Add cosmetic features  
❌ Build admin panels  
❌ Implement advanced analytics  
❌ Add A/B testing  

**Focus only on**: Features users need for the 11-step journey

---

## MVP Success Criteria

### Must Have (Non-negotiable)
- ✅ Register + verify email
- ✅ Login + auto-login
- ✅ Build & edit career profile
- ✅ View recommended jobs
- ✅ Search & filter jobs
- ✅ Apply to jobs
- ✅ Track application status
- ✅ Profile completion indicator

### Should Have (High priority)
- 🟡 Save jobs
- 🟡 Notifications
- 🟡 Dashboard with real data
- 🟡 Search history

### Nice to Have (Lower priority)
- ⏳ Advanced filters
- ⏳ Job recommendations ML
- ⏳ Messaging with recruiters
- ⏳ Profile scoring

---

## Testing Before Release

### Manual Testing (Required)
- [ ] Test 11-step user journey on real device
- [ ] Test with 2-3 different user accounts
- [ ] Test network errors (offline, timeout, server error)
- [ ] Test on small screen (4") and large screen (6"+)
- [ ] Test light mode and dark mode
- [ ] Test with RTL (Arabic) if supporting multilingual

### Automated Testing (Recommended)
- [ ] Unit tests for new BLoCs
- [ ] Widget tests for new screens
- [ ] Integration tests for critical flows

### Load Testing (Optional)
- [ ] Can backend handle 100 concurrent users?
- [ ] Are response times acceptable?

---

## Release Checklist

- [ ] All 11 user journey steps working
- [ ] Zero crashes on manual testing
- [ ] All lint errors fixed: `flutter analyze`
- [ ] All tests passing: `flutter test`
- [ ] No console errors/warnings
- [ ] Performance acceptable (< 3s load time)
- [ ] Screenshots taken for app store
- [ ] Privacy policy written
- [ ] Terms of service written
- [ ] Backend deployed to production
- [ ] Flutter app built: `flutter build apk --release`

---

## Post-MVP (Sprint 6+)

Once MVP is released, focus on:
- User feedback collection
- Bug fixes & stability
- Performance optimization
- Advanced features
- Scale infrastructure
- Expand job categories
- Add recruiter portal
- Build matching algorithm

---

## Key Principle

**Every sprint must deliver user-facing value.**

If a sprint doesn't result in something users can see and use, it's the wrong sprint.

---

## Success Metrics

**Sprint 1**: User can complete profile (100% feature complete)  
**Sprint 2**: User sees personalized data (real-time working)  
**Sprint 3**: User can find & apply (job discovery working)  
**Sprint 4**: User can track applications (visibility working)  
**Sprint 5**: User stays informed (notifications working)  

**MVP Release**: User can go from signup to first application to tracking it. ✅

---

## Timeline

```
Week 1: Complete Career Profile (Sprint 1) ← Start immediately
Week 2: Dashboard + Jobs discovery (Sprint 2-3)
Week 3: Application tracking (Sprint 4)
Week 4: Notifications + Polish (Sprint 5)

End of Week 4: MVP Ready for Release 🚀
```

---

**Status**: Ready to implement  
**Confidence**: High (90%+)  
**Risk**: Low (pattern proven, APIs exist)  
**Next Action**: Start Sprint 1 immediately

Let's ship it! 🚀
