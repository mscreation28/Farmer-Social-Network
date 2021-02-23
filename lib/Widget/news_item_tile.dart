import 'package:KrishiMitr/Screen/news_web_view.dart';
import 'package:flutter/material.dart';

class NewsItemTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl, category;

  NewsItemTile({this.imgUrl, this.desc, this.title, this.content, this.posturl, this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          NewsWebView.routeName,
          arguments: {
            'posturl': posturl,
            'category': category
          }
        );
      },
      child: Container(
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,      
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    imgUrl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: 12,),
              Text(
                title,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                desc,
                maxLines: 2,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              )
            ],
          ),
        )    
      ),
    );
  }
}