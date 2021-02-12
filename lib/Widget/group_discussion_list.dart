import 'package:KrishiMitr/network/clients/GroupClient.dart';

import '../Screen/group_chat.dart';
import '../models/groups.dart';
import 'package:flutter/material.dart';

class GroupDiscussionList extends StatelessWidget {  
  Future<List<Group>> getGroupList() async {
    GroupClient groupClient = new GroupClient();
    List<Group> list = await groupClient.getAllGroups();
    return list;
  }
  Widget _buildGroupList(BuildContext context, List<Group> groupList) {

    List<Widget> list = [];
    for (var i = 0; i < groupList.length; i++) {      
      list.add(
        FlatButton( 
          padding: EdgeInsets.symmetric(horizontal: 5),        
          onPressed: () {
            Navigator.pushNamed(
              context,
              GroupChat.routeName,
              arguments: {
                'group':groupList[i]
              }
            );
          },
          materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '# ${groupList[i].groupName}',
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
            'Group Dicussion',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,  
              color: Theme.of(context).primaryColorDark
            )
          ),
          Divider(thickness: 1.5,),
          FutureBuilder(        
            future: getGroupList(),
            builder: (context, snapshot) {
              return snapshot.hasData 
                ? _buildGroupList(context, snapshot.data as List<Group>)
                  : CircularProgressIndicator();
            },                        
          )          
        ]
      ),      
    );
  }  
}

