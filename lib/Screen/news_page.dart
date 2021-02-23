import 'package:KrishiMitr/Widget/news_item_tile.dart';
import 'package:KrishiMitr/models/Article.dart';
import 'package:KrishiMitr/network/clients/NewsClient.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {  
  static const routeName = 'news-page';
  var _isLoading; 
  List<Article> newsList;
  String category;
  var arguments;
  NewsPage(this.arguments) {
    category = arguments['category'];
  }
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  void getNewsList() async {
    NewsClient newsClient = new NewsClient();    
    print(widget.category);
    widget.newsList = await newsClient.getNews(widget.category);
    setState(() {
      widget._isLoading = false;
    });
  }
  @override
  void initState() {  
    widget._isLoading = true;
    getNewsList();
    super.initState();        
  }
  @override
  Widget build(BuildContext context) {        
    // print(widget.category);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '# ${widget.category}',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark
        ),
        backgroundColor: Theme.of(context).primaryColorLight     
      ),
      body: widget._isLoading
        ? CircularProgressIndicator()
          : Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemCount: widget.newsList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsItemTile(
                  imgUrl: widget.newsList[index].urlToImage ?? "",
                  title: widget.newsList[index].title ?? "",
                  desc: widget.newsList[index].description ?? "",
                  content: widget.newsList[index].content ?? "",
                  posturl: widget.newsList[index].articleUrl ?? "",
                  category: widget.category,
                );
              }
            ),
          )
    );
  }
}