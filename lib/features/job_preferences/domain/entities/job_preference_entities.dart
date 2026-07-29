/// Job Preferences for career profile
class JobPreferenceEntity {
  final String id;
  final String careerProfileId;
  final List<String> jobTitles; // Preferred job titles
  final List<String> industries; // Preferred industries
  final List<String> workEnvironments; // REMOTE, HYBRID, ONSITE
  final List<String> employmentTypes; // FULL_TIME, PART_TIME, CONTRACT, FREELANCE
  final List<String> locations; // Preferred locations
  final int? minSalary; // Minimum salary expectation
  final int? maxSalary; // Maximum salary expectation
  final String? salaryCurrency; // USD, IQD, etc.
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobPreferenceEntity({
    required this.id,
    required this.careerProfileId,
    required this.jobTitles,
    required this.industries,
    required this.workEnvironments,
    required this.employmentTypes,
    required this.locations,
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency = 'USD',
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobPreferenceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum WorkEnvironment {
  remote,
  hybrid,
  onsite,
}

extension WorkEnvironmentX on WorkEnvironment {
  String get value {
    switch (this) {
      case WorkEnvironment.remote:
        return 'REMOTE';
      case WorkEnvironment.hybrid:
        return 'HYBRID';
      case WorkEnvironment.onsite:
        return 'ONSITE';
    }
  }

  static WorkEnvironment fromString(String value) {
    switch (value) {
      case 'REMOTE':
        return WorkEnvironment.remote;
      case 'HYBRID':
        return WorkEnvironment.hybrid;
      case 'ONSITE':
        return WorkEnvironment.onsite;
      default:
        return WorkEnvironment.onsite;
    }
  }

  String get label {
    switch (this) {
      case WorkEnvironment.remote:
        return 'Remote';
      case WorkEnvironment.hybrid:
        return 'Hybrid';
      case WorkEnvironment.onsite:
        return 'On-Site';
    }
  }
}

enum EmploymentType {
  fullTime,
  partTime,
  contract,
  freelance,
}

extension EmploymentTypeX on EmploymentType {
  String get value {
    switch (this) {
      case EmploymentType.fullTime:
        return 'FULL_TIME';
      case EmploymentType.partTime:
        return 'PART_TIME';
      case EmploymentType.contract:
        return 'CONTRACT';
      case EmploymentType.freelance:
        return 'FREELANCE';
    }
  }

  static EmploymentType fromString(String value) {
    switch (value) {
      case 'FULL_TIME':
        return EmploymentType.fullTime;
      case 'PART_TIME':
        return EmploymentType.partTime;
      case 'CONTRACT':
        return EmploymentType.contract;
      case 'FREELANCE':
        return EmploymentType.freelance;
      default:
        return EmploymentType.fullTime;
    }
  }

  String get label {
    switch (this) {
      case EmploymentType.fullTime:
        return 'Full Time';
      case EmploymentType.partTime:
        return 'Part Time';
      case EmploymentType.contract:
        return 'Contract';
      case EmploymentType.freelance:
        return 'Freelance';
    }
  }
}
