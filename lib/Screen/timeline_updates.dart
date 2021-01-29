import 'package:KrishiMitr/models/post_model.dart';
import 'package:KrishiMitr/models/timeline_event.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/PostCliet.dart';
import 'package:KrishiMitr/network/clients/TimelineEventClient.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widget/timeline_post.dart';
import '../models/dummy_data.dart';
import '../models/timeline_model.dart';
import 'package:flutter/material.dart';

class TimelineUpdate extends StatefulWidget {
  static const routeName = "TimeLineUpdate";  

  @override
  _TimelineUpdateState createState() => _TimelineUpdateState();
}

class _TimelineUpdateState extends State<TimelineUpdate> {
  List<TimelineModel> timelines = dummyTimeline;
  bool isLoggedIn = false;
  String cropName;
  int userId;
  int cropId; 
  User loginUser;
  PostClient postClient = new PostClient();  

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userIdData =  prefs.getInt(Utils.USER_ID);

    if (userIdData != null) {
      setState(() {
        isLoggedIn = true;
        userId= userIdData;
      });
      return;
    }
  }

  Future<User> getLoggedInUser() async {
    IUserClient userClient = new UserClient();
    return await userClient.getSpecificUser(userId);
  }

  Future<User> getUserDetail(int userpostId) async {
    IUserClient userClient = new UserClient();
    return await userClient.getSpecificUser(userpostId);
  }

  Future<List<PostModel>> getAllPostOnCrop() async {
    loginUser = await getLoggedInUser();
    List<PostModel> postList =
        await postClient.getAllPostOnCrop(cropId);
    postList.sort((p1,p2){
      return p2.postDate.compareTo(p1.postDate);
    });
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    cropName = routeArgs['cropname'] as String;
    cropId = routeArgs['cropid'] as int;

    timelines.sort((a, b) => a.date.compareTo(b.date));
    return Scaffold( 
      appBar: AppBar(
        title: Text(
          "# $cropName",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark
          ),          
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark
        ),
        backgroundColor: Theme.of(context).primaryColorLight,        
      ),     
      // body: FutureBuilder (
      //    : ,
      //   builder : (ctx, snapshot) {
      body: FutureBuilder(
        future: getAllPostOnCrop(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TimelinePost(post: snapshot.data[index] as PostModel, loginUser: loginUser),
                );
              },
              itemCount: snapshot.data.length,
            )
              : CircularProgressIndicator();
        },
      )
      
      // ListView.builder(
      //   itemBuilder: (context, index) {
      //     return Card(
      //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //       child: TimelinePost(timeline: timelines[index]),            
      //     );
      //   },
      //   itemCount: timelines.length,
          // );
        // }
      // )
    );
  }
}