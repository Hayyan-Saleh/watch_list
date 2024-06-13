import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movie_details_repository.dart';

class GetMovieDetailsUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  const GetMovieDetailsUseCase({required this.movieDetailsRepository});
  Future<Either<Failure, MovieDetails>> call({required int movieId}) async {
    return await movieDetailsRepository.getMovieDetails(movieId);
  }
}
