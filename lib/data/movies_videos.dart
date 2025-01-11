class Video {
  final String iso6391;
  final String iso3166_1;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  Video({
    required this.iso6391,
    required this.iso3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  // fromMap constructor to create a Video instance from a map
  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      iso6391: map['iso_639_1'],
      iso3166_1: map['iso_3166_1'],
      name: map['name'],
      key: map['key'],
      site: map['site'],
      size: map['size'],
      type: map['type'],
      official: map['official'],
      publishedAt: DateTime.parse(map['published_at']),
      id: map['id'],
    );
  }

  // toMap function to convert a Video instance to a map
  Map<String, dynamic> toMap() {
    return {
      'iso_639_1': iso6391,
      'iso_3166_1': iso3166_1,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt.toIso8601String(),
      'id': id,
    };
  }
}

class VideoList {
  final List<Video> results;

  VideoList({required this.results});

  // fromMap constructor to create a VideoList instance from a map
  factory VideoList.fromMap(Map<String, dynamic> map) {
    return VideoList(
      results: List<Video>.from(map['results'].map((x) => Video.fromMap(x))),
    );
  }

  // toMap function to convert a VideoList instance to a map
  Map<String, dynamic> toMap() {
    return {
      'results': List<dynamic>.from(results.map((x) => x.toMap())),
    };
  }
}