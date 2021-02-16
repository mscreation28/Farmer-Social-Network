import 'dart:convert';

import '../../models/user_group.dart';
import '../interfaces/IUserGroupClient.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class UserGroupClient implements IUserGroupClient {
  static const String USER_GROUP = "userChannel";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  Future<Response> addGroupUser(UserGroup userGroup) async {
    String token = await getTokenString();
    try {
      final response = await http.post(
        '${Utils.BASE_URL}$USER_GROUP',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token'          
        },
        body: jsonEncode(userGroup.toJson()),
      );
      print(jsonDecode(response.body));
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<Response> deleteGroupUser(int userGroupId) async {
    String token = await getTokenString();
    var response = await http.delete('${Utils.BASE_URL}$USER_GROUP/$userGroupId',headers: {
      'Authorization':'Bearer $token'
    });
    print(jsonEncode(response.body));
  return response;
  }

  @override
  Future<List<UserGroup>> getAllGroupUser(int groupId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$USER_GROUP/$groupId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<UserGroup> userGroupList = [];
        final jsonResponse = jsonDecode(response.body);

        for (var user in jsonResponse['userChannel']) {
          userGroupList.add(UserGroup.fromJson(user));
        }
        return userGroupList;
      } else {
        throw Exception('Failed to load Group users');
      }
    } catch (error) {
      print(error.toString());
    }
  } 
}
