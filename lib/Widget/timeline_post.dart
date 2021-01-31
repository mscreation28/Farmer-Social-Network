import '../Screen/profile_page.dart';
import '../Screen/timline_comment_page.dart';
import '../Utility/Utils.dart';
import '../models/like.dart';
import '../models/post_model.dart';
import '../models/users.dart';
import '../network/clients/LikeClient.dart';
import '../network/clients/UserClient.dart';
import '../Screen/visitor_profile_page.dart';
import 'package:flutter/material.dart';

class BuildPost extends StatelessWidget {
  PostModel post;
  User user;
  User loginUser;
  BuildPost({this.post, this.user, this.loginUser});

  @override
  Widget build(BuildContext context) {
    final DateTime date = post.postDate;    
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

    return InkWell(
      onTap: () {
        loginUser.userId == post.userId 
          ? Navigator.pushNamed(context, ProfilePage.routeName
          )
          : Navigator.pushNamed(context, VisitorProfilePage.routeName,
              arguments: {'userId': post.userId});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.isUserCrop==1 
              ? "Congratulate ${user.userName} for soweing a new crop.."
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
                          image: NetworkImage('${Utils.BASE_URL}uploads/${user.userProfileUrl}'),
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
      ),
    );
  }
}
class TimelinePost extends StatefulWidget {
  PostModel post;
  User loginUser;

  TimelinePost({this.post, this.loginUser}); 

  @override
  _TimelinePostState createState() => _TimelinePostState();
}

class _TimelinePostState extends State<TimelinePost> {
  int likeid;  

  Future<User> getUserDetails() async {
    UserClient userClient = new UserClient();    
    return await userClient.getSpecificUser(widget.post.userId);
  }

  Future<int> getLikeDetails() async {
    LikeClient likeClient = new LikeClient();

    List<Like> likes = await likeClient.getAllLike(widget.post.postId);
    likeid = likes.isEmpty ? -1 : likes.firstWhere((element) => element.userId == widget.loginUser.userId).likeId;
    return likeid;
  }

  void addComment(BuildContext context) {
    Navigator.pushNamed(
      context,
      TimelineCommentPage.routeName,
      arguments: {
        'post' : widget.post,
        'loginuser' : widget.loginUser,
        'refresh' : refresh
      }
    );
  } 

  void addLike() async {
    LikeClient likeClient = new LikeClient();
    Like like = new Like();
    like.postId = widget.post.postId;
    like.userId = widget.loginUser.userId;
    print(like);        
    await likeClient.addLike(like);
    setState(() {
      getLikeDetails();
      widget.post.likeCount+=1;
    });
  }

  void removeLike(int likeid) async {
    LikeClient likeClient = new LikeClient();    
    await likeClient.deleteLike(likeid,widget.post.postId);
    setState(() {
      getLikeDetails();
      widget.post.likeCount-=1;
    });
  }

  void refresh(int add) {
    setState(() {
      widget.post.likeCount+=add;      
      getLikeDetails();
    });
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
                ? BuildPost(post: widget.post, user: snapshot.data, loginUser: widget.loginUser)
                  : CircularProgressIndicator();
            },
          )
          ,
          Divider(),
          Row(
            children: [
              FutureBuilder(
                future: getLikeDetails(),
                builder: (context, snapshot) {
                  return (snapshot.hasData && snapshot.data!=-1)  
                    ? IconButton(
                      padding: EdgeInsets.all(3),  
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.favorite),
                      onPressed: () {                  
                        removeLike(snapshot.data as int);
                      },
                      color: Theme.of(context).primaryColor
                    )
                      : IconButton(
                      padding: EdgeInsets.all(3),  
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.favorite_outline),                            
                      onPressed: () {                  
                        addLike();
                      },
                      color: Colors.grey.shade700,
                    );  
                }              
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