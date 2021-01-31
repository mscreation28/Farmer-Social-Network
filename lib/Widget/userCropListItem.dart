import '../Screen/timeline_activity.dart';
import '../models/crops.dart';
import '../models/user_crops.dart';
import '../page/edit_crop_timeline.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class UserCropList extends StatelessWidget {
  final Function refresh;
  final UserCrop userCrop;
  List<Crop> cropList;
  Function callBack;

  UserCropList(this.userCrop,this.cropList,this.refresh);

  void viewallActicity(BuildContext cntx) {
    Navigator.pushNamed(cntx, TimelineActivity.routeName, arguments: {
      'userCrop': userCrop,
    });
  }

  void editActivity(BuildContext cntx) {
    Navigator.pushNamed(cntx, EditCropTimeline.routeName, arguments: {
      'userCrop': userCrop,
      'cropList':cropList,
      'refresh':refresh,
    });
  }


  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat("dd MMMM, yyyy").format(userCrop.cropDate);
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(userCrop.cropDate).inDays;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userCrop.cropName,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editActivity(context);
                      })
                ],
              ),
              Divider(),
              Text(userCrop.breed),
              SizedBox(height: 5),
              Text(
                  '${userCrop.croptaluka}, ${userCrop.cropCity}, ${userCrop.cropState}'),
              SizedBox(height: 5),
              Text('Area - ${userCrop.area} Vigha'),
              SizedBox(height: 5),
              Text(
                _difference~/30==0 ? 
                  '$formattedDate   \u2022   ${_difference % 30} days'
                  : '$formattedDate   \u2022   ${_difference ~/ 30} Months  ${_difference % 30} days'),
            ],
          ),
        ),
        Divider(
          height: 0.5,
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: FlatButton(
            onPressed: () {
              viewallActicity(context);
            },
            child: Text(
              'View All Activity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
