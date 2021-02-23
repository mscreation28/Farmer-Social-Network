import 'package:flutter/material.dart';

class ExitGroupDialog extends StatelessWidget {
  final Function exitGroup;
  ExitGroupDialog({this.exitGroup});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure..??"),
      content: Text(
          'Would you exit from this group?'),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(          
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            // Navigator.pop(context);
            exitGroup();
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 3);
          },
        )
      ],
    );
  }
}
