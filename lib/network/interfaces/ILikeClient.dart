import 'package:KrishiMitr/models/like.dart';

abstract class ILikeClient{  
  void deleteLike(int likeId, int postId);  
  void addLike(Like like);
}