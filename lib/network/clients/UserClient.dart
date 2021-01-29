import 'dart:convert';

import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class UserClient implements IUserClient {
  static const String USER_URL = "users";
  static const String LOGIN_URL = "login";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  Future<http.Response> registerUser(User user) async {
    var response = await http.post('${Utils.BASE_URL}$USER_URL',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    print(jsonDecode(response.body));
    return response;
  }

  @override
  Future<http.Response> loginUser(User user) async {
    var response = await http.post('${Utils.BASE_URL}$USER_URL/$LOGIN_URL',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    return response;
  }

  @override
  void deleteUser(int id) async {
    // TODO: implement deleteUser
  }

  @override
  Future<List<User>> getAllUsers() async {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User> getSpecificUser(int id) async {
    String token = await getTokenString();
    final response = await http.get(
      '${Utils.BASE_URL}$USER_URL/$id',
      headers: {'Authorization': 'Bearer $token'},
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Failed to load user');
    }
  }
    @override
  Future<dio.Response> updateUser(User user) async {
    String token = await getTokenString();
    dio.FormData formData = new dio.FormData.fromMap(user.toJson());

    if (user.profilPic != null){
      String fileName = user.profilPic.path.split('/').last;
      var file =
          await MultipartFile.fromFile(user.profilPic.path, filename: fileName);
      formData.files.add(MapEntry('userProfilePic', file));
      return await dio.Dio().patch('${Utils.BASE_URL}$USER_URL/${user.userId}',
          data: formData,
          options: dio.Options(
              headers: <String, String>{'Authorization': 'Bearer $token'}));
    } else {
      return await dio.Dio().patch('${Utils.BASE_URL}$USER_URL/${user.userId}',
      data: formData,
          options: dio.Options(
              headers: <String, String>{'Authorization': 'Bearer $token'}));
    }
  }
}
