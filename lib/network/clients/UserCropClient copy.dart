import 'dart:convert';

import 'package:KrishiMitr/models/user_crops.dart';
import 'package:KrishiMitr/network/interfaces/IUserCropClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';

class UserCropClient implements IUserCropClient {
  static const String USER_CROP = "userCrops";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  void addUserCrop(UserCrop userCrop) async {
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
      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
      } else {
        throw Exception("Error while addding new crop");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void deleteUserCrop(int userCropId) async {
    String token = await getTokenString();
    var response = await http.delete('${Utils.BASE_URL}$USER_CROP/$userCropId',headers: {
      'Authorization':'Bearer $token'
    });
    print(jsonEncode(response.body));
    if (response.statusCode == 200) {
      print(jsonEncode(response.body));
    } else {
      throw Exception("Delete Unsuccesfull");
    }
  }

  @override
  Future<List<UserCrop>> getAllUserCrop(int userCropId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$USER_CROP/$userCropId',headers: {
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
  void updateUserCrop(UserCrop userCrop) async {
    String token = await getTokenString();
    var response = await http.patch(
        '${Utils.BASE_URL}$USER_CROP/${userCrop.userCropId}',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token',
        },
        body: jsonEncode(userCrop.toJson()));
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      throw Exception("Error while addding new crop");
    }
  }
}
