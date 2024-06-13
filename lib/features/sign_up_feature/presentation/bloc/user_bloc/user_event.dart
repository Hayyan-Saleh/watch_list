part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends UserEvent {}

class CacheUserDataEvent extends UserEvent {
  final User user;
  const CacheUserDataEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class AddToFavouriteEvent extends UserEvent {
  final Movie movie;
  const AddToFavouriteEvent({required this.movie});
  @override
  List<Object> get props => [movie];
}

class RemoveFromFavouriteEvent extends UserEvent {
  final Movie movie;
  const RemoveFromFavouriteEvent({required this.movie});
  @override
  List<Object> get props => [movie];
}
