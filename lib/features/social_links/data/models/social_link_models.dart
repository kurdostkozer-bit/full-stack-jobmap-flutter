import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/social_link_entities.dart';

part 'social_link_models.g.dart';

@JsonSerializable()
class SocialLinkModel extends SocialLinkEntity {
  SocialLinkModel({
    required super.id,
    required super.careerProfileId,
    required super.platform,
    required super.url,
    super.isVisible = true,
    super.displayOrder = 0,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkModelFromJson(json);

  factory SocialLinkModel.fromEntity(SocialLinkEntity entity) =>
      SocialLinkModel(
        id: entity.id,
        careerProfileId: entity.careerProfileId,
        platform: entity.platform,
        url: entity.url,
        isVisible: entity.isVisible,
        displayOrder: entity.displayOrder,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => _$SocialLinkModelToJson(this);

  SocialLinkEntity toEntity() => SocialLinkEntity(
        id: id,
        careerProfileId: careerProfileId,
        platform: platform,
        url: url,
        isVisible: isVisible,
        displayOrder: displayOrder,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class SocialLinkResponseDto {
  final String id;
  final String careerProfileId;
  final String platform;
  final String url;
  final bool isVisible;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  SocialLinkResponseDto({
    required this.id,
    required this.careerProfileId,
    required this.platform,
    required this.url,
    required this.isVisible,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SocialLinkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkResponseDtoToJson(this);

  SocialLinkModel toModel() => SocialLinkModel(
        id: id,
        careerProfileId: careerProfileId,
        platform: SocialLinkPlatformX.fromString(platform),
        url: url,
        isVisible: isVisible,
        displayOrder: displayOrder,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class CreateSocialLinkDto {
  final String careerProfileId;
  final String platform;
  final String url;
  final bool isVisible;

  CreateSocialLinkDto({
    required this.careerProfileId,
    required this.platform,
    required this.url,
    this.isVisible = true,
  });

  factory CreateSocialLinkDto.fromJson(Map<String, dynamic> json) =>
      _$CreateSocialLinkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSocialLinkDtoToJson(this);

  factory CreateSocialLinkDto.fromEntity(SocialLinkEntity entity) =>
      CreateSocialLinkDto(
        careerProfileId: entity.careerProfileId,
        platform: entity.platform.value,
        url: entity.url,
        isVisible: entity.isVisible,
      );
}

@JsonSerializable()
class UpdateSocialLinkDto {
  final String? url;
  final bool? isVisible;
  final int? displayOrder;

  UpdateSocialLinkDto({
    this.url,
    this.isVisible,
    this.displayOrder,
  });

  factory UpdateSocialLinkDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateSocialLinkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSocialLinkDtoToJson(this);
}
