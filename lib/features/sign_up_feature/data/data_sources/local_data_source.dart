import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_list/core/errors/exceptions.dart';
import 'package:watch_list/features/sign_up_feature/data/models/user_model.dart';

abstract class LocalDataSource {
  Future<UserModel> getCachedUser();
  Future<void> cacheUserData(UserModel user);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  // ignore: non_constant_identifier_names
  final String USER_KEY = "AF4210LIJ2KBN509";
  const LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserData(UserModel user) async {
    String jsonEndcoded = json.encode(user.toJson());
    await sharedPreferences.setString(USER_KEY, jsonEndcoded);
    return;
  }

  @override
  Future<UserModel> getCachedUser() async {
    final String? jsonString = sharedPreferences.getString(USER_KEY);
    if (jsonString == null) {
      throw EmptyCacheException();
    } else {
      final Map<String, dynamic> decodedJson = json.decode(jsonString);

      return UserModel.fromJson(decodedJson);
    }
  }
}
