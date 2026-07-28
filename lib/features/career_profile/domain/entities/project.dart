class Project {
  final String id;

  final String careerProfileId;

  final String title;

  final String description;

  final String role;

  final DateTime? startDate;

  final DateTime? endDate;

  final bool isOngoing;

  final List<String> skills;

  final List<String> mediaUrls;

  final String projectUrl;

  const Project({
    required this.id,
    required this.careerProfileId,
    required this.title,
    required this.description,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isOngoing,
    required this.skills,
    required this.mediaUrls,
    required this.projectUrl,
  });
}