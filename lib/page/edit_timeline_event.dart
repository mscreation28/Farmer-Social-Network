import '../Widget/delete_dialog_event.dart';
import '../Utility/Validation.dart';
import '../models/timeline_event.dart';
import '../models/timeline_model.dart';
import '../network/clients/TimelineEventClient.dart';
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
  TimelineEvent timelineEvent;
  String name;
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
  Future<void> editTimeLineEvent() async{
    TimelineEventClient timelineEventClient  = new TimelineEventClient();
    // await timelineEventClient.updateTimelineEvent(timelineEvent);
    refreshState();
    var response = await timelineEventClient.updateTimelineEvent(timelineEvent);
    if(response.statusCode==200){
      Navigator.of(context).pop();
    }
  }

  Future<void> deleteTimeLineEvent() async{
    TimelineEventClient timelineEventClient = new TimelineEventClient();
    // await timelineEventClient.deleteTimelineEvent(timelineEvent.timelineId);
    var response = await timelineEventClient.deleteTimelineEvent(timelineEvent.timelineId);
    if(response.statusCode==200){
      refreshState();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    timelineEvent = routArgs['timeline'] as TimelineEvent;
    refreshState = routArgs['refresh'] as Function;
    _date = timelineEvent.timelineDate;
  
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return DeleteDialogEvent(deleteTimeline: deleteTimeLineEvent,);
              },
            )            
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {                  
                _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                editTimeLineEvent();
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
                  initialValue: timelineEvent.title,
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
                  initialValue: timelineEvent.description,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Enter Description'
                  ),
                  onSaved: (value) => timelineEvent.description = value,
                  keyboardType: TextInputType.multiline,
                  validator: (value) => Validation.validateTimelineDescription(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}