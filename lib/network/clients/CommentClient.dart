import 'dart:convert';

import '../../models/comment.dart';
import '../interfaces/ICommentClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class CommentClient implements ICommentClient {
  static const String COMMENT = "comments";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  void addComment(Comment comment) async {
    String token = await getTokenString();
    try {
      final response = await http.post(
        '${Utils.BASE_URL}$COMMENT',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token'
          
        },
        body: jsonEncode(comment.toJson()),
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
      } else {
        throw Exception("Error while addding new comment");
      }
    } catch (error) {
      print(error.toString());
    }
  }
  
  @override
  Future<List<Comment>> getAllComment(int postId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$COMMENT/$postId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<Comment> comments = [];
        final jsonResponse = jsonDecode(response.body);

        for (var comment in jsonResponse['comments']) {
          comments.add(Comment.fromJson(comment));
        }
        return comments;
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
