import 'dart:convert';

import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/features/movies_feature/data/models/movie_details_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieDetailsRemoteDataSource {
  Future<String> getMovieTrailerUrl(int movieId);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final http.Client client;
  const MovieDetailsRemoteDataSourceImpl({required this.client});
  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final url = "$MOVIE_BASE_URL/movie/$movieId?api_key=$API_KEY";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedJsonMap = json.decode(response.body);
      return MovieDetailsModel.fromJson(decodedJsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getMovieTrailerUrl(int movieId) async {
    final url = "$MOVIE_BASE_URL/movie/$movieId/videos?api_key=$API_KEY";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body)['results'];
      final String result = decodedJson.firstWhere((video) {
        if (video['site'] == 'YouTube' &&
            video['type'].toLowerCase().contains('trailer')) {
          return true;
        }
        return false;
      }, orElse: () => decodedJson.first['key'])['key'];

      // return 'https://www.youtube.com/watch?v=$result';
      return result;
    } else {
      throw ServerException();
    }
  }
}
