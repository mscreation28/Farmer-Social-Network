
import 'package:KrishiMitr/Widget/delete_dialog_crop.dart';
import 'package:KrishiMitr/Utility/Validation.dart';
import 'package:KrishiMitr/models/crops.dart';
import 'package:KrishiMitr/models/user_crops.dart';
import 'package:KrishiMitr/network/clients/UserCropClient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditCropTimeline extends StatefulWidget {
  static const routeName = "./edit-crop"; 
  
  @override
  _EditCropTimelineState createState() => _EditCropTimelineState();
}

class _EditCropTimelineState extends State<EditCropTimeline> {
  final croplist = [
    'wheat1','groundnut1','corn1',
  ];
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String usercropId;
  UserCrop userCrop;
  String selectCropId;
  DateTime _date = DateTime.now();
  String name;
  List<Crop> cropList;
  Function refreshState;
  
  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },      
    ).then((value) {
      if(value == null) {
        return;
      }
      setState(() {        
        userCrop.cropDate = value;
        print(_date);
      });
    });
  }

  Future<void> updateUserCrop() async{
    UserCropClient userCropClient = new UserCropClient();
    var response = await userCropClient.updateUserCrop(userCrop); 
    if(response.statusCode==200){
      refreshState();
      Navigator.of(context).pop();
    }
  }

  void deleteUserCrop() async{
    UserCropClient userCropClient = new UserCropClient();
    var response =  await userCropClient.deleteUserCrop(userCrop.userCropId);
    if(response.statusCode==200){
      refreshState();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    userCrop = routeArgs['userCrop'] as UserCrop;
    cropList = routeArgs['cropList'] as List<Crop>;
    refreshState = routeArgs['refresh'] as Function;
    selectCropId = croplist[0];
    _date = userCrop.cropDate;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return DeleteDialogCrop(deleteCrop: deleteUserCrop,);
              },
            )
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {                  
                _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                updateUserCrop();
              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always; //enable realtime validation
                });
              }              
            }
          )
        ],
        title: Text(
          'Edit Crop',
          style: GoogleFonts.lato(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField<String>(                  
                  value: userCrop.cropId.toString(),
                  decoration: InputDecoration(
                    labelText: 'Select your crop*'
                  ),
                  // elevation: 20,
                  onChanged: (crop) =>
                      setState(()  {selectCropId = crop; userCrop.cropId = int.parse(crop);  }),
                  validator: (value) => value == null ? 'Crop is required' : null,
                  items: cropList.map<DropdownMenuItem<String>>((Crop crop) {
                    return DropdownMenuItem<String>(
                      value: crop.cropId.toString(),
                      child: Text(crop.cropName),
                    );
                  }).toList(),
                  
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: userCrop.breed,
                  decoration: InputDecoration(labelText: 'Enter crop breed*'),
                  validator: (value) => Validation.validateCropBreed(value),
                  onSaved: (value) => userCrop.breed = value,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: userCrop.croptaluka,
                        decoration: InputDecoration(labelText: 'Enter Taluka*'),
                        validator: (value) => value.isEmpty ? 'Taluka is required field' : null,
                        onSaved: (value) => userCrop.croptaluka = value,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        initialValue: userCrop.cropCity,
                        decoration: InputDecoration(labelText: 'Enter District*',),
                        validator: (value) => value.isEmpty ? 'District is required' : null,
                        onSaved: (value) => userCrop.cropCity= value,                        
                      ),
                    ),
                  ],
                ),              
                SizedBox(height: 10),
                TextFormField(
                  initialValue: userCrop.cropState,
                  decoration: InputDecoration(labelText: 'Enter State*'),
                  validator: (value) => value.isEmpty ? 'State is required' : null,
                  onSaved: (value) => userCrop.cropState = value,
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: userCrop.area.toString(),
                  decoration: InputDecoration(labelText: 'Enter Area*'),
                  validator: (value) =>Validation.validateArea(value),
                  onSaved: (value) => userCrop.area = double.parse(value),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                InkWell(                  
                  onTap: () {_presentDatePicker(context);},
                  child: InputDecorator(
                    decoration: InputDecoration(labelText: 'Select Date*'),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(DateFormat.yMMMd().format(_date)),
                        Icon(Icons.calendar_today,
                            color: Theme.of(context).primaryColor
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}