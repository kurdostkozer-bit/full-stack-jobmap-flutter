class Portfolio {
  final String id;

  final String careerProfileId;

  final String title;

  final String description;

  final String coverImage;

  final List<String> images;

  final List<String> videos;

  final List<String> documents;

  final List<String> externalLinks;

  const Portfolio({
    required this.id,
    required this.careerProfileId,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.images,
    required this.videos,
    required this.documents,
    required this.externalLinks,
  });
}