import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/core/network/network_info.dart';
import 'package:watch_list/features/movies_feature/data/data_sources/movie_details_remote_data_source.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movie_details_repository.dart';

class MoovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final NetworkInfo networkInfo;
  final MovieDetailsRemoteDataSource remoteDataSource;
  const MoovieDetailsRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        MovieDetails movieDetails =
            await remoteDataSource.getMovieDetails(movieId);
        return Right(movieDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getMovieTrailerUrl(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        String trailerUrl = await remoteDataSource.getMovieTrailerUrl(movieId);
        return Right(trailerUrl);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
