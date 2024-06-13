import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required final int id,
      required final bool isAdult,
      required final String backdropPath,
      required final String posterPath,
      required final String originalLanguage,
      required final String originalTitle,
      required final String releaseDate,
      required final String overview,
      required final double popularity,
      required final double voteAverage,
      required final int voteCount})
      : super(
            backdropPath: backdropPath,
            id: id,
            isAdult: isAdult,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount);

  factory MovieModel.fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap.isEmpty) return MovieModel.defaultModel();
    final String posterPath = jsonMap['poster_path'] ?? 'not available';
    final String backdropPath = jsonMap['backdrop_path'] ?? 'not available';
    return MovieModel(
        id: jsonMap['id'],
        isAdult: jsonMap['adult'],
        backdropPath: backdropPath,
        posterPath: posterPath,
        originalLanguage: jsonMap['original_language'],
        originalTitle: jsonMap['original_title'],
        releaseDate: jsonMap['release_date'],
        overview: jsonMap['overview'],
        popularity: jsonMap['popularity'],
        voteAverage: jsonMap['vote_average'],
        voteCount: jsonMap['vote_count']);
  }
  factory MovieModel.defaultModel() {
    return const MovieModel(
        id: 0,
        isAdult: false,
        backdropPath: 'backdropPath',
        posterPath: 'posterPath',
        originalLanguage: 'originalLanguage',
        originalTitle: 'originalTitle',
        releaseDate: 'releaseDate',
        overview: 'overview',
        popularity: 0.0,
        voteAverage: 0.0,
        voteCount: 0);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adult': isAdult,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'release_date': releaseDate,
      'overview': overview,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount
    };
  }
}
