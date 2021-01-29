import 'package:KrishiMitr/Widget/timeline_post.dart';
import 'package:KrishiMitr/models/comment.dart';
import 'package:KrishiMitr/models/post_model.dart';
import 'package:KrishiMitr/models/reply.dart';
import 'package:KrishiMitr/models/timeline_model.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/CommentClient.dart';
import 'package:KrishiMitr/network/clients/ReplyClient.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:KrishiMitr/network/clients/Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineCommentPage extends StatefulWidget {
  static const routeName = 'tmeline-comment-page';
  PostModel post;
  User user;
  int postId;  
  TextEditingController commentController;

  @override
  _TimelineCommentPageState createState() => _TimelineCommentPageState();
}

class _TimelineCommentPageState extends State<TimelineCommentPage> {  
  
  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    widget.post = routArgs['post'] as PostModel;
    widget.user = routArgs['user'] as User;
    widget.postId = widget.post.postId;
    widget.commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark
          ),                    
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
      ),
      body: SingleChildScrollView(
        child: Container(       
          color: Colors.white, 
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildPost(post: widget.post, user: widget.user,),
              Divider(),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(3),  
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.favorite_outline),
                    onPressed: () {},           
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
                ],
              ),
              SizedBox(height: 7,),
              isReply 
                    ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColorLight.withOpacity(0.5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Replying to @$replyCommentName',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,                              
                            ),
                          ),
                          IconButton(
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                isReply = false;
                              });
                              replyCommentName = "";
                              replyCommentId = null;
                            }
                          )
                        ],
                      )
                    ) : SizedBox(width: 0,),
              Row(
                children: [
                  // Container(
                  //   height: 50.0,
                  //   width: 50.0,
                  //   padding: EdgeInsets.all(8),                      
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     shape: BoxShape.circle,                        
                  //     border: Border.all(
                  //       color: Colors.grey.shade200,
                  //       width: 0.5,
                  //     ),                      
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/images/farmer.png"),
                  //     )
                  //   ),                   
                  // ),                  
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(                                                  
                    child: TextField( 
                      controller: widget.commentController, 
                      style: TextStyle(
                        height: 1,                      
                      ),                                     
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Comment..',
                        hintText: 'Add a comment...',
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
                    // color: Theme.of(context).primaryColorLight,
                    height: 45,
                    width: 45,                                      
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,                        
                      // border: Border.all(
                      //   color: Theme.of(contexrt).primaryColorDark,
                      //   width: 1.5,
                      // ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send_sharp,
                        // color: Colors.grey.shade700,
                        color: Theme.of(context).primaryColorDark,
                      ), 
                      onPressed: () {
                        addNewComment();
                      },                
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Comments ↓',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder(            
                future: getAllComments(widget.postId),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? getCommentWidget(snapshot.data as List<Comment>)
                        : CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  static int userId;
  bool isLoggedIn = false;
  Comment comment = new Comment();
  Reply reply = new Reply();
  CommentClient commentClient = new CommentClient();
  UserClient userClient= new UserClient();
  ReplyClient replyClient = new ReplyClient();
  bool isReply=false;
  int replyCommentId;
  String replyCommentName;

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
        userId = userIdData;
      });
      return;
    }
  }

  Future<List<Comment>> getAllComments(int postId) async {    
    List<Comment> commentList = await commentClient.getAllComment(postId);
    print(commentList);
    return commentList;
  }

  Future<String> getUserName(int userId) async {    
    User user = await userClient.getSpecificUser(userId);    
    return user.userName;  
  }

  void addNewComment() async {
    String inputText = widget.commentController.text;    
    if(isReply)    
      addNewReply(replyCommentId,inputText);    
    else
    {
      comment.commentDate = DateTime.now();
      comment.userId = userId;
      comment.postId = widget.postId;
      comment.comment = widget.commentController.text;
      widget.commentController.clear();
      await commentClient.addComment(comment);
    }
  }

  Widget getCommentWidget(List<Comment> commentList) {
    List<Widget> list = [];
    for (var i = 0; i < commentList.length; i++) {
      list.add(commentsLayout(commentList[i]));
      list.add(SizedBox(height: 10,));
    }
    return new Column(      
      children: list
    );
  }
  
  Widget commentsLayout(Comment comment) {
    return FutureBuilder(
      future: getUserName(comment.userId),
      builder: (context, snapshot) {
        return snapshot.hasData 
        ? commentWidget(snapshot.data as String, comment)
          : CircularProgressIndicator();
      }                  
    );
  }

  Widget commentWidget(String uname, Comment comment) {    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,      
      children: [
        Container(
          height: 40.0,
          width: 40.0,
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
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width-140,
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5), topRight: Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uname,
                    // getUserName(comment.userId),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    comment.comment
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: FlatButton( 
                height: 0,    
                minWidth: 0,            
                onPressed: () {
                  replyCommentId=comment.commentId;                  
                  replyCommentName=uname;
                  setState(() {
                    isReply = true;
                  });                  
                },
                materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
                child: Text('Reply')
              ),
            ),
            //future builder 
            FutureBuilder(
              future: getAllReply(comment.commentId),
              builder: (context, snapshot) {
                return snapshot.hasData
                  ? getReplyWidget(snapshot.data as List<Reply>)
                    : CircularProgressIndicator();
              },
            )
          ],
        )
      ],
    );
  }

  Widget getReplyWidget(List<Reply> replyList) {
    List<Widget> list = [];
    for (var i = 0; i < replyList.length; i++) {
      list.add(replyLayout(replyList[i]));
      list.add(SizedBox(height: 10,));
    }
    return new Column(      
      children: list
    );
  }
  void addNewReply(int commentid, String replyText) async {
    reply.commentId = commentid;
    reply.reply = replyText;
    reply.replyDate = DateTime.now();
    reply.userId = userId;
    widget.commentController.text="";
    await replyClient.addReply(reply);
    setState(() {
      isReply=false;
    });
  }

  Widget replyLayout(Reply reply) {
    return FutureBuilder(
      future: getUserName(reply.userId),
      builder: (context, snapshot) {
        return snapshot.hasData 
        ? replyWidget(snapshot.data as String, reply.reply)
          : CircularProgressIndicator();
      }                  
    );
  }

  Future<List<Reply>> getAllReply(int commentId) async {
    List<Reply> replyList = await replyClient.getAllReply(commentId);
    print(commentId);
    print(replyList);
    return replyList;
  }

  Widget replyWidget(String uname, String reply) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,                    
      children: [
        Container(
          height: 40.0,
          width: 40.0,
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
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width-140,
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5), topRight: Radius.circular(5))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uname,
                    // getUserName(reply.userId),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    reply
                  )
                ],
              ),
            ),
          ]
        ),
      ]
    );
  }  
}