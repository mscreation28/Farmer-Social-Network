import 'package:flutter/foundation.dart';

class UserCrop{
  final String id;
  final String name;  
  final String variety;
  final String taluka;
  final String district;
  final String state;
  final int area;

  final DateTime date;
  

  const UserCrop({
    @required this.id,
    @required this.variety,
    @required this.taluka,
    @required this.district,
    @required this.state,
    @required this.date,
    @required this.area,
    @required this.name,
  });
}