class Skill {
  final String id;

  final String careerProfileId;

  final String name;

  final String category;

  final String level;

  final int yearsOfExperience;

  final bool verified;

  const Skill({
    required this.id,
    required this.careerProfileId,
    required this.name,
    required this.category,
    required this.level,
    required this.yearsOfExperience,
    required this.verified,
  });
}