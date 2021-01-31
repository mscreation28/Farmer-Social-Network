import 'package:flutter/material.dart';

class DeleteDialogCrop extends StatelessWidget {
  final Function deleteCrop;
  DeleteDialogCrop({this.deleteCrop});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure..??"),
      content: Text(
          'Would you like to delete crop detail? This will delete all timelines events of this crop.'),
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
            deleteCrop();
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 1);
          },
        )
      ],
    );
  }
}
