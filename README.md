# JobMap - Job Marketplace Platform

**Status**: MVP Implementation Phase (50% Complete)

**Current Phase**: Building user-facing features  
**Focus**: Career Profile (60% done) → Dashboard → Jobs → Applications

**Next Milestone**: MVP Ready for Users (3-4 weeks)

---

## What Is JobMap?

JobMap is a comprehensive job marketplace platform built with:
- **Backend**: NestJS (Node.js framework)
- **Frontend**: Flutter (cross-platform mobile app)
- **Database**: PostgreSQL
- **Architecture**: Clean Architecture + BLoC Pattern

### Key Features (Roadmap)
- ✅ User Authentication (register, verify email, login, logout, forgot password)
- 🏗️ Career Profile Management (skills, experience, education, projects, certificates)
- 📋 Job Listings & Search
- 📝 Job Applications
- 💾 Saved Jobs
- 🔔 Notifications
- 💬 Messaging
- ⭐ Ratings & Reviews (future)
- 🤝 Referral System

---

## Getting Started

### Prerequisites
- **Flutter SDK**: Latest stable version
- **Node.js**: v16+
- **PostgreSQL**: Latest version
- **Git**: For version control

### Quick Setup

```bash
# 1. Clone repository
git clone <repo-url>
cd jobMap

# 2. Setup Flutter dependencies
flutter clean
flutter pub get

# 3. Start backend
cd backend
npm install
npm run start:dev

# 4. Run Flutter app (in new terminal)
cd ..
flutter run
```

### Verify Installation
```bash
# Check backend is running
curl http://localhost:3000/api/v1/health

# Check Flutter linter
flutter analyze

# Run tests
flutter test
```

---

## Project Structure

```
jobMap/
├── lib/                              # Flutter app
│   ├── core/                         # Infrastructure layer
│   │   ├── config/                   # Environment configuration
│   │   ├── network/                  # API client, interceptors
│   │   ├── di/                       # Dependency injection
│   │   ├── router/                   # Navigation setup
│   │   └── extensions/               # Utility extensions
│   │
│   ├── design_system/                # Reusable UI components
│   │   ├── colors/                   # Color themes
│   │   ├── typography/               # Text styles
│   │   ├── components/               # Buttons, inputs, cards, etc.
│   │   └── extensions/               # BuildContext, String utilities
│   │
│   └── features/                     # Feature modules
│       ├── auth/                     # Authentication (complete)
│       ├── profile/                  # Career profile (in progress)
│       └── home/                     # Dashboard (planned)
│
├── test/                             # Unit & Widget tests
│   ├── fixtures/                     # Test data
│   └── features/                     # Feature tests
│
├── backend/                          # NestJS backend
│   ├── src/
│   │   ├── auth/                     # Authentication module
│   │   ├── profile/                  # Career profile module
│   │   ├── jobs/                     # Jobs module
│   │   └── common/                   # Shared utilities
│   └── package.json
│
└── Documentation/
    ├── QUICK_START.md                # ← Start here!
    ├── INDEX.md                      # Project index
    ├── BACKEND_INTEGRATION_GUIDE.md  # Integration guide
    ├── TESTING_GUIDE.md              # Testing procedures
    ├── API_INTEGRATION_CHECKLIST.md  # Progress tracking
    ├── QUALITY_CHECKLIST.md          # QA requirements
    ├── SPRINT_SUMMARY.md             # Latest sprint status
    └── SESSION_COMPLETE.md           # Session details
```

---

## Architecture Overview

### Clean Architecture Pattern
```
Presentation Layer    → Screens, BLoC, UI components
    ↓
Domain Layer          → Entities, repository interfaces, use cases
    ↓
Data Layer            → API clients, local storage, repository implementations
    ↓
Core Layer            → Network, config, DI, utilities
```

### State Management: BLoC
```
User Interaction → BLoC Event → Use Case → Repository → Data Source → API
                                                            ↓
                                                        Response
                                                            ↓
                                                        BLoC State
                                                            ↓
                                                        UI Update
```

---

## Documentation

**Start with these files** (in order):

1. **[QUICK_START.md](QUICK_START.md)** - 5-minute setup and common tasks
2. **[INDEX.md](INDEX.md)** - Full project navigation
3. **[SPRINT_SUMMARY.md](SPRINT_SUMMARY.md)** - What's been completed
4. **[BACKEND_INTEGRATION_GUIDE.md](BACKEND_INTEGRATION_GUIDE.md)** - How APIs work
5. **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - How to test everything
6. **[API_INTEGRATION_CHECKLIST.md](API_INTEGRATION_CHECKLIST.md)** - Progress tracking

---

## Current Status

### ✅ Completed
- Authentication system (register, verify, login, logout, forgot password)
- Secure token storage and management
- Auto-login functionality
- Token refresh on expiration
- Design system v1.0 (colors, typography, components)
- Unit tests for auth module
- Comprehensive documentation

### 🏗️ In Progress
- Backend API integration testing
- Career Profile screens

### ⏳ Planned
- Career Profile screens (Experience, Education, Skills, etc.)
- Dashboard with real data
- Jobs domain (listing, search, applications)
- Notifications system

---

## API Integration Status

### Auth Endpoints (8/8) - Ready to Test
- `POST /auth/register` - New user registration
- `POST /auth/verify-email` - Email verification
- `POST /auth/login` - User login
- `GET /auth/me` - Get current user
- `POST /auth/logout` - User logout
- `POST /auth/forgot-password` - Forgot password
- `POST /auth/reset-password` - Reset password
- `POST /auth/refresh-token` - Refresh JWT token

