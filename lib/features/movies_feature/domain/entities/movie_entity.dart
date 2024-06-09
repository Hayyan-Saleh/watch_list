import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final bool isAdult;
  final String backdropPath,
      posterPath,
      originalLanguage,
      originalTitle,
      releaseDate,
      overview;
  final double popularity, voteAverage, voteCount;

  const Movie(
      {required this.backdropPath,
      required this.id,
      required this.originalLanguage,
      required this.isAdult,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => [
        id,
        isAdult,
        backdropPath,
        posterPath,
        originalLanguage,
        originalTitle,
        releaseDate,
        overview,
        popularity,
        voteAverage,
        voteCount
      ];
}
