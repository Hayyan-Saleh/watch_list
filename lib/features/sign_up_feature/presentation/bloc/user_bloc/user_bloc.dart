import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/use_cases/cache_user_data_use_case.dart';
import 'package:watch_list/features/sign_up_feature/domain/use_cases/get_cached_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCachedUserUseCase getCachedUser;
  final CacheUserDataUseCase cacheUserData;
  UserBloc({required this.cacheUserData, required this.getCachedUser})
      : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserDataEvent) {
        emit(UserLoadingState());
        final either = await getCachedUser();
        emit(_mapEither(either));
      } else if (event is CacheUserDataEvent) {
        emit(UserLoadingState());
        await cacheUserData(event.user);
        emit(const UserStoredState(message: SUCCESS_MESSAGE));
        add(GetUserDataEvent());
      } else if (event is AddToFavouriteEvent) {
        emit(UserLoadingState());
        final either = await getCachedUser();
        either.fold((failure) {
          emit(const UserErrorState(message: EMPTY_CACHE_FAILURE_MESSAGE));
        }, (user) {
          user.userFavouriteMovies.add(event.movie);
          add(CacheUserDataEvent(user: user));
          if (state is UserStoredState) {
            add(GetUserDataEvent());
          }
        });
      } else if (event is RemoveFromFavouriteEvent) {
        emit(UserLoadingState());
        final either = await getCachedUser();
        either.fold((failure) {
          emit(const UserErrorState(message: EMPTY_CACHE_FAILURE_MESSAGE));
        }, (user) {
          user.userFavouriteMovies.remove(event.movie);
          add(CacheUserDataEvent(user: user));
          if (state is UserStoredState) {
            emit(UserMovieAddedState(movies: user.userFavouriteMovies));
          }
        });
      }
    });
  }

  UserState _mapEither(Either<Failure, User> either) {
    return either.fold((failure) {
      return const UserErrorState(message: EMPTY_CACHE_FAILURE_MESSAGE);
    }, (user) {
      return UserLoadedState(user: user);
    });
  }
}
