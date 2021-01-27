import 'package:KrishiMitr/models/reply.dart';

abstract class IReplyClient{
  Future<List<Reply>> getAllReply(int commentId);   
  void addReply(Reply userCrop);
}