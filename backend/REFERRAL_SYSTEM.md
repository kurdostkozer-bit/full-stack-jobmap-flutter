# Referral System Documentation

## Overview
The Referral System enables users to invite others and earn rewards when invited users complete their Career Profile. Each user has a unique referral code that can be shared to onboard new members.

**Reward Structure:** 0.10 USD per successful invite (when referred user creates their Career Profile)

**Referral Status Lifecycle:**
- `PENDING` → User uses referral code at signup
- `REGISTERED` → User completes registration
- `COMPLETED` → Referred user creates Career Profile (reward earned)

---

## API Endpoints

### 1. Get User Referral Stats
**GET** `/v1/referrals/user/:userId`

Retrieve referral statistics for a user, including their referral code, successful invites, and recent referral activity.

**Parameters:**
- `userId` (UUID, path param) - User ID

**Response:**
```json
{
  "referralCode": "ABC12345",
  "successfulInvites": 3,
  "estimatedReward": 0.30,
  "paymentStatus": "Pending",
  "recentReferrals": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "status": "COMPLETED",
      "rewardAmount": 0.10,
      "rewardPaid": false,
      "createdAt": "2026-01-15T10:30:00Z"
    }
  ]
}
```

---

### 2. Get Admin Referral Stats
**GET** `/v1/referrals/admin/:referrerId`

Admin view of referral statistics for a specific user, showing complete referral history and payment details.

**Parameters:**
- `referrerId` (UUID, path param) - Referrer user ID

**Response:**
```json
{
  "userId": "550e8400-e29b-41d4-a716-446655440000",
  "userEmail": "user@example.com",
  "referralCode": "ABC12345",
  "successfulInvites": 3,
  "estimatedReward": 0.30,
  "paymentStatus": "Pending",
  "lastPaymentDate": null,
  "referrals": [
    {
      "id": "660e8400-e29b-41d4-a716-446655440001",
      "referredUserEmail": "invited@example.com",
      "status": "COMPLETED",
      "rewardAmount": 0.10,
      "rewardPaid": false,
      "rewardPaidAt": null,
      "paymentNote": null,
      "careerProfileCompletedAt": "2026-01-20T14:22:00Z",
      "createdAt": "2026-01-15T10:30:00Z"
    }
  ]
}
```

---

### 3. Mark Referral as Paid
**PATCH** `/v1/referrals/admin/:referralId/pay`

Admin endpoint to mark a completed referral as paid, with optional payment notes for tracking.

**Parameters:**
- `referralId` (UUID, path param) - Referral ID

**Request Body:**
```json
{
  "paymentNote": "Payment sent via Stripe - Invoice #INV-001"
}
```

**Response:**
Returns updated `UserReferralStatsDto` for the referrer with payment status updated.

```json
{
  "referralCode": "ABC12345",
  "successfulInvites": 3,
  "estimatedReward": 0.20,
  "paymentStatus": "Partially Paid",
  "recentReferrals": [...]
}
```

---

## Database Schema

### Users Table Extensions
```sql
ALTER TABLE users ADD COLUMN referralCode VARCHAR(10) UNIQUE;
ALTER TABLE users ADD COLUMN successfulInvites INT DEFAULT 0;
ALTER TABLE users ADD COLUMN estimatedReward DECIMAL(10,2);
```

### Referrals Table
```sql
CREATE TABLE referrals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  referrerUserId UUID NOT NULL REFERENCES users(id),
  referredUserId UUID NOT NULL REFERENCES users(id) UNIQUE,
  referralCode VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
  rewardAmount DECIMAL(10,2) DEFAULT 0.10,
  rewardPaid BOOLEAN DEFAULT FALSE,
  rewardPaidAt TIMESTAMP,
  paymentNote TEXT,
  careerProfileCompletedAt TIMESTAMP,
  createdAt TIMESTAMP DEFAULT NOW(),
  updatedAt TIMESTAMP DEFAULT NOW(),
  
  INDEX idx_referrer (referrerUserId),
  INDEX idx_referred (referredUserId),
  INDEX idx_status (status),
  INDEX idx_reward_paid (rewardPaid)
);
```

---

## Integration Points

### Career Profile Creation Hook
When a user creates their first Career Profile, the system automatically:
1. Checks if they have an associated referral record
2. Marks the referral as `COMPLETED`
3. Updates the referrer's `successfulInvites` count
4. Adds 0.10 USD to the referrer's `estimatedReward`

**Location:** `CareerProfilesService.create()`

---

## Payment Workflow (v1)

### Current Process (Manual)
1. Admin monitors unpaid completed referrals via `/v1/referrals/admin/:referrerId`
2. Admin processes payment through external system (Stripe, PayPal, etc.)
3. Admin calls `PATCH /v1/referrals/admin/:referralId/pay` with payment note
4. System marks referral as paid and updates payment timestamp

### Future Enhancement (v2)
- Integrate Stripe/PayPal API
- Auto-trigger payments on threshold (e.g., when reward reaches $10)
- Webhook-based payment confirmation

---

## Status Codes

| Code | Meaning |
|------|---------|
| 200  | Success |
| 400  | Bad Request (invalid UUID format) |
| 404  | User or referral not found |
| 500  | Server error |

---

## Notes

- Referral code generation ensures uniqueness with retry logic
- If a Career Profile creation fails, the referral logic silently fails and doesn't block profile creation
- All timestamps are in UTC
- Reward amounts are stored as DECIMAL(10,2) for precision
- Payment tracking is manual in v1, designed for future automation
