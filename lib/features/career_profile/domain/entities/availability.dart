class Availability {
  final String careerProfileId;

  final bool isAvailableForWork;

  final DateTime? availableFrom;

  final String employmentType;

  final String workplacePreference;

  final bool willingToRelocate;

  final bool willingToTravel;

  final int noticePeriodDays;

  final String preferredLocation;

  const Availability({
    required this.careerProfileId,
    required this.isAvailableForWork,
    required this.availableFrom,
    required this.employmentType,
    required this.workplacePreference,
    required this.willingToRelocate,
    required this.willingToTravel,
    required this.noticePeriodDays,
    required this.preferredLocation,
  });
}