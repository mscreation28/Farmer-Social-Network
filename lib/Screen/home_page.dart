import 'dart:convert';

import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/Widget/news_list.dart';
import 'package:KrishiMitr/models/Message.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widget/group_discussion_list.dart';
import '../Widget/timeline_update_list.dart';
import '../Widget/titleText.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyCustomClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    return RRect.fromLTRBR(50, 0, 0, 0, Radius.zero);
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => false;
}

class _HomePageState extends State<HomePage> {
  List<Map<String, Object>> _pages;
  List<Map<String, Object>> _iconlist;
  IO.Socket socket;

  int _selectedPageIndex = 0;
  void initState() {
    establishConnection();
    _pages = [
      {'page': TimelineUpdateList()},
      {'page': NewsList()},
    ];
    _iconlist = [
      {'title': 'Timeline Update', 'icon': 'assets/images/wheat.png'},
      {'title': 'Group Discussion', 'icon': 'assets/images/farmer_group.png'},
      {'title': 'News', 'icon': 'assets/images/farmer.png'}
    ];
    super.initState();
  }

  Future<void> establishConnection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final User user = User.fromJson(jsonDecode(prefs.getString(Utils.USER)));

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
            jsonEncode(<String, dynamic>{
              "userId": user.userId,
              "userName": user.userName,
            }));
      });
    
      socket.on('message', (data) {
        print(data);
        var json = jsonDecode(data);

        Message message = Message.fromJson(json);
        message.sentByMe = false;
         setState(() {
            message.storeMessage(message);
         });
        
      });
      _pages.add({'page': GroupDiscussionList(socket)});
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildIcon(String imgr, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: isSelected ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isSelected ? BorderRadius.circular(20) : null,
          // shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
          image: DecorationImage(
            image: AssetImage(imgr),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TitleText(
            color1: Theme.of(context).primaryColorDark,
            color2: Theme.of(context).accentColor),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorLight
            ],
          )),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Row(
        // fit: StackFit.loose,
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(
                              width: 0,
                            ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedPageIndex = index;
                            print(index);
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              width: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5)),
                                color: index == _selectedPageIndex
                                    ? Colors.white
                                    : Theme.of(context).primaryColorLight,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                                // color: Theme.of(context).primaryColor,
                                margin: EdgeInsets.symmetric(vertical: 2.5),
                                padding: EdgeInsets.only(
                                    right: 15, left: 8, top: 5, bottom: 5),
                                width: 80,
                                height: 70,
                                child: _buildIcon(_iconlist[index]['icon'],
                                    index == _selectedPageIndex)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                // separatorBuilder: (context, index) {
                //   // return SizedBox(
                //   //   height: 10,
                //   // );
                // },
                itemCount: _iconlist.length),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
            child: Container(
                color: Colors.white70,
                padding: EdgeInsets.all(20),
                width: width - 95,
                child: _pages[_selectedPageIndex]['page']),
          ),

          // Positioned(
          //   left: width-160,
          //   // top: 50;
          // Container(width: width, child: TimelineUpdate())
          // )
        ],
      ),
    );
  }
}
