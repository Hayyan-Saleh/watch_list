import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_list/features/sign_up_feature/data/data_sources/Local_data_source.dart';
import 'package:watch_list/features/sign_up_feature/data/repositories/user_repository_impl.dart';
import 'package:watch_list/features/sign_up_feature/domain/repositories/user_repository.dart';
import 'package:watch_list/features/sign_up_feature/domain/use_cases/cache_user_data_use_case.dart';
import 'package:watch_list/features/sign_up_feature/domain/use_cases/get_cached_user_use_case.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // features - user

  // bloc

  sl.registerFactory(() => UserBloc(cacheUserData: sl(), getCachedUser: sl()));

  //use_cases

  sl.registerLazySingleton(() => CacheUserDataUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(userRepository: sl()));

  //repository

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(localDataSource: sl()));

  //data_sources

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  //extra
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
