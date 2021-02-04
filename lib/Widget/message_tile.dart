import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sentbyMe;
  final String time;

  MessageTile({this.message, this.sender, this.sentbyMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(      
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: sentbyMe ? 0 : 12,
        right: sentbyMe ? 12 : 0
      ),
      alignment: sentbyMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sentbyMe ? EdgeInsets.only(left: 45) : EdgeInsets.only(right: 45),
        padding: EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
        decoration: BoxDecoration(
        borderRadius: sentbyMe ? BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15)
          )
          :
          BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15)
          ),
          color: sentbyMe ? Theme.of(context).primaryColorLight.withOpacity(0.82) : Colors.grey.shade300
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,          
              children: [
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 0,
                  minWidth: 0,
                  padding: EdgeInsets.all(0),
                  child: Text(
                    sender, textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 6.0),
                Text(message, textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0)),
                SizedBox(height: 4),                              
              ],
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700
              )
            ),
          ],
        ),
        
      ),      
    );
  }
}