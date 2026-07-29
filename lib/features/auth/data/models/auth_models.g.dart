// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_$UserResponseImpl _$$UserResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserResponseImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      careerProfileId: json['careerProfileId'] as String?,
    );

Map<String, dynamic> _$$UserResponseImplToJson(_$UserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'emailVerified': instance.emailVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'careerProfileId': instance.careerProfileId,
    };

_$VerifyEmailRequestImpl _$$VerifyEmailRequestImplFromJson(
  Map<String, dynamic> json,
) => _$VerifyEmailRequestImpl(
  email: json['email'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$$VerifyEmailRequestImplToJson(
  _$VerifyEmailRequestImpl instance,
) => <String, dynamic>{'email': instance.email, 'code': instance.code};

_$ForgotPasswordRequestImpl _$$ForgotPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordRequestImpl(email: json['email'] as String);

Map<String, dynamic> _$$ForgotPasswordRequestImplToJson(
  _$ForgotPasswordRequestImpl instance,
) => <String, dynamic>{'email': instance.email};

_$ResetPasswordRequestImpl _$$ResetPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ResetPasswordRequestImpl(
  email: json['email'] as String,
  code: json['code'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
  _$ResetPasswordRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'code': instance.code,
  'newPassword': instance.newPassword,
};
