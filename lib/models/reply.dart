class Reply{
  int replyId;
  int commentId;  
  int userId;  
  String reply;
  DateTime replyDate;

  Reply({
    this.replyId,
    this.commentId,
    this.userId,
    this.reply,
    this.replyDate
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
        replyId: json['replyId'],
        replyDate: DateTime.parse(json['replyDate']),
        reply: json['reply'],
        commentId: json['commentId'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson(){
    return {
      "replyId": replyId,
      "reply": reply,
      "commentId": commentId,
      "replyDate": replyDate.toIso8601String(),
      "userId": userId
    };
  }
}