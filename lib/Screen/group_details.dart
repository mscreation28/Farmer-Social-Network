import 'package:flutter/material.dart';

class GroupDetais extends StatelessWidget {
  static const routeName = 'group-detals';
  String groupName;
  int groupId; 

  Widget _buildImage(String imgUrl) {
    return Container(
      height: 45.0,
      width: 45.0,                                            
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,                        
        border: Border.all(
          color: Colors.grey.shade200,
          width: 0.5,
        ),                      
        image: DecorationImage(
          image:AssetImage(imgUrl),
        )
      ),                   
    );
  }
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    groupName = routeArgs['groupName'] as String;
    groupId = routeArgs['groupId'] as int;   

    return Scaffold(
      appBar: AppBar(        
        title: Text(                    
          'Group Details',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark
        ),
        // elevation: 0,
      ),
      body: Container(        
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),                
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius:1,
                    color: Colors.grey.shade200
                  )
                ]                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "# $groupName",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),                    
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600                      
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This is the group where you can discuss all $groupName related  things. You can talk to many farmers across india and take benifite of their knowledge.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade900
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),                
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius:1,
                    color: Colors.grey.shade200
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(
                    'Want to join the group ?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColorLight,                    
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,                 
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    child: Text(
                      'JOIN',
                      style: TextStyle(                        
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ]              
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),                
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius:1,
                    color: Colors.grey.shade200
                  )
                ]                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "10 Members",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),                    
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Shyam Makwana'),
                    subtitle: Text('Junagadh, Gujarat'),
                    leading: _buildImage("assets/images/farmer.png")
                  ),
                  ListTile(
                    title: Text('Shyam Makwana'),
                    subtitle: Text('Junagadh, Gujarat'),
                    leading: _buildImage("assets/images/farmer.png")
                  ),
                  ListTile(
                    title: Text('Shyam Makwana'),
                    subtitle: Text('Junagadh, Gujarat'),
                    leading: _buildImage("assets/images/farmer.png")
                  ),
                  ListTile(
                    title: Text('Shyam Makwana'),
                    subtitle: Text('Junagadh, Gujarat'),
                    leading: _buildImage("assets/images/farmer.png")
                  ),
                  ListTile(
                    title: Text('Shyam Makwana'),
                    subtitle: Text('Junagadh, Gujarat'),
                    leading: _buildImage("assets/images/farmer.png")
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}