import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movie_detailes_use_cases/get_movie_trailer_url_use_case.dart';

part 'movie_trailer_event.dart';
part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  final GetMovieTrailerUseCase movieTrailer;
  MovieTrailerBloc({required this.movieTrailer})
      : super(MovieTrailerInitial()) {
    on<MovieTrailerEvent>((event, emit) async {
      if (event is GetMovieTrailerEvent) {
        emit(TrailerLinkLoadingState());
        final either = await movieTrailer(movieId: event.movieId);
        emit(either.fold(
            (failure) =>
                const ErrorMovieTrailerState(message: SERVER_FAILURE_MESSAGE),
            (url) => TrailerLinkLoadedState(trailerLink: url)));
      }
    });
  }
}
