class Certificate {
  final String id;

  final String careerProfileId;

  final String title;

  final String issuingOrganization;

  final DateTime issueDate;

  final DateTime? expiryDate;

  final String credentialId;

  final String credentialUrl;

  const Certificate({
    required this.id,
    required this.careerProfileId,
    required this.title,
    required this.issuingOrganization,
    required this.issueDate,
    required this.expiryDate,
    required this.credentialId,
    required this.credentialUrl,
  });
}