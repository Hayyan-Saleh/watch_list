part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserStoredState extends UserState {
  final String message;
  const UserStoredState({required this.message});
  @override
  List<Object> get props => [message];
}

class UserLoadedState extends UserState {
  final User user;
  const UserLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class UserErrorState extends UserState {
  final String message;
  const UserErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
