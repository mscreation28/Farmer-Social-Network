import 'dart:async';
import 'dart:convert';
import 'package:KrishiMitr/Utility/GroupData.dart';

import 'package:KrishiMitr/Utility/StreamSocket.dart';
import 'package:KrishiMitr/models/Message.dart';
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
  IO.Socket socket;

  GroupChat(this.arguments) {
    // print(arguments['group']);
    group = arguments['group'];
    socket = arguments['socket'];
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
  StreamSocket streamSocket = StreamSocket();
  User sender;
  List<Message> messageList;

  
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessagesFromDb();
    listenForNewMessage();
  }

  void listenForNewMessage(){
        widget.socket.on('message', (data) {
        print("here");
        print(data);
        var json = jsonDecode(data);

        Message message = Message.fromJson(json);
        message.sentByMe = false;

        setState(() {
          
        });
        
    });
  }

  void getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sender = User.fromJson(jsonDecode(prefs.getString(Utils.USER)));
    messageList =
        await new Message().getMessages(widget.group.groupId, sender.userId);
  }

  Widget _getChatMessage(List<Message> messageList) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return index != messageList.length - 1
              ? MessageTile(messageList[index])
              : Column(
                  children: [
                    MessageTile(messageList[index]),
                    SizedBox(
                      height: 60,
                    )
                  ],
                );
        },
        itemCount: messageList.length,
      ),
    );
  }

  void _sendMessage() {
    if (widget.messageController.text.isNotEmpty &&
        widget.messageController.text != "") {
      Message message = new Message(
        message: widget.messageController.text,
        userId: sender.userId,
        userName: sender.userName,
        groupId: widget.group.groupId,
        sentByMe: true,
        messageTime: DateTime.now(),
      );
      widget.messageController.text = "";
      widget.socket.emit(
        'chatMessage',
        jsonEncode(message.toJson()),
      );

      setState(() {
        message.storeMessage(message);
      });
        
        // streamSocket.addResponse(message);
    
    }
  }

  Future<void> _buildNavigation(BuildContext context, Group group) async {
    GroupData groupData = new GroupData();
    List<User> users = await groupData.getGroupUsers(group);
    Navigator.pushNamed(context, GroupDetais.routeName, arguments: {
      'group': group,
      'groupUsers': users,
      'isInGroup': true,
      'currentUser': sender,
    });
  }

  Future<List<Message>> getMessagesFromDb() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sender = User.fromJson(jsonDecode(prefs.getString(Utils.USER)));
    return await new Message().getMessages(widget.group.groupId, sender.userId);
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
            FutureBuilder(
              future: getMessagesFromDb(),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? _getChatMessage(snapshot.data as List<Message>)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
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
