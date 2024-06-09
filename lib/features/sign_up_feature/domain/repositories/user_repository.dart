import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCachedUser();
  Future<void> cacheUserData(User user);
}
