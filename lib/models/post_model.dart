import 'package:intl/intl.dart';

class PostModel {
  int postId;
  int userId;  
  DateTime postDate = new DateTime.now();
  String postDecription;
  String title;
  int likeCount;
  int isUserCrop;  

  PostModel({
    this.postId,
    this.postDecription,
    this.postDate,
    this.likeCount,
    this.title,
    this.isUserCrop,
    this.userId,    
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json['postId'],
        postDecription: json['postDecription'],
        likeCount: json['likeCount'],
        title: json['title'],
        isUserCrop: json['isUserCrop'],
        postDate: DateFormat('yyyy-M-d').parse((json['postDate'])),        
        userId: json['userId']);
  }  
}
