import '../../models/user_group.dart';
import 'package:http/http.dart';

abstract class IUserGroupClient{
  Future<List<UserGroup>> getAllGroupUser(int groupId);  
  Future<Response> deleteGroupUser(int userGroupId);
  Future<Response> addGroupUser(UserGroup usserGroup);
}