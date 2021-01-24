import 'package:flutter/foundation.dart';

class User{
  final int userId;
  final String userName;
  final String userCity;
  final String userState;
  final String userContactNumber;
  final String userProfileUrl;
  final String userType;

  User({@required this.userId,@required this.userName,@required this.userContactNumber,@required this.userCity,@required this.userState, this.userProfileUrl,@required this.userType});
  
  factory User.fromJson(Map<String,dynamic> json){
    return User(
      userId: json['userId'], 
      userName: json['userName'], 
      userContactNumber: json['userContactNumber'], 
      userCity: json['userCity'],
      userState: json['userState'],
      userProfileUrl: json['userProfileUrl'], 
     userType: json['userType'],
    );  
  }
  
  
}