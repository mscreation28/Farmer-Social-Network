import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewCropTimeline extends StatefulWidget {
  static const routeName = "./new-crop";

  @override
  _NewCropTimelineState createState() => _NewCropTimelineState();
}

class _NewCropTimelineState extends State<NewCropTimeline> {
  final crop = [
    'wheat','groundnut','corn','wheat1','groundnut1','corn1',
  ];
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String selectCrop;
  DateTime _date = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
          'New Crop',
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
                  value: selectCrop,
                  decoration: InputDecoration(
                    labelText: 'Select your crop*'
                  ),
                  // elevation: 20,
                  onChanged: (crop) =>
                      setState(() => selectCrop = crop),
                  validator: (value) => value == null ? 'field required' : null,
                  items: crop.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter crop variety*'),
                  validator: (value) => value.isEmpty ? 'Crop variety is required' : null,
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Enter Taluka*'),
                        validator: (value) => value.isEmpty ? 'Taluka is required field' : null,
                        onSaved: (value) => name = value,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Enter District*',),
                        validator: (value) => value.isEmpty ? 'District is required' : null,
                        onSaved: (value) => name = value,                        
                      ),
                    ),
                  ],
                ),              
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter State*'),
                  validator: (value) => value.isEmpty ? 'State is required' : null,
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter Area*'),
                  validator: (value) => value.isEmpty ? 'Area is required' : null,
                  onSaved: (value) => name = value,
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