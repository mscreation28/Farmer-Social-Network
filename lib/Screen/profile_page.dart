import '../Widget/userCropListItem.dart';
import '../models/dummy_data.dart';

import '../Widget/titleText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "./profile-page";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _headSection() {
    return Container(
      height: 225,              
      child: Stack(                
        alignment: Alignment.topLeft,
        overflow: Overflow.visible,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            child: Image.asset(
              "assets/images/back_farm.JPG",
              fit: BoxFit.cover
            ),
          ),
          Positioned(  
            bottom: 0,                 
            left: 25,
            child: Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(8),                      
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,                        
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0,4),
                    blurRadius: 4,                            
                  )
                ]
              ),
              child: Image.asset(
                "assets/images/farmer.png",                
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 170, left: 160),                    
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                        
                FittedBox(
                  child: Text(
                    'Shyam Makwana',
                    style: GoogleFonts.cairo(
                      textStyle: Theme.of(context).textTheme.headline6,
                      fontSize: 25,
                      fontWeight: FontWeight.bold, 
                      height: 0.8,
                    ),
                  ),
                ),
                FittedBox(                          
                  child: Text(
                    'Junagadh, Gujarat',
                    style: GoogleFonts.cairo(
                      textStyle: Theme.of(context).textTheme.caption,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }  
  Widget getUserCropList()
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < dummyCrop.length; i++){
        list.add(UserCropList(i));
    }
    return new Column(children: list);
  }
  @override
  Widget build(BuildContext context) {        
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          color1: Theme.of(context).primaryColorDark,
          color2: Theme.of(context).accentColor
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
            )
          ),
        ),
      ),      
      body: SingleChildScrollView(        
        child: Container(          
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headSection(),
              SizedBox(
                height: 20,
              ),
              getUserCropList()            
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,          
        ),
      ),
    );
  }
}