import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';

class MovieDetails extends Movie {
  final int budget, revenue, runtime;
  final String status, tagline, movieHomepageURL;
  final List<String> spokenLangauges,
      productionCountries,
      productionCompanies,
      genres;
  const MovieDetails(
      {required this.budget,
      required this.revenue,
      required this.runtime,
      required this.status,
      required this.tagline,
      required this.movieHomepageURL,
      required this.spokenLangauges,
      required this.genres,
      required this.productionCompanies,
      required this.productionCountries,
      required final int id,
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

  @override
  List<Object> get props => [
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
        voteCount,
        budget,
        revenue,
        runtime,
        status,
        tagline,
        movieHomepageURL,
        spokenLangauges,
        productionCountries,
        productionCompanies,
        genres
      ];
}
