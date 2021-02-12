import '../../models/groups.dart';

import 'package:http/http.dart';

abstract class IGroupCleint{
  Future<List<Group>> getAllGroups();
  Future<Response> joinGroup(Group group, int userId);
  Future<Response> leaveGroup(Group group, int userId);
}