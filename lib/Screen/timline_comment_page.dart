import 'package:KrishiMitr/Widget/timeline_post.dart';
import 'package:KrishiMitr/models/timeline_model.dart';
import 'package:flutter/material.dart';

class TimelineCommentPage extends StatefulWidget {
  static const routeName = 'tmeline-comment-page';
  TimelineModel timeline;

  @override
  _TimelineCommentPageState createState() => _TimelineCommentPageState();
}

class _TimelineCommentPageState extends State<TimelineCommentPage> {  

  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, TimelineModel>;
    widget.timeline = routArgs['timeline'];

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
      body: Container(       
        color: Colors.white, 
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildPost(timeline: widget.timeline,),
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
            Row(
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
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
                  width: 7,
                ),
                Expanded(                                                  
                  child: TextField(   
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
                    onPressed: () {},                
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
            )
          ],
        ),
      ),
    );
  }
}