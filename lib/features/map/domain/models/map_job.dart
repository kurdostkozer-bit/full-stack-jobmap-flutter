class MapJob {
  final String id;
  final String title;
  final String company;
  final double latitude;
  final double longitude;
  final String city;
  final String salary;
  final bool featured;

  const MapJob({
    required this.id,
    required this.title,
    required this.company,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.salary,
    this.featured = false,
  });
}
