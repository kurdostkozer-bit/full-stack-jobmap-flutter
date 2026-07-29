# JobMap - Testing Guide

**Phase**: Stabilization Sprint - Auth Integration Testing

---

## Prerequisites

### Backend Running
```bash
cd backend
npm install
npm run start:dev

# Verify it's running
curl http://localhost:3000/api/v1/health
# Expected: 200 OK
```

### Flutter Project Ready
```bash
cd jobMap
flutter clean
flutter pub get
flutter analyze  # Should have zero errors
```

### Device/Emulator
- Android emulator OR iOS simulator OR real device
- Internet connection (for API calls)
- Sufficient storage (~100MB for apk/app)

---

## Test Scenarios

### 1. Registration Flow

**Objective**: Register a new account, verify email, then login.

#### Test 1.1: Valid Registration

**Steps**:
1. Open app → Splash screen appears (1-2 seconds)
2. Auto-navigate to Welcome screen
3. Tap "Register"
4. Fill registration form:
   - Email: `test-user-001@example.com`
   - Password: `TestPassword@123`
   - Confirm Password: `TestPassword@123`
   - First Name: `Test`
   - Last Name: `User`
5. Tap "Register" button

**Expected Result**:
- Loading spinner appears
- After 1-2 seconds: Success message shown
- Navigate to "Email Verification" screen
- Screen shows: "We sent a code to test-user-001@example.com"

**Failed Result** (Document):
- If error: Note the exact error message
- Check backend logs for why registration failed
- Common issues:
  - Email already exists (409)
  - Invalid password format (422)
  - Backend not running (connection refused)

#### Test 1.2: Email Verification

**Prerequisites**: Complete Test 1.1

**Steps**:
1. Check email inbox for verification code (usually test@example.com)
   - If using test/mock backend: Check server logs or use default code `123456`
2. On "Email Verification" screen:
   - Enter 6-digit code
   - Tap "Verify"

**Expected Result**:
- Loading spinner appears
- Success message shown
- Navigate to Login screen automatically (or show success screen)

**Failed Result**:
- If "Invalid code" error: Regenerate or check backend
- If timeout: Retry or check network

#### Test 1.3: Login After Registration

**Prerequisites**: Complete Test 1.2

**Steps**:
1. If not on Login screen, tap "Login" from Welcome
2. Fill login form:
   - Email: `test-user-001@example.com`
   - Password: `TestPassword@123`
3. Tap "Login"

**Expected Result**:
- Loading spinner appears
- After 1-2 seconds: Navigate to Home screen
- Home screen shows user name: "Test User"
- No console errors

**Failed Result**:
- If "Invalid credentials" error: Verify email/password
- If network error: Check backend running
- If timeout: Check connection

---

### 2. Login Flow (Existing User)

**Objective**: Test login with pre-existing account.

#### Test 2.1: Correct Credentials

**Precondition**: Use registered account from Test 1.3 or create test account on backend

**Steps**:
1. From Welcome screen, tap "Login"
2. Enter email and password (use valid account)
3. Tap "Login"

**Expected Result**:
- Loading state shown
- Navigate to Home screen
- User name displayed
- No errors

#### Test 2.2: Wrong Password

**Steps**:
1. From Login screen, enter:
   - Email: Valid email (from Test 1.3)
   - Password: `WrongPassword@123`
2. Tap "Login"

**Expected Result**:
- Loading state shown (2-3 seconds)
- Error message shown: "Invalid credentials" or similar
- Stay on Login screen
- Can retry with correct password

#### Test 2.3: Non-existent Email

**Steps**:
1. Enter email: `nonexistent@example.com`
2. Enter password: Any password
3. Tap "Login"

