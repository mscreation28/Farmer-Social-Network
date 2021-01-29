import 'package:KrishiMitr/models/like.dart';

abstract class ILikeClient{  
  void deleteLike(int likeId);  
  void addLike(Like like);
}