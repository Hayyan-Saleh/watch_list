import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';

import '../entities/movie_entity.dart';

abstract class MoviesListRepository {
  const MoviesListRepository();
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getUpcomingMovies();

  Future<Either<Failure, List<Movie>>> getTodayMostTrendingMovies();
  Future<Either<Failure, List<Movie>>> getThisWeekMostTrendingMovies();

  Future<Either<Failure, List<Movie>>> searchMovies(
      String movieTitle, String? year, String? region);
}
