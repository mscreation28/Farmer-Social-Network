import '../Widget/timeline_post.dart';
import '../models/dummy_data.dart';
import '../models/timeline_model.dart';
import 'package:flutter/material.dart';

class TimelineUpdate extends StatelessWidget {
  
  List<TimelineModel> timelines = dummyTimeline;  

  @override
  Widget build(BuildContext context) {
    timelines.sort((a, b) => a.date.compareTo(b.date));
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TimelinePost(timeline: timelines[index]),            
          );
        },
        itemCount: timelines.length,
      )
    );
  }
}