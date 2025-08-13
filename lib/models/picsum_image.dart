class PicsumImage {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  PicsumImage({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory PicsumImage.fromJson(Map<String, dynamic> json) {
    return PicsumImage(
      id: json['id'].toString(),
      author: json['author'] ?? '',
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}
