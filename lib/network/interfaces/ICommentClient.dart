import 'package:KrishiMitr/models/comment.dart';

abstract class ICommentClient{
  Future<List<Comment>> getAllComment(int postId);   
  void addComment(Comment userCrop);
}