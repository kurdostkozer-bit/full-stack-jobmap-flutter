class Experience {
  final String id;

  final String careerProfileId;

  final String companyName;

  final String jobTitle;

  final String employmentType;

  final String country;

  final String city;

  final DateTime startDate;

  final DateTime? endDate;

  final bool isCurrentJob;

  final String description;

  const Experience({
    required this.id,
    required this.careerProfileId,
    required this.companyName,
    required this.jobTitle,
    required this.employmentType,
    required this.country,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.isCurrentJob,
    required this.description,
  });
}