// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  success: json['success'] as bool,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  errors: json['errors'],
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'message': instance.message,
  'statusCode': instance.statusCode,
  'errors': instance.errors,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$PaginationMetaImpl _$$PaginationMetaImplFromJson(Map<String, dynamic> json) =>
    _$PaginationMetaImpl(
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$$PaginationMetaImplToJson(
  _$PaginationMetaImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
  'totalItems': instance.totalItems,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};

_$PaginatedResponseImpl<T> _$$PaginatedResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$PaginatedResponseImpl<T>(
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
  pagination: PaginationMeta.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$PaginatedResponseImplToJson<T>(
  _$PaginatedResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': instance.data.map(toJsonT).toList(),
  'pagination': instance.pagination,
};
