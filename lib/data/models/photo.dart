class Photo {
  final int id;
  final String imageUrl;
  final String photographer;
  final String? alt;

  Photo({
    required this.id,
    required this.imageUrl,
    required this.photographer,
    this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      imageUrl: json['src']['small'],
      photographer: json['photographer'],
      alt: json['alt'] ?? '',
    );
  }
}
