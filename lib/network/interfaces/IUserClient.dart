
import 'package:KrishiMitr/models/users.dart';

abstract class IUserClient{
  Future<List<User>> getAllUsers();
  Future<User> getSpecificUser(int id);
  void deleteUser(int id);
  void updateUser(int id, User user);
  void addUser(User user);
}