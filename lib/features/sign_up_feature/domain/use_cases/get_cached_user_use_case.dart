import 'package:fpdart/fpdart.dart';
import 'package:watch_list/core/errors/failures.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/repositories/user_repository.dart';

class GetCachedUserUseCase {
  final UserRepository userRepository;
  const GetCachedUserUseCase({required this.userRepository});

  Future<Either<Failure, User>> call() async {
    return await userRepository.getCachedUser();
  }
}
