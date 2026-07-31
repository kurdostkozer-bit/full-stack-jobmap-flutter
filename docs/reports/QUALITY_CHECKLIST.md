# JobMap - Quality Assurance Checklist

**Current Phase**: Stabilization Sprint (No New Features)

---

## 1. Authentication Testing ✓

### Registration Flow
- [ ] **Happy Path**
  - [ ] Fill all fields correctly
  - [ ] Accept terms
  - [ ] Success message shown
  - [ ] Email verification state reached

- [ ] **Validation**
  - [ ] Empty fields show errors
  - [ ] Invalid email rejected
  - [ ] Weak password rejected
  - [ ] Password mismatch detected
  - [ ] Terms agreement required

- [ ] **Error Handling**
  - [ ] Email already exists (409)
  - [ ] Server error (500) - graceful message
  - [ ] Network timeout - retry option
  - [ ] Offline - queue request or show message

### Email Verification
- [ ] **Valid Code**
  - [ ] Code accepted
  - [ ] Success state
  - [ ] Auto-proceed to login or manual button

- [ ] **Invalid Code**
  - [ ] Rejected with error
  - [ ] Can retry
  - [ ] Resend code option available

### Login Flow
- [ ] **Correct Credentials**
  - [ ] Login succeeds
  - [ ] Token saved securely
  - [ ] Navigate to Home/Dashboard
  - [ ] User data loaded

- [ ] **Wrong Password**
  - [ ] Rejected
  - [ ] Error message shown
  - [ ] Can retry

- [ ] **Account Not Found**
  - [ ] Proper error message
  - [ ] Option to register

### Auto-Login
- [ ] **With Valid Token**
  - [ ] App opens
  - [ ] SplashScreen briefly shown
  - [ ] Auto-navigate to Home
  - [ ] No login screen

- [ ] **With Expired Token**
  - [ ] Token refresh attempted
  - [ ] If refresh fails → Login required
  - [ ] If refresh succeeds → Auto-login

- [ ] **No Token**
  - [ ] Navigate to Welcome
  - [ ] Clean UI, no errors

### Token Refresh
- [ ] **On 401 Response**
  - [ ] Intercept 401
  - [ ] Call refresh endpoint
  - [ ] If new token valid → Retry request
  - [ ] If refresh fails → Force logout

### Logout
- [ ] **From Home**
  - [ ] Tap Logout (or menu)
  - [ ] Confirm dialog (optional)
  - [ ] API logout called
  - [ ] Tokens cleared
  - [ ] Navigate to Welcome
  - [ ] Cannot go back without login

### Forgot Password
- [ ] **Send Reset Code**
  - [ ] Enter email
  - [ ] Code sent (check email/logs)
  - [ ] Success state shown

- [ ] **Reset Password**
  - [ ] Enter code + new password
  - [ ] Password updated
  - [ ] Can login with new password
  - [ ] Old password doesn't work

---

## 2. Network Testing ✓

### Connection Loss
- [ ] **During Request**
  - [ ] Request in progress
  - [ ] Connection drops
  - [ ] Timeout error shown (not crash)
  - [ ] User can retry
  - [ ] Request queued (optional)

- [ ] **Between Requests**
  - [ ] App functional without internet
  - [ ] Cache used when available
  - [ ] Offline indicator shown (optional)

### Connection Recovery
- [ ] **After Reconnection**
  - [ ] Queued requests attempted
  - [ ] Fresh data fetched
  - [ ] UI updated

### Timeout Handling
- [ ] **Long Requests**
  - [ ] After 30s timeout
  - [ ] Error shown (not spinning forever)
  - [ ] User can retry

### Server Errors
- [ ] **400/422 Validation Error**
  - [ ] Error message from server displayed
  - [ ] User can fix and retry

- [ ] **401 Unauthorized**
  - [ ] Token refresh attempted
  - [ ] Or force logout

- [ ] **403 Forbidden**
  - [ ] Permission error shown
  - [ ] No crash

- [ ] **404 Not Found**
  - [ ] Graceful error
  - [ ] User can go back

- [ ] **500+ Server Error**
  - [ ] Retry option shown
  - [ ] User notified (not silent failure)

---

## 3. UI Testing ✓

### Light Mode
- [ ] **All Screens**
  - [ ] Colors correct
  - [ ] Text readable
  - [ ] No contrast issues
  - [ ] Buttons clickable

### Dark Mode
- [ ] **All Screens**
  - [ ] Colors correct
  - [ ] Text readable
  - [ ] No contrast issues
  - [ ] Proper dark theme applied

### Small Screens (4" phones)
- [ ] **Responsive Layout**
  - [ ] Text not cut off
  - [ ] Buttons reachable
  - [ ] No horizontal scroll
  - [ ] Forms scrollable

### Large Screens (10"+ tablets)
- [ ] **Responsive Layout**
  - [ ] Content centered
  - [ ] Proper spacing
  - [ ] Not stretched

### Orientation
- [ ] **Portrait**
  - [ ] Layouts correct
  - [ ] All elements visible
  - [ ] No overflow

- [ ] **Landscape**
  - [ ] Layouts adapt
  - [ ] AppBar adjusts
  - [ ] Forms still usable

### RTL (Arabic)
- [ ] **Direction**
  - [ ] Text right-aligned
  - [ ] Icons mirrored appropriately
  - [ ] Touch targets same
  - [ ] Navigation direction reversed

### LTR (English)
- [ ] **Direction**
  - [ ] Text left-aligned
  - [ ] Normal layout

---

## 4. Performance Testing

### Memory
- [ ] **No Memory Leaks**
  - [ ] Navigate screens multiple times
  - [ ] Memory doesn't keep growing
  - [ ] DevTools shows stable heap

