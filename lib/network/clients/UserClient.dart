import 'dart:convert';

import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/Utils.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:http/http.dart' as http;

class UserClient implements IUserClient {
  static const String USER_URL = "users";
    static const String LOGIN_URL = "login";

  @override
  void registerUser(User user) async {
    var response = await http.post('${Utils.BASE_URL}$USER_URL',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    } else {
      throw Exception("Error while adding new crop");
    }
  }
    @override
  void loginUser(User user) async {
    var response = await http.post('${Utils.BASE_URL}$USER_URL/$LOGIN_URL',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception("Error while loging user");
    }
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
    final response = await http.get('${Utils.BASE_URL}$USER_URL/$id');
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void updateUser(User user) async {
    var response = await http.patch('${Utils.BASE_URL}$USER_URL/${user.userId}',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception("Error while updating user");
    }
  }
}
