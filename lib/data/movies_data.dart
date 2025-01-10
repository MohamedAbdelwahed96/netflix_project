class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final int runtime;
  final String homepage;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.homepage
  });

  // Function to create a Movie object from a map (deserialization)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      id: map['id'] ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
      runtime: map['runtime'] ?? 0,
      homepage: map['homepage'] ?? '',
    );
  }
}

class MovieResponse {
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final List<Movie> movies;

  MovieResponse({
    this.maximumDate,
    this.minimumDate,
    required this.movies,
  });

  // Function to create a MovieResponse object from a map (deserialization)
  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      maximumDate: map['dates'] != null
          ? DateTime.parse(map['dates']['maximum'] ?? '')
          : null,
      minimumDate: map['dates'] != null
          ? DateTime.parse(map['dates']['minimum'] ?? '')
          : null,
      movies: List<Movie>.from(map['results']?.map((x) => Movie.fromMap(x)) ?? []),
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  static List<Genre> fromList(List<dynamic> list) {
    return list.map((e) => Genre.fromMap(e)).toList();
  }
}











class Moviess {
  final bool adult;
  final String backdropPath;
  final Collection belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Moviess({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Moviess.fromMap(Map<String, dynamic> map) {
    return Moviess(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      belongsToCollection: Collection.fromMap(map['belongs_to_collection']),
      budget: map['budget'],
      genres: List<Genre>.from(map['genres'].map((x) => Genre.fromMap(x))),
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originCountry: List<String>.from(map['origin_country']),
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'].toDouble(),
      posterPath: map['poster_path'],
      productionCompanies: List<ProductionCompany>.from(map['production_companies'].map((x) => ProductionCompany.fromMap(x))),
      productionCountries: List<ProductionCountry>.from(map['production_countries'].map((x) => ProductionCountry.fromMap(x))),
      releaseDate: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      spokenLanguages: List<SpokenLanguage>.from(map['spoken_languages'].map((x) => SpokenLanguage.fromMap(x))),
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average'].toDouble(),
      voteCount: map['vote_count'],
    );
  }
}

class Collection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  Collection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'],
      name: map['name'],
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
    );
  }
}

class ProductionCompany {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromMap(Map<String, dynamic> map) {
    return ProductionCompany(
      id: map['id'],
      logoPath: map['logo_path'],
      name: map['name'],
      originCountry: map['origin_country'],
    );
  }
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromMap(Map<String, dynamic> map) {
    return ProductionCountry(
      iso31661: map['iso_3166_1'],
      name: map['name'],
    );
  }
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromMap(Map<String, dynamic> map) {
    return SpokenLanguage(
      englishName: map['english_name'],
      iso6391: map['iso_639_1'],
      name: map['name'],
    );
  }
}
