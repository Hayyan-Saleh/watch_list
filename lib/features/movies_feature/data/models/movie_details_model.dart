import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel(
      {required final int budget,
      required final int revenue,
      required final int runtime,
      required final String status,
      required final String tagline,
      required final String movieHomepageURL,
      required final List<String> spokenLangauges,
      required final List<String> genres,
      required final List<String> productionCompanies,
      required final List<String> productionCountries,
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
            budget: budget,
            genres: genres,
            movieHomepageURL: movieHomepageURL,
            productionCompanies: productionCompanies,
            productionCountries: productionCountries,
            revenue: revenue,
            runtime: runtime,
            spokenLangauges: spokenLangauges,
            status: status,
            tagline: tagline,
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

  factory MovieDetailsModel.fromJson(Map<String, dynamic> jsonMap) {
    return MovieDetailsModel(
        budget: jsonMap['budget'],
        revenue: jsonMap['revenue'],
        runtime: jsonMap['runtime'],
        status: jsonMap['status'],
        tagline: jsonMap['tagline'],
        movieHomepageURL: jsonMap['homepage'],
        spokenLangauges: stringListFromJson(jsonMap, 'spoken_languages'),
        genres: stringListFromJson(jsonMap, 'genres'),
        productionCompanies:
            stringListFromJson(jsonMap, 'production_companies'),
        productionCountries:
            stringListFromJson(jsonMap, 'production_countries'),
        id: jsonMap['id'],
        isAdult: jsonMap['adult'],
        backdropPath: jsonMap['backdrop_path'],
        posterPath: jsonMap['poster_path'],
        originalLanguage: jsonMap['original_language'],
        originalTitle: jsonMap['original_title'],
        releaseDate: jsonMap['release_date'],
        overview: jsonMap['overview'],
        popularity: jsonMap['popularity'],
        voteAverage: jsonMap['vote_average'],
        voteCount: jsonMap['vote_count']);
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
