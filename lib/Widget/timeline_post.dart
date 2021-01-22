import 'package:KrishiMitr/models/dummy_data.dart';
import 'package:KrishiMitr/models/timeline_model.dart';
import 'package:flutter/material.dart';

class TimelinePost extends StatelessWidget {
  TimelineModel timeline;
  TimelinePost({this.timeline});
  String getCropname(String id) {
    return dummyCrop.firstWhere((element) => element.id==id).name;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = timeline.date;    
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

    return Card(          
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shyam's timeline update on ${getCropname(timeline.usercropid)}",
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
                              'Shyam Makwana',
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
                              'Junagadh, Gujarat',
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
                    timeline.title,
                    style: TextStyle(
                      fontSize: 17,   
                      fontWeight: FontWeight.bold            
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    timeline.description!=null ? timeline.description : "none",
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
                    text: '10 Like',
                    style: TextStyle(                      
                      fontSize: 15,            
                      color: Theme.of(context).primaryColorDark,          
                      fontWeight: FontWeight.bold                          
                    ),
                  )
                ]
              ),
            ),
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
                SizedBox(width: 20,),
                IconButton(
                  padding: EdgeInsets.all(3),  
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {},           
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
      ),
    );
  }
}