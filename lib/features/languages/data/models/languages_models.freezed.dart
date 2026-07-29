// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'languages_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LanguageResponse _$LanguageResponseFromJson(Map<String, dynamic> json) {
  return _LanguageResponse.fromJson(json);
}

/// @nodoc
mixin _$LanguageResponse {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  LanguageProficiency get proficiency => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LanguageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageResponseCopyWith<LanguageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageResponseCopyWith<$Res> {
  factory $LanguageResponseCopyWith(
    LanguageResponse value,
    $Res Function(LanguageResponse) then,
  ) = _$LanguageResponseCopyWithImpl<$Res, LanguageResponse>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    LanguageProficiency proficiency,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$LanguageResponseCopyWithImpl<$Res, $Val extends LanguageResponse>
    implements $LanguageResponseCopyWith<$Res> {
  _$LanguageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguageResponse
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
                      as LanguageProficiency,
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
abstract class _$$LanguageResponseImplCopyWith<$Res>
    implements $LanguageResponseCopyWith<$Res> {
  factory _$$LanguageResponseImplCopyWith(
    _$LanguageResponseImpl value,
    $Res Function(_$LanguageResponseImpl) then,
  ) = __$$LanguageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String name,
    LanguageProficiency proficiency,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$LanguageResponseImplCopyWithImpl<$Res>
    extends _$LanguageResponseCopyWithImpl<$Res, _$LanguageResponseImpl>
    implements _$$LanguageResponseImplCopyWith<$Res> {
  __$$LanguageResponseImplCopyWithImpl(
    _$LanguageResponseImpl _value,
    $Res Function(_$LanguageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LanguageResponse
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
      _$LanguageResponseImpl(
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
                  as LanguageProficiency,
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
class _$LanguageResponseImpl implements _LanguageResponse {
  const _$LanguageResponseImpl({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.proficiency,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$LanguageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String name;
  @override
  final LanguageProficiency proficiency;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'LanguageResponse(id: $id, careerProfileId: $careerProfileId, name: $name, proficiency: $proficiency, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageResponseImpl &&
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

  /// Create a copy of LanguageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageResponseImplCopyWith<_$LanguageResponseImpl> get copyWith =>
      __$$LanguageResponseImplCopyWithImpl<_$LanguageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageResponseImplToJson(this);
  }
}

abstract class _LanguageResponse implements LanguageResponse {
  const factory _LanguageResponse({
    required final String id,
    required final String careerProfileId,
    required final String name,
    required final LanguageProficiency proficiency,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$LanguageResponseImpl;

  factory _LanguageResponse.fromJson(Map<String, dynamic> json) =
      _$LanguageResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get name;
  @override
  LanguageProficiency get proficiency;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of LanguageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageResponseImplCopyWith<_$LanguageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateLanguageRequest _$CreateLanguageRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateLanguageRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateLanguageRequest {
  String get name => throw _privateConstructorUsedError;
  LanguageProficiency get proficiency => throw _privateConstructorUsedError;

  /// Serializes this CreateLanguageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateLanguageRequestCopyWith<CreateLanguageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateLanguageRequestCopyWith<$Res> {
  factory $CreateLanguageRequestCopyWith(
    CreateLanguageRequest value,
    $Res Function(CreateLanguageRequest) then,
  ) = _$CreateLanguageRequestCopyWithImpl<$Res, CreateLanguageRequest>;
  @useResult
  $Res call({String name, LanguageProficiency proficiency});
}

/// @nodoc
class _$CreateLanguageRequestCopyWithImpl<
  $Res,
  $Val extends CreateLanguageRequest
>
    implements $CreateLanguageRequestCopyWith<$Res> {
  _$CreateLanguageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? proficiency = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            proficiency: null == proficiency
                ? _value.proficiency
                : proficiency // ignore: cast_nullable_to_non_nullable
                      as LanguageProficiency,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateLanguageRequestImplCopyWith<$Res>
    implements $CreateLanguageRequestCopyWith<$Res> {
  factory _$$CreateLanguageRequestImplCopyWith(
    _$CreateLanguageRequestImpl value,
    $Res Function(_$CreateLanguageRequestImpl) then,
  ) = __$$CreateLanguageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, LanguageProficiency proficiency});
}

/// @nodoc
class __$$CreateLanguageRequestImplCopyWithImpl<$Res>
    extends
        _$CreateLanguageRequestCopyWithImpl<$Res, _$CreateLanguageRequestImpl>
    implements _$$CreateLanguageRequestImplCopyWith<$Res> {
  __$$CreateLanguageRequestImplCopyWithImpl(
    _$CreateLanguageRequestImpl _value,
    $Res Function(_$CreateLanguageRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? proficiency = null}) {
    return _then(
      _$CreateLanguageRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        proficiency: null == proficiency
            ? _value.proficiency
            : proficiency // ignore: cast_nullable_to_non_nullable
                  as LanguageProficiency,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateLanguageRequestImpl implements _CreateLanguageRequest {
  const _$CreateLanguageRequestImpl({
    required this.name,
    required this.proficiency,
  });

  factory _$CreateLanguageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateLanguageRequestImplFromJson(json);

  @override
  final String name;
  @override
  final LanguageProficiency proficiency;

  @override
  String toString() {
    return 'CreateLanguageRequest(name: $name, proficiency: $proficiency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateLanguageRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, proficiency);

  /// Create a copy of CreateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateLanguageRequestImplCopyWith<_$CreateLanguageRequestImpl>
  get copyWith =>
      __$$CreateLanguageRequestImplCopyWithImpl<_$CreateLanguageRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateLanguageRequestImplToJson(this);
  }
}

abstract class _CreateLanguageRequest implements CreateLanguageRequest {
  const factory _CreateLanguageRequest({
    required final String name,
    required final LanguageProficiency proficiency,
  }) = _$CreateLanguageRequestImpl;

  factory _CreateLanguageRequest.fromJson(Map<String, dynamic> json) =
      _$CreateLanguageRequestImpl.fromJson;

  @override
  String get name;
  @override
  LanguageProficiency get proficiency;

  /// Create a copy of CreateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateLanguageRequestImplCopyWith<_$CreateLanguageRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateLanguageRequest _$UpdateLanguageRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateLanguageRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateLanguageRequest {
  String? get name => throw _privateConstructorUsedError;
  LanguageProficiency? get proficiency => throw _privateConstructorUsedError;

  /// Serializes this UpdateLanguageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateLanguageRequestCopyWith<UpdateLanguageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateLanguageRequestCopyWith<$Res> {
  factory $UpdateLanguageRequestCopyWith(
    UpdateLanguageRequest value,
    $Res Function(UpdateLanguageRequest) then,
  ) = _$UpdateLanguageRequestCopyWithImpl<$Res, UpdateLanguageRequest>;
  @useResult
  $Res call({String? name, LanguageProficiency? proficiency});
}

/// @nodoc
class _$UpdateLanguageRequestCopyWithImpl<
  $Res,
  $Val extends UpdateLanguageRequest
>
    implements $UpdateLanguageRequestCopyWith<$Res> {
  _$UpdateLanguageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? proficiency = freezed}) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            proficiency: freezed == proficiency
                ? _value.proficiency
                : proficiency // ignore: cast_nullable_to_non_nullable
                      as LanguageProficiency?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateLanguageRequestImplCopyWith<$Res>
    implements $UpdateLanguageRequestCopyWith<$Res> {
  factory _$$UpdateLanguageRequestImplCopyWith(
    _$UpdateLanguageRequestImpl value,
    $Res Function(_$UpdateLanguageRequestImpl) then,
  ) = __$$UpdateLanguageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, LanguageProficiency? proficiency});
}

/// @nodoc
class __$$UpdateLanguageRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateLanguageRequestCopyWithImpl<$Res, _$UpdateLanguageRequestImpl>
    implements _$$UpdateLanguageRequestImplCopyWith<$Res> {
  __$$UpdateLanguageRequestImplCopyWithImpl(
    _$UpdateLanguageRequestImpl _value,
    $Res Function(_$UpdateLanguageRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed, Object? proficiency = freezed}) {
    return _then(
      _$UpdateLanguageRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        proficiency: freezed == proficiency
            ? _value.proficiency
            : proficiency // ignore: cast_nullable_to_non_nullable
                  as LanguageProficiency?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateLanguageRequestImpl implements _UpdateLanguageRequest {
  const _$UpdateLanguageRequestImpl({this.name, this.proficiency});

  factory _$UpdateLanguageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateLanguageRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final LanguageProficiency? proficiency;

  @override
  String toString() {
    return 'UpdateLanguageRequest(name: $name, proficiency: $proficiency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLanguageRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.proficiency, proficiency) ||
                other.proficiency == proficiency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, proficiency);

  /// Create a copy of UpdateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLanguageRequestImplCopyWith<_$UpdateLanguageRequestImpl>
  get copyWith =>
      __$$UpdateLanguageRequestImplCopyWithImpl<_$UpdateLanguageRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateLanguageRequestImplToJson(this);
  }
}

abstract class _UpdateLanguageRequest implements UpdateLanguageRequest {
  const factory _UpdateLanguageRequest({
    final String? name,
    final LanguageProficiency? proficiency,
  }) = _$UpdateLanguageRequestImpl;

  factory _UpdateLanguageRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateLanguageRequestImpl.fromJson;

  @override
  String? get name;
  @override
  LanguageProficiency? get proficiency;

  /// Create a copy of UpdateLanguageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateLanguageRequestImplCopyWith<_$UpdateLanguageRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
