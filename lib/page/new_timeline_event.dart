import '../Utility/Validation.dart';
import '../models/timeline_event.dart';
import '../models/user_crops.dart';
import '../network/clients/TimelineEventClient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewTimelineEvent extends StatefulWidget {
  static const routeName = "./new-timeline-event";

  @override
  _NewTimelineEventState createState() => _NewTimelineEventState();
}

class _NewTimelineEventState extends State<NewTimelineEvent> {  
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;  
  DateTime _date = DateTime.now();
  String name;
  TimelineEvent timelineEvent = new TimelineEvent();
  UserCrop userCrop;
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
        timelineEvent.timelineDate = value;
        _date = value;
        print(_date);
      });
    });
  }
  Future<void> addNewTimeline() async{
    TimelineEventClient timelineEventClient = new TimelineEventClient();
    timelineEvent.userCropId = userCrop.userCropId;
    timelineEvent.timelineDate = _date;
    
    var response = await timelineEventClient.addTimelineEvent(timelineEvent);
    if (response.statusCode == 201) {
      refreshState();
      Navigator.of(context).pop();
    } else {
      throw Exception('Error while adding timeline');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    userCrop = routArgs['userCrop'] as UserCrop;
    refreshState = routArgs['refresh'] as Function;

    timelineEvent.timelineDate = _date;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {                  
                _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                addNewTimeline();
              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always; //enable realtime validation
                });
              }              
            }
          )
        ],
        title: Text(
          'New Timeline Event',
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
                  decoration: InputDecoration(labelText: 'Enter event title*'),
                  validator: (value) => Validation.validateTimelineTitle(value),
                  onSaved: (value) => timelineEvent.title = value,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {                    
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
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Enter Description'),                  
                  onSaved: (value) => timelineEvent.description= value,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    return Validation.validateTimelineDescription(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}