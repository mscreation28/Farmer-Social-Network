class Like {
  int likeId;
  int userId;
  int postId;  

  Like({
    this.likeId,
    this.postId,
    this.userId,    
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
        likeId: json['likeId'],        
        postId: json['postId'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "likeId": likeId,      
      "userId": userId,
      "postId": postId,      
    };
  }
}
