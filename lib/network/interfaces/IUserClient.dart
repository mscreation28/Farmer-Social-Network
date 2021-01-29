
import 'package:KrishiMitr/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

abstract class IUserClient{
  Future<List<User>> getAllUsers();
  Future<User> getSpecificUser(int id);
  void deleteUser(int id);
  Future<dio.Response> updateUser(User user);
  Future<http.Response> registerUser(User user);
  Future<http.Response> loginUser(User user);
}