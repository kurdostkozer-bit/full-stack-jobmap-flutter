# Sprint 1 Plan - Complete Career Profile

**Duration**: 1 week  
**Goal**: 100% Career Profile complete (backend + frontend + UI)  
**Target**: User can create and manage complete career profile  

---

## Current Status

### ✅ Complete
- Profile (Domain + Data + BLoC)
- Skills (Domain + Data + BLoC)
- Experience (Domain + Data + BLoC)

### ⏳ Need to Build (Today)
- Education (Domain + Data + BLoC)
- Languages (Domain + Data + BLoC)
- Projects (Domain + Data + BLoC)
- Certificates (Domain + Data + BLoC)

### ⏳ Need to Build (This Sprint)
- UI Screens for all 10 features
- Service Locator registration
- Route registration
- Testing with real backend

---

## Detailed Task Breakdown

### Phase 1: Complete Backend Features (2-3 hours)

**For Each Feature (Education, Languages, Projects, Certificates):**

1. Copy Experience folder as template
2. Rename to feature name
3. Find/replace all references
4. Customize entity fields
5. Update API endpoints
6. Register in Service Locator
7. Add route in app router

**Files to create (per feature):**
- [ ] Entity with Freezed model
- [ ] Repository interface
- [ ] 4 UseCases (Get, Create, Update, Delete)
- [ ] Response/Request models
- [ ] Remote DataSource (CRUD endpoints)
- [ ] Local DataSource (caching)
- [ ] Repository implementation
- [ ] BLoC (Events, States, Handlers)

**Total for 4 features**: ~15 files each = 60 files

**Time estimate**: 2-3 hours (using template pattern)

---

### Phase 2: Build UI Screens (2-3 hours)

**For Each Feature, Create:**
- List screen showing all items
- Add/Edit form dialog
- Delete confirmation
- Error handling
- Loading states
- Empty state

**Template to use**: 
`lib/features/profile/presentation/screens/profile_screen.dart`

**Screens to build:**
- [ ] EducationScreen
- [ ] LanguagesScreen
- [ ] ProjectsScreen
- [ ] CertificatesScreen
- [ ] SocialLinksScreen
- [ ] AttachmentsScreen

**Plus**:
- [ ] Profile completion indicator
- [ ] Navigation hub (ProfileOverviewScreen improvement)

**Time estimate**: 2-3 hours (using template)

---

### Phase 3: Service Locator & Routes (15 minutes)

**Service Locator** (`lib/core/di/service_locator.dart`):
- [ ] Register 4 RemoteDataSources
- [ ] Register 4 LocalDataSources
- [ ] Register 4 Repositories
- [ ] Register 16 UseCases
- [ ] Register 4 BLoCs

**Routes** (`lib/core/router/app_router.dart`):
- [ ] Add 4 new routes with BLoC providers

**Time estimate**: 10-15 minutes

---

### Phase 4: Testing (2-3 hours)

**Manual Testing Checklist:**

For each feature:
- [ ] Load list (data comes from API)
- [ ] Create new item
- [ ] Edit existing item
- [ ] Delete item
- [ ] Error scenarios (offline, server error)
- [ ] Caching works (kill app, data still visible)
- [ ] Pagination (if applicable)

