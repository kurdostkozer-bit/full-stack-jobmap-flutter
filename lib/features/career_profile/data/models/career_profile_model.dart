import '../../domain/entities/career_profile.dart';

class CareerProfileModel extends CareerProfile {
  const CareerProfileModel({
    required super.id,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.headline,
    required super.about,
    required super.country,
    required super.city,
    required super.phone,
    required super.email,
    required super.profileImage,
    required super.isProfileActivated,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CareerProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CareerProfileModel(
      id: json['id'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      headline: json['headline'],
      about: json['about'],
      country: json['country'],
      city: json['city'],
      phone: json['phone'],
      email: json['email'],
      profileImage: json['profile_image'],
      isProfileActivated: json['is_profile_activated'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'headline': headline,
      'about': about,
      'country': country,
      'city': city,
      'phone': phone,
      'email': email,
      'profile_image': profileImage,
      'is_profile_activated': isProfileActivated,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}