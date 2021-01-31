import '../Screen/timeline_updates.dart';
import '../models/crops.dart';
import '../network/clients/CropClient.dart';
import 'package:flutter/material.dart';

class TimelineUpdateList extends StatelessWidget {
  Widget _buildCropList(BuildContext context, List<Crop> croplist) {

    List<Widget> list = [];
    for (var i = 0; i < croplist.length; i++) {
      print(croplist[i].cropName);
      list.add(
        FlatButton( 
          padding: EdgeInsets.symmetric(horizontal: 5),        
          onPressed: () {
            Navigator.pushNamed(
              context,
              TimelineUpdate.routeName,
              arguments: {
                'cropid' : croplist[i].cropId,
                'cropname' : croplist[i].cropName,
              }
            );
          },
          materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '# ${croplist[i].cropName}',
              style: TextStyle(
                color: Colors.grey.shade800, 
                fontWeight: FontWeight.w600,
                fontSize: 16            
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      );
    }
    print(list);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: list
      )
    );
  }

  Future<List<Crop>> getCropList() async {
    CropClient cropClient = new CropClient();
    List<Crop> cropList =  await cropClient.getAllCrops();
    cropList.sort((c1,c2){
      return c1.cropId - c2.cropId;
    });
    return cropList;
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
          FutureBuilder(        
            future: getCropList(),
            builder: (context, snapshot) {
              return snapshot.hasData 
                ? _buildCropList(context, snapshot.data as List<Crop>)
                  : CircularProgressIndicator();
            },                        
          )          
        ]
      ),      
    );
  }
}
