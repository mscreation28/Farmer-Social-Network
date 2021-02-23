import '../interfaces/INewsClient.dart';
import 'package:http/http.dart' as http;
import '../../models/Article.dart';
import 'dart:convert';
import '../../Utility/Utils.dart';

class NewsClient implements INewsClient {  

  Future<List<Article>> getNews(String keyword) async{
    print(keyword);
    List<Article> news  = [];
    String url = "http://newsapi.org/v2/everything?q=${keyword}&apiKey=${Utils.API_KEY}";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
    return news;
  }
}