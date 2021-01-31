import 'dart:convert';

import '../../models/like.dart';
import '../interfaces/ILikeClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

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
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        throw Exception("Error while addding new like");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void deleteLike(int likeId, int postId) async {
    String token = await getTokenString();
    var url = Uri.parse('${Utils.BASE_URL}$LIKE/$likeId');
    var request = http.Request("DELETE",url);
      
    request.headers.addAll(<String, String>{'Authorization':'Bearer $token',});
    request.bodyFields = {'postId':postId.toString()};
    
    var response = await request.send();
    // print(jsonEncode(response.body));
    if (response.statusCode == 200) {
      print(jsonEncode("\n\n\${response.body}"));
    } else {
      throw Exception("Delete Unsuccesfull");
    }
  } 

  @override
  Future<List<Like>> getAllLike(int postId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$LIKE/$postId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<Like> likes = [];
        final jsonResponse = jsonDecode(response.body);

        for (var like in jsonResponse['likes']) {
          likes.add(Like.fromJson(like));
        }
        return likes;
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      print(error.toString());
    }
  }

}
