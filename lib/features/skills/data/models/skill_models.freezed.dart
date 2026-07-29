// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SkillResponse _$SkillResponseFromJson(Map<String, dynamic> json) {
  return _SkillResponse.fromJson(json);
}

/// @nodoc
mixin _$SkillResponse {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get proficiency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SkillResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkillResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillResponseCopyWith<SkillResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillResponseCopyWith<$Res> {
  factory $SkillResponseCopyWith(
    SkillResponse value,
    $Res Function(SkillResponse) then,
  ) = _$SkillResponseCopyWithImpl<$Res, SkillResponse>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    int proficiency,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$SkillResponseCopyWithImpl<$Res, $Val extends SkillResponse>
    implements $SkillResponseCopyWith<$Res> {
  _$SkillResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkillResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
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
abstract class _$$SkillResponseImplCopyWith<$Res>
    implements $SkillResponseCopyWith<$Res> {
  factory _$$SkillResponseImplCopyWith(
    _$SkillResponseImpl value,
    $Res Function(_$SkillResponseImpl) then,
  ) = __$$SkillResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    int proficiency,
    String? description,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$SkillResponseImplCopyWithImpl<$Res>
    extends _$SkillResponseCopyWithImpl<$Res, _$SkillResponseImpl>
    implements _$$SkillResponseImplCopyWith<$Res> {
  __$$SkillResponseImplCopyWithImpl(
    _$SkillResponseImpl _value,
    $Res Function(_$SkillResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SkillResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? name = null,
    Object? proficiency = null,
    Object? description = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SkillResponseImpl(
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
class _$SkillResponseImpl implements _SkillResponse {
  const _$SkillResponseImpl({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.proficiency,
    this.description,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$SkillResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String name;
  @override
  final int proficiency;
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
    return 'SkillResponse(id: $id, careerProfileId: $careerProfileId, name: $name, proficiency: $proficiency, description: $description, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
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
    name,
    proficiency,
    description,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of SkillResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillResponseImplCopyWith<_$SkillResponseImpl> get copyWith =>
      __$$SkillResponseImplCopyWithImpl<_$SkillResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillResponseImplToJson(this);
  }
}

abstract class _SkillResponse implements SkillResponse {
  const factory _SkillResponse({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final int proficiency,
    final String? description,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SkillResponseImpl;

  factory _SkillResponse.fromJson(Map<String, dynamic> json) =
      _$SkillResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get name;
  @override
  int get proficiency;
  @override
  String? get description;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SkillResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillResponseImplCopyWith<_$SkillResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateSkillRequest _$CreateSkillRequestFromJson(Map<String, dynamic> json) {
  return _CreateSkillRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateSkillRequest {
  String get name => throw _privateConstructorUsedError;
  int get proficiency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CreateSkillRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSkillRequestCopyWith<CreateSkillRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSkillRequestCopyWith<$Res> {
  factory $CreateSkillRequestCopyWith(
    CreateSkillRequest value,
    $Res Function(CreateSkillRequest) then,
  ) = _$CreateSkillRequestCopyWithImpl<$Res, CreateSkillRequest>;
  @useResult
  $Res call({String name, int proficiency, String? description});
}

/// @nodoc
class _$CreateSkillRequestCopyWithImpl<$Res, $Val extends CreateSkillRequest>
    implements $CreateSkillRequestCopyWith<$Res> {
  _$CreateSkillRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? proficiency = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateSkillRequestImplCopyWith<$Res>
    implements $CreateSkillRequestCopyWith<$Res> {
  factory _$$CreateSkillRequestImplCopyWith(
    _$CreateSkillRequestImpl value,
    $Res Function(_$CreateSkillRequestImpl) then,
  ) = __$$CreateSkillRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int proficiency, String? description});
}

/// @nodoc
class __$$CreateSkillRequestImplCopyWithImpl<$Res>
    extends _$CreateSkillRequestCopyWithImpl<$Res, _$CreateSkillRequestImpl>
    implements _$$CreateSkillRequestImplCopyWith<$Res> {
  __$$CreateSkillRequestImplCopyWithImpl(
    _$CreateSkillRequestImpl _value,
    $Res Function(_$CreateSkillRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? proficiency = null,
    Object? description = freezed,
  }) {
    return _then(
      _$CreateSkillRequestImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSkillRequestImpl implements _CreateSkillRequest {
  const _$CreateSkillRequestImpl({
    required this.name,
    required this.proficiency,
    this.description,
  });

  factory _$CreateSkillRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSkillRequestImplFromJson(json);

  @override
  final String name;
  @override
  final int proficiency;
  @override
  final String? description;

  @override
  String toString() {
    return 'CreateSkillRequest(name: $name, proficiency: $proficiency, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSkillRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, proficiency, description);

  /// Create a copy of CreateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSkillRequestImplCopyWith<_$CreateSkillRequestImpl> get copyWith =>
      __$$CreateSkillRequestImplCopyWithImpl<_$CreateSkillRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSkillRequestImplToJson(this);
  }
}

abstract class _CreateSkillRequest implements CreateSkillRequest {
  const factory _CreateSkillRequest({
    required final String name,
    required final int proficiency,
    final String? description,
  }) = _$CreateSkillRequestImpl;

  factory _CreateSkillRequest.fromJson(Map<String, dynamic> json) =
      _$CreateSkillRequestImpl.fromJson;

  @override
  String get name;
  @override
  int get proficiency;
  @override
  String? get description;

  /// Create a copy of CreateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSkillRequestImplCopyWith<_$CreateSkillRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateSkillRequest _$UpdateSkillRequestFromJson(Map<String, dynamic> json) {
  return _UpdateSkillRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateSkillRequest {
  String? get name => throw _privateConstructorUsedError;
  int? get proficiency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this UpdateSkillRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateSkillRequestCopyWith<UpdateSkillRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSkillRequestCopyWith<$Res> {
  factory $UpdateSkillRequestCopyWith(
    UpdateSkillRequest value,
    $Res Function(UpdateSkillRequest) then,
  ) = _$UpdateSkillRequestCopyWithImpl<$Res, UpdateSkillRequest>;
  @useResult
  $Res call({String? name, int? proficiency, String? description});
}

/// @nodoc
class _$UpdateSkillRequestCopyWithImpl<$Res, $Val extends UpdateSkillRequest>
    implements $UpdateSkillRequestCopyWith<$Res> {
  _$UpdateSkillRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? proficiency = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            proficiency: freezed == proficiency
                ? _value.proficiency
                : proficiency // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$UpdateSkillRequestImplCopyWith<$Res>
    implements $UpdateSkillRequestCopyWith<$Res> {
  factory _$$UpdateSkillRequestImplCopyWith(
    _$UpdateSkillRequestImpl value,
    $Res Function(_$UpdateSkillRequestImpl) then,
  ) = __$$UpdateSkillRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, int? proficiency, String? description});
}

/// @nodoc
class __$$UpdateSkillRequestImplCopyWithImpl<$Res>
    extends _$UpdateSkillRequestCopyWithImpl<$Res, _$UpdateSkillRequestImpl>
    implements _$$UpdateSkillRequestImplCopyWith<$Res> {
  __$$UpdateSkillRequestImplCopyWithImpl(
    _$UpdateSkillRequestImpl _value,
    $Res Function(_$UpdateSkillRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? proficiency = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$UpdateSkillRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        proficiency: freezed == proficiency
            ? _value.proficiency
            : proficiency // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$UpdateSkillRequestImpl implements _UpdateSkillRequest {
  const _$UpdateSkillRequestImpl({
    this.name,
    this.proficiency,
    this.description,
  });

  factory _$UpdateSkillRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSkillRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final int? proficiency;
  @override
  final String? description;

  @override
  String toString() {
    return 'UpdateSkillRequest(name: $name, proficiency: $proficiency, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSkillRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, proficiency, description);

  /// Create a copy of UpdateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSkillRequestImplCopyWith<_$UpdateSkillRequestImpl> get copyWith =>
      __$$UpdateSkillRequestImplCopyWithImpl<_$UpdateSkillRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSkillRequestImplToJson(this);
  }
}

abstract class _UpdateSkillRequest implements UpdateSkillRequest {
  const factory _UpdateSkillRequest({
    final String? name,
    final int? proficiency,
    final String? description,
  }) = _$UpdateSkillRequestImpl;

  factory _UpdateSkillRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateSkillRequestImpl.fromJson;

  @override
  String? get name;
  @override
  int? get proficiency;
  @override
  String? get description;

  /// Create a copy of UpdateSkillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSkillRequestImplCopyWith<_$UpdateSkillRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
