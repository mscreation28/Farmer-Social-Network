import 'dart:convert';
import 'package:KrishiMitr/Utility/GroupData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screen/group_details.dart';
import '../Utility/Utils.dart';
import '../Widget/message_tile.dart';
import 'package:flutter/material.dart';
import '../models/groups.dart';
import '../models/users.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupChat extends StatefulWidget {
  static const routeName = "group-chat";
  String groupName;
  int groupId;
  TextEditingController messageController = new TextEditingController();
  List<Map<String, dynamic>> msglist = [];

  var arguments;
  Group group;

  GroupChat(this.arguments) {
    print(arguments['group']);
    group = arguments['group'];
    groupName = group.groupName;
    groupId = group.groupId;
    // print("\n\n\n");
    // print(group.groupName);
  }

  @override
  _GroupChatState createState() => _GroupChatState();
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const CustomAppBar({Key key, this.onTap, this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: appBar);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _GroupChatState extends State<GroupChat> {
  User sender;
  IO.Socket socket;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    establishConnection();
  }

  void getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sender = User.fromJson(jsonDecode(prefs.getString(Utils.USER)));
  }

  void establishConnection() async {
    try {
      socket = IO.io(Utils.BASE_URL, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      socket.onConnect((_) {
        print('connected');
        socket.emit(
            'joinChannel',
            jsonEncode(<String,dynamic>
              {
                "userId": sender.userId,
                "userName": sender.userName,
                "groupId": widget.group.groupId
              }
            ));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _getChatMessage() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MessageTile(
          message: widget.msglist[index]['message'],
          sender: widget.msglist[index]['sender'],
          sentbyMe: widget.msglist[index]['sentbyMe'],
          time: widget.msglist[index]['time'],
        );
      },
      itemCount: widget.msglist.length,
    );
  }

  void _sendMessage() {
    if (widget.messageController.text.isNotEmpty &&
        widget.messageController.text != "") {
      var message = {
        'sender': 'Shyam',
        'message': widget.messageController.text,
        'sentbyMe': true,
        'time': '6:40 PM'
      };
    socket.emit(
            'chatMessage',
            jsonEncode(<String,dynamic>
              {
                "userId": sender.userId,
                "userName": sender.userName,
                "groupId": widget.group.groupId,
                "message":widget.messageController.text
              }
            ));
      setState(() {
        widget.messageController.text = "";
        widget.msglist.add(message);
      });
    }
  }
  Future<void> _buildNavigation(BuildContext context, Group group) async {
    GroupData groupData = new GroupData();         
    List<User> users = await groupData.getGroupUsers(group);
    Navigator.pushNamed(
      context,
      GroupDetais.routeName,
      arguments: {
        'group':group,
        'groupUsers':users,
        'isInGroup':true,
        'currentUser':sender,
      }
    );     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
          title: Text(
            "# ${widget.groupName}",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        ),
        onTap: () {
          _buildNavigation(context, widget.group);
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
                color: Theme.of(context).scaffoldBackgroundColor,
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
                                  color: Colors.grey.shade600, width: 1.5),
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade600, width: 1.5),
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
                          _sendMessage();
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
