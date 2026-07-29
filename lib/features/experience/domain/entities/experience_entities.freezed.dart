// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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
