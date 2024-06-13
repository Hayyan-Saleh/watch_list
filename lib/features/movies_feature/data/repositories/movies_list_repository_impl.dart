import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/core/network/network_info.dart';
import 'package:watch_list/features/movies_feature/data/models/movie_model.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movies_list_repository.dart';

import '../data_sources/movies_list_remote_data_source.dart';

typedef GetMoviesFunction = Future<List<MovieModel>> Function();

class MoviesListRepositoryImpl extends MoviesListRepository {
  final MoviesListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const MoviesListRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    return await _getMoviesFromFunc(
        () => remoteDataSource.getNowPlayingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    return await _getMoviesFromFunc(() => remoteDataSource.getPopularMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getThisWeekMostTrendingMovies() async {
    return await _getMoviesFromFunc(
        () => remoteDataSource.getThisWeekMostTrendingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getTodayMostTrendingMovies() async {
    return await _getMoviesFromFunc(
        () => remoteDataSource.getTodayMostTrendingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    return await _getMoviesFromFunc(() => remoteDataSource.getTopRatedMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() async {
    return await _getMoviesFromFunc(() => remoteDataSource.getUpcomingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      String movieTitle, String? year, String? region) async {
    return await _getMoviesFromFunc(
        () => remoteDataSource.searchMovies(movieTitle, year, region));
  }

  Future<Either<Failure, List<Movie>>> _getMoviesFromFunc(
      GetMoviesFunction func) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await func();
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
