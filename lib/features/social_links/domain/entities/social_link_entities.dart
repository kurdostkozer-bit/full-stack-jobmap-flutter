/// Portfolio and Social Link entities
class SocialLinkEntity {
  final String id;
  final String careerProfileId;
  final SocialLinkPlatform platform; // GITHUB, LINKEDIN, PORTFOLIO, TWITTER, etc.
  final String url;
  final bool isVisible;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  SocialLinkEntity({
    required this.id,
    required this.careerProfileId,
    required this.platform,
    required this.url,
    this.isVisible = true,
    this.displayOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinkEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum SocialLinkPlatform {
  github,
  linkedin,
  portfolio,
  twitter,
  instagram,
  codepen,
  behance,
  dribbble,
  medium,
  devto,
  youtube,
  website,
  other,
}

extension SocialLinkPlatformX on SocialLinkPlatform {
  String get value {
    switch (this) {
      case SocialLinkPlatform.github:
        return 'GITHUB';
      case SocialLinkPlatform.linkedin:
        return 'LINKEDIN';
      case SocialLinkPlatform.portfolio:
        return 'PORTFOLIO';
      case SocialLinkPlatform.twitter:
        return 'TWITTER';
      case SocialLinkPlatform.instagram:
        return 'INSTAGRAM';
      case SocialLinkPlatform.codepen:
        return 'CODEPEN';
      case SocialLinkPlatform.behance:
        return 'BEHANCE';
      case SocialLinkPlatform.dribbble:
        return 'DRIBBBLE';
      case SocialLinkPlatform.medium:
        return 'MEDIUM';
      case SocialLinkPlatform.devto:
        return 'DEVTO';
      case SocialLinkPlatform.youtube:
        return 'YOUTUBE';
      case SocialLinkPlatform.website:
        return 'WEBSITE';
      case SocialLinkPlatform.other:
        return 'OTHER';
    }
  }

  static SocialLinkPlatform fromString(String value) {
    switch (value) {
      case 'GITHUB':
        return SocialLinkPlatform.github;
      case 'LINKEDIN':
        return SocialLinkPlatform.linkedin;
      case 'PORTFOLIO':
        return SocialLinkPlatform.portfolio;
      case 'TWITTER':
        return SocialLinkPlatform.twitter;
      case 'INSTAGRAM':
        return SocialLinkPlatform.instagram;
      case 'CODEPEN':
        return SocialLinkPlatform.codepen;
      case 'BEHANCE':
        return SocialLinkPlatform.behance;
      case 'DRIBBBLE':
        return SocialLinkPlatform.dribbble;
      case 'MEDIUM':
        return SocialLinkPlatform.medium;
      case 'DEVTO':
        return SocialLinkPlatform.devto;
      case 'YOUTUBE':
        return SocialLinkPlatform.youtube;
      case 'WEBSITE':
        return SocialLinkPlatform.website;
      default:
        return SocialLinkPlatform.other;
    }
  }

  String get label {
    switch (this) {
      case SocialLinkPlatform.github:
        return 'GitHub';
      case SocialLinkPlatform.linkedin:
        return 'LinkedIn';
      case SocialLinkPlatform.portfolio:
        return 'Portfolio';
      case SocialLinkPlatform.twitter:
        return 'Twitter';
      case SocialLinkPlatform.instagram:
        return 'Instagram';
      case SocialLinkPlatform.codepen:
        return 'CodePen';
      case SocialLinkPlatform.behance:
        return 'Behance';
      case SocialLinkPlatform.dribbble:
        return 'Dribbble';
      case SocialLinkPlatform.medium:
        return 'Medium';
      case SocialLinkPlatform.devto:
        return 'Dev.to';
      case SocialLinkPlatform.youtube:
        return 'YouTube';
      case SocialLinkPlatform.website:
        return 'Website';
      case SocialLinkPlatform.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case SocialLinkPlatform.github:
        return 'github';
      case SocialLinkPlatform.linkedin:
        return 'linkedin';
      case SocialLinkPlatform.portfolio:
        return 'briefcase';
      case SocialLinkPlatform.twitter:
        return 'twitter';
      case SocialLinkPlatform.instagram:
        return 'instagram';
      case SocialLinkPlatform.codepen:
        return 'code';
      case SocialLinkPlatform.behance:
        return 'behance';
      case SocialLinkPlatform.dribbble:
        return 'dribbble';
      case SocialLinkPlatform.medium:
        return 'medium';
      case SocialLinkPlatform.devto:
        return 'dev';
      case SocialLinkPlatform.youtube:
        return 'youtube';
      case SocialLinkPlatform.website:
        return 'globe';
      case SocialLinkPlatform.other:
        return 'link';
    }
  }
}
