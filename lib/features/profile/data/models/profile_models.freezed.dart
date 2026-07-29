// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CareerProfileResponse _$CareerProfileResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CareerProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$CareerProfileResponse {
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

  /// Serializes this CareerProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CareerProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CareerProfileResponseCopyWith<CareerProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareerProfileResponseCopyWith<$Res> {
  factory $CareerProfileResponseCopyWith(
    CareerProfileResponse value,
    $Res Function(CareerProfileResponse) then,
  ) = _$CareerProfileResponseCopyWithImpl<$Res, CareerProfileResponse>;
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
class _$CareerProfileResponseCopyWithImpl<
  $Res,
  $Val extends CareerProfileResponse
>
    implements $CareerProfileResponseCopyWith<$Res> {
  _$CareerProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CareerProfileResponse
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
abstract class _$$CareerProfileResponseImplCopyWith<$Res>
    implements $CareerProfileResponseCopyWith<$Res> {
  factory _$$CareerProfileResponseImplCopyWith(
    _$CareerProfileResponseImpl value,
    $Res Function(_$CareerProfileResponseImpl) then,
  ) = __$$CareerProfileResponseImplCopyWithImpl<$Res>;
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
class __$$CareerProfileResponseImplCopyWithImpl<$Res>
    extends
        _$CareerProfileResponseCopyWithImpl<$Res, _$CareerProfileResponseImpl>
    implements _$$CareerProfileResponseImplCopyWith<$Res> {
  __$$CareerProfileResponseImplCopyWithImpl(
    _$CareerProfileResponseImpl _value,
    $Res Function(_$CareerProfileResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CareerProfileResponse
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
      _$CareerProfileResponseImpl(
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
class _$CareerProfileResponseImpl implements _CareerProfileResponse {
  const _$CareerProfileResponseImpl({
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

  factory _$CareerProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareerProfileResponseImplFromJson(json);

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
    return 'CareerProfileResponse(id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, bio: $bio, headline: $headline, location: $location, website: $website, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareerProfileResponseImpl &&
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

  /// Create a copy of CareerProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareerProfileResponseImplCopyWith<_$CareerProfileResponseImpl>
  get copyWith =>
      __$$CareerProfileResponseImplCopyWithImpl<_$CareerProfileResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CareerProfileResponseImplToJson(this);
  }
}

abstract class _CareerProfileResponse implements CareerProfileResponse {
  const factory _CareerProfileResponse({
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
  }) = _$CareerProfileResponseImpl;

  factory _CareerProfileResponse.fromJson(Map<String, dynamic> json) =
      _$CareerProfileResponseImpl.fromJson;

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

  /// Create a copy of CareerProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareerProfileResponseImplCopyWith<_$CareerProfileResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get githubUrl => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(
    UpdateProfileRequest value,
    $Res Function(UpdateProfileRequest) then,
  ) = _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
  });
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProfileRequest
>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(
    _$UpdateProfileRequestImpl value,
    $Res Function(_$UpdateProfileRequestImpl) then,
  ) = __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
  });
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(
    _$UpdateProfileRequestImpl _value,
    $Res Function(_$UpdateProfileRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? bio = freezed,
    Object? headline = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? linkedinUrl = freezed,
    Object? githubUrl = freezed,
  }) {
    return _then(
      _$UpdateProfileRequestImpl(
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.headline,
    this.location,
    this.website,
    this.linkedinUrl,
    this.githubUrl,
  });

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
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
  String toString() {
    return 'UpdateProfileRequest(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, bio: $bio, headline: $headline, location: $location, website: $website, linkedinUrl: $linkedinUrl, githubUrl: $githubUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
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
                other.githubUrl == githubUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    phoneNumber,
    profileImageUrl,
    bio,
    headline,
    location,
    website,
    linkedinUrl,
    githubUrl,
  );

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith =>
      __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(this);
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest({
    final String? firstName,
    final String? lastName,
    final String? phoneNumber,
    final String? profileImageUrl,
    final String? bio,
    final String? headline,
    final String? location,
    final String? website,
    final String? linkedinUrl,
    final String? githubUrl,
  }) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
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

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