**Expected Result**:
- Error message shown (same as wrong password, don't reveal which field is wrong)
- Stay on Login screen

#### Test 2.4: Empty Fields

**Steps**:
1. Leave email and password empty
2. Tap "Login"

**Expected Result**:
- Validation errors shown under fields (not API call)
- Cannot submit form
- No network request made

---

### 3. Auto-Login Flow

**Objective**: App remembers user and auto-login on restart.

#### Test 3.1: Auto-Login After Successful Login

**Prerequisites**: Complete Test 2.1 (logged in)

**Steps**:
1. On Home screen
2. Kill app (close completely, not just minimize)
3. Reopen app

**Expected Result**:
- Splash screen appears (1-2 seconds)
- Loading spinner shown
- Auto-navigate to Home screen (not Welcome)
- User data shown (name, profile info)
- No console errors

**Failed Result**:
- If navigated to Welcome instead: Token not saved correctly
- If stuck on splash: Token validation error

#### Test 3.2: Auto-Login with Expired Token (Token Refresh)

**Prerequisites**: Token expired or about to expire

**Steps**:
1. Manipulate device time (advanced test):
   - On Android: Settings → Developer Options → Simulated time
   - On iOS: Manual test only
2. Or wait for token to expire naturally
3. Kill and restart app

**Expected Result**:
- Splash screen appears
- Token refresh happens (invisible to user)
- Navigate to Home with refreshed token
- User session continues

**Alternative** (If no token refresh):
- Splash appears
- Navigate to Welcome (force re-login)
- User can login again

---

### 4. Token Management

#### Test 4.1: Token Stored Securely

**Prerequisites**: Logged in (Test 2.1)

**Debug**:
```dart
// In Flutter DevTools console
final storage = FlutterSecureStorage();
final token = await storage.read(key: 'auth_token');
print(token);
```

**Expected**:
- Token exists and is a valid JWT
- Token NOT in SharedPreferences (never!)
- Token NOT visible in app logs

#### Test 4.2: Token Cleared on Logout

**Prerequisites**: Logged in

**Steps**:
1. From Home screen, open menu
2. Tap "Logout"
3. Confirm logout (if dialog shown)

**Expected Result**:
- Token cleared from secure storage
- User session cleared
- Navigate to Welcome screen
- Cannot go back without logging in again

**Debug**:
```dart
final token = await storage.read(key: 'auth_token');
print(token); // Should be null
```

---

### 5. GET /me Endpoint

#### Test 5.1: User Data Loaded

**Prerequisites**: Logged in (Test 2.1)

**Objective**: Verify `/auth/me` endpoint called and user data loaded.

**Debug** (DevTools):
- Network tab should show request to `/auth/me`
- Response shows user JSON with id, email, firstName, lastName

**Expected Behavior**:
- On login: `/auth/me` automatically called
- User data displayed on Home screen
- No additional manual call needed

---

### 6. Network Error Scenarios

#### Test 6.1: Connection Loss During Request

**Setup**:
1. On Login screen
2. Have internet ON initially

**Steps**:
1. Fill login form
2. Tap "Login"
3. Immediately turn OFF internet (airplane mode or disable WiFi)
4. Loading spinner still showing

**Expected Result**:
- After ~30 seconds: Timeout error shown
- Error message: "Connection timeout. Please try again."
- Retry button available
- Can turn internet back on and retry

#### Test 6.2: Connection Loss Between Requests

**Setup**:
1. Logged in (Test 2.1)
2. On Home screen

**Steps**:
1. Turn OFF internet
2. Navigate to another screen (if available)
3. Try to make API call (e.g., load profile, etc.)

**Expected Result**:
- If immediate call: Error shown
- If queued: Message shown after attempt
- Retry option available
- App doesn't crash

#### Test 6.3: Server Error (500)

**Setup** (Simulate on backend):
```bash
# In backend, modify endpoint to return 500
# or use network proxy to inject 500 response
```

**Steps**:
1. Attempt login

**Expected Result**:
- Error message: "Server error. Please try again later."
- Retry button shown
- User can retry

#### Test 6.4: Validation Error (400/422)

**Setup**:
1. Send invalid data to registration

**Example**:
- Email: `invalid-email`
- Password: `123` (too short)

**Expected Result**:
- Error message shown: Server-provided or generic validation error
- Form stays filled (doesn't clear)
- User can fix and resubmit

---

### 7. UI/UX Testing

#### Test 7.1: Light Mode

**Setup**: Device in Light mode (Settings → Display → Light theme)

**Screens to Check**:
- [ ] Splash screen - readable, proper colors
- [ ] Welcome screen - all text readable, buttons clickable
- [ ] Login screen - form fields visible, labels clear
- [ ] Register screen - all fields visible, no overlap
- [ ] Home screen - content visible, navigation clear

**Expected**:
- No color contrast issues
- Text readable (WCAG AA minimum)
- Buttons have proper affordance (look clickable)

#### Test 7.2: Dark Mode

**Setup**: Device in Dark mode (Settings → Display → Dark theme)

**Same screens as 7.1**

**Expected**:
- Colors properly inverted
- Text readable in dark theme
- No harsh colors
- Proper contrast with dark background

#### Test 7.3: Small Screen (4" phone)

**Setup**: Use emulator/device with small screen

**Steps**:
1. Open each screen
2. Check for:
   - Text cutoff
   - Buttons unreachable
   - Horizontal scroll (shouldn't happen)
   - Forms scrollable

**Expected**:
- All content fits without horizontal scroll
- Forms scrollable vertically
- Touch targets (buttons) minimum 48x48dp
- No overflow errors

#### Test 7.4: Large Screen (Tablet 10"+)

**Setup**: Use tablet or large screen emulator

**Expected**:
- Content centered (not stretched)
- Proper padding/spacing
- Layout adapts (not just scaled)
- Readable text (not too large)

#### Test 7.5: Landscape Orientation

**Steps**:
1. Open app on phone
2. Rotate to landscape
3. Check each screen

**Expected**:
- Layout adapts
- AppBar still visible
- Forms still usable
- No content hidden

#### Test 7.6: RTL (Arabic)

**Setup** (If supported):
- Change device language to Arabic
- Or use `--locale ar_SA` flag

**Expected**:
- Text right-aligned
- Buttons/icons mirrored
- Navigation direction reversed
- Touch targets same size

#### Test 7.7: Text Size (Accessibility)

**Setup**: Device → Settings → Accessibility → Large text (150-200%)

**Expected**:
- All text larger but readable
- No overlap
- Buttons still clickable
- No horizontal scroll

---

### 8. Performance Testing

#### Test 8.1: Memory Leaks

**Setup**:
1. Open DevTools (Flutter DevTools in VS Code)
2. Select Memory tab

**Steps**:
1. Login → Logout → Login (repeat 5 times)
2. Watch Memory graph

**Expected**:
- Memory stays relatively stable
- No continuous growth
- After logout: Memory drops (if screens disposed)

**Check**:
- Heap size graph should not climb indefinitely
- BLoCs disposed on close (no listeners holding references)

#### Test 8.2: Smooth Performance (60fps)

**Setup**: DevTools → Performance tab

**Steps**:
1. Navigate between screens
2. Scroll through lists
3. Interact with UI

**Expected**:
- Frame rate: 60fps (or 120fps on high-refresh displays)
- No frame drops visible
- Smooth animations
- No UI jank

#### Test 8.3: Battery Usage

**Setup**: Monitor on real device

**Steps**:
1. Logged in for 5 minutes (no interaction)
2. Check battery level drop

**Expected**:
- Minimal battery drain
- No background work happening
- App idle (not continuously polling)

---

### 9. Security Testing

#### Test 9.1: Token Not in SharedPreferences

**Debug**:
```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
final allKeys = prefs.getKeys();
print(allKeys); // Should NOT contain 'auth_token'
```

**Expected**: No auth tokens in SharedPreferences

#### Test 9.2: Token Not in Logs

**Steps**:
1. Login
2. Check console output (Run tab)

**Expected**:
- No full token printed
- Password never logged
- Only safe info (id, email) in debug logs

#### Test 9.3: Secure Storage Working

**Debug**:
```dart
final storage = FlutterSecureStorage();
final token = await storage.read(key: 'auth_token');
print('Token length: ${token?.length}'); // Safe
```

**Expected**: Token in FlutterSecureStorage, not readable directly

---

### 10. End-to-End Flow

#### Test 10.1: Complete User Journey

**Entire Flow**:
1. ✓ App starts → Splash → Welcome
2. ✓ Register new account
3. ✓ Verify email
4. ✓ Login with new account
5. ✓ View Home screen with user data
6. ✓ Close app
7. ✓ Reopen app → Auto-login → Home
8. ✓ Logout from Home
9. ✓ Login again
10. ✓ Home shows user data again

**Expected Result**:
- All steps succeed
- No crashes
- No unhandled exceptions
- Smooth transitions
- User data persistent

---

## Checklist

### Registration & Verification ✓
- [ ] New user can register
- [ ] Email verification works
- [ ] Can login after verification
- [ ] Invalid credentials rejected
- [ ] Validation errors shown

### Login ✓
- [ ] Login with correct credentials works
- [ ] Wrong password rejected
- [ ] Empty fields validated
- [ ] Can login multiple times
- [ ] Multiple users can login separately

### Auto-Login ✓
- [ ] Token saved on login
- [ ] Token loaded on startup
- [ ] Auto-navigate to Home
- [ ] Auto-login with expired token (refresh)
- [ ] Logout clears token

### Logout ✓
- [ ] Logout works
- [ ] Tokens cleared
- [ ] Navigate to Welcome
- [ ] Can login again after logout

### Network ✓
- [ ] Timeout handled (30s)
- [ ] Connection loss handled
- [ ] Server errors handled (500, 400, etc.)
- [ ] Validation errors shown
- [ ] Retry option available

### UI ✓
- [ ] Light mode readable
- [ ] Dark mode readable
- [ ] Small screens work
- [ ] Large screens work
- [ ] Landscape works
- [ ] RTL works (if supported)
- [ ] Text size works

### Security ✓
- [ ] Token in secure storage
- [ ] Token NOT in preferences
- [ ] Token NOT in logs
- [ ] Password NOT logged

### Performance ✓
- [ ] No memory leaks
- [ ] 60fps smooth
- [ ] Battery drain minimal
- [ ] No excessive network calls

---

## Known Issues

Document any issues found:

| Issue | Steps to Reproduce | Expected | Actual | Status |
|-------|-------------------|----------|--------|--------|
| Example | Login with valid creds | Navigate to Home | Stay on Login | Open |
| ... | ... | ... | ... | ... |

---

## Sign-off

**Tester**: ________________  **Date**: __________

**Backend**: ✓ Running at `http://localhost:3000/api/v1`

**All Auth Tests**: ✓ Passed

**Ready for**: Career Profile UI development

---

## Commands for Testing

```bash
# Clear app data and cache
flutter clean
flutter pub get

# Run app in debug mode
flutter run

# Run app on specific device
flutter run -d <device-id>

# Run with logging
flutter run -v

# Build APK for testing
flutter build apk --debug

# Run unit tests
flutter test

# Run specific test file
flutter test test/features/auth/presentation/bloc/auth_bloc_test.dart

# Check for lint issues
flutter analyze

# Format code
dart format lib/ test/
```

---

## Support & Debugging

**Network Issues**:
```bash
# Test backend connectivity
curl -v http://localhost:3000/api/v1/health

# Test with sample login
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password"}'
```

**Flutter DevTools**:
- Open: `flutter pub global run devtools`
- Connect: `http://localhost:9100`
- Check Network tab for API calls
- Check Memory for leaks
- Check Performance for frame drops

**Common Issues**:
1. **"Connection refused"** → Backend not running
2. **"Invalid credentials"** → Wrong email/password
3. **"Timeout"** → Network too slow or backend hang
4. **"Token not found"** → Auto-login failed, check secure storage
5. **"401 Unauthorized"** → Token expired and refresh failed

