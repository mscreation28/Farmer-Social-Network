import 'dart:convert';

import 'package:KrishiMitr/models/groups.dart';

import '../../models/crops.dart';
import '../../Utility/Utils.dart';
import '../interfaces/IGroupClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupClient implements IGroupCleint{
  static const GROUP_URL = 'channel';
  
  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }
  


  @override
  Future<List<Group>> getAllGroups() async {
      String token = await getTokenString();
    List<Group> groupList = [];
    var response = await http.get('${Utils.BASE_URL}$GROUP_URL'
      ,headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
    );
    if(response.statusCode==200){
      var jsonResponse = jsonDecode(response.body);
      for(var crop in jsonResponse['channels']){
        groupList.add(new Group.fromJson(crop));
      }
    }else{
      throw Exception('Error while getting group list');
    }
    return groupList;
  }

  @override
  Future<http.Response> joinGroup(Group group, int userId) {
    }
  
    @override
    Future<http.Response> leaveGroup(Group group, int userId) {
   
  }

}