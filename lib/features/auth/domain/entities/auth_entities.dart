/// User entity
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final String? bio;
  final bool emailVerified;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.bio,
    required this.emailVerified,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';
}

/// Auth state entity
class AuthState {
  final String token;
  final String refreshToken;
  final User user;
  final bool emailVerified;

  AuthState({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.emailVerified,
  });
}
