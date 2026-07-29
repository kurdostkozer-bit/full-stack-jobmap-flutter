// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CareerProfileImpl _$$CareerProfileImplFromJson(Map<String, dynamic> json) =>
    _$CareerProfileImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      bio: json['bio'] as String?,
      headline: json['headline'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CareerProfileImplToJson(_$CareerProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'bio': instance.bio,
      'headline': instance.headline,
      'location': instance.location,
      'website': instance.website,
      'linkedinUrl': instance.linkedinUrl,
      'githubUrl': instance.githubUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  name: json['name'] as String,
  proficiency: (json['proficiency'] as num).toInt(),
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'name': instance.name,
      'proficiency': instance.proficiency,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ExperienceImpl _$$ExperienceImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      jobTitle: json['jobTitle'] as String,
      companyName: json['companyName'] as String,
      companyWebsite: json['companyWebsite'] as String?,
      location: json['location'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool,
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ExperienceImplToJson(_$ExperienceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'companyWebsite': instance.companyWebsite,
      'location': instance.location,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$EducationImpl _$$EducationImplFromJson(Map<String, dynamic> json) =>
    _$EducationImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      schoolName: json['schoolName'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String,
      degreeType: json['degreeType'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      grade: json['grade'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EducationImplToJson(_$EducationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'schoolName': instance.schoolName,
      'fieldOfStudy': instance.fieldOfStudy,
      'degreeType': instance.degreeType,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'grade': instance.grade,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      name: json['name'] as String,
      proficiency: json['proficiency'] as String,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'name': instance.name,
      'proficiency': instance.proficiency,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      technologies: (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      projectUrl: json['projectUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      role: json['role'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'title': instance.title,
      'description': instance.description,
      'technologies': instance.technologies,
      'projectUrl': instance.projectUrl,
      'imageUrl': instance.imageUrl,
      'role': instance.role,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CertificateImpl _$$CertificateImplFromJson(Map<String, dynamic> json) =>
    _$CertificateImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      name: json['name'] as String,
      issuer: json['issuer'] as String,
      credentialId: json['credentialId'] as String?,
      credentialUrl: json['credentialUrl'] as String?,
      issueDate: DateTime.parse(json['issueDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      doesNotExpire: json['doesNotExpire'] as bool,
      verificationStatus: json['verificationStatus'] as String,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CertificateImplToJson(_$CertificateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'name': instance.name,
      'issuer': instance.issuer,
      'credentialId': instance.credentialId,
      'credentialUrl': instance.credentialUrl,
      'issueDate': instance.issueDate.toIso8601String(),
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'doesNotExpire': instance.doesNotExpire,
      'verificationStatus': instance.verificationStatus,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
