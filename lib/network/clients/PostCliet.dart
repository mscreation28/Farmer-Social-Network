import 'dart:convert';

import 'package:KrishiMitr/models/post_model.dart';
import 'package:KrishiMitr/models/user_crops.dart';
import 'package:KrishiMitr/network/interfaces/IPostClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class PostClient implements IPostClient {
  static const String POST = "posts";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }  

  @override
  Future<List<PostModel>> getAllPostOnCrop(int cropId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$POST/$cropId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<PostModel> postList = [];
        final jsonResponse = jsonDecode(response.body);

        for (var user in jsonResponse['post']) {
          postList.add(PostModel.fromJson(user));
        }
        return postList;
      } else {
        throw Exception('Failed to load user crops');
      }
    } catch (error) {
      print(error.toString());
    }
  }  
}
