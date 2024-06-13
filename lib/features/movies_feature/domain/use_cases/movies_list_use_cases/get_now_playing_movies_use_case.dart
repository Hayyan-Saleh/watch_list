import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movies_list_repository.dart';

class GetNowPlayingMoviesUseCase {
  final MoviesListRepository moviesListRepository;
  const GetNowPlayingMoviesUseCase({required this.moviesListRepository});

  Future<Either<Failure, List<Movie>>> call() async {
    return await moviesListRepository.getNowPlayingMovies();
  }
}
