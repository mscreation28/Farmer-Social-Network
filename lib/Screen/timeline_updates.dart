import 'package:KrishiMitr/models/timeline_event.dart';
import 'package:KrishiMitr/network/clients/TimelineEventClient.dart';

import '../Widget/timeline_post.dart';
import '../models/dummy_data.dart';
import '../models/timeline_model.dart';
import 'package:flutter/material.dart';

class TimelineUpdate extends StatelessWidget {
  static const routeName = "TimeLineUpdate";
  List<TimelineModel> timelines = dummyTimeline;
    
  String cropName;
  int cropId; 

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
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TimelinePost(timeline: timelines[index]),            
              );
            },
            itemCount: timelines.length,
          // );
        // }
      )
    );
  }
}