import '../models/post_model.dart';
import '../models/users.dart';
import '../network/clients/PostCliet.dart';
import '../network/clients/UserClient.dart';
import '../Utility/Utils.dart';
import '../network/interfaces/IUserClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/timeline_post.dart';
import 'package:flutter/material.dart';

class TimelineUpdate extends StatefulWidget {
  static const routeName = "TimeLineUpdate";  

  @override
  _TimelineUpdateState createState() => _TimelineUpdateState();
}

class _TimelineUpdateState extends State<TimelineUpdate> {  
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
    print("jdsjdhsj\n\n");    
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print(routeArgs);
    cropName = routeArgs['cropname'] as String;
    cropId = routeArgs['cropid'] as int;
    print(cropName);
    print(cropId);
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
    );
  }
}