### Battery
- [ ] **Reasonable Usage**
  - [ ] No constant background work
  - [ ] BLoCs properly disposed
  - [ ] Streams closed

### Network
- [ ] **No Excessive Requests**
  - [ ] Check network tab
  - [ ] Only necessary calls made
  - [ ] No duplicate requests
  - [ ] Responses cached

### UI Responsiveness
- [ ] **No Jank**
  - [ ] 60fps (smooth scrolling)
  - [ ] Buttons respond immediately
  - [ ] No frame drops

---

## 5. Security Testing

### Token Storage
- [ ] **Secure Storage**
  - [ ] Token in Flutter Secure Storage
  - [ ] Not in SharedPreferences
  - [ ] Not in plain text

- [ ] **Token Expiration**
  - [ ] Expired token detected
  - [ ] Refresh attempted
  - [ ] User logged out if refresh fails

### API Communication
- [ ] **HTTPS**
  - [ ] All requests over HTTPS (production)
  - [ ] Certificates valid

- [ ] **No Sensitive Data in Logs**
  - [ ] Passwords never logged
  - [ ] Tokens never logged
  - [ ] Only IDs/non-sensitive data in logs

---

## 6. Accessibility Testing

### Text Size
- [ ] **Large Text (200%)**
  - [ ] All screens readable
  - [ ] No overlap
  - [ ] Buttons still clickable

### Screen Reader
- [ ] **Labels Present**
  - [ ] All icons have semantics
  - [ ] Form fields labeled
  - [ ] Buttons have text

### Touch Targets
- [ ] **Minimum 48x48 dp**
  - [ ] All buttons large enough
  - [ ] Not too close together
  - [ ] Reachable for one-handed use

---

## 7. Data Testing

### Form Validation
- [ ] **Input Validation**
  - [ ] Email format checked
  - [ ] Password strength verified
  - [ ] Required fields enforced
  - [ ] Length limits respected

### API Response Handling
- [ ] **JSON Parsing**
  - [ ] Valid JSON parsed correctly
  - [ ] Invalid JSON shows error
  - [ ] Missing fields handled (null safety)

### Caching
- [ ] **Local Data**
  - [ ] User profile cached after login
  - [ ] Cache cleared on logout
  - [ ] Cache updated on refresh

---

## 8. Integration Testing

### End-to-End Flow
- [ ] **Full Registration to Profile**
  - [ ] Register new account
  - [ ] Verify email
  - [ ] Login
  - [ ] Auto-login on restart
  - [ ] View profile
  - [ ] Update profile
  - [ ] Logout
  - [ ] Login again

### Multiple Users
- [ ] **User Switching**
  - [ ] Login as User A
  - [ ] Logout
  - [ ] Login as User B
  - [ ] Data for User B shown (not A)

---

## 9. Device Testing

### Real Device (Recommended)
- [ ] **Android Phone**
  - [ ] Min SDK 21 (or your requirement)
  - [ ] Works as expected
  - [ ] No native crashes

- [ ] **iPhone**
  - [ ] iOS 12+ (or your requirement)
  - [ ] Works as expected
  - [ ] No native crashes

### Emulator/Simulator
- [ ] **Android Emulator**
  - [ ] 1-2 versions of Android
  - [ ] Works as expected

- [ ] **iOS Simulator**
  - [ ] Latest iOS version
  - [ ] Works as expected

---

## 10. Code Quality

### Unit Tests
- [ ] **Auth Tests**
  - [ ] Repository tests (50%+ coverage)
  - [ ] BLoC tests (30%+ coverage)
  - [ ] Component tests

- [ ] **Run Tests**
  ```bash
  flutter test
  ```
  - [ ] All tests pass
  - [ ] No warnings

### Code Formatting
- [ ] **Dart Format**
  ```bash
  dart format lib/ test/
  ```
  - [ ] Consistent formatting

- [ ] **Lint Analysis**
  ```bash
  flutter analyze
  ```
  - [ ] No errors
  - [ ] Warnings addressed

### Documentation
- [ ] **Code Comments**
  - [ ] Complex logic explained
  - [ ] TODOs tracked
  - [ ] Public methods documented

---

## Checklists by Feature

### ✅ Authentication Sprint
- [ ] All 8 auth flows pass
- [ ] Network error handling works
- [ ] Token storage secure
- [ ] Auto-login works
- [ ] All tests pass
- [ ] No crashes

### ⏳ Career Profile Sprint (Next)
- [ ] Personal Info screen connects to API
- [ ] Skills screen CRUD works
- [ ] Experience screen CRUD works
- [ ] Education screen CRUD works
- [ ] Projects screen CRUD works
- [ ] Certificates screen CRUD works
- [ ] Profile completion bar accurate
- [ ] All integration tests pass

### ⏳ Dashboard Sprint
- [ ] Real data from API
- [ ] Profile completion shown
- [ ] Recent jobs displayed
- [ ] Application count shown
- [ ] Referral status shown

---

## Release Checklist

- [ ] All unit tests pass (70%+ coverage)
- [ ] All integration tests pass
- [ ] No crashes on real device
- [ ] Performance acceptable (60fps)
- [ ] Battery/memory reasonable
- [ ] All security checks passed
- [ ] Documentation complete
- [ ] Build succeeds without warnings
- [ ] Version bumped
- [ ] Changelog updated
- [ ] Screenshots updated for play store
- [ ] Privacy policy reviewed

---

## Known Issues / Deferred

- [ ] (To be filled during testing)

---

## Sign-off

- Backend Review: ___________  Date: _______
- Frontend Review: __________  Date: _______
- QA Review: ________________  Date: _______
- Product Review: ___________  Date: _______
