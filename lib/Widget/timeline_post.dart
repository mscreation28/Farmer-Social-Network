import 'package:KrishiMitr/Screen/timline_comment_page.dart';
import 'package:KrishiMitr/models/dummy_data.dart';
import 'package:KrishiMitr/models/like.dart';
import 'package:KrishiMitr/models/post_model.dart';
import 'package:KrishiMitr/models/timeline_model.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/LikeClient.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:flutter/material.dart';

class BuildPost extends StatelessWidget {
  PostModel post;
  User user;
  BuildPost({this.post, this.user});

  String getCropname(String id) {
    return dummyCrop.firstWhere((element) => element.id==id).name;
  }
  
  @override
  Widget build(BuildContext context) {
    final DateTime date = post.postDate;    
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.isUserCrop==1 
            ? "Congratulate ${user.userName} fro soweing a new crop.."
              : "${user.userName}'s Timeline updated..",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 0.5
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    padding: EdgeInsets.all(8),                      
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,                        
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),                      
                      image: DecorationImage(
                        image: AssetImage("assets/images/farmer.png"),
                      )
                    ),                   
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          '${user.userName}',
                          style: TextStyle(                          
                            fontSize: 17,
                            fontWeight: FontWeight.bold, 
                            height: 0.8,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      FittedBox(                          
                        child: Text(
                          '${user.userCity}, ${user.userState}',
                          style: TextStyle(                          
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        " ${_difference~/30} Months  ${_difference%30} days",
                        style: TextStyle(
                          fontSize: 13,                
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ]
                  )
                ],
              ),
              SizedBox(
                // height: 10,
                width: MediaQuery.of(context).size.width *0.5,
                child: Divider(                                        
                  // thickness: 1.5,                 
                ),
              ),
              Text(
                post.isUserCrop==1 
                  ? 'Wheat (${post.title})'
                    : post.title,
                style: TextStyle(
                  fontSize: 17,   
                  fontWeight: FontWeight.bold            
                ),
              ),
              SizedBox(height: 4,),
              Text(
                post.postDecription!=null ? post.postDecription : "-",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,               
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ), 
        SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.favorite,
                  size: 19,
                  color: Theme.of(context).primaryColor,
                )
              ),
              WidgetSpan(child: SizedBox(width: 10,)),
              TextSpan(
                text: '${post.likeCount} Like',
                style: TextStyle(                      
                  fontSize: 15,            
                  color: Theme.of(context).primaryColorDark,          
                  fontWeight: FontWeight.bold                          
                ),
              )
            ]
          ),
        ),
      ],
    );
  }
}
class TimelinePost extends StatelessWidget {
  PostModel post;
  User loginUser;
  TimelinePost({this.post, this.loginUser}); 

  Future<User> getUserDetails() async {
    UserClient userClient = new UserClient();
    return await userClient.getSpecificUser(post.userId);
  }

  void addComment(BuildContext context) {
    Navigator.pushNamed(
      context,
      TimelineCommentPage.routeName,
      arguments: {
        'post' : post,
        'loginuser' : loginUser,
      }
    );
  } 

  void addLike() async {
    LikeClient likeClient = new LikeClient();
    Like like;
    like.postId = post.postId;
    like.userId = loginUser.userId;
    print(like);
    await likeClient.addLike(like);
  }

  @override
  Widget build(BuildContext context) {    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: Column(
        children: [
          FutureBuilder(
            future: getUserDetails(),
            builder: (context, snapshot) {
              return snapshot.hasData
                ? BuildPost(post: post, user: snapshot.data,)
                  : CircularProgressIndicator();
            },
          )
          ,
          Divider(),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(3),  
                constraints: BoxConstraints(),
                icon: Icon(Icons.favorite_outline),
                onPressed: () {
                  addLike();
                },           
                color: Colors.grey.shade700,       
              ),
              SizedBox(width: 5,),
              Text(
                'Like',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700
                ),
              ),
              SizedBox(width: 20,),
              IconButton(
                padding: EdgeInsets.all(3),  
                constraints: BoxConstraints(),
                icon: Icon(Icons.comment_outlined),
                onPressed: () {
                  addComment(context);
                },           
                color: Colors.grey.shade700,       
              ),
              SizedBox(width: 5,),
              Text(
                'Comment',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}