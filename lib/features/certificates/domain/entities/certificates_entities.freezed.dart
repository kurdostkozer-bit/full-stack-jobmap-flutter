// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certificates_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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
  CertificateVerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;
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
    CertificateVerificationStatus verificationStatus,
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
    CertificateVerificationStatus verificationStatus,
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
  final CertificateVerificationStatus verificationStatus;
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
    required final CertificateVerificationStatus verificationStatus,
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
  CertificateVerificationStatus get verificationStatus;
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
