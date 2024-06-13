import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movie_details_repository.dart';

class GetMovieTrailerUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  const GetMovieTrailerUseCase({required this.movieDetailsRepository});
  Future<Either<Failure, String>> call({required int movieId}) async {
    return await movieDetailsRepository.getMovieTrailerUrl(movieId);
  }
}
