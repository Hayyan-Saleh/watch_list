import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, String>> getMovieTrailerUrl(int movieId);
  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId);
}
