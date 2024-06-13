import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movie_detailes_use_cases/get_movie_detailes_use_case.dart';

import '../../../../../core/constants/strings.dart';

part 'movie_detailes_event.dart';
part 'movie_detailes_state.dart';

class MovieDetailesBloc extends Bloc<MovieDetailesEvent, MovieDetailesState> {
  final GetMovieDetailsUseCase getMovieDetails;
  MovieDetailesBloc({required this.getMovieDetails})
      : super(MovieDetailesInitial()) {
    on<MovieDetailesEvent>((event, emit) async {
      if (event is GetMovieDetailsEvent) {
        emit(LoadingMovieDetailesState());

        final either = await getMovieDetails(movieId: event.movieId);
        either.fold((failure) {
          _mapFailure(failure);
        }, (movieDetails) {
          emit(LoadedMovieDetailsState(movieDetails: movieDetails));
        });
      }
    });
  }

  ErrorMovieDetailsState _mapFailure(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return const ErrorMovieDetailsState(message: OFFLINE_FAILURE_MESSAGE);
      case ServerFailure:
        return const ErrorMovieDetailsState(message: SERVER_FAILURE_MESSAGE);
    }
    return const ErrorMovieDetailsState(message: OFFLINE_FAILURE_MESSAGE);
  }
}
