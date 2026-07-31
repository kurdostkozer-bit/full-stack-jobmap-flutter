import 'package:flutter/foundation.dart';

class EmailAuthService {
  /// Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  /// Requirements: min 8 chars, 1 uppercase, 1 lowercase, 1 number
  bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  /// Get password strength feedback
  String getPasswordStrengthFeedback(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (!password.contains(RegExp(r'[A-Z]'))) return 'Add uppercase letter';
    if (!password.contains(RegExp(r'[a-z]'))) return 'Add lowercase letter';
    if (!password.contains(RegExp(r'[0-9]'))) return 'Add number';
    return 'Strong password';
  }

  /// Validate full name
  bool isValidFullName(String fullName) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]{2,}$');
    return nameRegex.hasMatch(fullName.trim());
  }

  /// Validate phone number (optional, basic validation)
  bool isValidPhone(String? phone) {
    if (phone == null || phone.isEmpty) return true; // Optional field
    final phoneRegex = RegExp(r'^\d{10,}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'\D'), ''));
  }

  /// Log authentication event (for security audit)
  void logAuthEvent(String event, {String? email, String? error}) {
    debugPrint('[AUTH] $event${email != null ? ' - $email' : ''}${error != null ? ' - ERROR: $error' : ''}');
  }
}
