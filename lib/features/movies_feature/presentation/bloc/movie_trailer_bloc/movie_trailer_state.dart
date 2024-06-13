part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerState extends Equatable {
  const MovieTrailerState();

  @override
  List<Object> get props => [];
}

final class MovieTrailerInitial extends MovieTrailerState {}

class TrailerLinkLoadingState extends MovieTrailerState {}

class TrailerLinkLoadedState extends MovieTrailerState {
  final String trailerLink;
  const TrailerLinkLoadedState({required this.trailerLink});

  @override
  List<Object> get props => [trailerLink];
}

class ErrorMovieTrailerState extends MovieTrailerState {
  final String message;
  const ErrorMovieTrailerState({required this.message});
  @override
  List<Object> get props => [message];
}
