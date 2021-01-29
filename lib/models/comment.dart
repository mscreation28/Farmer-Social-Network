class Comment{
  int commentId;
  int postId;  
  int userId;  
  String comment;
  DateTime commentDate;

  Comment({
    this.commentId,
    this.postId,
    this.userId,
    this.comment,
    this.commentDate
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentId: json['commentId'],
        commentDate: DateTime.parse(json['commentDate']),
        comment: json['comment'],
        postId: json['postId'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson(){
    return {
      "commentId": commentId,
      "comment": comment,
      "postId": postId,
      "commentDate": commentDate.toIso8601String(),
      "userId": userId
    };
  }
}
