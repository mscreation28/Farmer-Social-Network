import '../../models/Article.dart';

abstract class INewsClient{    
  Future<List<Article>> getNews(String keyword);
}