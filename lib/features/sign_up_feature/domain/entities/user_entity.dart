import 'package:equatable/equatable.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';

class User extends Equatable {
  final String userName;
  final bool isAdult;
  final List<Movie> userFavouriteMovies;

  const User(
      {required this.isAdult,
      required this.userName,
      required this.userFavouriteMovies});

  @override
  List<Object?> get props => [userName, isAdult, userFavouriteMovies];
}
