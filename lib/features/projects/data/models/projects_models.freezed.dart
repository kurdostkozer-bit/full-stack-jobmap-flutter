// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) {
  return _ProjectResponse.fromJson(json);
}

/// @nodoc
mixin _$ProjectResponse {
  String get id => throw _privateConstructorUsedError;
  String get careerProfileId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  List<String> get technologies => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrently => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProjectResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectResponseCopyWith<ProjectResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectResponseCopyWith<$Res> {
  factory $ProjectResponseCopyWith(
    ProjectResponse value,
    $Res Function(ProjectResponse) then,
  ) = _$ProjectResponseCopyWithImpl<$Res, ProjectResponse>;
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String title,
    String? description,
    String? role,
    List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently,
    String? imageUrl,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ProjectResponseCopyWithImpl<$Res, $Val extends ProjectResponse>
    implements $ProjectResponseCopyWith<$Res> {
  _$ProjectResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? title = null,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = null,
    Object? imageUrl = freezed,
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
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            technologies: null == technologies
                ? _value.technologies
                : technologies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrently: null == isCurrently
                ? _value.isCurrently
                : isCurrently // ignore: cast_nullable_to_non_nullable
                      as bool,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ProjectResponseImplCopyWith<$Res>
    implements $ProjectResponseCopyWith<$Res> {
  factory _$$ProjectResponseImplCopyWith(
    _$ProjectResponseImpl value,
    $Res Function(_$ProjectResponseImpl) then,
  ) = __$$ProjectResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String careerProfileId,
    String title,
    String? description,
    String? role,
    List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently,
    String? imageUrl,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ProjectResponseImplCopyWithImpl<$Res>
    extends _$ProjectResponseCopyWithImpl<$Res, _$ProjectResponseImpl>
    implements _$$ProjectResponseImplCopyWith<$Res> {
  __$$ProjectResponseImplCopyWithImpl(
    _$ProjectResponseImpl _value,
    $Res Function(_$ProjectResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? careerProfileId = null,
    Object? title = null,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = null,
    Object? imageUrl = freezed,
    Object? displayOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ProjectResponseImpl(
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
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        technologies: null == technologies
            ? _value._technologies
            : technologies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrently: null == isCurrently
            ? _value.isCurrently
            : isCurrently // ignore: cast_nullable_to_non_nullable
                  as bool,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
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
class _$ProjectResponseImpl implements _ProjectResponse {
  const _$ProjectResponseImpl({
    required this.id,
    required this.careerProfileId,
    required this.title,
    this.description,
    this.role,
    required final List<String> technologies,
    this.startDate,
    this.endDate,
    required this.isCurrently,
    this.imageUrl,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  }) : _technologies = technologies;

  factory _$ProjectResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String careerProfileId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? role;
  final List<String> _technologies;
  @override
  List<String> get technologies {
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologies);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isCurrently;
  @override
  final String? imageUrl;
  @override
  final int displayOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ProjectResponse(id: $id, careerProfileId: $careerProfileId, title: $title, description: $description, role: $role, technologies: $technologies, startDate: $startDate, endDate: $endDate, isCurrently: $isCurrently, imageUrl: $imageUrl, displayOrder: $displayOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.careerProfileId, careerProfileId) ||
                other.careerProfileId == careerProfileId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._technologies,
              _technologies,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrently, isCurrently) ||
                other.isCurrently == isCurrently) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
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
    role,
    const DeepCollectionEquality().hash(_technologies),
    startDate,
    endDate,
    isCurrently,
    imageUrl,
    displayOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectResponseImplCopyWith<_$ProjectResponseImpl> get copyWith =>
      __$$ProjectResponseImplCopyWithImpl<_$ProjectResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectResponseImplToJson(this);
  }
}

abstract class _ProjectResponse implements ProjectResponse {
  const factory _ProjectResponse({
    required final String id,
    required final String careerProfileId,
    required final String title,
    final String? description,
    final String? role,
    required final List<String> technologies,
    final DateTime? startDate,
    final DateTime? endDate,
    required final bool isCurrently,
    final String? imageUrl,
    required final int displayOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$ProjectResponseImpl;

  factory _ProjectResponse.fromJson(Map<String, dynamic> json) =
      _$ProjectResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get careerProfileId;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get role;
  @override
  List<String> get technologies;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrently;
  @override
  String? get imageUrl;
  @override
  int get displayOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectResponseImplCopyWith<_$ProjectResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateProjectRequest _$CreateProjectRequestFromJson(Map<String, dynamic> json) {
  return _CreateProjectRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateProjectRequest {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  List<String> get technologies => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCurrently => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this CreateProjectRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateProjectRequestCopyWith<CreateProjectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateProjectRequestCopyWith<$Res> {
  factory $CreateProjectRequestCopyWith(
    CreateProjectRequest value,
    $Res Function(CreateProjectRequest) then,
  ) = _$CreateProjectRequestCopyWithImpl<$Res, CreateProjectRequest>;
  @useResult
  $Res call({
    String title,
    String? description,
    String? role,
    List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently,
    String? imageUrl,
  });
}

/// @nodoc
class _$CreateProjectRequestCopyWithImpl<
  $Res,
  $Val extends CreateProjectRequest
>
    implements $CreateProjectRequestCopyWith<$Res> {
  _$CreateProjectRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            technologies: null == technologies
                ? _value.technologies
                : technologies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrently: null == isCurrently
                ? _value.isCurrently
                : isCurrently // ignore: cast_nullable_to_non_nullable
                      as bool,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateProjectRequestImplCopyWith<$Res>
    implements $CreateProjectRequestCopyWith<$Res> {
  factory _$$CreateProjectRequestImplCopyWith(
    _$CreateProjectRequestImpl value,
    $Res Function(_$CreateProjectRequestImpl) then,
  ) = __$$CreateProjectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? description,
    String? role,
    List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently,
    String? imageUrl,
  });
}

/// @nodoc
class __$$CreateProjectRequestImplCopyWithImpl<$Res>
    extends _$CreateProjectRequestCopyWithImpl<$Res, _$CreateProjectRequestImpl>
    implements _$$CreateProjectRequestImplCopyWith<$Res> {
  __$$CreateProjectRequestImplCopyWithImpl(
    _$CreateProjectRequestImpl _value,
    $Res Function(_$CreateProjectRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$CreateProjectRequestImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        technologies: null == technologies
            ? _value._technologies
            : technologies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrently: null == isCurrently
            ? _value.isCurrently
            : isCurrently // ignore: cast_nullable_to_non_nullable
                  as bool,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateProjectRequestImpl implements _CreateProjectRequest {
  const _$CreateProjectRequestImpl({
    required this.title,
    this.description,
    this.role,
    required final List<String> technologies,
    this.startDate,
    this.endDate,
    required this.isCurrently,
    this.imageUrl,
  }) : _technologies = technologies;

  factory _$CreateProjectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateProjectRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final String? role;
  final List<String> _technologies;
  @override
  List<String> get technologies {
    if (_technologies is EqualUnmodifiableListView) return _technologies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_technologies);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isCurrently;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'CreateProjectRequest(title: $title, description: $description, role: $role, technologies: $technologies, startDate: $startDate, endDate: $endDate, isCurrently: $isCurrently, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateProjectRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._technologies,
              _technologies,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrently, isCurrently) ||
                other.isCurrently == isCurrently) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    role,
    const DeepCollectionEquality().hash(_technologies),
    startDate,
    endDate,
    isCurrently,
    imageUrl,
  );

  /// Create a copy of CreateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateProjectRequestImplCopyWith<_$CreateProjectRequestImpl>
  get copyWith =>
      __$$CreateProjectRequestImplCopyWithImpl<_$CreateProjectRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateProjectRequestImplToJson(this);
  }
}

abstract class _CreateProjectRequest implements CreateProjectRequest {
  const factory _CreateProjectRequest({
    required final String title,
    final String? description,
    final String? role,
    required final List<String> technologies,
    final DateTime? startDate,
    final DateTime? endDate,
    required final bool isCurrently,
    final String? imageUrl,
  }) = _$CreateProjectRequestImpl;

  factory _CreateProjectRequest.fromJson(Map<String, dynamic> json) =
      _$CreateProjectRequestImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  String? get role;
  @override
  List<String> get technologies;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCurrently;
  @override
  String? get imageUrl;

  /// Create a copy of CreateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateProjectRequestImplCopyWith<_$CreateProjectRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UpdateProjectRequest _$UpdateProjectRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProjectRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProjectRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  List<String>? get technologies => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool? get isCurrently => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this UpdateProjectRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProjectRequestCopyWith<UpdateProjectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProjectRequestCopyWith<$Res> {
  factory $UpdateProjectRequestCopyWith(
    UpdateProjectRequest value,
    $Res Function(UpdateProjectRequest) then,
  ) = _$UpdateProjectRequestCopyWithImpl<$Res, UpdateProjectRequest>;
  @useResult
  $Res call({
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  });
}

/// @nodoc
class _$UpdateProjectRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProjectRequest
>
    implements $UpdateProjectRequestCopyWith<$Res> {
  _$UpdateProjectRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            technologies: freezed == technologies
                ? _value.technologies
                : technologies // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCurrently: freezed == isCurrently
                ? _value.isCurrently
                : isCurrently // ignore: cast_nullable_to_non_nullable
                      as bool?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProjectRequestImplCopyWith<$Res>
    implements $UpdateProjectRequestCopyWith<$Res> {
  factory _$$UpdateProjectRequestImplCopyWith(
    _$UpdateProjectRequestImpl value,
    $Res Function(_$UpdateProjectRequestImpl) then,
  ) = __$$UpdateProjectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  });
}

/// @nodoc
class __$$UpdateProjectRequestImplCopyWithImpl<$Res>
    extends _$UpdateProjectRequestCopyWithImpl<$Res, _$UpdateProjectRequestImpl>
    implements _$$UpdateProjectRequestImplCopyWith<$Res> {
  __$$UpdateProjectRequestImplCopyWithImpl(
    _$UpdateProjectRequestImpl _value,
    $Res Function(_$UpdateProjectRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? role = freezed,
    Object? technologies = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isCurrently = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$UpdateProjectRequestImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        technologies: freezed == technologies
            ? _value._technologies
            : technologies // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCurrently: freezed == isCurrently
            ? _value.isCurrently
            : isCurrently // ignore: cast_nullable_to_non_nullable
                  as bool?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProjectRequestImpl implements _UpdateProjectRequest {
  const _$UpdateProjectRequestImpl({
    this.title,
    this.description,
    this.role,
    final List<String>? technologies,
    this.startDate,
    this.endDate,
    this.isCurrently,
    this.imageUrl,
  }) : _technologies = technologies;

  factory _$UpdateProjectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProjectRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? role;
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
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool? isCurrently;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'UpdateProjectRequest(title: $title, description: $description, role: $role, technologies: $technologies, startDate: $startDate, endDate: $endDate, isCurrently: $isCurrently, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProjectRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._technologies,
              _technologies,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCurrently, isCurrently) ||
                other.isCurrently == isCurrently) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    role,
    const DeepCollectionEquality().hash(_technologies),
    startDate,
    endDate,
    isCurrently,
    imageUrl,
  );

  /// Create a copy of UpdateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProjectRequestImplCopyWith<_$UpdateProjectRequestImpl>
  get copyWith =>
      __$$UpdateProjectRequestImplCopyWithImpl<_$UpdateProjectRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProjectRequestImplToJson(this);
  }
}

abstract class _UpdateProjectRequest implements UpdateProjectRequest {
  const factory _UpdateProjectRequest({
    final String? title,
    final String? description,
    final String? role,
    final List<String>? technologies,
    final DateTime? startDate,
    final DateTime? endDate,
    final bool? isCurrently,
    final String? imageUrl,
  }) = _$UpdateProjectRequestImpl;

  factory _UpdateProjectRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProjectRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get role;
  @override
  List<String>? get technologies;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool? get isCurrently;
  @override
  String? get imageUrl;

  /// Create a copy of UpdateProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProjectRequestImplCopyWith<_$UpdateProjectRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
