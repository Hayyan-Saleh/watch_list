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
      required final double voteCount})
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

  factory MovieModel.fromJson(Map<String, dynamic> jsonMovie) {
    return MovieModel(
        id: jsonMovie['id'],
        isAdult: jsonMovie['isAdult'],
        backdropPath: jsonMovie['backdropPath'],
        posterPath: jsonMovie['posterPath'],
        originalLanguage: jsonMovie['originalLanguage'],
        originalTitle: jsonMovie['originalTitle'],
        releaseDate: jsonMovie['releaseDate'],
        overview: jsonMovie['overview'],
        popularity: jsonMovie['popularity'],
        voteAverage: jsonMovie['voteAverage'],
        voteCount: jsonMovie['voteCount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isAdult': isAdult,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'releaseDate': releaseDate,
      'overview': overview,
      'popularity': popularity,
      'voteAverage': voteAverage,
      'voteCount': voteCount
    };
  }
}
