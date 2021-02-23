import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  static const routeName = 'news-web-view';
  String postUrl;  
  String category;
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    widget.postUrl =  routeArgs['posturl'] as String;
    widget.category = routeArgs['category'] as String;
    print(widget.postUrl);
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.postUrl,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}