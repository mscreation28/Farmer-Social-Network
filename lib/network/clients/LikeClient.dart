import 'dart:convert';

import 'package:KrishiMitr/models/like.dart';
import 'package:KrishiMitr/network/interfaces/ILikeClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';

class LikeClient implements ILikeClient {
  static const String LIKE = "like";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  void addLike(Like like) async {
    String token = await getTokenString();
    try {
      final response = await http.post(
        '${Utils.BASE_URL}$LIKE',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token'          
        },
        body: jsonEncode(like.toJson()),
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
      } else {
        throw Exception("Error while addding new like");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void deleteLike(int likeId) async {
    String token = await getTokenString();
    var response = await http.delete('${Utils.BASE_URL}$LIKE/$likeId',headers: {
      'Authorization':'Bearer $token'
    });
    print(jsonEncode(response.body));
    if (response.statusCode == 200) {
      print(jsonEncode(response.body));
    } else {
      throw Exception("Delete Unsuccesfull");
    }
  }  
}
