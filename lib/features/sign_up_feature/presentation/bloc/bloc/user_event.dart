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
