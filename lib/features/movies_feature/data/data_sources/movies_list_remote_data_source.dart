import 'dart:convert';

import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/features/movies_feature/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MoviesListRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpcomingMovies();

  Future<List<MovieModel>> getTodayMostTrendingMovies();
  Future<List<MovieModel>> getThisWeekMostTrendingMovies();

  Future<List<MovieModel>> searchMovies(
      String movieTitle, String? year, String? region);
}

class MoviesListRemoteDataSourceImpl implements MoviesListRemoteDataSource {
  final http.Client client;
  const MoviesListRemoteDataSourceImpl({required this.client});
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    const url = '$MOVIE_BASE_URL/movie/now_playing?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    const url = '$MOVIE_BASE_URL/movie/top_rated?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    const url = '$MOVIE_BASE_URL/movie/top_rated?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    const url = '$MOVIE_BASE_URL/movie/upcoming?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> getThisWeekMostTrendingMovies() async {
    const url = '$MOVIE_BASE_URL/trending/movie/week?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> getTodayMostTrendingMovies() async {
    const url = '$MOVIE_BASE_URL/trending/movie/day?page=1&api_key=$API_KEY';
    return await _getMoviesListFromURL(url);
  }

  @override
  Future<List<MovieModel>> searchMovies(
      String movieTitle, String? year, String? region) async {
    final yearAttribute = year == null ? '' : "&year=$year";
    final regionAttribute = region == null ? '' : "&region=$region";
    final query = _convertToUrlSafeString(movieTitle);
    final url =
        '$MOVIE_BASE_URL/search/movie?query=$query$yearAttribute$regionAttribute&api_key=$API_KEY';

    final response = await _getMoviesListFromURL(url);
    return Future.value(response);
  }

  Future<List<MovieModel>> _getMoviesListFromURL(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body)['results'];
      return decodedJson
          .map<MovieModel>((jsonMovie) => MovieModel.fromJson(jsonMovie))
          .toList();
    } else {
      throw ServerException();
    }
  }

  String _convertToUrlSafeString(String query) {
    return query.replaceAll(' ', '%20');
  }
}
