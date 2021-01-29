import 'dart:convert';

import 'package:KrishiMitr/models/user_crops.dart';
import 'package:KrishiMitr/network/interfaces/IUserCropClient.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class UserCropClient implements IUserCropClient {
  static const String USER_CROP = "userCrops";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  Future<Response> addUserCrop(UserCrop userCrop) async {
    String token = await getTokenString();
    try {
      final response = await http.post(
        '${Utils.BASE_URL}$USER_CROP',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token'
          
        },
        body: jsonEncode(userCrop.toJson()),
      );
      print(jsonDecode(response.body));
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<Response> deleteUserCrop(int userCropId) async {
    String token = await getTokenString();
    var response = await http.delete('${Utils.BASE_URL}$USER_CROP/$userCropId',headers: {
      'Authorization':'Bearer $token'
    });
    print(jsonEncode(response.body));
  return response;
  }

  @override
  Future<List<UserCrop>> getAllUserCrop(int userId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$USER_CROP/$userId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<UserCrop> userCropList = [];
        final jsonResponse = jsonDecode(response.body);

        for (var user in jsonResponse['userCrops']) {
          userCropList.add(UserCrop.fromJson(user));
        }
        return userCropList;
      } else {
        throw Exception('Failed to load user crops');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future<UserCrop> getSpecificUserCrop(int userCropId) async {
    // TODO: implement getSpecificUserCrop
    throw UnimplementedError();
  }

  @override
  Future<http.Response> updateUserCrop(UserCrop userCrop) async {
    String token = await getTokenString();
    var response = await http.patch(
        '${Utils.BASE_URL}$USER_CROP/${userCrop.userCropId}',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token',
        },
        body: jsonEncode(userCrop.toJson()));
    print(jsonDecode(response.body));
    return response;
  }
}
