import 'package:KrishiMitr/models/timeline_event.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/TimelineEventClient.dart';
import 'package:KrishiMitr/page/edit_timeline_event.dart';

import '../models/timeline_model.dart';
import '../models/user_crops.dart';
import '../page/new_timeline_event.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class VisitorTimelineActivity extends StatefulWidget {
  static const routeName = './Visitor-timeline-activity';
  String usercropId;
  UserCrop userCrop;
  @override
  _VisitorTimelineActivityState createState() => _VisitorTimelineActivityState();
}

class _VisitorTimelineActivityState extends State<VisitorTimelineActivity> {  

  void editActivity(TimelineEvent timeline,BuildContext cntx) {
    Navigator.pushNamed(
      cntx,
      EditTimelineEvent.routeName,
      arguments: {
        'timeline' :timeline,
        'refresh' :refresh,
      }
    );
  }

  TimelineTile _buildTimelineTile(
      TimelineEvent timelineEvent, List<TimelineEvent> timelineList) {
    final DateTime date = timelineEvent.timelineDate;
    final String formattedDate = DateFormat("dd MMMM, yyyy").format(date);
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      beforeLineStyle: LineStyle(color: Colors.grey.shade300),
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
      isLast: timelineList.last == timelineEvent,
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
                    timelineEvent.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Container(
                  //   child: IconButton(
                  //       icon: Icon(Icons.edit),
                  //       padding: EdgeInsets.all(0),
                  //       constraints: BoxConstraints(),
                  //       onPressed: () {
                  //         editActivity(timelineEvent, context);
                  //       }),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timelineEvent.description != null
                  ? timelineEvent.description
                  : "none",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${_difference ~/ 30} Months  ${_difference % 30} days",
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

  Widget headTile(List<TimelineEvent> timelineList) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      isFirst: true,
      isLast: timelineList.length <= 0,
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
                  widget.userCrop.cropName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "   ( ${widget.userCrop.breed} )",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.userCrop.croptaluka}, ${widget.userCrop.cropCity}, ${widget.userCrop.cropState}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Area - ${widget.userCrop.area} Vigha',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {
      getCropTimelines(widget.userCrop.userCropId);
    });
  }

  Future<List<TimelineEvent>> getCropTimelines(int userCropId) async
  {
    TimelineEventClient timelineEventClient = new TimelineEventClient();
   List<TimelineEvent> timlineEventList = await timelineEventClient.getAllTimelineEvents(userCropId);
   timlineEventList.sort((timeline1,timeline2){
     return timeline2.timelineDate.compareTo(timeline1.timelineDate);
   });
   return timlineEventList;
  }

  Widget _getTimeline(List<TimelineEvent> timelineList) {
    List<Widget> list = [];
    list.add(headTile(timelineList));
    for (var i = 0; i < timelineList.length; i++) {
      list.add(_buildTimelineTile(timelineList[i], timelineList));
    }
    return ListView(children: list);
  }

  @override
  Widget build(BuildContext context) {
    final routArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    widget.userCrop = routArgs['userCrop'] as UserCrop;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TimeLine Activity',
          style: GoogleFonts.lato(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15),
        child: FutureBuilder(
          future: getCropTimelines(widget.userCrop.userCropId),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? _getTimeline(snapshot.data as List<TimelineEvent>)
                : CircularProgressIndicator();
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, NewTimelineEvent.routeName,arguments: {
      //        'userCrop': widget.userCrop,
      //        'refresh': refresh,
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
