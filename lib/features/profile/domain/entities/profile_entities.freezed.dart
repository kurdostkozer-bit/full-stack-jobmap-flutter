// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CareerProfile _$CareerProfileFromJson(Map<String, dynamic> json) {
  return _CareerProfile.fromJson(json);
}

/// @nodoc
mixin _$CareerProfile {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get githubUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CareerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CareerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CareerProfileCopyWith<CareerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareerProfileCopyWith<$Res> {
  factory $CareerProfileCopyWith(
    CareerProfile value,
    $Res Function(CareerProfile) then,
  ) = _$CareerProfileCopyWithImpl<$Res, CareerProfile>;
  @useResult
  $Res call({
    String id,
    String userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CareerProfileCopyWithImpl<$Res, $Val extends CareerProfile>
    implements $CareerProfileCopyWith<$Res> {
  _$CareerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CareerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            headline: freezed == headline
                ? _value.headline
                : headline // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            githubUrl: freezed == githubUrl
                ? _value.githubUrl
                : githubUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CareerProfileImplCopyWith<$Res>
    implements $CareerProfileCopyWith<$Res> {
  factory _$$CareerProfileImplCopyWith(
    _$CareerProfileImpl value,
    $Res Function(_$CareerProfileImpl) then,
  ) = __$$CareerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CareerProfileImplCopyWithImpl<$Res>
    extends _$CareerProfileCopyWithImpl<$Res, _$CareerProfileImpl>
    implements _$$CareerProfileImplCopyWith<$Res> {
  __$$CareerProfileImplCopyWithImpl(
    _$CareerProfileImpl _value,
    $Res Function(_$CareerProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CareerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CareerProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        headline: freezed == headline
            ? _value.headline
            : headline // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        githubUrl: freezed == githubUrl
            ? _value.githubUrl
            : githubUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CareerProfileImpl implements _CareerProfile {
  const _$CareerProfileImpl({
    required this.id,
    required this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.headline,
    this.location,
    this.website,
    this.linkedinUrl,
    this.githubUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$CareerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareerProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? profileImageUrl;
  @override
  final String? bio;
  @override
  final String? headline;
  @override
  final String? location;
  @override
  final String? website;
  @override
  final String? linkedinUrl;
  @override
  final String? githubUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CareerProfile(id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, bio: $bio, headline: $headline, location: $location, website: $website, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.githubUrl, githubUrl) ||
                other.githubUrl == githubUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    firstName,
    lastName,
    email,
    phoneNumber,
    profileImageUrl,
    bio,
    headline,
    location,
    website,
    linkedinUrl,
    githubUrl,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CareerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareerProfileImplCopyWith<_$CareerProfileImpl> get copyWith =>
      __$$CareerProfileImplCopyWithImpl<_$CareerProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareerProfileImplToJson(this);
  }
}

abstract class _CareerProfile implements CareerProfile {
  const factory _CareerProfile({
    required final String id,
    required final String userId,
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phoneNumber,
    final String? profileImageUrl,
    final String? bio,
    final String? headline,
    final String? location,
    final String? website,
    final String? linkedinUrl,
    final String? githubUrl,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CareerProfileImpl;

  factory _CareerProfile.fromJson(Map<String, dynamic> json) =
      _$CareerProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  String? get profileImageUrl;
  @override
  String? get bio;
  @override
  String? get headline;
  @override
  String? get location;
  @override
  String? get website;
  @override
  String? get linkedinUrl;
  @override
  String? get githubUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CareerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareerProfileImplCopyWith<_$CareerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get proficiency => throw _privateConstructorUsedError; // 1-5
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    int proficiency,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            proficiency: null == proficiency
                ? _value.proficiency
                : proficiency // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
    _$SkillImpl value,
    $Res Function(_$SkillImpl) then,
  ) = __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    int proficiency,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
    _$SkillImpl _value,
    $Res Function(_$SkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SkillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        proficiency: null == proficiency
            ? _value.proficiency
            : proficiency // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.proficiency,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String name;
  @override
  final int proficiency;
  // 1-5
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Skill(id: $id, careerProfileId: $careerProfileId, name: $name, proficiency: $proficiency, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    name,
    proficiency,
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(this);
  }
}

abstract class _Skill implements Skill {
  const factory _Skill({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final int proficiency,
    final String? description,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get name;
  @override
  int get proficiency; // 1-5
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  return _Experience.fromJson(json);
}

/// @nodoc
mixin _$Experience {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String? get companyWebsite => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Experience to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceCopyWith<Experience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceCopyWith<$Res> {
  factory $ExperienceCopyWith(
    Experience value,
    $Res Function(Experience) then,
  ) = _$ExperienceCopyWithImpl<$Res, Experience>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String jobTitle,
    String companyName,
    String? companyWebsite,
    String location,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ExperienceCopyWithImpl<$Res, $Val extends Experience>
    implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? jobTitle = null,
    Object? companyName = null,
    Object? companyWebsite = freezed,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            jobTitle: null == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            companyWebsite: freezed == companyWebsite
                ? _value.companyWebsite
                : companyWebsite // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrent: null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperienceImplCopyWith<$Res>
    implements $ExperienceCopyWith<$Res> {
  factory _$$ExperienceImplCopyWith(
    _$ExperienceImpl value,
    $Res Function(_$ExperienceImpl) then,
  ) = __$$ExperienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String jobTitle,
    String companyName,
    String? companyWebsite,
    String location,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ExperienceImplCopyWithImpl<$Res>
    extends _$ExperienceCopyWithImpl<$Res, _$ExperienceImpl>
    implements _$$ExperienceImplCopyWith<$Res> {
  __$$ExperienceImplCopyWithImpl(
    _$ExperienceImpl _value,
    $Res Function(_$ExperienceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? jobTitle = null,
    Object? companyName = null,
    Object? companyWebsite = freezed,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ExperienceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        jobTitle: null == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        companyWebsite: freezed == companyWebsite
            ? _value.companyWebsite
            : companyWebsite // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrent: null == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceImpl implements _Experience {
  const _$ExperienceImpl({
    required this.id,
    required this.careerProfileId,
    required this.jobTitle,
    required this.companyName,
    this.companyWebsite,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    this.description,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$ExperienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String jobTitle;
  @override
  final String companyName;
  @override
  final String? companyWebsite;
  @override
  final String location;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isCurrent;
  @override
  final String? description;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Experience(id: $id, careerProfileId: $careerProfileId, jobTitle: $jobTitle, companyName: $companyName, companyWebsite: $companyWebsite, location: $location, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.companyWebsite, companyWebsite) ||
                other.companyWebsite == companyWebsite) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    jobTitle,
    companyName,
    companyWebsite,
    location,
    startDate,
    endDate,
    isCurrent,
    description,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      __$$ExperienceImplCopyWithImpl<_$ExperienceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceImplToJson(this);
  }
}

abstract class _Experience implements Experience {
  const factory _Experience({
    required final String id,
    required final String careerProfileId,
    required final String jobTitle,
    required final String companyName,
    final String? companyWebsite,
    required final String location,
    required final DateTime startDate,
    final DateTime? endDate,
    required final bool isCurrent,
    final String? description,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ExperienceImpl;

  factory _Experience.fromJson(Map<String, dynamic> json) =
      _$ExperienceImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get jobTitle;
  @override
  String get companyName;
  @override
  String? get companyWebsite;
  @override
  String get location;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrent;
  @override
  String? get description;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Experience
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceImplCopyWith<_$ExperienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Education _$EducationFromJson(Map<String, dynamic> json) {
  return _Education.fromJson(json);
}

/// @nodoc
mixin _$Education {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String get fieldOfStudy => throw _privateConstructorUsedError;
  String get degreeType =>
      throw _privateConstructorUsedError; // Bachelor, Master, PhD, etc.
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationCopyWith<Education> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationCopyWith<$Res> {
  factory $EducationCopyWith(Education value, $Res Function(Education) then) =
      _$EducationCopyWithImpl<$Res, Education>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String schoolName,
    String fieldOfStudy,
    String degreeType,
    DateTime? startDate,
    DateTime? endDate,
    String? grade,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$EducationCopyWithImpl<$Res, $Val extends Education>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? schoolName = null,
    Object? fieldOfStudy = null,
    Object? degreeType = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? grade = freezed,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            schoolName: null == schoolName
                ? _value.schoolName
                : schoolName // ignore: cast_nullable_to_non_nullable
                      as String,
            fieldOfStudy: null == fieldOfStudy
                ? _value.fieldOfStudy
                : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                      as String,
            degreeType: null == degreeType
                ? _value.degreeType
                : degreeType // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EducationImplCopyWith<$Res>
    implements $EducationCopyWith<$Res> {
  factory _$$EducationImplCopyWith(
    _$EducationImpl value,
    $Res Function(_$EducationImpl) then,
  ) = __$$EducationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String schoolName,
    String fieldOfStudy,
    String degreeType,
    DateTime? startDate,
    DateTime? endDate,
    String? grade,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$EducationImplCopyWithImpl<$Res>
    extends _$EducationCopyWithImpl<$Res, _$EducationImpl>
    implements _$$EducationImplCopyWith<$Res> {
  __$$EducationImplCopyWithImpl(
    _$EducationImpl _value,
    $Res Function(_$EducationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? schoolName = null,
    Object? fieldOfStudy = null,
    Object? degreeType = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? grade = freezed,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$EducationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        schoolName: null == schoolName
            ? _value.schoolName
            : schoolName // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldOfStudy: null == fieldOfStudy
            ? _value.fieldOfStudy
            : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                  as String,
        degreeType: null == degreeType
            ? _value.degreeType
            : degreeType // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EducationImpl implements _Education {
  const _$EducationImpl({
    required this.id,
    required this.careerProfileId,
    required this.schoolName,
    required this.fieldOfStudy,
    required this.degreeType,
    this.startDate,
    this.endDate,
    this.grade,
    this.description,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$EducationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String schoolName;
  @override
  final String fieldOfStudy;
  @override
  final String degreeType;
  // Bachelor, Master, PhD, etc.
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? grade;
  @override
  final String? description;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Education(id: $id, careerProfileId: $careerProfileId, schoolName: $schoolName, fieldOfStudy: $fieldOfStudy, degreeType: $degreeType, startDate: $startDate, endDate: $endDate, grade: $grade, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.degreeType, degreeType) ||
                other.degreeType == degreeType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    schoolName,
    fieldOfStudy,
    degreeType,
    startDate,
    endDate,
    grade,
    description,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      __$$EducationImplCopyWithImpl<_$EducationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationImplToJson(this);
  }
}

abstract class _Education implements Education {
  const factory _Education({
    required final String id,
    required final String careerProfileId,
    required final String schoolName,
    required final String fieldOfStudy,
    required final String degreeType,
    final DateTime? startDate,
    final DateTime? endDate,
    final String? grade,
    final String? description,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$EducationImpl;

  factory _Education.fromJson(Map<String, dynamic> json) =
      _$EducationImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get schoolName;
  @override
  String get fieldOfStudy;
  @override
  String get degreeType; // Bachelor, Master, PhD, etc.
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get grade;
  @override
  String? get description;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Education
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationImplCopyWith<_$EducationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return _Language.fromJson(json);
}

/// @nodoc
mixin _$Language {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get proficiency =>
      throw _privateConstructorUsedError; // Native, Fluent, Intermediate, Basic
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Language to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageCopyWith<Language> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageCopyWith<$Res> {
  factory $LanguageCopyWith(Language value, $Res Function(Language) then) =
      _$LanguageCopyWithImpl<$Res, Language>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    String proficiency,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$LanguageCopyWithImpl<$Res, $Val extends Language>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            proficiency: null == proficiency
                ? _value.proficiency
                : proficiency // ignore: cast_nullable_to_non_nullable
                      as String,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LanguageImplCopyWith<$Res>
    implements $LanguageCopyWith<$Res> {
  factory _$$LanguageImplCopyWith(
    _$LanguageImpl value,
    $Res Function(_$LanguageImpl) then,
  ) = __$$LanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    String proficiency,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$LanguageImplCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$LanguageImpl>
    implements _$$LanguageImplCopyWith<$Res> {
  __$$LanguageImplCopyWithImpl(
    _$LanguageImpl _value,
    $Res Function(_$LanguageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$LanguageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        proficiency: null == proficiency
            ? _value.proficiency
            : proficiency // ignore: cast_nullable_to_non_nullable
                  as String,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageImpl implements _Language {
  const _$LanguageImpl({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.proficiency,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$LanguageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String name;
  @override
  final String proficiency;
  // Native, Fluent, Intermediate, Basic
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Language(id: $id, careerProfileId: $careerProfileId, name: $name, proficiency: $proficiency, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    name,
    proficiency,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      __$$LanguageImplCopyWithImpl<_$LanguageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageImplToJson(this);
  }
}

abstract class _Language implements Language {
  const factory _Language({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final String proficiency,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$LanguageImpl;

  factory _Language.fromJson(Map<String, dynamic> json) =
      _$LanguageImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get name;
  @override
  String get proficiency; // Native, Fluent, Intermediate, Basic
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String>? get technologies => throw _privateConstructorUsedError;
  String? get projectUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? imageUrl,
    String role,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? title = null,
    Object? description = freezed,
    Object? technologies = freezed,
    Object? projectUrl = freezed,
    Object? imageUrl = freezed,
    Object? role = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            technologies: freezed == technologies
                ? _value.technologies
                : technologies // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            projectUrl: freezed == projectUrl
                ? _value.projectUrl
                : projectUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrent: null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                      as bool,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
    _$ProjectImpl value,
    $Res Function(_$ProjectImpl) then,
  ) = __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? imageUrl,
    String role,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
    _$ProjectImpl _value,
    $Res Function(_$ProjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? title = null,
    Object? description = freezed,
    Object? technologies = freezed,
    Object? projectUrl = freezed,
    Object? imageUrl = freezed,
    Object? role = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ProjectImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        technologies: freezed == technologies
            ? _value._technologies
            : technologies // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        projectUrl: freezed == projectUrl
            ? _value.projectUrl
            : projectUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrent: null == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
                  as bool,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl implements _Project {
  const _$ProjectImpl({
    required this.id,
    required this.careerProfileId,
    required this.title,
    this.description,
    final List<String>? technologies,
    this.projectUrl,
    this.imageUrl,
    required this.role,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  }) : _technologies = technologies;

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String title;
  @override
  final String? description;
  final List<String>? _technologies;
  @override
  List<String>? get technologies {
    final value = _technologies;
    if (value == null) return null;
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? projectUrl;
  @override
  final String? imageUrl;
  @override
  final String role;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isCurrent;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Project(id: $id, careerProfileId: $careerProfileId, title: $title, description: $description, technologies: $technologies, projectUrl: $projectUrl, imageUrl: $imageUrl, role: $role, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._technologies,
              _technologies,
            ) &&
            (identical(other.projectUrl, projectUrl) ||
                other.projectUrl == projectUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    title,
    description,
    const DeepCollectionEquality().hash(_technologies),
    projectUrl,
    imageUrl,
    role,
    startDate,
    endDate,
    isCurrent,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(this);
  }
}

abstract class _Project implements Project {
  const factory _Project({
    required final String id,
    required final String careerProfileId,
    required final String title,
    final String? description,
    final List<String>? technologies,
    final String? projectUrl,
    final String? imageUrl,
    required final String role,
    required final DateTime startDate,
    final DateTime? endDate,
    required final bool isCurrent,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ProjectImpl;

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<String>? get technologies;
  @override
  String? get projectUrl;
  @override
  String? get imageUrl;
  @override
  String get role;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrent;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Certificate _$CertificateFromJson(Map<String, dynamic> json) {
  return _Certificate.fromJson(json);
}

/// @nodoc
mixin _$Certificate {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get issuer => throw _privateConstructorUsedError;
  String? get credentialId => throw _privateConstructorUsedError;
  String? get credentialUrl => throw _privateConstructorUsedError;
  DateTime get issueDate => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  bool get doesNotExpire => throw _privateConstructorUsedError;
  String get verificationStatus =>
      throw _privateConstructorUsedError; // PENDING, VERIFIED, REJECTED
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Certificate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateCopyWith<Certificate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateCopyWith<$Res> {
  factory $CertificateCopyWith(
    Certificate value,
    $Res Function(Certificate) then,
  ) = _$CertificateCopyWithImpl<$Res, Certificate>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    String issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime issueDate,
    DateTime? expiryDate,
    bool doesNotExpire,
    String verificationStatus,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CertificateCopyWithImpl<$Res, $Val extends Certificate>
    implements $CertificateCopyWith<$Res> {
  _$CertificateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? issuer = null,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = null,
    Object? expiryDate = freezed,
    Object? doesNotExpire = null,
    Object? verificationStatus = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            careerProfileId: null == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            issuer: null == issuer
                ? _value.issuer
                : issuer // ignore: cast_nullable_to_non_nullable
                      as String,
            credentialId: freezed == credentialId
                ? _value.credentialId
                : credentialId // ignore: cast_nullable_to_non_nullable
                      as String?,
            credentialUrl: freezed == credentialUrl
                ? _value.credentialUrl
                : credentialUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            issueDate: null == issueDate
                ? _value.issueDate
                : issueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiryDate: freezed == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            doesNotExpire: null == doesNotExpire
                ? _value.doesNotExpire
                : doesNotExpire // ignore: cast_nullable_to_non_nullable
                      as bool,
            verificationStatus: null == verificationStatus
                ? _value.verificationStatus
                : verificationStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificateImplCopyWith<$Res>
    implements $CertificateCopyWith<$Res> {
  factory _$$CertificateImplCopyWith(
    _$CertificateImpl value,
    $Res Function(_$CertificateImpl) then,
  ) = __$$CertificateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    String issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime issueDate,
    DateTime? expiryDate,
    bool doesNotExpire,
    String verificationStatus,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CertificateImplCopyWithImpl<$Res>
    extends _$CertificateCopyWithImpl<$Res, _$CertificateImpl>
    implements _$$CertificateImplCopyWith<$Res> {
  __$$CertificateImplCopyWithImpl(
    _$CertificateImpl _value,
    $Res Function(_$CertificateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? issuer = null,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = null,
    Object? expiryDate = freezed,
    Object? doesNotExpire = null,
    Object? verificationStatus = null,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CertificateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        issuer: null == issuer
            ? _value.issuer
            : issuer // ignore: cast_nullable_to_non_nullable
                  as String,
        credentialId: freezed == credentialId
            ? _value.credentialId
            : credentialId // ignore: cast_nullable_to_non_nullable
                  as String?,
        credentialUrl: freezed == credentialUrl
            ? _value.credentialUrl
            : credentialUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        issueDate: null == issueDate
            ? _value.issueDate
            : issueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiryDate: freezed == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        doesNotExpire: null == doesNotExpire
            ? _value.doesNotExpire
            : doesNotExpire // ignore: cast_nullable_to_non_nullable
                  as bool,
        verificationStatus: null == verificationStatus
            ? _value.verificationStatus
            : verificationStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateImpl implements _Certificate {
  const _$CertificateImpl({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.issuer,
    this.credentialId,
    this.credentialUrl,
    required this.issueDate,
    this.expiryDate,
    required this.doesNotExpire,
    required this.verificationStatus,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$CertificateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String name;
  @override
  final String issuer;
  @override
  final String? credentialId;
  @override
  final String? credentialUrl;
  @override
  final DateTime issueDate;
  @override
  final DateTime? expiryDate;
  @override
  final bool doesNotExpire;
  @override
  final String verificationStatus;
  // PENDING, VERIFIED, REJECTED
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Certificate(id: $id, careerProfileId: $careerProfileId, name: $name, issuer: $issuer, credentialId: $credentialId, credentialUrl: $credentialUrl, issueDate: $issueDate, expiryDate: $expiryDate, doesNotExpire: $doesNotExpire, verificationStatus: $verificationStatus, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.issuer, issuer) || other.issuer == issuer) &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.credentialUrl, credentialUrl) ||
                other.credentialUrl == credentialUrl) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.doesNotExpire, doesNotExpire) ||
                other.doesNotExpire == doesNotExpire) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    careerProfileId,
    name,
    issuer,
    credentialId,
    credentialUrl,
    issueDate,
    expiryDate,
    doesNotExpire,
    verificationStatus,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateImplCopyWith<_$CertificateImpl> get copyWith =>
      __$$CertificateImplCopyWithImpl<_$CertificateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateImplToJson(this);
  }
}

abstract class _Certificate implements Certificate {
  const factory _Certificate({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final String issuer,
    final String? credentialId,
    final String? credentialUrl,
    required final DateTime issueDate,
    final DateTime? expiryDate,
    required final bool doesNotExpire,
    required final String verificationStatus,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CertificateImpl;

  factory _Certificate.fromJson(Map<String, dynamic> json) =
      _$CertificateImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get name;
  @override
  String get issuer;
  @override
  String? get credentialId;
  @override
  String? get credentialUrl;
  @override
  DateTime get issueDate;
  @override
  DateTime? get expiryDate;
  @override
  bool get doesNotExpire;
  @override
  String get verificationStatus; // PENDING, VERIFIED, REJECTED
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateImplCopyWith<_$CertificateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
