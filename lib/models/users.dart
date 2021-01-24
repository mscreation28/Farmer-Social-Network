import 'package:flutter/foundation.dart';

class User{
   int userId;
   String userName;
   String userCity;
   String userState;
   String userContactNumber;
   String userProfileUrl;
   String userType;
   String userpassword;

  User({@required this.userpassword, @required this.userId,@required this.userName,@required this.userContactNumber,@required this.userCity,@required this.userState, this.userProfileUrl,@required this.userType});
  
  factory User.fromJson(Map<String,dynamic> json){
    return User(
      userId: json['userId'], 
      userName: json['userName'], 
      userContactNumber: json['userContactNumber'], 
      userCity: json['userCity'],
      userState: json['userState'],
      userProfileUrl: json['userProfileUrl'], 
     userType: json['userType'],
     userpassword: json['userPassword'],
    );  
  }

  Map<String, String> toJson(){
    return {
      'userId': userId.toString(), 
      'userName': userName, 
      'userContactNumber':userContactNumber, 
      'userCity': userCity,
      'userState': userState,
      'userProfileUrl': userProfileUrl, 
      'userType': userType,
      'userpassword': userpassword
    };
  }
  
  
}