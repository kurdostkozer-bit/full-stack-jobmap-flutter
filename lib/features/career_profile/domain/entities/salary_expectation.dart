class SalaryExpectation {
  final String careerProfileId;

  final double? minimumSalary;

  final double? desiredSalary;

  final String currency;

  final String salaryPeriod;

  final bool isNegotiable;

  const SalaryExpectation({
    required this.careerProfileId,
    required this.minimumSalary,
    required this.desiredSalary,
    required this.currency,
    required this.salaryPeriod,
    required this.isNegotiable,
  });
}