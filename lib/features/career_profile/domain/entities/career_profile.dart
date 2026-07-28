class CareerProfile {
  final String id;

  final String userId;

  final String firstName;
  final String lastName;

  final String headline;

  final String about;

  final String country;
  final String city;

  final String phone;
  final String email;

  final String profileImage;

  final bool isProfileActivated;

  final DateTime createdAt;
  final DateTime updatedAt;

  const CareerProfile({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.headline,
    required this.about,
    required this.country,
    required this.city,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.isProfileActivated,
    required this.createdAt,
    required this.updatedAt,
  });
}