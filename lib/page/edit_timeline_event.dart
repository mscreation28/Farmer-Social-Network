import 'package:KrishiMitr/models/dummy_data.dart';
import 'package:KrishiMitr/models/timeline_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditTimelineEvent extends StatefulWidget {
  static const routeName = "./edit-timeline-event";

  @override
  _EditTimelineEventState createState() => _EditTimelineEventState();
}

class _EditTimelineEventState extends State<EditTimelineEvent> {  
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;  
  DateTime _date = DateTime.now();
  String timelineId;
  TimelineModel event;
  String name;

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
        _date = value;
        print(_date);
      });
    });
  }

  // Widget showCupertinoDate(BuildContext context) {
  //   return Container(     
  //     height: MediaQuery.of(context).copyWith().size.height / 3,
  //     decoration: BoxDecoration(        
  //       borderRadius: BorderRadius.only(
  //           topLeft: const Radius.circular(100),
  //           topRight: const Radius.circular(100))),
  //     child: CupertinoDatePicker(        
  //       initialDateTime: _date,
  //       onDateTimeChanged: (DateTime Editdate) {
  //         setState(() {
  //           _date = Editdate;
  //         });
  //       },        
  //       maximumDate: DateTime.now(),       
  //       // minuteInterval: 1,
  //       mode: CupertinoDatePickerMode.date,
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    timelineId = routArgs['timelineid'];
    event = dummyTimeline.firstWhere((element) => element.id == timelineId);    
    _date = event.date;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {

            }
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState.validate()) {                  
                _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields

              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always; //enable realtime validation
                });
              }              
            }
          )
        ],
        title: Text(
          'Edit Timeline Event',
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
                TextFormField(
                  initialValue: event.title,
                  decoration: InputDecoration(labelText: 'Enter event title*'),
                  validator: (value) => value.isEmpty ? 'event title is required' : null,
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // showModalBottomSheet(  
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(15)
                    //     ),
                    //   ),                                                                
                    //   context: context,
                    //   builder: (context) {
                    //     return showCupertinoDate(context);
                    //   },
                    // );
                    _presentDatePicker(context);
                  },
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
                SizedBox(height: 10),
                TextFormField(                  
                  initialValue: event.description,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Enter Description'
                  ),
                  onSaved: (value) => name = value,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}