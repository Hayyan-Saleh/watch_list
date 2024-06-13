import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movies_list_repository.dart';

class SearchMoviesUseCase {
  final MoviesListRepository moviesListRepository;
  const SearchMoviesUseCase({required this.moviesListRepository});

  Future<Either<Failure, List<Movie>>> call(
      {required String movieTitle,
      required String? year,
      required String? region}) async {
    return await moviesListRepository.searchMovies(movieTitle, year, region);
  }
}
