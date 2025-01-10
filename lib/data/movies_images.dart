class ImageBackdrop {
  final double aspectRatio;
  final int height;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  ImageBackdrop({
    required this.aspectRatio,
    required this.height,
    this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  // Convert JSON map to ImageBackdrop object
  factory ImageBackdrop.fromMap(Map<String, dynamic> map) {
    return ImageBackdrop(
      aspectRatio: map['aspect_ratio']?.toDouble() ?? 0.0,
      height: map['height'] ?? 0,
      iso6391: map['iso_639_1'],
      filePath: map['file_path'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
      width: map['width'] ?? 0,
    );
  }
}

class Images {
  final List<ImageBackdrop> backdrops;

  Images({required this.backdrops});

  // Convert JSON list to Images object
  factory Images.fromMap(Map<String, dynamic> map) {
    var list = map['backdrops'] as List;
    List<ImageBackdrop> backdropsList =
    list.map((e) => ImageBackdrop.fromMap(e)).toList();
    return Images(backdrops: backdropsList);
  }
}