### Career Profile Endpoints (0/30) - Ready to Build
- Skills (CRUD)
- Experience (CRUD)
- Education (CRUD)
- Languages (CRUD)
- Projects (CRUD)
- Certificates (CRUD)
- Social Links
- Attachments

### Dashboard Endpoints (0/6) - Planned
- Profile completion percentage
- Recommended jobs
- Recent job listings
- Application statistics
- Saved jobs count
- Referral status

---

## Development Workflow

### Before Writing Code
1. Understand feature requirements
2. Design data model
3. Review similar implementations
4. Create tests (TDD approach)
5. Implement feature
6. Run tests and lint checks
7. Manual testing
8. Update documentation

### Clean Code Standards
```bash
# Format code
dart format lib/ test/

# Check lint
flutter analyze

# Run tests
flutter test

# Check coverage
flutter test --coverage
```

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/auth-integration

# Make changes
# Commit regularly
git commit -m "feat: Add login endpoint integration"

# Push to GitHub
git push -u origin feature/auth-integration

# Create pull request for review
```

---

## Testing

### Unit Tests (30+)
```bash
flutter test
```

Test coverage includes:
- Authentication flows
- Repository methods
- BLoC events and states
- Component rendering

### Integration Tests
**Status**: Ready to run with real backend

```bash
# Once backend is running
flutter test integration_test/
```

### Manual Testing
Follow detailed procedures in [TESTING_GUIDE.md](TESTING_GUIDE.md)

---

## Network Architecture

### API Client
- **Base URL**: Configured per environment (dev/staging/prod)
- **Timeout**: 30 seconds
- **Retry**: Automatic for network errors

### Interceptors
- **AuthInterceptor**: Auto-injects JWT token in headers
- **LoggingInterceptor**: Logs all requests/responses (dev only)
- **Error Handler**: Catches and handles API errors

### Security
- **Token Storage**: FlutterSecureStorage (not SharedPreferences)
- **Token Refresh**: Automatic on 401 response
- **HTTPS**: Enforced in production

---

## Troubleshooting

### "Connection refused"
```
Solution: Ensure backend is running
cd backend && npm run start:dev
```

### "Invalid credentials"
```
Solution: Check email/password are correct
Use registered account from testing-guide.md
```

### "Request timeout"
```
Solution: Check internet connection or backend responsiveness
Increase timeout in DioProvider if needed
```

### "Lint errors"
```
Solution: Format and fix
dart format lib/ test/
flutter analyze --fix
```

For more issues, see Troubleshooting section in [QUICK_START.md](QUICK_START.md).

---

## Performance

### Target Metrics
- **UI Responsiveness**: 60fps smooth scrolling
- **Memory**: Stable heap (no leaks)
- **Network**: <2s for typical requests
- **Battery**: <5% impact per hour

### Optimization Tips
- Use DevTools Memory tab to check for leaks
- Monitor network tab for excessive requests
- Profile with `flutter run --profile`
- Use `--analyze` flag for optimization hints

---

## Security Considerations

### Authentication
- ✅ Secure token storage (FlutterSecureStorage)
- ✅ HTTPS only (production)
- ✅ Token refresh on expiration
- ✅ Automatic logout on 401

### Data Protection
- ✅ No sensitive data in logs
- ✅ Password never stored locally
- ✅ Secure communication (TLS)

### Best Practices
- Update dependencies regularly
- Run security audits
- Review API responses for XSS vulnerabilities
- Validate all user inputs

---

## Contributing

### Code Style
- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep methods short and focused

### Testing Requirements
- Write tests for new features
- Aim for >70% code coverage
- Test error scenarios
- Test UI edge cases

### Documentation
- Update README for significant changes
- Document API changes
- Add examples for new components
- Keep QUICK_START.md current

---

## Team Resources

### Internal Documentation
- Project roadmap (in Google Drive)
- API documentation (in Swagger/OpenAPI)
- Design specifications (in Figma)
- Database schema (in DrawIO)

### External Resources
- [Flutter Official Docs](https://flutter.dev)
- [NestJS Documentation](https://docs.nestjs.com)
- [Clean Architecture Guide](https://resocoder.com)
- [BLoC Pattern](https://bloclibrary.dev)

---

## Version History

| Version | Date | Status | Notes |
|---------|------|--------|-------|
| 0.1.0 | 2024-07-29 | Beta | Auth infrastructure complete, ready for testing |
| 0.0.1 | 2024-07-01 | Alpha | Initial project setup |

---

## License

This project is proprietary and confidential.

---

## Contact & Support

**For questions about**:
- **Code**: Review similar implementations or ask team lead
- **Architecture**: Check SPRINT_SUMMARY.md
- **Integration**: Read BACKEND_INTEGRATION_GUIDE.md
- **Testing**: Follow TESTING_GUIDE.md
- **Progress**: Check API_INTEGRATION_CHECKLIST.md

---

## Next Steps

1. **Read [QUICK_START.md](QUICK_START.md)** for 5-minute setup
2. **Verify backend**: `curl http://localhost:3000/api/v1/health`
3. **Run app**: `flutter run`
4. **Run tests**: `flutter test`
5. **Start contributing**: Pick a task from [API_INTEGRATION_CHECKLIST.md](API_INTEGRATION_CHECKLIST.md)

---

**Happy coding!** 🚀

For detailed project information, see [INDEX.md](INDEX.md)
