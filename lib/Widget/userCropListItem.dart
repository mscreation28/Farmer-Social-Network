import '../models/dummy_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class UserCropList extends StatelessWidget {
  final int index;
  UserCropList(this.index);

  @override
  Widget build(BuildContext context) {
    final DateTime date = dummyCrop[index].date;
    final String formattedDate = DateFormat("dd MMMM, yyyy").format(date);
    final DateTime curDate = DateTime.now();
    final _difference = curDate.difference(date).inDays;

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
                    dummyCrop[index].name,                
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.edit
                  )
                ],
              ),
              Divider(),
              Text(
                dummyCrop[index].variety            
              ),
              SizedBox(height: 5),
              Text(
                '${dummyCrop[index].taluka}, ${dummyCrop[index].district}, ${dummyCrop[index].state}'
              ),
              SizedBox(height: 5),
              Text(
                'Area - ${dummyCrop[index].area} Vigha'
              ),
              SizedBox(height: 5),
              Text(                    
                '$formattedDate   \u2022   ${_difference~/30} Months  ${_difference%30} days'
              ),
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
            onPressed: () {},
            child: Text(
              'View All Activity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
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