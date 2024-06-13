part of 'movies_list_bloc.dart';

sealed class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

final class MoviesListInitial extends MoviesListState {}

final class LoadingMoviesListState extends MoviesListState {}

final class LoadedMoviesListState extends MoviesListState {
  final List<Movie> nowPlayingMovies,
      popularMovies,
      topRatedMovies,
      upcomingMovies,
      todayMostTrendingMovies,
      thisWeekMostTrendingMovies;

  const LoadedMoviesListState(
      {required this.nowPlayingMovies,
      required this.popularMovies,
      required this.thisWeekMostTrendingMovies,
      required this.todayMostTrendingMovies,
      required this.topRatedMovies,
      required this.upcomingMovies});

  @override
  List<Object> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        upcomingMovies,
        todayMostTrendingMovies,
        thisWeekMostTrendingMovies
      ];
}

class SearchDoneMovieListState extends MoviesListState {
  final List<Movie> searchedMovies;
  const SearchDoneMovieListState({required this.searchedMovies});
  @override
  List<Object> get props => [searchedMovies];
}

class ErrorMovieState extends MoviesListState {
  final String message;
  const ErrorMovieState({required this.message});
  @override
  List<Object> get props => [message];
}
