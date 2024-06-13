import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/sign_up_feature/data/data_sources/Local_data_source.dart';
import 'package:watch_list/features/sign_up_feature/data/models/user_model.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final LocalDataSource localDataSource;
  const UserRepositoryImp({required this.localDataSource});
  @override
  Future<void> cacheUserData(User user) async {
    final userModel = UserModel(
        userName: user.userName,
        userFavouriteMovies: user.userFavouriteMovies,
        isAdult: user.isAdult);
    await localDataSource.cacheUserData(userModel);
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }
}
