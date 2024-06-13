import 'package:watch_list/features/movies_feature/data/models/movie_model.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel(
      {required bool isAdult,
      required String userName,
      required List<Movie> userFavouriteMovies})
      : super(
            userName: userName,
            userFavouriteMovies: userFavouriteMovies,
            isAdult: isAdult);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonMovies = json['userFavouriteMovies'];
    final movies = jsonMovies
        .map<Movie>((jsonMovie) => MovieModel.fromJson(jsonMovie))
        .toList();

    return UserModel(
        userName: json['userName'],
        isAdult: json['isAdult'],
        userFavouriteMovies: movies);
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'isAdult': isAdult,
      'userFavouriteMovies': userFavouriteMovies.map((movie) {
        MovieModel movieModel = MovieModel(
            id: movie.id,
            isAdult: movie.isAdult,
            backdropPath: movie.backdropPath,
            posterPath: movie.posterPath,
            originalLanguage: movie.originalLanguage,
            originalTitle: movie.originalTitle,
            releaseDate: movie.releaseDate,
            overview: movie.overview,
            popularity: movie.popularity,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount);
        return movieModel.toJson();
      }).toList()
    };
  }
}
