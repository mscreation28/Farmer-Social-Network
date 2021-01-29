import 'package:KrishiMitr/Screen/tab_page.dart';
import 'package:KrishiMitr/Screen/timeline_activity.dart';
import 'package:flutter/material.dart';

class DeleteDialogEvent extends StatelessWidget {
  final Function deleteTimeline;
  DeleteDialogEvent({this.deleteTimeline});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure..??"),
      content: Text(
          'Would you like to delete this time line event?'),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(          
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            // Navigator.pop(context);
            deleteTimeline();
            Navigator.popUntil(context, ModalRoute.withName(TimelineActivity.routeName));
          },
        )
      ],
    );
  }
}
