/// Resume/Attachment entities
class AttachmentEntity {
  final String id;
  final String careerProfileId;
  final String fileName;
  final String fileType; // pdf, docx, jpg, png
  final int fileSizeBytes;
  final String fileUrl;
  final String? description;
  final AttachmentCategory category; // RESUME, COVER_LETTER, PORTFOLIO
  final bool isPrimary; // Mark primary resume
  final DateTime uploadedAt;
  final DateTime updatedAt;

  AttachmentEntity({
    required this.id,
    required this.careerProfileId,
    required this.fileName,
    required this.fileType,
    required this.fileSizeBytes,
    required this.fileUrl,
    this.description,
    required this.category,
    this.isPrimary = false,
    required this.uploadedAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum AttachmentCategory {
  resume,
  coverLetter,
  portfolio,
  certification,
  other,
}

extension AttachmentCategoryX on AttachmentCategory {
  String get value {
    switch (this) {
      case AttachmentCategory.resume:
        return 'RESUME';
      case AttachmentCategory.coverLetter:
        return 'COVER_LETTER';
      case AttachmentCategory.portfolio:
        return 'PORTFOLIO';
      case AttachmentCategory.certification:
        return 'CERTIFICATION';
      case AttachmentCategory.other:
        return 'OTHER';
    }
  }

  static AttachmentCategory fromString(String value) {
    switch (value) {
      case 'RESUME':
        return AttachmentCategory.resume;
      case 'COVER_LETTER':
        return AttachmentCategory.coverLetter;
      case 'PORTFOLIO':
        return AttachmentCategory.portfolio;
      case 'CERTIFICATION':
        return AttachmentCategory.certification;
      default:
        return AttachmentCategory.other;
    }
  }

  String get label {
    switch (this) {
      case AttachmentCategory.resume:
        return 'Resume';
      case AttachmentCategory.coverLetter:
        return 'Cover Letter';
      case AttachmentCategory.portfolio:
        return 'Portfolio';
      case AttachmentCategory.certification:
        return 'Certification';
      case AttachmentCategory.other:
        return 'Other';
    }
  }
}
