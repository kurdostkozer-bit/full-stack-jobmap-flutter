/// Profile completion tracking
class ProfileCompletionEntity {
  final String careerProfileId;
  final int completionPercentage; // 0-100
  final Map<String, bool> sectionsCompleted; // Map of section -> completed status
  final List<String> nextSteps; // Recommended next steps
  final DateTime lastUpdated;

  ProfileCompletionEntity({
    required this.careerProfileId,
    required this.completionPercentage,
    required this.sectionsCompleted,
    required this.nextSteps,
    required this.lastUpdated,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileCompletionEntity &&
          runtimeType == other.runtimeType &&
          careerProfileId == other.careerProfileId;

  @override
  int get hashCode => careerProfileId.hashCode;
}

/// Completion sections
enum CompletionSection {
  basicInfo,
  education,
  experience,
  skills,
  projects,
  languages,
  certificates,
  attachments,
  socialLinks,
  jobPreferences,
}

extension CompletionSectionX on CompletionSection {
  String get value {
    switch (this) {
      case CompletionSection.basicInfo:
        return 'basicInfo';
      case CompletionSection.education:
        return 'education';
      case CompletionSection.experience:
        return 'experience';
      case CompletionSection.skills:
        return 'skills';
      case CompletionSection.projects:
        return 'projects';
      case CompletionSection.languages:
        return 'languages';
      case CompletionSection.certificates:
        return 'certificates';
      case CompletionSection.attachments:
        return 'attachments';
      case CompletionSection.socialLinks:
        return 'socialLinks';
      case CompletionSection.jobPreferences:
        return 'jobPreferences';
    }
  }

  String get label {
    switch (this) {
      case CompletionSection.basicInfo:
        return 'Basic Info';
      case CompletionSection.education:
        return 'Education';
      case CompletionSection.experience:
        return 'Experience';
      case CompletionSection.skills:
        return 'Skills';
      case CompletionSection.projects:
        return 'Projects';
      case CompletionSection.languages:
        return 'Languages';
      case CompletionSection.certificates:
        return 'Certificates';
      case CompletionSection.attachments:
        return 'Attachments';
      case CompletionSection.socialLinks:
        return 'Social Links';
      case CompletionSection.jobPreferences:
        return 'Job Preferences';
    }
  }
}
