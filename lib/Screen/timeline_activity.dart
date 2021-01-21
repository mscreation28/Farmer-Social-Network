import 'package:KrishiMitr/page/edit_timeline_event.dart';

import '../models/dummy_data.dart';
import '../models/timeline_model.dart';
import '../models/user_crop.dart';
import '../page/new_timeline_event.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TimelineActivity extends StatefulWidget { 
  static const routeName = './timeline-activity';
  List<TimelineModel> activityList;
  String usercropId;

  @override
  _TimelineActivityState createState() => _TimelineActivityState();
}

class _TimelineActivityState extends State<TimelineActivity> {  

  void editActivity(int index, BuildContext cntx) {
    Navigator.pushNamed(
      cntx,
      EditTimelineEvent.routeName,
      arguments: {
        'timelineid' : widget.activityList[index].id,        
      }
    );
  }

  TimelineTile _buildTimelineTile(int i) {
    final DateTime date = widget.activityList[i].date;
    final String formattedDate = DateFormat("dd MMMM, yyyy").format(date);
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      beforeLineStyle: LineStyle(
        color: Colors.grey.shade300
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.25,
        drawGap: true,
        width: 10,
        height: 10,  
        padding: EdgeInsets.all(6),             
        indicator: Icon(
          Icons.circle,
          size: 10,          
          color: Colors.grey.shade400,
        ),
      ),
      isLast: widget.activityList.length==i+1,
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
            formattedDate,
            style: TextStyle(
              fontSize: 14, 
              color: Colors.grey.shade700,                          
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      endChild: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [                
                  Text(
                    widget.activityList[i].title,
                    style: TextStyle(
                      fontSize: 16,                
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(                    
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      onPressed: () {
                        editActivity(i, context);
                      }
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.activityList[i].description!=null ? widget.activityList[i].description : "none",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,               
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${_difference~/30} Months  ${_difference%30} days",
              style: TextStyle(
                fontSize: 14,                
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget headTile(String id) {
    UserCrop crop = dummyCrop.firstWhere((element) => element.id == id); 
    
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      isFirst: true,
      isLast: widget.activityList.length<=0,
      indicatorStyle: IndicatorStyle(        
        width: 10,
        height: 10,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        indicator: Icon(
          Icons.circle,
          size: 15,          
          color: Theme.of(context).primaryColor,
        ),
      ),
      beforeLineStyle: LineStyle(color: Colors.grey.shade300),
      endChild: Container(        
        padding:
            const EdgeInsets.only(left: 16, right: 15, top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(          
                  crop.name,
                  style: TextStyle(
                    fontSize: 20,                         
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(          
                  "   ( ${crop.variety} )",
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w300                       
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),          
            Text(          
              '${crop.taluka}, ${crop.district}, ${crop.state}',
              style: TextStyle(
                fontSize: 16,                                      
              ),
            ),
            const SizedBox(height: 4),
            Text(          
              'Area - ${crop.area} Vigha',
              style: TextStyle(
                fontSize: 16,                                      
              ),
            ),            
          ],
        ),
      ),
    );
  }

  Widget _getTimeline(String usercropId) {
    List<Widget> list = new List<Widget>();
    list.add(headTile(usercropId));
    for(var i = 0; i < widget.activityList.length; i++){
        list.add(_buildTimelineTile(i));
    }
    return ListView(children: list);
  }

  @override
  Widget build(BuildContext context) {    
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    widget.usercropId = routArgs['usercropid'];
    widget.activityList = dummyTimeline.where((element) => element.usercropid == widget.usercropId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TimeLine Activity',
          style: GoogleFonts.lato(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
      ),
      body: Container(     
        padding: EdgeInsets.only(left: 15),                                   
        child: _getTimeline(widget.usercropId),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewTimelineEvent.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}