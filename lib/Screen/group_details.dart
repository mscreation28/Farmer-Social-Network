import './group_chat.dart';
import '../Utility/GroupData.dart';
import '../Utility/Utils.dart';
import '../Widget/exit_group_dialog.dart';
import '../models/user_group.dart';
import '../models/users.dart';
import '../network/clients/UserGroupClient.dart';
import 'package:flutter/material.dart';
import '../models/groups.dart';

class GroupDetais extends StatelessWidget {
  static const routeName = 'group-detals';
  Group group;
  List<User> groupUserList;
  bool isInGroup;
  User currentUser;

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
          image:NetworkImage('${Utils.BASE_URL}uploads/${imgUrl}'),
        )
      ),                   
    );
  }
  Widget _buildGroupUserList(BuildContext context){    
    List<Widget> list = [];     
    for(int i=0;i<groupUserList.length;i++) {
      list.add(
        ListTile(
          title: Text(groupUserList[i].userName),
          subtitle: Text('${groupUserList[i].userCity}, ${groupUserList[i].userState}'),
          leading: _buildImage(groupUserList[i].userProfileUrl)
        )
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: list      
    );
  }
  void _joinGroup(BuildContext context) {
    UserGroupClient userGroupClient = new UserGroupClient();
    UserGroup u = new UserGroup();
    u.groupId = group.groupId;
    u.userId = currentUser.userId;
    userGroupClient.addGroupUser(u).then((value) {
      Navigator.popAndPushNamed(
        context,
        GroupChat.routeName,
        arguments: {
          'group':group,         
        }
      );
    });    
  }
  void _exitGroup() async {
    GroupData groupData = new GroupData();
    int userGroupId = await groupData.getUserGroupId(currentUser.userId, group.groupId);
    UserGroupClient userGroupClient = new UserGroupClient();
    userGroupClient.deleteGroupUser(userGroupId).then((value) {
      print("deleted successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    group =  routeArgs['group'] as Group;
    groupUserList = routeArgs['groupUsers'] as List<User>;
    isInGroup = routeArgs['isInGroup'] as bool;
    currentUser = routeArgs['currentUser'] as User;
    
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
                    "# ${group.groupName}",
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
                    "${group.groupDescription}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade900
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            !isInGroup ? Container(
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
                    onPressed: () {
                      _joinGroup(context);
                    },
                    child: Text(
                      'JOIN',
                      style: TextStyle(                        
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ]              
              ),
            ) : SizedBox(),
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
                      "${groupUserList.length} Members",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),                    
                    ),
                  ),
                  groupUserList.length!=0 ? Divider() : SizedBox(height: 15,),
                  _buildGroupUserList(context),
                ],
              ),
            ),
            SizedBox(height: 10),
            isInGroup ? InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return ExitGroupDialog(exitGroup: _exitGroup,);
                },
              ),             
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  children:[
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(width: 15,),
                    Text(
                      'Exit group ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red
                      ),
                    ),
                  ]              
                ),
              ),
            ) : SizedBox(),
          ],
        ),
      )
    );
  }
}