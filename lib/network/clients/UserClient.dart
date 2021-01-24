import 'dart:convert';

import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:http/http.dart' as http;

class UserClient implements IUserClient{
  static const String BASE_URL = "http://127.0.0.1:3000/";
  static const String USER_URL = "users/";

  @override
    void addUser(User user) async {
      // TODO: implement addUser
    }
  
    @override
    void deleteUser(int id)async {
      // TODO: implement deleteUser
    }
  
    @override
    Future<List<User>> getAllUsers() async{
      // TODO: implement getAllUsers
      throw UnimplementedError();
    }
  
    @override
    Future<User> getSpecificUser(int id) async {
      final response = await http.get('$BASE_URL+$USER_URL+$id');
      if(response.statusCode==200){
        return User.fromJson(jsonDecode(response.body)['user']);
      }else{
       throw Exception('Failed to load user');
      }
    }
  
    @override
    void updateUser(int id, User user) async{
    // TODO: implement updateUser
  }

}