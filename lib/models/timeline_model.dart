import 'package:flutter/foundation.dart';

class TimelineModel{
  final String id;
  final String usercropid;  
  final String title;  
  final String description;
  final DateTime date;

  const TimelineModel({
    @required this.id,
    @required this.usercropid,
    @required this.title,
    @required this.date,
    this.description,
  });
}