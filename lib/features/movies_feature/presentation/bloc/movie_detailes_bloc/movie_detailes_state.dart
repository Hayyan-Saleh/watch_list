part of 'movie_detailes_bloc.dart';

sealed class MovieDetailesState extends Equatable {
  const MovieDetailesState();

  @override
  List<Object> get props => [];
}

final class MovieDetailesInitial extends MovieDetailesState {}

class LoadingMovieDetailesState extends MovieDetailesState {}

class LoadedMovieDetailsState extends MovieDetailesState {
  final MovieDetails movieDetails;
  const LoadedMovieDetailsState({required this.movieDetails});
  @override
  List<Object> get props => [movieDetails];
}

class ErrorMovieDetailsState extends MovieDetailesState {
  final String message;
  const ErrorMovieDetailsState({required this.message});
  @override
  List<Object> get props => [message];
}
