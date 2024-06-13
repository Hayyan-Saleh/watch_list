import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_now_playing_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_popular_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_this_week_most_trending_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_today_most_trending_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_top_rated_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_upcoming_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/search_movies_use_case.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';

typedef DefFun = Future<Either<Failure, List<Movie>>> Function();

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetPopularMoviesUseCase getPopularMovies;
  final GetUpcomingMoviesUseCase getUpcomingMovies;
  final GetTopRatedMoviesUseCase getTopRatedMovies;
  final GetThisWeekMostTrendingMoviesUseCase getThisWeekMostTrendingMovies;
  final GetTodayMostTrendingMoviesUseCase getTodayMostTrendingMovies;
  final SearchMoviesUseCase searchMovies;

  Failure failureType = OfflineFailure();
  MoviesListBloc(
      {required this.getNowPlayingMovies,
      required this.getPopularMovies,
      required this.getThisWeekMostTrendingMovies,
      required this.getTodayMostTrendingMovies,
      required this.getTopRatedMovies,
      required this.getUpcomingMovies,
      required this.searchMovies})
      : super(MoviesListInitial()) {
    on<MoviesListEvent>((event, emit) async {
      if (event is GetMoviesListEvent) {
        emit(LoadingMoviesListState());
        List<Movie> nowPlayingMovies = [];
        List<Movie> popularMovies = [];
        List<Movie> upcomingMovies = [];
        List<Movie> topRatedMovies = [];
        List<Movie> weekMostTrendingMovies = [];
        List<Movie> dayMostTrendingMovies = [];

        Either<Failure, List<Movie>> either = await getNowPlayingMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => nowPlayingMovies = movies);
        either = await getPopularMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => popularMovies = movies);
        either = await getUpcomingMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => upcomingMovies = movies);
        either = await getTodayMostTrendingMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => dayMostTrendingMovies = movies);
        either = await getThisWeekMostTrendingMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => weekMostTrendingMovies = movies);
        either = await getTopRatedMovies();
        either.fold((failure) => emit(_mapFailure(failure)),
            (movies) => topRatedMovies = movies);
        if (state is LoadingMoviesListState) {
          emit(LoadedMoviesListState(
              nowPlayingMovies: nowPlayingMovies,
              popularMovies: popularMovies,
              thisWeekMostTrendingMovies: weekMostTrendingMovies,
              todayMostTrendingMovies: dayMostTrendingMovies,
              topRatedMovies: topRatedMovies,
              upcomingMovies: upcomingMovies));
        }
      } else if (event is SearchMovieListEvent) {
        emit(LoadingMoviesListState());

        List<Movie> searchedMovies = [];
        final either = await searchMovies(
            movieTitle: event.query, year: event.year, region: event.region);
        either.fold((failure) {
          emit(_mapFailure(failure));
        }, (movies) {
          searchedMovies = movies;
          emit(SearchDoneMovieListState(searchedMovies: searchedMovies));
        });
      }
    });
  }

  ErrorMovieState _mapFailure(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return const ErrorMovieState(message: OFFLINE_FAILURE_MESSAGE);
      case ServerFailure:
        return const ErrorMovieState(message: SERVER_FAILURE_MESSAGE);
    }
    return const ErrorMovieState(message: OFFLINE_FAILURE_MESSAGE);
  }
}
