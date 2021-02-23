import 'package:KrishiMitr/Screen/news_page.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {  
  
  List<String> groupList = ['agriculture','farmer','fertilizer','pesticides','seed'];

  Widget _buildGroupList(BuildContext context) {    
    List<Widget> list = [];
    for (var i = 0; i < groupList.length; i++) {      
      list.add(
        FlatButton( 
          padding: EdgeInsets.symmetric(horizontal: 5),        
          onPressed: () {
            print(groupList[i]);
            Navigator.of(context).pushNamed(
              NewsPage.routeName,
              arguments: {
                'category':groupList[i]
              }
            );
          },
          materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '# ${groupList[i]}',
              style: TextStyle(
                color: Colors.grey.shade800, 
                fontWeight: FontWeight.w600,
                fontSize: 16            
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      );
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: list
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'News',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,  
              color: Theme.of(context).primaryColorDark
            )
          ),
          Divider(thickness: 1.5,),
          _buildGroupList(context)                    
        ]
      ),      
    );
  }  
}

