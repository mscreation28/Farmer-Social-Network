import 'package:KrishiMitr/models/Message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  Message message;
  MessageTile(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(      
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: message.sentByMe ? 0 : 12,
        right: message.sentByMe? 12 : 0
      ),
      alignment: message.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: message.sentByMe ? EdgeInsets.only(left: 45) : EdgeInsets.only(right: 45),
        padding: EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
        decoration: BoxDecoration(
        borderRadius: message.sentByMe ? BorderRadius.only(
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
          color: message.sentByMe ? Theme.of(context).primaryColorLight.withOpacity(0.82) : Colors.grey.shade300
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
                    message.userName, textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 6.0),
                Text(message.message, textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0)),
                SizedBox(height: 4),                              
              ],
            ),
            Text(
              DateFormat.jm().format(message.messageTime),
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