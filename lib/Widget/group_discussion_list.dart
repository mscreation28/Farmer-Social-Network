import '../Screen/group_chat.dart';
import '../models/groups.dart';
import 'package:flutter/material.dart';

class GroupDiscussionList extends StatelessWidget {  
  Future<List<Group>> getGroupList() async {
    List<Group> list = [];
    list.add(Group(groupId: 1, groupName: "Cereail"));
    list.add(Group(groupId: 2, groupName: "Pulses"));
    list.add(Group(groupId: 3, groupName: "Vegetables"));
    list.add(Group(groupId: 4, groupName: "Fruits"));    
    list.add(Group(groupId: 5, groupName: "OilSeeds"));
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
                'groupId' : groupList[i].groupId,
                'groupName' : groupList[i].groupName,
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