**Test Scenarios:**
- [ ] Light mode
- [ ] Dark mode
- [ ] Small screen (4")
- [ ] Large screen (6"+)
- [ ] Landscape orientation

**Automated Tests** (Optional but recommended):
- [ ] Unit tests for each BLoC
- [ ] Widget tests for screens

**Time estimate**: 2-3 hours

---

### Phase 5: Profile Completion Indicator (30 minutes)

**Goal**: Show user how complete their profile is

**Implementation**:
1. Backend: Calculate profile completion % (if not already done)
2. Frontend: Display as circular progress indicator
3. Show what's missing
4. Link to incomplete sections

**API**: GET /profile/completion-status

**Location**: 
- [ ] Dashboard (Sprint 2)
- [ ] Profile screen (this sprint)

**Time estimate**: 30 minutes

---

## Daily Breakdown

### Day 1: Backend Architecture
- [ ] Build Education feature (30 min)
- [ ] Build Languages feature (25 min)
- [ ] Build Projects feature (30 min)
- [ ] Build Certificates feature (30 min)
- [ ] Register all in Service Locator (10 min)
- [ ] Add all routes (5 min)

**Total**: ~2.5 hours

### Day 2: UI Screens (Part 1)
- [ ] EducationScreen (45 min)
- [ ] LanguagesScreen (30 min)
- [ ] ProjectsScreen (45 min)
- [ ] CertificatesScreen (45 min)

**Total**: ~2.5 hours

### Day 3: UI Screens (Part 2) + Testing
- [ ] SocialLinksScreen (optional, 30 min)
- [ ] AttachmentsScreen (optional, 30 min)
- [ ] Manual testing (2 hours)
- [ ] Fix bugs (30 min)

**Total**: ~3 hours

### Day 4: Polish & Final Testing
- [ ] Dark mode testing
- [ ] Small/large screen testing
- [ ] Error scenario testing
- [ ] Offline caching testing
- [ ] Fix remaining issues (1-2 hours)

**Total**: ~2 hours

---

## Key Points

### DRY Principle (Don't Repeat Yourself)
- Copy Experience template exactly
- Minimal customization needed
- Reuse screen components

### Testing First
- Test each feature with real backend before moving on
- Don't build all 4 features then test
- Build 1, test, then scale to others

### Focus on User Value
- Each screen should work perfectly
- No partial implementations
- Better to have 3 perfect features than 6 mediocre ones

### Use Design System
- All buttons from design system
- All typography consistent
- All spacing consistent

---

## Deliverables

### Code
- [ ] 60 new files (4 features × ~15 files each)
- [ ] 1500+ lines of code
- [ ] 0 lint errors
- [ ] All tests passing

### Features Implemented
- [ ] Education (Get, Create, Update, Delete)
- [ ] Languages (Get, Create, Update, Delete)
- [ ] Projects (Get, Create, Update, Delete)
- [ ] Certificates (Get, Create, Update, Delete)
- [ ] Profile Completion % display

### Testing
- [ ] All CRUD operations verified
- [ ] Caching verified
- [ ] Error handling verified
- [ ] Multi-screen compatibility verified

### Documentation
- [ ] Updated checklist
- [ ] Known issues documented
- [ ] Next sprint ready

---

## Success Criteria

✅ **User can:**
1. View all profile sections
2. Add new items in each section
3. Edit existing items
4. Delete items
5. See profile completion %
6. Go offline and still view cached data
7. See loading states
8. See error messages on failures

✅ **Code Quality:**
- Zero lint errors
- All tests passing
- No crashes
- Responsive on all devices

✅ **Performance:**
- List loads < 2 seconds
- Add/Edit/Delete < 1 second
- Smooth scrolling (60fps)
- No memory leaks

---

## Risk Mitigation

### Risk: Build something then test it all at once
**Mitigation**: Build feature 1, test, then build features 2-4

### Risk: Run out of time
**Mitigation**: 
- Reuse templates (minimal customization)
- Skip optional features (SocialLinks, Attachments) if time running out
- Skip UI polish if time running out (functionality first)

### Risk: API changes break implementation
**Mitigation**: 
- Verify API endpoints exist before building
- Test with real backend as soon as possible

### Risk: Errors in bulk implementation
**Mitigation**:
- Test each feature independently
- Don't copy-paste blindly, understand what you're copying

---

## Optional (If Time Permits)

- [ ] Drag-to-reorder for career items
- [ ] Date pickers for experience/education
- [ ] File upload for attachments
- [ ] Image cropping for profile picture
- [ ] Profile preview (what it looks like to recruiters)
- [ ] Undo/Redo functionality
- [ ] Bulk delete

---

## Definition of "Done"

Sprint 1 is complete when:

✅ All 10 Career Profile features working (backend + frontend)  
✅ All CRUD operations tested with real backend  
✅ No crashes or unhandled errors  
✅ Responsive on all screen sizes  
✅ UI polished and professional  
✅ User can complete profile setup 100%  
✅ Can proceed directly to Sprint 2 (Dashboard)  

---

## Exit Criteria

**Do NOT move to Sprint 2 until:**
- All 10 features are 100% functional
- Can complete profile without errors
- Profile completion % calculated correctly
- All screens responsive
- Caching working (tested by killing app)

---

## Resources

- **Template**: `lib/features/experience/` - Use this as template
- **Guide**: `CAREER_PROFILE_TEMPLATE.md` - Follow this exactly
- **Tests**: `TESTING_GUIDE.md` - Test using these procedures
- **Components**: Design System - Reuse existing UI components

---

## Next Sprint Preview

Once this sprint is complete:

**Sprint 2**: Build Dashboard
- Load real user data
- Show profile completion
- Show recent jobs
- Show applications count
- Make it beautiful

**Then Sprint 3**: Build Jobs discovery

---

## Go! 🚀

Everything is ready:
- ✅ Pattern established
- ✅ Template ready
- ✅ Time estimate clear
- ✅ Success criteria defined
- ✅ Risk mitigated

**Start with copying Experience feature.**

---

**Questions?** Refer to CAREER_PROFILE_TEMPLATE.md

**Ready?** Let's complete the Career Profile!

🎯 Sprint 1 Target: 100% Career Profile Complete
