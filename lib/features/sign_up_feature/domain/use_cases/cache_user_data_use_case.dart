import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';
import 'package:watch_list/features/sign_up_feature/domain/repositories/user_repository.dart';

class CacheUserDataUseCase {
  final UserRepository userRepository;
  const CacheUserDataUseCase({required this.userRepository});

  Future<void> call(User user) async {
    return await userRepository.cacheUserData(user);
  }
}
