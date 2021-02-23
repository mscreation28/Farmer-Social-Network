import 'dart:convert';

import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/models/groups.dart';
import 'package:KrishiMitr/models/user_group.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:KrishiMitr/network/clients/UserGroupClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupData {  
  // GroupData({this.group});
    

  Future<List<User>> getGroupUsers(Group group) async {
    UserGroupClient userGroupClient = new UserGroupClient();
    UserClient userClient = new UserClient();
    List<UserGroup> groupUserList = await userGroupClient.getAllGroupUser(group.groupId);    
    List<User> users = [];
    for(int i=0;i<groupUserList.length;i++) {
      User u = await userClient.getSpecificUser(groupUserList[i].userId);
      users.add(u);
    }
    return users;
  }

  Future<User> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userIdData = prefs.getInt(Utils.USER_ID);    
    UserClient userClient = new UserClient();
    return await userClient.getSpecificUser(userIdData);      
  }

  Future<bool> checkUserGroup(Group group) async {
    List<User> users = await getGroupUsers(group);
    User u = await getCurrentUser();
    try
    {
      users.firstWhere((element) => element.userId == u.userId);
      return true;
    }
    catch(e) {
      return false;    
    }      
  }

  Future<int> getUserGroupId(int userId, int groupId) async {
    UserGroupClient userGroupClient = new UserGroupClient();    
    List<UserGroup> groupUserList = await userGroupClient.getAllGroupUser(groupId);
    try{
      return groupUserList.firstWhere((element) {
        return (element.groupId == groupId && element.userId==userId);
      }).userGroupId;
    }
    catch(e) {
      return -1;
    }
  }
}