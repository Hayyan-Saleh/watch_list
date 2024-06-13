import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_list/core/network/network_info.dart';
import 'package:watch_list/features/movies_feature/data/data_sources/movie_details_remote_data_source.dart';
import 'package:watch_list/features/movies_feature/data/data_sources/movies_list_remote_data_source.dart';
import 'package:watch_list/features/movies_feature/data/repositories/movie_details_repository_impl.dart';
import 'package:watch_list/features/movies_feature/data/repositories/movies_list_repository_impl.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movie_details_repository.dart';
import 'package:watch_list/features/movies_feature/domain/repositories/movies_list_repository.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movie_detailes_use_cases/get_movie_detailes_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movie_detailes_use_cases/get_movie_trailer_url_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_now_playing_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_popular_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_this_week_most_trending_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_today_most_trending_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_top_rated_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/get_upcoming_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/domain/use_cases/movies_list_use_cases/search_movies_use_case.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movie_detailes_bloc/movie_detailes_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movie_trailer_bloc/movie_trailer_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:watch_list/features/sign_up_feature/data/data_sources/Local_data_source.dart';
import 'package:watch_list/features/sign_up_feature/data/repositories/user_repository_impl.dart';
import 'package:watch_list/features/sign_up_feature/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:watch_list/features/sign_up_feature/domain/use_cases/cache_user_data_use_case.dart';
import 'package:watch_list/features/sign_up_feature/domain/use_cases/get_cached_user_use_case.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';

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

  //features - movies

  //bloc

  sl.registerFactory(() => MovieDetailesBloc(getMovieDetails: sl()));
  sl.registerFactory(() => MovieTrailerBloc(movieTrailer: sl()));
  sl.registerFactory(() => MoviesListBloc(
      getNowPlayingMovies: sl(),
      getPopularMovies: sl(),
      getThisWeekMostTrendingMovies: sl(),
      getTodayMostTrendingMovies: sl(),
      getTopRatedMovies: sl(),
      getUpcomingMovies: sl(),
      searchMovies: sl()));

  //use_cases

  sl.registerLazySingleton(
      () => GetMovieDetailsUseCase(movieDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetMovieTrailerUseCase(movieDetailsRepository: sl()));
  sl.registerLazySingleton(
      () => GetNowPlayingMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => GetPopularMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => GetThisWeekMostTrendingMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => GetTodayMostTrendingMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => GetTopRatedMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => GetUpcomingMoviesUseCase(moviesListRepository: sl()));
  sl.registerLazySingleton(
      () => SearchMoviesUseCase(moviesListRepository: sl()));

  //repositories

  sl.registerLazySingleton<MoviesListRepository>(() =>
      MoviesListRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<MovieDetailsRepository>(() =>
      MoovieDetailsRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  //data_sources

  sl.registerLazySingleton<MoviesListRemoteDataSource>(
      () => MoviesListRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(client: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //extra
  final sharedPreferences = await SharedPreferences.getInstance();
  final client = http.Client();
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => connectionChecker);
  sl.registerLazySingleton(() => client);
}
