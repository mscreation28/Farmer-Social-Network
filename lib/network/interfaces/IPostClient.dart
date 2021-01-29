import 'package:KrishiMitr/models/post_model.dart';

abstract class IPostClient{
  Future<List<PostModel>> getAllPostOnCrop(int cropId);  
}