import 'package:KrishiMitr/Screen/timeline_updates.dart';
import 'package:flutter/material.dart';

class TimelineUpdateList extends StatelessWidget {
  Widget _buildCropList(BuildContext context) {
    final croplist = [
      'wheat1','groundnut1','corn1','wheat1','groundnut1','corn1','wheat1','groundnut1','corn1'
    ];
    List<Widget> list = [];
    for (var i = 0; i < croplist.length; i++) {
      list.add(
        FlatButton( 
          padding: EdgeInsets.symmetric(horizontal: 5),        
          onPressed: () {
            Navigator.pushNamed(
              context,
              TimelineUpdate.routeName,
            );
          },
          materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '# ${croplist[i]}',
              style: TextStyle(
                color: Colors.grey.shade800,  
                fontSize: 15            
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      );
    }
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline Event Updates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,  
              color: Theme.of(context).primaryColorDark
            )
          ),
          Divider(thickness: 1.5,),
          _buildCropList(context)
        ]
      ),      
    );
  }
}
