part of 'movie_detailes_bloc.dart';

sealed class MovieDetailesEvent extends Equatable {
  const MovieDetailesEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailsEvent extends MovieDetailesEvent {
  final int movieId;
  const GetMovieDetailsEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}
