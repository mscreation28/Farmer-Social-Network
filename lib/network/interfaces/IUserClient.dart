
import 'package:KrishiMitr/models/users.dart';
import 'package:http/http.dart' as http;

abstract class IUserClient{
  Future<List<User>> getAllUsers();
  Future<User> getSpecificUser(int id);
  void deleteUser(int id);
  void updateUser(User user);
  void registerUser(User user);
  Future<http.Response> loginUser(User user);
}