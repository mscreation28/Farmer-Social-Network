import '../page/edit_profile.dart';

import '../page/new_crop_timeline.dart';

import '../Widget/userCropListItem.dart';
import '../models/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "./profile-page";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void gotoEditProfile() {
    Navigator.pushNamed(
      context,
      EditProfile.routeName,
    );
  }

  Widget _headSection() {
    return Container(
      // height: 230,              
      child: Stack(                
        alignment: Alignment.topLeft,
        overflow: Overflow.visible,
        children: [         
          Column(
            children: [
              Container(
                height: 150.0,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/back_farm.JPG",
                  fit: BoxFit.cover
                ),
              ),
              Container(                              
                width: double.infinity,
                padding: EdgeInsets.only(top: 15,left: 160),
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
                    Container(
                      alignment: Alignment.topRight,
                      child: FlatButton( 
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,                                                                 
                        onPressed: () {
                          gotoEditProfile();
                        }, 
                        padding: EdgeInsets.only(right: 17),
                        minWidth: 0,
                        height: 0,                       
                        // constraints: BoxConstraints(),                                                
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:'Edit Profile',
                                style: GoogleFonts.cairo(
                                  textStyle: Theme.of(context).textTheme.caption,
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold                          
                                ),                        
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 5,)
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.edit,
                                  size: 21,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              )
                            ]
                          ),
                        )
                        
                        // icon: 
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
          Positioned(  
            top: 100,                 
            left: 20,
            child: Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(8),                      
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,                        
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0,4),
                    blurRadius: 4,                            
                  )
                ],
                image: DecorationImage(
                  image: AssetImage("assets/images/farmer.png"),
                )
              ),
              // child: Image.asset(
              //   "assets/images/farmer.png",                
              // ),
            ),
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
      // appBar: AppBar(
        
      // ),      
      body: SingleChildScrollView(        
        child: Container(          
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headSection(),
              SizedBox(
                height: 10,
              ),
              getUserCropList()            
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {      
          Navigator.pushNamed(
            context,
            NewCropTimeline.routeName,
          );
        },
        child: Icon(
          Icons.add,          
        ),
      ),
    );
  }
}