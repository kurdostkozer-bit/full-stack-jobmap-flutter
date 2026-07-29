// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certificates_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CertificateResponse _$CertificateResponseFromJson(Map<String, dynamic> json) {
  return _CertificateResponse.fromJson(json);
}

/// @nodoc
mixin _$CertificateResponse {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get issuer => throw _privateConstructorUsedError;
  String? get credentialId => throw _privateConstructorUsedError;
  String? get credentialUrl => throw _privateConstructorUsedError;
  DateTime get issueDate => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  bool get doesNotExpire => throw _privateConstructorUsedError;
  CertificateVerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CertificateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateResponseCopyWith<CertificateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateResponseCopyWith<$Res> {
  factory $CertificateResponseCopyWith(
    CertificateResponse value,
    $Res Function(CertificateResponse) then,
  ) = _$CertificateResponseCopyWithImpl<$Res, CertificateResponse>;
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
    CertificateVerificationStatus verificationStatus,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CertificateResponseCopyWithImpl<$Res, $Val extends CertificateResponse>
    implements $CertificateResponseCopyWith<$Res> {
  _$CertificateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateResponse
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
                      as CertificateVerificationStatus,
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
abstract class _$$CertificateResponseImplCopyWith<$Res>
    implements $CertificateResponseCopyWith<$Res> {
  factory _$$CertificateResponseImplCopyWith(
    _$CertificateResponseImpl value,
    $Res Function(_$CertificateResponseImpl) then,
  ) = __$$CertificateResponseImplCopyWithImpl<$Res>;
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
    CertificateVerificationStatus verificationStatus,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CertificateResponseImplCopyWithImpl<$Res>
    extends _$CertificateResponseCopyWithImpl<$Res, _$CertificateResponseImpl>
    implements _$$CertificateResponseImplCopyWith<$Res> {
  __$$CertificateResponseImplCopyWithImpl(
    _$CertificateResponseImpl _value,
    $Res Function(_$CertificateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateResponse
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
      _$CertificateResponseImpl(
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
                  as CertificateVerificationStatus,
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
class _$CertificateResponseImpl implements _CertificateResponse {
  const _$CertificateResponseImpl({
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

  factory _$CertificateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateResponseImplFromJson(json);

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
  final CertificateVerificationStatus verificationStatus;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CertificateResponse(id: $id, careerProfileId: $careerProfileId, name: $name, issuer: $issuer, credentialId: $credentialId, credentialUrl: $credentialUrl, issueDate: $issueDate, expiryDate: $expiryDate, doesNotExpire: $doesNotExpire, verificationStatus: $verificationStatus, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateResponseImpl &&
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

  /// Create a copy of CertificateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateResponseImplCopyWith<_$CertificateResponseImpl> get copyWith =>
      __$$CertificateResponseImplCopyWithImpl<_$CertificateResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateResponseImplToJson(this);
  }
}

abstract class _CertificateResponse implements CertificateResponse {
  const factory _CertificateResponse({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final String issuer,
    final String? credentialId,
    final String? credentialUrl,
    required final DateTime issueDate,
    final DateTime? expiryDate,
    required final bool doesNotExpire,
    required final CertificateVerificationStatus verificationStatus,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$CertificateResponseImpl;

  factory _CertificateResponse.fromJson(Map<String, dynamic> json) =
      _$CertificateResponseImpl.fromJson;

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
  CertificateVerificationStatus get verificationStatus;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of CertificateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateResponseImplCopyWith<_$CertificateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateCertificateRequest _$CreateCertificateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateCertificateRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCertificateRequest {
  String get name => throw _privateConstructorUsedError;
  String get issuer => throw _privateConstructorUsedError;
  String? get credentialId => throw _privateConstructorUsedError;
  String? get credentialUrl => throw _privateConstructorUsedError;
  DateTime get issueDate => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  bool get doesNotExpire => throw _privateConstructorUsedError;

  /// Serializes this CreateCertificateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCertificateRequestCopyWith<CreateCertificateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCertificateRequestCopyWith<$Res> {
  factory $CreateCertificateRequestCopyWith(
    CreateCertificateRequest value,
    $Res Function(CreateCertificateRequest) then,
  ) = _$CreateCertificateRequestCopyWithImpl<$Res, CreateCertificateRequest>;
  @useResult
  $Res call({
    String name,
    String issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime issueDate,
    DateTime? expiryDate,
    bool doesNotExpire,
  });
}

/// @nodoc
class _$CreateCertificateRequestCopyWithImpl<
  $Res,
  $Val extends CreateCertificateRequest
>
    implements $CreateCertificateRequestCopyWith<$Res> {
  _$CreateCertificateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? issuer = null,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = null,
    Object? expiryDate = freezed,
    Object? doesNotExpire = null,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateCertificateRequestImplCopyWith<$Res>
    implements $CreateCertificateRequestCopyWith<$Res> {
  factory _$$CreateCertificateRequestImplCopyWith(
    _$CreateCertificateRequestImpl value,
    $Res Function(_$CreateCertificateRequestImpl) then,
  ) = __$$CreateCertificateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime issueDate,
    DateTime? expiryDate,
    bool doesNotExpire,
  });
}

/// @nodoc
class __$$CreateCertificateRequestImplCopyWithImpl<$Res>
    extends
        _$CreateCertificateRequestCopyWithImpl<
          $Res,
          _$CreateCertificateRequestImpl
        >
    implements _$$CreateCertificateRequestImplCopyWith<$Res> {
  __$$CreateCertificateRequestImplCopyWithImpl(
    _$CreateCertificateRequestImpl _value,
    $Res Function(_$CreateCertificateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? issuer = null,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = null,
    Object? expiryDate = freezed,
    Object? doesNotExpire = null,
  }) {
    return _then(
      _$CreateCertificateRequestImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCertificateRequestImpl implements _CreateCertificateRequest {
  const _$CreateCertificateRequestImpl({
    required this.name,
    required this.issuer,
    this.credentialId,
    this.credentialUrl,
    required this.issueDate,
    this.expiryDate,
    required this.doesNotExpire,
  });

  factory _$CreateCertificateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCertificateRequestImplFromJson(json);

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
  String toString() {
    return 'CreateCertificateRequest(name: $name, issuer: $issuer, credentialId: $credentialId, credentialUrl: $credentialUrl, issueDate: $issueDate, expiryDate: $expiryDate, doesNotExpire: $doesNotExpire)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCertificateRequestImpl &&
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
                other.doesNotExpire == doesNotExpire));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    issuer,
    credentialId,
    credentialUrl,
    issueDate,
    expiryDate,
    doesNotExpire,
  );

  /// Create a copy of CreateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCertificateRequestImplCopyWith<_$CreateCertificateRequestImpl>
  get copyWith =>
      __$$CreateCertificateRequestImplCopyWithImpl<
        _$CreateCertificateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCertificateRequestImplToJson(this);
  }
}

abstract class _CreateCertificateRequest implements CreateCertificateRequest {
  const factory _CreateCertificateRequest({
    required final String name,
    required final String issuer,
    final String? credentialId,
    final String? credentialUrl,
    required final DateTime issueDate,
    final DateTime? expiryDate,
    required final bool doesNotExpire,
  }) = _$CreateCertificateRequestImpl;

  factory _CreateCertificateRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCertificateRequestImpl.fromJson;

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

  /// Create a copy of CreateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCertificateRequestImplCopyWith<_$CreateCertificateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateCertificateRequest _$UpdateCertificateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateCertificateRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateCertificateRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get issuer => throw _privateConstructorUsedError;
  String? get credentialId => throw _privateConstructorUsedError;
  String? get credentialUrl => throw _privateConstructorUsedError;
  DateTime? get issueDate => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  bool? get doesNotExpire => throw _privateConstructorUsedError;

  /// Serializes this UpdateCertificateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateCertificateRequestCopyWith<UpdateCertificateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCertificateRequestCopyWith<$Res> {
  factory $UpdateCertificateRequestCopyWith(
    UpdateCertificateRequest value,
    $Res Function(UpdateCertificateRequest) then,
  ) = _$UpdateCertificateRequestCopyWithImpl<$Res, UpdateCertificateRequest>;
  @useResult
  $Res call({
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  });
}

/// @nodoc
class _$UpdateCertificateRequestCopyWithImpl<
  $Res,
  $Val extends UpdateCertificateRequest
>
    implements $UpdateCertificateRequestCopyWith<$Res> {
  _$UpdateCertificateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? issuer = freezed,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = freezed,
    Object? expiryDate = freezed,
    Object? doesNotExpire = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuer: freezed == issuer
                ? _value.issuer
                : issuer // ignore: cast_nullable_to_non_nullable
                      as String?,
            credentialId: freezed == credentialId
                ? _value.credentialId
                : credentialId // ignore: cast_nullable_to_non_nullable
                      as String?,
            credentialUrl: freezed == credentialUrl
                ? _value.credentialUrl
                : credentialUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            issueDate: freezed == issueDate
                ? _value.issueDate
                : issueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiryDate: freezed == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            doesNotExpire: freezed == doesNotExpire
                ? _value.doesNotExpire
                : doesNotExpire // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateCertificateRequestImplCopyWith<$Res>
    implements $UpdateCertificateRequestCopyWith<$Res> {
  factory _$$UpdateCertificateRequestImplCopyWith(
    _$UpdateCertificateRequestImpl value,
    $Res Function(_$UpdateCertificateRequestImpl) then,
  ) = __$$UpdateCertificateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  });
}

/// @nodoc
class __$$UpdateCertificateRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateCertificateRequestCopyWithImpl<
          $Res,
          _$UpdateCertificateRequestImpl
        >
    implements _$$UpdateCertificateRequestImplCopyWith<$Res> {
  __$$UpdateCertificateRequestImplCopyWithImpl(
    _$UpdateCertificateRequestImpl _value,
    $Res Function(_$UpdateCertificateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? issuer = freezed,
    Object? credentialId = freezed,
    Object? credentialUrl = freezed,
    Object? issueDate = freezed,
    Object? expiryDate = freezed,
    Object? doesNotExpire = freezed,
  }) {
    return _then(
      _$UpdateCertificateRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuer: freezed == issuer
            ? _value.issuer
            : issuer // ignore: cast_nullable_to_non_nullable
                  as String?,
        credentialId: freezed == credentialId
            ? _value.credentialId
            : credentialId // ignore: cast_nullable_to_non_nullable
                  as String?,
        credentialUrl: freezed == credentialUrl
            ? _value.credentialUrl
            : credentialUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        issueDate: freezed == issueDate
            ? _value.issueDate
            : issueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiryDate: freezed == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        doesNotExpire: freezed == doesNotExpire
            ? _value.doesNotExpire
            : doesNotExpire // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateCertificateRequestImpl implements _UpdateCertificateRequest {
  const _$UpdateCertificateRequestImpl({
    this.name,
    this.issuer,
    this.credentialId,
    this.credentialUrl,
    this.issueDate,
    this.expiryDate,
    this.doesNotExpire,
  });

  factory _$UpdateCertificateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateCertificateRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? issuer;
  @override
  final String? credentialId;
  @override
  final String? credentialUrl;
  @override
  final DateTime? issueDate;
  @override
  final DateTime? expiryDate;
  @override
  final bool? doesNotExpire;

  @override
  String toString() {
    return 'UpdateCertificateRequest(name: $name, issuer: $issuer, credentialId: $credentialId, credentialUrl: $credentialUrl, issueDate: $issueDate, expiryDate: $expiryDate, doesNotExpire: $doesNotExpire)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCertificateRequestImpl &&
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
                other.doesNotExpire == doesNotExpire));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    issuer,
    credentialId,
    credentialUrl,
    issueDate,
    expiryDate,
    doesNotExpire,
  );

  /// Create a copy of UpdateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCertificateRequestImplCopyWith<_$UpdateCertificateRequestImpl>
  get copyWith =>
      __$$UpdateCertificateRequestImplCopyWithImpl<
        _$UpdateCertificateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateCertificateRequestImplToJson(this);
  }
}

abstract class _UpdateCertificateRequest implements UpdateCertificateRequest {
  const factory _UpdateCertificateRequest({
    final String? name,
    final String? issuer,
    final String? credentialId,
    final String? credentialUrl,
    final DateTime? issueDate,
    final DateTime? expiryDate,
    final bool? doesNotExpire,
  }) = _$UpdateCertificateRequestImpl;

  factory _UpdateCertificateRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateCertificateRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get issuer;
  @override
  String? get credentialId;
  @override
  String? get credentialUrl;
  @override
  DateTime? get issueDate;
  @override
  DateTime? get expiryDate;
  @override
  bool? get doesNotExpire;

  /// Create a copy of UpdateCertificateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCertificateRequestImplCopyWith<_$UpdateCertificateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
