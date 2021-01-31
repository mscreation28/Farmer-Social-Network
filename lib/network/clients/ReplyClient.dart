import 'dart:convert';

import '../../models/reply.dart';
import '../interfaces/IReplyClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utility/Utils.dart';

class ReplyClient implements IReplyClient {
  static const String REPLY = "reply";

  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }

  @override
  void addReply(Reply reply) async {
    String token = await getTokenString();
    try {
      final response = await http.post(
        '${Utils.BASE_URL}$REPLY',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token'          
        },
        body: jsonEncode(reply.toJson()),
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
  Future<List<Reply>> getAllReply(int commentId) async {
    String token = await getTokenString();
    try {
      final response =
          await http.get('${Utils.BASE_URL}$REPLY/$commentId',headers: {
            'Authorization':'Bearer $token',
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        List<Reply> replies = [];
        final jsonResponse = jsonDecode(response.body);

        for (var reply in jsonResponse['replies']) {
          replies.add(Reply.fromJson(reply));
        }
        return replies;
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
