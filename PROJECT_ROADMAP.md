# JobMap - Project Roadmap

**Project Status:** Phase 2 Complete ✅  
**Current Completion:** 40-50% of full platform  
**Last Updated:** July 29, 2026

---

## ✅ What's Done

### Foundation (Phase 1)
- ✅ Auth System (JWT, registration, login, refresh)
- ✅ Users Entity & Management
- ✅ Database setup with Drizzle + PostgreSQL

### Career Profile Domain (Phase 1)
- ✅ Career Profile (core entity)
- ✅ Skills (with endorsements ready)
- ✅ Experience (timeline-based)
- ✅ Education
- ✅ Languages
- ✅ Projects (portfolio with display order)
- ✅ Certificates (verification-ready)
- ✅ Social Links (portfolio integration)
- ✅ Attachments (file storage with provider abstraction)
- ✅ Job Preferences
- ✅ Profile Completion (weighted scoring)

### Growth & Monetization (Phase 1)
- ✅ Referral System (codes, tracking, manual payments)

### Business Domain (Phase 2)
- ✅ Companies (with verification, size, industry)
- ✅ Company Members (5 role types for team management)
- ✅ Recruiters (company-wide recruiter profiles)
- ✅ Departments (team organization)
- ✅ Company Locations (multi-location support)

**All Phase 2 includes:**
- Audit fields (createdBy, updatedBy)
- Soft delete (deletedAt)
- Advanced filtering & pagination
- Proper relationships & constraints

---

## 🚀 Current Strategy: Parallel Development

We will NOT finish Backend completely before starting Frontend.

Instead: **Parallel Development** for faster feedback loops and API validation.

### Sprint Structure

#### Sprint 1 (In Progress → 1 week)

**Frontend Path (Flutter)**
- [ ] Setup Flutter project structure
- [ ] Implement Design System (colors, typography, spacing, icons, components)
- [ ] Build Authentication screens (login, signup, password reset)
- [ ] Build Profile screens (view/edit career profile)

**Backend Path**
- [ ] Jobs domain (schema, entity, DTOs, repository, service, controller)
- [ ] Job Applications domain (schema, entity, DTOs, repository, service, controller)
- [ ] Integration: Applications → Career Profile

#### Sprint 2

**Frontend Path**
- [ ] Skills UI (add/edit/delete with endorsements)
- [ ] Experience UI (timeline with add/edit/delete)
- [ ] Education UI
- [ ] Languages UI
- [ ] Projects UI (portfolio showcase)
- [ ] Certificates UI
- [ ] Attachments UI (resume upload)

**Backend Path**
- [ ] Saved Jobs domain
- [ ] Basic Notifications system
- [ ] Search/filter APIs for jobs

#### Sprint 3

**Frontend Path**
- [ ] Jobs browse & search
- [ ] Job details view
- [ ] Apply to job flow
- [ ] Saved jobs list

**Backend Path**
- [ ] Matching Engine (basic scoring)
- [ ] Job recommendations
- [ ] Notification triggers

#### Sprint 4

**Frontend Path**
- [ ] Application tracking
- [ ] Application status timeline
- [ ] Referral sharing UI
- [ ] Settings & profile management

**Backend Path**
- [ ] Admin Dashboard APIs
- [ ] Analytics & reporting
- [ ] Performance optimization

#### Sprint 5

**Frontend Path**
- [ ] Polish & refinement
- [ ] Bug fixes
- [ ] Performance optimization

**Backend Path**
- [ ] Final optimization
- [ ] Documentation
- [ ] Security audit

---

## 📋 Next Actions (Starting Point)

### Immediate (Today)

**Path A - Frontend (Flutter)**

Create folder structure:
```
flutter/
├── lib/
│   ├── core/
│   │   ├── config/
│   │   ├── constants/
│   │   └── theme/
│   ├── features/
│   │   ├── auth/
│   │   ├── profile/
│   │   ├── jobs/
│   │   ├── applications/
│   │   └── settings/
│   ├── shared/
│   │   ├── widgets/
│   │   ├── theme/
│   │   └── utils/
│   └── main.dart
```

Task 1: Design System Setup
- Color palette
- Typography system
- Spacing/sizing scale
- Icon set (SVGs)
- Component library (buttons, cards, inputs, etc.)
- Navigation theme

Task 2: Authentication Screens
- Login screen
- Signup screen
- Password reset flow
- Session management

**Path B - Backend**

Task 1: Jobs Domain
- Schema with status enum (DRAFT, PUBLISHED, CLOSED, ON_HOLD)
- Advanced filtering (salary range, location, level, type)
- Search capabilities
- Full CRUD with audit fields

Task 2: Applications Domain
- Schema with status enum (SUBMITTED, VIEWED, SHORTLISTED, REJECTED, ACCEPTED, WITHDRAWN)
- Timeline tracking (submitted_at, viewed_at, etc.)
- Relationship to Jobs & Users
- Full CRUD with audit fields

---

## 🎯 Why This Approach?

1. **Faster Feedback** - API issues discovered during UI build
2. **Better Design** - UX needs might require API changes now, not at 50% backend
3. **Team Efficiency** - Both teams progress simultaneously
4. **Early Testing** - Real-world usage patterns discovered early
5. **Risk Mitigation** - API problems found before major backend investment

---

## 📊 Completion Estimate

- **Current:** 40-50% complete
- **After Sprint 1:** 60%
- **After Sprint 2:** 75%
- **After Sprint 3:** 85%
- **After Sprint 4:** 95%
- **After Sprint 5:** 100% (MVP ready)

**Total Timeline:** 5 sprints × 1 week = 5 weeks to MVP

---

## 🔐 Phase Freeze v1.0

**LOCKED:** Career Profile Domain (Auth, Users, Career Profile, Skills, Experience, Education, Languages, Projects, Certificates, Social Links, Attachments, Job Preferences, Profile Completion, Referrals)

**Only critical bugs or security issues allowed in Phase 1.**

All new work goes to Phase 3+.

---

## 📱 Tech Stack Summary

| Layer | Technology | Status |
|-------|-----------|--------|
| **Frontend** | Flutter | Starting soon |
| **Backend** | NestJS | In progress |
| **Database** | PostgreSQL | ✅ Running |
| **ORM** | Drizzle | ✅ Configured |
| **Auth** | JWT | ✅ Implemented |
| **API** | REST + Versioning | ✅ Configured |
| **Deployment** | (TBD) | Later phase |

---

**Decision:** Begin parallel development starting today. Frontend team starts Design System + Auth. Backend team starts Jobs + Applications.
