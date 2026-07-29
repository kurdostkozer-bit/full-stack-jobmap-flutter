// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EducationResponse _$EducationResponseFromJson(Map<String, dynamic> json) {
  return _EducationResponse.fromJson(json);
}

/// @nodoc
mixin _$EducationResponse {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get school => throw _privateConstructorUsedError;
  String get degree => throw _privateConstructorUsedError;
  String? get fieldOfStudy => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get currentlyStudying => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EducationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EducationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationResponseCopyWith<EducationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationResponseCopyWith<$Res> {
  factory $EducationResponseCopyWith(
    EducationResponse value,
    $Res Function(EducationResponse) then,
  ) = _$EducationResponseCopyWithImpl<$Res, EducationResponse>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String school,
    String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$EducationResponseCopyWithImpl<$Res, $Val extends EducationResponse>
    implements $EducationResponseCopyWith<$Res> {
  _$EducationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EducationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? school = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = null,
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
            school: null == school
                ? _value.school
                : school // ignore: cast_nullable_to_non_nullable
                      as String,
            degree: null == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String,
            fieldOfStudy: freezed == fieldOfStudy
                ? _value.fieldOfStudy
                : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentlyStudying: null == currentlyStudying
                ? _value.currentlyStudying
                : currentlyStudying // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EducationResponseImplCopyWith<$Res>
    implements $EducationResponseCopyWith<$Res> {
  factory _$$EducationResponseImplCopyWith(
    _$EducationResponseImpl value,
    $Res Function(_$EducationResponseImpl) then,
  ) = __$$EducationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String school,
    String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$EducationResponseImplCopyWithImpl<$Res>
    extends _$EducationResponseCopyWithImpl<$Res, _$EducationResponseImpl>
    implements _$$EducationResponseImplCopyWith<$Res> {
  __$$EducationResponseImplCopyWithImpl(
    _$EducationResponseImpl _value,
    $Res Function(_$EducationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EducationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? school = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$EducationResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        careerProfileId: null == careerProfileId
            ? _value.careerProfileId
            : careerProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        school: null == school
            ? _value.school
            : school // ignore: cast_nullable_to_non_nullable
                  as String,
        degree: null == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldOfStudy: freezed == fieldOfStudy
            ? _value.fieldOfStudy
            : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentlyStudying: null == currentlyStudying
            ? _value.currentlyStudying
            : currentlyStudying // ignore: cast_nullable_to_non_nullable
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
class _$EducationResponseImpl implements _EducationResponse {
  const _$EducationResponseImpl({
    required this.id,
    required this.careerProfileId,
    required this.school,
    required this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    required this.currentlyStudying,
    this.description,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$EducationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String school;
  @override
  final String degree;
  @override
  final String? fieldOfStudy;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool currentlyStudying;
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
    return 'EducationResponse(id: $id, careerProfileId: $careerProfileId, school: $school, degree: $degree, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, currentlyStudying: $currentlyStudying, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.school, school) || other.school == school) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.currentlyStudying, currentlyStudying) ||
                other.currentlyStudying == currentlyStudying) &&
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
    school,
    degree,
    fieldOfStudy,
    startDate,
    endDate,
    currentlyStudying,
    description,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of EducationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationResponseImplCopyWith<_$EducationResponseImpl> get copyWith =>
      __$$EducationResponseImplCopyWithImpl<_$EducationResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationResponseImplToJson(this);
  }
}

abstract class _EducationResponse implements EducationResponse {
  const factory _EducationResponse({
    required final String id,
    required final String careerProfileId,
    required final String school,
    required final String degree,
    final String? fieldOfStudy,
    final DateTime? startDate,
    final DateTime? endDate,
    required final bool currentlyStudying,
    final String? description,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$EducationResponseImpl;

  factory _EducationResponse.fromJson(Map<String, dynamic> json) =
      _$EducationResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get school;
  @override
  String get degree;
  @override
  String? get fieldOfStudy;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get currentlyStudying;
  @override
  String? get description;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of EducationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationResponseImplCopyWith<_$EducationResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateEducationRequest _$CreateEducationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateEducationRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateEducationRequest {
  String get school => throw _privateConstructorUsedError;
  String get degree => throw _privateConstructorUsedError;
  String? get fieldOfStudy => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get currentlyStudying => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CreateEducationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateEducationRequestCopyWith<CreateEducationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEducationRequestCopyWith<$Res> {
  factory $CreateEducationRequestCopyWith(
    CreateEducationRequest value,
    $Res Function(CreateEducationRequest) then,
  ) = _$CreateEducationRequestCopyWithImpl<$Res, CreateEducationRequest>;
  @useResult
  $Res call({
    String school,
    String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying,
    String? description,
  });
}

/// @nodoc
class _$CreateEducationRequestCopyWithImpl<
  $Res,
  $Val extends CreateEducationRequest
>
    implements $CreateEducationRequestCopyWith<$Res> {
  _$CreateEducationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? school = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            school: null == school
                ? _value.school
                : school // ignore: cast_nullable_to_non_nullable
                      as String,
            degree: null == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String,
            fieldOfStudy: freezed == fieldOfStudy
                ? _value.fieldOfStudy
                : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentlyStudying: null == currentlyStudying
                ? _value.currentlyStudying
                : currentlyStudying // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateEducationRequestImplCopyWith<$Res>
    implements $CreateEducationRequestCopyWith<$Res> {
  factory _$$CreateEducationRequestImplCopyWith(
    _$CreateEducationRequestImpl value,
    $Res Function(_$CreateEducationRequestImpl) then,
  ) = __$$CreateEducationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String school,
    String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying,
    String? description,
  });
}

/// @nodoc
class __$$CreateEducationRequestImplCopyWithImpl<$Res>
    extends
        _$CreateEducationRequestCopyWithImpl<$Res, _$CreateEducationRequestImpl>
    implements _$$CreateEducationRequestImplCopyWith<$Res> {
  __$$CreateEducationRequestImplCopyWithImpl(
    _$CreateEducationRequestImpl _value,
    $Res Function(_$CreateEducationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? school = null,
    Object? degree = null,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = null,
    Object? description = freezed,
  }) {
    return _then(
      _$CreateEducationRequestImpl(
        school: null == school
            ? _value.school
            : school // ignore: cast_nullable_to_non_nullable
                  as String,
        degree: null == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldOfStudy: freezed == fieldOfStudy
            ? _value.fieldOfStudy
            : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentlyStudying: null == currentlyStudying
            ? _value.currentlyStudying
            : currentlyStudying // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateEducationRequestImpl implements _CreateEducationRequest {
  const _$CreateEducationRequestImpl({
    required this.school,
    required this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    required this.currentlyStudying,
    this.description,
  });

  factory _$CreateEducationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateEducationRequestImplFromJson(json);

  @override
  final String school;
  @override
  final String degree;
  @override
  final String? fieldOfStudy;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool currentlyStudying;
  @override
  final String? description;

  @override
  String toString() {
    return 'CreateEducationRequest(school: $school, degree: $degree, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, currentlyStudying: $currentlyStudying, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEducationRequestImpl &&
            (identical(other.school, school) || other.school == school) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.currentlyStudying, currentlyStudying) ||
                other.currentlyStudying == currentlyStudying) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    school,
    degree,
    fieldOfStudy,
    startDate,
    endDate,
    currentlyStudying,
    description,
  );

  /// Create a copy of CreateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEducationRequestImplCopyWith<_$CreateEducationRequestImpl>
  get copyWith =>
      __$$CreateEducationRequestImplCopyWithImpl<_$CreateEducationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateEducationRequestImplToJson(this);
  }
}

abstract class _CreateEducationRequest implements CreateEducationRequest {
  const factory _CreateEducationRequest({
    required final String school,
    required final String degree,
    final String? fieldOfStudy,
    final DateTime? startDate,
    final DateTime? endDate,
    required final bool currentlyStudying,
    final String? description,
  }) = _$CreateEducationRequestImpl;

  factory _CreateEducationRequest.fromJson(Map<String, dynamic> json) =
      _$CreateEducationRequestImpl.fromJson;

  @override
  String get school;
  @override
  String get degree;
  @override
  String? get fieldOfStudy;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get currentlyStudying;
  @override
  String? get description;

  /// Create a copy of CreateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateEducationRequestImplCopyWith<_$CreateEducationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateEducationRequest _$UpdateEducationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateEducationRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateEducationRequest {
  String? get school => throw _privateConstructorUsedError;
  String? get degree => throw _privateConstructorUsedError;
  String? get fieldOfStudy => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool? get currentlyStudying => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this UpdateEducationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateEducationRequestCopyWith<UpdateEducationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateEducationRequestCopyWith<$Res> {
  factory $UpdateEducationRequestCopyWith(
    UpdateEducationRequest value,
    $Res Function(UpdateEducationRequest) then,
  ) = _$UpdateEducationRequestCopyWithImpl<$Res, UpdateEducationRequest>;
  @useResult
  $Res call({
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  });
}

/// @nodoc
class _$UpdateEducationRequestCopyWithImpl<
  $Res,
  $Val extends UpdateEducationRequest
>
    implements $UpdateEducationRequestCopyWith<$Res> {
  _$UpdateEducationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? school = freezed,
    Object? degree = freezed,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            school: freezed == school
                ? _value.school
                : school // ignore: cast_nullable_to_non_nullable
                      as String?,
            degree: freezed == degree
                ? _value.degree
                : degree // ignore: cast_nullable_to_non_nullable
                      as String?,
            fieldOfStudy: freezed == fieldOfStudy
                ? _value.fieldOfStudy
                : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            currentlyStudying: freezed == currentlyStudying
                ? _value.currentlyStudying
                : currentlyStudying // ignore: cast_nullable_to_non_nullable
                      as bool?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateEducationRequestImplCopyWith<$Res>
    implements $UpdateEducationRequestCopyWith<$Res> {
  factory _$$UpdateEducationRequestImplCopyWith(
    _$UpdateEducationRequestImpl value,
    $Res Function(_$UpdateEducationRequestImpl) then,
  ) = __$$UpdateEducationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  });
}

/// @nodoc
class __$$UpdateEducationRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateEducationRequestCopyWithImpl<$Res, _$UpdateEducationRequestImpl>
    implements _$$UpdateEducationRequestImplCopyWith<$Res> {
  __$$UpdateEducationRequestImplCopyWithImpl(
    _$UpdateEducationRequestImpl _value,
    $Res Function(_$UpdateEducationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? school = freezed,
    Object? degree = freezed,
    Object? fieldOfStudy = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? currentlyStudying = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$UpdateEducationRequestImpl(
        school: freezed == school
            ? _value.school
            : school // ignore: cast_nullable_to_non_nullable
                  as String?,
        degree: freezed == degree
            ? _value.degree
            : degree // ignore: cast_nullable_to_non_nullable
                  as String?,
        fieldOfStudy: freezed == fieldOfStudy
            ? _value.fieldOfStudy
            : fieldOfStudy // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        currentlyStudying: freezed == currentlyStudying
            ? _value.currentlyStudying
            : currentlyStudying // ignore: cast_nullable_to_non_nullable
                  as bool?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateEducationRequestImpl implements _UpdateEducationRequest {
  const _$UpdateEducationRequestImpl({
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.currentlyStudying,
    this.description,
  });

  factory _$UpdateEducationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateEducationRequestImplFromJson(json);

  @override
  final String? school;
  @override
  final String? degree;
  @override
  final String? fieldOfStudy;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool? currentlyStudying;
  @override
  final String? description;

  @override
  String toString() {
    return 'UpdateEducationRequest(school: $school, degree: $degree, fieldOfStudy: $fieldOfStudy, startDate: $startDate, endDate: $endDate, currentlyStudying: $currentlyStudying, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateEducationRequestImpl &&
            (identical(other.school, school) || other.school == school) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            (identical(other.fieldOfStudy, fieldOfStudy) ||
                other.fieldOfStudy == fieldOfStudy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.currentlyStudying, currentlyStudying) ||
                other.currentlyStudying == currentlyStudying) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    school,
    degree,
    fieldOfStudy,
    startDate,
    endDate,
    currentlyStudying,
    description,
  );

  /// Create a copy of UpdateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateEducationRequestImplCopyWith<_$UpdateEducationRequestImpl>
  get copyWith =>
      __$$UpdateEducationRequestImplCopyWithImpl<_$UpdateEducationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateEducationRequestImplToJson(this);
  }
}

abstract class _UpdateEducationRequest implements UpdateEducationRequest {
  const factory _UpdateEducationRequest({
    final String? school,
    final String? degree,
    final String? fieldOfStudy,
    final DateTime? startDate,
    final DateTime? endDate,
    final bool? currentlyStudying,
    final String? description,
  }) = _$UpdateEducationRequestImpl;

  factory _UpdateEducationRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateEducationRequestImpl.fromJson;

  @override
  String? get school;
  @override
  String? get degree;
  @override
  String? get fieldOfStudy;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool? get currentlyStudying;
  @override
  String? get description;

  /// Create a copy of UpdateEducationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateEducationRequestImplCopyWith<_$UpdateEducationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
