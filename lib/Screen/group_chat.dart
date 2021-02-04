import '../Screen/group_details.dart';
import '../Widget/message_tile.dart';
import 'package:flutter/material.dart';

class GroupChat extends StatefulWidget {
  static const routeName = "group-chat";
  String groupName;
  int groupId; 
  TextEditingController messageController;
  @override
  _GroupChatState createState() => _GroupChatState();
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const CustomAppBar({Key key, this.onTap,this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(onTap: onTap,child: appBar);
  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _GroupChatState extends State<GroupChat> {    
  
  Widget _getChatMessage() {
    List<Map<String,dynamic>> msglist = [];
    msglist.add({'sender':'Shyam', 'message':'hello ','sentbyMe':true, 'time':'6:40 PM'});
    msglist.add({'sender':'Shyam', 'message':'hello how are you?','sentbyMe':false, 'time':'6:40 PM'});
    msglist.add({'sender':'Shyam', 'message':'hello tesing a long message to check how it looks I hope it loooks better then my I hope, let\s make it more longer','sentbyMe':true, 'time':'6:40 PM'});
    msglist.add({'sender':'Shyam', 'message':'hello tesing a long message to check how it looks I hope it loooks better then my I hope.','sentbyMe':false, 'time':'6:40 PM'});
    msglist.add({'sender':'Shyam', 'message':'hi','sentbyMe':true, 'time':'6:40 PM'});
    return ListView.builder(
      itemBuilder: (context, index) {
        return MessageTile(
          message: msglist[index]['message'],
          sender: msglist[index]['sender'],
          sentbyMe: msglist[index]['sentbyMe'],
          time: msglist[index]['time'],
        );
      },
      itemCount: msglist.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    widget.groupName = routeArgs['groupName'] as String;
    widget.groupId = routeArgs['groupId'] as int;

    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
          title: Text(
            "# ${widget.groupName}",
            style: TextStyle(
              color: Theme.of(context).primaryColorDark
            ),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorDark
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            GroupDetais.routeName,
            arguments: {
              'groupName': widget.groupName,
              'groupId': widget.groupId
            }
          );
        },
      ),
      body: Container(
        child: Stack(
          children: [
            _getChatMessage(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,              
              child: Container(
                color:  Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.all(7),
                child: Row(
                  children: [                                  
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(                                                  
                      child: TextField(  
                        controller: widget.messageController,
                        style: TextStyle(
                          height: 1,                      
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Message..',
                          hintText: 'Send a message...',
                          enabledBorder: OutlineInputBorder(                        
                            borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.5
                            ),  
                            borderRadius: BorderRadius.circular(25)                     
                          ),
                          focusedBorder: OutlineInputBorder(                        
                            borderSide: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1.5
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          // prefixIcon: Icon(Icons.comment_outlined)                      
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(                    
                      height: 45,
                      width: 45,                                      
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        shape: BoxShape.circle,                                              
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_sharp,                        
                          color: Theme.of(context).primaryColorDark,
                        ), 
                        onPressed: () {
                          
                        },                
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}