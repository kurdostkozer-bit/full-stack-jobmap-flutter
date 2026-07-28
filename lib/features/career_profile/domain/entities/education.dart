class Education {
  final String id;

  final String careerProfileId;

  final String institutionName;

  final String degree;

  final String fieldOfStudy;

  final String country;

  final String city;

  final DateTime startDate;

  final DateTime? endDate;

  final bool isCurrentlyStudying;

  final String description;

  const Education({
    required this.id,
    required this.careerProfileId,
    required this.institutionName,
    required this.degree,
    required this.fieldOfStudy,
    required this.country,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.isCurrentlyStudying,
    required this.description,
  });
}