import 'package:flutter/foundation.dart';

class Comment{
  final String id;
  final String postid;  
  final String userid;  
  final String comment;
  final DateTime date;

  const Comment({
    @required this.id,
    @required this.postid,
    @required this.userid,
    @required this.comment,
    @required this.date
  });
}

class Reply{
  final String id;
  final String commnetid;  
  final String userid;  
  final String reply;
  final DateTime date;

  const Reply({
    @required this.id,
    @required this.commnetid,
    @required this.userid,
    @required this.reply,
    @required this.date
  });
}