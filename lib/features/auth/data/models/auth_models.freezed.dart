// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
    LoginRequest value,
    $Res Function(LoginRequest) then,
  ) = _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
    _$LoginRequestImpl value,
    $Res Function(_$LoginRequestImpl) then,
  ) = __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
    _$LoginRequestImpl _value,
    $Res Function(_$LoginRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? password = null}) {
    return _then(
      _$LoginRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl({required this.email, required this.password});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginRequest(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(this);
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest({
    required final String email,
    required final String password,
  }) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return _RegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestCopyWith<RegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestCopyWith<$Res> {
  factory $RegisterRequestCopyWith(
    RegisterRequest value,
    $Res Function(RegisterRequest) then,
  ) = _$RegisterRequestCopyWithImpl<$Res, RegisterRequest>;
  @useResult
  $Res call({String email, String password, String firstName, String lastName});
}

/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res, $Val extends RegisterRequest>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RegisterRequestImplCopyWith<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  factory _$$RegisterRequestImplCopyWith(
    _$RegisterRequestImpl value,
    $Res Function(_$RegisterRequestImpl) then,
  ) = __$$RegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, String firstName, String lastName});
}

/// @nodoc
class __$$RegisterRequestImplCopyWithImpl<$Res>
    extends _$RegisterRequestCopyWithImpl<$Res, _$RegisterRequestImpl>
    implements _$$RegisterRequestImplCopyWith<$Res> {
  __$$RegisterRequestImplCopyWithImpl(
    _$RegisterRequestImpl _value,
    $Res Function(_$RegisterRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _$RegisterRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestImpl implements _RegisterRequest {
  const _$RegisterRequestImpl({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory _$RegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'RegisterRequest(email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, firstName, lastName);

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      __$$RegisterRequestImplCopyWithImpl<_$RegisterRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestImplToJson(this);
  }
}

abstract class _RegisterRequest implements RegisterRequest {
  const factory _RegisterRequest({
    required final String email,
    required final String password,
    required final String firstName,
    required final String lastName,
  }) = _$RegisterRequestImpl;

  factory _RegisterRequest.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get firstName;
  @override
  String get lastName;

  /// Create a copy of RegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestImplCopyWith<_$RegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return _AuthResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthResponse {
  String get token => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  UserResponse get user => throw _privateConstructorUsedError;

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
    AuthResponse value,
    $Res Function(AuthResponse) then,
  ) = _$AuthResponseCopyWithImpl<$Res, AuthResponse>;
  @useResult
  $Res call({String token, String refreshToken, UserResponse user});

  $UserResponseCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res, $Val extends AuthResponse>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
    Object? user = null,
  }) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserResponse,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserResponseCopyWith<$Res> get user {
    return $UserResponseCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthResponseImplCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$$AuthResponseImplCopyWith(
    _$AuthResponseImpl value,
    $Res Function(_$AuthResponseImpl) then,
  ) = __$$AuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String refreshToken, UserResponse user});

  @override
  $UserResponseCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthResponseImplCopyWithImpl<$Res>
    extends _$AuthResponseCopyWithImpl<$Res, _$AuthResponseImpl>
    implements _$$AuthResponseImplCopyWith<$Res> {
  __$$AuthResponseImplCopyWithImpl(
    _$AuthResponseImpl _value,
    $Res Function(_$AuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? refreshToken = null,
    Object? user = null,
  }) {
    return _then(
      _$AuthResponseImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserResponse,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseImpl implements _AuthResponse {
  const _$AuthResponseImpl({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory _$AuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseImplFromJson(json);

  @override
  final String token;
  @override
  final String refreshToken;
  @override
  final UserResponse user;

  @override
  String toString() {
    return 'AuthResponse(token: $token, refreshToken: $refreshToken, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, refreshToken, user);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      __$$AuthResponseImplCopyWithImpl<_$AuthResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseImplToJson(this);
  }
}

abstract class _AuthResponse implements AuthResponse {
  const factory _AuthResponse({
    required final String token,
    required final String refreshToken,
    required final UserResponse user,
  }) = _$AuthResponseImpl;

  factory _AuthResponse.fromJson(Map<String, dynamic> json) =
      _$AuthResponseImpl.fromJson;

  @override
  String get token;
  @override
  String get refreshToken;
  @override
  UserResponse get user;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return _UserResponse.fromJson(json);
}

/// @nodoc
mixin _$UserResponse {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  bool? get emailVerified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get careerProfileId => throw _privateConstructorUsedError;

  /// Serializes this UserResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserResponseCopyWith<UserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResponseCopyWith<$Res> {
  factory $UserResponseCopyWith(
    UserResponse value,
    $Res Function(UserResponse) then,
  ) = _$UserResponseCopyWithImpl<$Res, UserResponse>;
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    String? profileImage,
    String? bio,
    bool? emailVerified,
    DateTime? createdAt,
    String? careerProfileId,
  });
}

/// @nodoc
class _$UserResponseCopyWithImpl<$Res, $Val extends UserResponse>
    implements $UserResponseCopyWith<$Res> {
  _$UserResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? profileImage = freezed,
    Object? bio = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
    Object? careerProfileId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            profileImage: freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            emailVerified: freezed == emailVerified
                ? _value.emailVerified
                : emailVerified // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            careerProfileId: freezed == careerProfileId
                ? _value.careerProfileId
                : careerProfileId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserResponseImplCopyWith<$Res>
    implements $UserResponseCopyWith<$Res> {
  factory _$$UserResponseImplCopyWith(
    _$UserResponseImpl value,
    $Res Function(_$UserResponseImpl) then,
  ) = __$$UserResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    String? profileImage,
    String? bio,
    bool? emailVerified,
    DateTime? createdAt,
    String? careerProfileId,
  });
}

/// @nodoc
class __$$UserResponseImplCopyWithImpl<$Res>
    extends _$UserResponseCopyWithImpl<$Res, _$UserResponseImpl>
    implements _$$UserResponseImplCopyWith<$Res> {
  __$$UserResponseImplCopyWithImpl(
    _$UserResponseImpl _value,
    $Res Function(_$UserResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? profileImage = freezed,
    Object? bio = freezed,
    Object? emailVerified = freezed,
    Object? createdAt = freezed,
    Object? careerProfileId = freezed,
  }) {
    return _then(
      _$UserResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        profileImage: freezed == profileImage
            ? _value.profileImage
            : profileImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        emailVerified: freezed == emailVerified
            ? _value.emailVerified
            : emailVerified // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        careerProfileId: freezed == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserResponseImpl implements _UserResponse {
  const _$UserResponseImpl({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    this.bio,
    this.emailVerified,
    this.createdAt,
    this.careerProfileId,
  });

  factory _$UserResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? profileImage;
  @override
  final String? bio;
  @override
  final bool? emailVerified;
  @override
  final DateTime? createdAt;
  @override
  final String? careerProfileId;

  @override
  String toString() {
    return 'UserResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, profileImage: $profileImage, bio: $bio, emailVerified: $emailVerified, createdAt: $createdAt, careerProfileId: $careerProfileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    profileImage,
    bio,
    emailVerified,
    createdAt,
    careerProfileId,
  );

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserResponseImplCopyWith<_$UserResponseImpl> get copyWith =>
      __$$UserResponseImplCopyWithImpl<_$UserResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserResponseImplToJson(this);
  }
}

abstract class _UserResponse implements UserResponse {
  const factory _UserResponse({
    required final String id,
    required final String email,
    required final String firstName,
    required final String lastName,
    final String? profileImage,
    final String? bio,
    final bool? emailVerified,
    final DateTime? createdAt,
    final String? careerProfileId,
  }) = _$UserResponseImpl;

  factory _UserResponse.fromJson(Map<String, dynamic> json) =
      _$UserResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get profileImage;
  @override
  String? get bio;
  @override
  bool? get emailVerified;
  @override
  DateTime? get createdAt;
  @override
  String? get careerProfileId;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserResponseImplCopyWith<_$UserResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) {
  return _VerifyEmailRequest.fromJson(json);
}

/// @nodoc
mixin _$VerifyEmailRequest {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this VerifyEmailRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyEmailRequestCopyWith<VerifyEmailRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyEmailRequestCopyWith<$Res> {
  factory $VerifyEmailRequestCopyWith(
    VerifyEmailRequest value,
    $Res Function(VerifyEmailRequest) then,
  ) = _$VerifyEmailRequestCopyWithImpl<$Res, VerifyEmailRequest>;
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class _$VerifyEmailRequestCopyWithImpl<$Res, $Val extends VerifyEmailRequest>
    implements $VerifyEmailRequestCopyWith<$Res> {
  _$VerifyEmailRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? code = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VerifyEmailRequestImplCopyWith<$Res>
    implements $VerifyEmailRequestCopyWith<$Res> {
  factory _$$VerifyEmailRequestImplCopyWith(
    _$VerifyEmailRequestImpl value,
    $Res Function(_$VerifyEmailRequestImpl) then,
  ) = __$$VerifyEmailRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class __$$VerifyEmailRequestImplCopyWithImpl<$Res>
    extends _$VerifyEmailRequestCopyWithImpl<$Res, _$VerifyEmailRequestImpl>
    implements _$$VerifyEmailRequestImplCopyWith<$Res> {
  __$$VerifyEmailRequestImplCopyWithImpl(
    _$VerifyEmailRequestImpl _value,
    $Res Function(_$VerifyEmailRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? code = null}) {
    return _then(
      _$VerifyEmailRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyEmailRequestImpl implements _VerifyEmailRequest {
  const _$VerifyEmailRequestImpl({required this.email, required this.code});

  factory _$VerifyEmailRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyEmailRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String code;

  @override
  String toString() {
    return 'VerifyEmailRequest(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailRequestImplCopyWith<_$VerifyEmailRequestImpl> get copyWith =>
      __$$VerifyEmailRequestImplCopyWithImpl<_$VerifyEmailRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyEmailRequestImplToJson(this);
  }
}

abstract class _VerifyEmailRequest implements VerifyEmailRequest {
  const factory _VerifyEmailRequest({
    required final String email,
    required final String code,
  }) = _$VerifyEmailRequestImpl;

  factory _VerifyEmailRequest.fromJson(Map<String, dynamic> json) =
      _$VerifyEmailRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get code;

  /// Create a copy of VerifyEmailRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailRequestImplCopyWith<_$VerifyEmailRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ForgotPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordRequestCopyWith<$Res> {
  factory $ForgotPasswordRequestCopyWith(
    ForgotPasswordRequest value,
    $Res Function(ForgotPasswordRequest) then,
  ) = _$ForgotPasswordRequestCopyWithImpl<$Res, ForgotPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ForgotPasswordRequest
>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForgotPasswordRequestImplCopyWith<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$$ForgotPasswordRequestImplCopyWith(
    _$ForgotPasswordRequestImpl value,
    $Res Function(_$ForgotPasswordRequestImpl) then,
  ) = __$$ForgotPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ForgotPasswordRequestCopyWithImpl<$Res, _$ForgotPasswordRequestImpl>
    implements _$$ForgotPasswordRequestImplCopyWith<$Res> {
  __$$ForgotPasswordRequestImplCopyWithImpl(
    _$ForgotPasswordRequestImpl _value,
    $Res Function(_$ForgotPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$ForgotPasswordRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordRequestImpl implements _ForgotPasswordRequest {
  const _$ForgotPasswordRequestImpl({required this.email});

  factory _$ForgotPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
  get copyWith =>
      __$$ForgotPasswordRequestImplCopyWithImpl<_$ForgotPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordRequestImplToJson(this);
  }
}

abstract class _ForgotPasswordRequest implements ForgotPasswordRequest {
  const factory _ForgotPasswordRequest({required final String email}) =
      _$ForgotPasswordRequestImpl;

  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordRequestImpl.fromJson;

  @override
  String get email;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return _ResetPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordRequest {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordRequestCopyWith<ResetPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordRequestCopyWith<$Res> {
  factory $ResetPasswordRequestCopyWith(
    ResetPasswordRequest value,
    $Res Function(ResetPasswordRequest) then,
  ) = _$ResetPasswordRequestCopyWithImpl<$Res, ResetPasswordRequest>;
  @useResult
  $Res call({String email, String code, String newPassword});
}

/// @nodoc
class _$ResetPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ResetPasswordRequest
>
    implements $ResetPasswordRequestCopyWith<$Res> {
  _$ResetPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? newPassword = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResetPasswordRequestImplCopyWith<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  factory _$$ResetPasswordRequestImplCopyWith(
    _$ResetPasswordRequestImpl value,
    $Res Function(_$ResetPasswordRequestImpl) then,
  ) = __$$ResetPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code, String newPassword});
}

/// @nodoc
class __$$ResetPasswordRequestImplCopyWithImpl<$Res>
    extends _$ResetPasswordRequestCopyWithImpl<$Res, _$ResetPasswordRequestImpl>
    implements _$$ResetPasswordRequestImplCopyWith<$Res> {
  __$$ResetPasswordRequestImplCopyWithImpl(
    _$ResetPasswordRequestImpl _value,
    $Res Function(_$ResetPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
    Object? newPassword = null,
  }) {
    return _then(
      _$ResetPasswordRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordRequestImpl implements _ResetPasswordRequest {
  const _$ResetPasswordRequestImpl({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  factory _$ResetPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String code;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ResetPasswordRequest(email: $email, code: $code, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, code, newPassword);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith =>
      __$$ResetPasswordRequestImplCopyWithImpl<_$ResetPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordRequestImplToJson(this);
  }
}

abstract class _ResetPasswordRequest implements ResetPasswordRequest {
  const factory _ResetPasswordRequest({
    required final String email,
    required final String code,
    required final String newPassword,
  }) = _$ResetPasswordRequestImpl;

  factory _ResetPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get code;
  @override
  String get newPassword;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
