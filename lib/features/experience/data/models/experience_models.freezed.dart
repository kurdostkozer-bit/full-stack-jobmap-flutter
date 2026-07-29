// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExperienceResponse _$ExperienceResponseFromJson(Map<String, dynamic> json) {
  return _ExperienceResponse.fromJson(json);
}

/// @nodoc
mixin _$ExperienceResponse {
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

  /// Serializes this ExperienceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperienceResponseCopyWith<ExperienceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceResponseCopyWith<$Res> {
  factory $ExperienceResponseCopyWith(
    ExperienceResponse value,
    $Res Function(ExperienceResponse) then,
  ) = _$ExperienceResponseCopyWithImpl<$Res, ExperienceResponse>;
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
class _$ExperienceResponseCopyWithImpl<$Res, $Val extends ExperienceResponse>
    implements $ExperienceResponseCopyWith<$Res> {
  _$ExperienceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperienceResponse
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
abstract class _$$ExperienceResponseImplCopyWith<$Res>
    implements $ExperienceResponseCopyWith<$Res> {
  factory _$$ExperienceResponseImplCopyWith(
    _$ExperienceResponseImpl value,
    $Res Function(_$ExperienceResponseImpl) then,
  ) = __$$ExperienceResponseImplCopyWithImpl<$Res>;
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
class __$$ExperienceResponseImplCopyWithImpl<$Res>
    extends _$ExperienceResponseCopyWithImpl<$Res, _$ExperienceResponseImpl>
    implements _$$ExperienceResponseImplCopyWith<$Res> {
  __$$ExperienceResponseImplCopyWithImpl(
    _$ExperienceResponseImpl _value,
    $Res Function(_$ExperienceResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperienceResponse
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
      _$ExperienceResponseImpl(
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
class _$ExperienceResponseImpl implements _ExperienceResponse {
  const _$ExperienceResponseImpl({
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

  factory _$ExperienceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceResponseImplFromJson(json);

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
    return 'ExperienceResponse(id: $id, careerProfileId: $careerProfileId, jobTitle: $jobTitle, companyName: $companyName, companyWebsite: $companyWebsite, location: $location, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceResponseImpl &&
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

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceResponseImplCopyWith<_$ExperienceResponseImpl> get copyWith =>
      __$$ExperienceResponseImplCopyWithImpl<_$ExperienceResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceResponseImplToJson(this);
  }
}

abstract class _ExperienceResponse implements ExperienceResponse {
  const factory _ExperienceResponse({
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
  }) = _$ExperienceResponseImpl;

  factory _ExperienceResponse.fromJson(Map<String, dynamic> json) =
      _$ExperienceResponseImpl.fromJson;

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

  /// Create a copy of ExperienceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperienceResponseImplCopyWith<_$ExperienceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateExperienceRequest _$CreateExperienceRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateExperienceRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateExperienceRequest {
  String get jobTitle => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String? get companyWebsite => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CreateExperienceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateExperienceRequestCopyWith<CreateExperienceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateExperienceRequestCopyWith<$Res> {
  factory $CreateExperienceRequestCopyWith(
    CreateExperienceRequest value,
    $Res Function(CreateExperienceRequest) then,
  ) = _$CreateExperienceRequestCopyWithImpl<$Res, CreateExperienceRequest>;
  @useResult
  $Res call({
    String jobTitle,
    String companyName,
    String? companyWebsite,
    String location,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    String? description,
  });
}

/// @nodoc
class _$CreateExperienceRequestCopyWithImpl<
  $Res,
  $Val extends CreateExperienceRequest
>
    implements $CreateExperienceRequestCopyWith<$Res> {
  _$CreateExperienceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = null,
    Object? companyName = null,
    Object? companyWebsite = freezed,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateExperienceRequestImplCopyWith<$Res>
    implements $CreateExperienceRequestCopyWith<$Res> {
  factory _$$CreateExperienceRequestImplCopyWith(
    _$CreateExperienceRequestImpl value,
    $Res Function(_$CreateExperienceRequestImpl) then,
  ) = __$$CreateExperienceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String jobTitle,
    String companyName,
    String? companyWebsite,
    String location,
    DateTime startDate,
    DateTime? endDate,
    bool isCurrent,
    String? description,
  });
}

/// @nodoc
class __$$CreateExperienceRequestImplCopyWithImpl<$Res>
    extends
        _$CreateExperienceRequestCopyWithImpl<
          $Res,
          _$CreateExperienceRequestImpl
        >
    implements _$$CreateExperienceRequestImplCopyWith<$Res> {
  __$$CreateExperienceRequestImplCopyWithImpl(
    _$CreateExperienceRequestImpl _value,
    $Res Function(_$CreateExperienceRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = null,
    Object? companyName = null,
    Object? companyWebsite = freezed,
    Object? location = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCurrent = null,
    Object? description = freezed,
  }) {
    return _then(
      _$CreateExperienceRequestImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateExperienceRequestImpl implements _CreateExperienceRequest {
  const _$CreateExperienceRequestImpl({
    required this.jobTitle,
    required this.companyName,
    this.companyWebsite,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    this.description,
  });

  factory _$CreateExperienceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateExperienceRequestImplFromJson(json);

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
  String toString() {
    return 'CreateExperienceRequest(jobTitle: $jobTitle, companyName: $companyName, companyWebsite: $companyWebsite, location: $location, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExperienceRequestImpl &&
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
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    jobTitle,
    companyName,
    companyWebsite,
    location,
    startDate,
    endDate,
    isCurrent,
    description,
  );

  /// Create a copy of CreateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateExperienceRequestImplCopyWith<_$CreateExperienceRequestImpl>
  get copyWith =>
      __$$CreateExperienceRequestImplCopyWithImpl<
        _$CreateExperienceRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateExperienceRequestImplToJson(this);
  }
}

abstract class _CreateExperienceRequest implements CreateExperienceRequest {
  const factory _CreateExperienceRequest({
    required final String jobTitle,
    required final String companyName,
    final String? companyWebsite,
    required final String location,
    required final DateTime startDate,
    final DateTime? endDate,
    required final bool isCurrent,
    final String? description,
  }) = _$CreateExperienceRequestImpl;

  factory _CreateExperienceRequest.fromJson(Map<String, dynamic> json) =
      _$CreateExperienceRequestImpl.fromJson;

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

  /// Create a copy of CreateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateExperienceRequestImplCopyWith<_$CreateExperienceRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateExperienceRequest _$UpdateExperienceRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateExperienceRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateExperienceRequest {
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get companyWebsite => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool? get isCurrent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this UpdateExperienceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateExperienceRequestCopyWith<UpdateExperienceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateExperienceRequestCopyWith<$Res> {
  factory $UpdateExperienceRequestCopyWith(
    UpdateExperienceRequest value,
    $Res Function(UpdateExperienceRequest) then,
  ) = _$UpdateExperienceRequestCopyWithImpl<$Res, UpdateExperienceRequest>;
  @useResult
  $Res call({
    String? jobTitle,
    String? companyName,
    String? companyWebsite,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  });
}

/// @nodoc
class _$UpdateExperienceRequestCopyWithImpl<
  $Res,
  $Val extends UpdateExperienceRequest
>
    implements $UpdateExperienceRequestCopyWith<$Res> {
  _$UpdateExperienceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = freezed,
    Object? companyName = freezed,
    Object? companyWebsite = freezed,
    Object? location = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrent = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            jobTitle: freezed == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyName: freezed == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyWebsite: freezed == companyWebsite
                ? _value.companyWebsite
                : companyWebsite // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrent: freezed == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UpdateExperienceRequestImplCopyWith<$Res>
    implements $UpdateExperienceRequestCopyWith<$Res> {
  factory _$$UpdateExperienceRequestImplCopyWith(
    _$UpdateExperienceRequestImpl value,
    $Res Function(_$UpdateExperienceRequestImpl) then,
  ) = __$$UpdateExperienceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? jobTitle,
    String? companyName,
    String? companyWebsite,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  });
}

/// @nodoc
class __$$UpdateExperienceRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateExperienceRequestCopyWithImpl<
          $Res,
          _$UpdateExperienceRequestImpl
        >
    implements _$$UpdateExperienceRequestImplCopyWith<$Res> {
  __$$UpdateExperienceRequestImplCopyWithImpl(
    _$UpdateExperienceRequestImpl _value,
    $Res Function(_$UpdateExperienceRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = freezed,
    Object? companyName = freezed,
    Object? companyWebsite = freezed,
    Object? location = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrent = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$UpdateExperienceRequestImpl(
        jobTitle: freezed == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyName: freezed == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyWebsite: freezed == companyWebsite
            ? _value.companyWebsite
            : companyWebsite // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrent: freezed == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
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
class _$UpdateExperienceRequestImpl implements _UpdateExperienceRequest {
  const _$UpdateExperienceRequestImpl({
    this.jobTitle,
    this.companyName,
    this.companyWebsite,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  factory _$UpdateExperienceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateExperienceRequestImplFromJson(json);

  @override
  final String? jobTitle;
  @override
  final String? companyName;
  @override
  final String? companyWebsite;
  @override
  final String? location;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool? isCurrent;
  @override
  final String? description;

  @override
  String toString() {
    return 'UpdateExperienceRequest(jobTitle: $jobTitle, companyName: $companyName, companyWebsite: $companyWebsite, location: $location, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateExperienceRequestImpl &&
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
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    jobTitle,
    companyName,
    companyWebsite,
    location,
    startDate,
    endDate,
    isCurrent,
    description,
  );

  /// Create a copy of UpdateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateExperienceRequestImplCopyWith<_$UpdateExperienceRequestImpl>
  get copyWith =>
      __$$UpdateExperienceRequestImplCopyWithImpl<
        _$UpdateExperienceRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateExperienceRequestImplToJson(this);
  }
}

abstract class _UpdateExperienceRequest implements UpdateExperienceRequest {
  const factory _UpdateExperienceRequest({
    final String? jobTitle,
    final String? companyName,
    final String? companyWebsite,
    final String? location,
    final DateTime? startDate,
    final DateTime? endDate,
    final bool? isCurrent,
    final String? description,
  }) = _$UpdateExperienceRequestImpl;

  factory _UpdateExperienceRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateExperienceRequestImpl.fromJson;

  @override
  String? get jobTitle;
  @override
  String? get companyName;
  @override
  String? get companyWebsite;
  @override
  String? get location;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool? get isCurrent;
  @override
  String? get description;

  /// Create a copy of UpdateExperienceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateExperienceRequestImplCopyWith<_$UpdateExperienceRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
