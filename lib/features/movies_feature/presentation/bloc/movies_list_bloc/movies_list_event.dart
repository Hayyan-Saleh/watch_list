part of 'movies_list_bloc.dart';

sealed class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesListEvent extends MoviesListEvent {}

class SearchMovieListEvent extends MoviesListEvent {
  final String query;
  final String? year, region;
  const SearchMovieListEvent({required this.query, this.region, this.year});

  @override
  List<Object> get props {
    List<Object> list = [query];
    if (year != null) {
      list.add(year!);
    }
    if (region != null) {
      list.add(region!);
    }
    return list;
  }
}
