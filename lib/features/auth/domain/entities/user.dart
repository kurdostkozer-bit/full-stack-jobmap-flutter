class User {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? profileImage;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.profileImage,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.createdAt,
  });
}