import 'package:KrishiMitr/Screen/timeline_updates.dart';
import 'package:KrishiMitr/Widget/group_discussion_list.dart';
import 'package:KrishiMitr/Widget/timeline_update_list.dart';
import 'package:KrishiMitr/Widget/titleText.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyCustomClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {    
    return RRect.fromLTRBR(50, 0, 0, 0, Radius.zero);
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => false;
}

class _HomePageState extends State<HomePage> {
  List<Map<String,Object>> _pages;
  List<Map<String,Object>> _iconlist;

  int _selectedPageIndex = 0;
  void initState() {
    _pages = [
      {'page': TimelineUpdateList()},      
      {'page': GroupDiscussionList()},
    ];
    _iconlist = [
      {'title': 'Timeline Update', 'icon': 'assets/images/wheat.png'},
      {'title': 'Group Discussion', 'icon': 'assets/images/farmer.png'}
    ];
    super.initState();
  }

  Widget _buildIcon(String imgr, bool isSelected){
    return Container(                                 
      decoration: BoxDecoration(        
        color: Colors.white,
        shape: isSelected ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isSelected ?BorderRadius.circular(20) : null,
        // shape: BoxShape.rectangle,                   
        border: Border.all(
          color: Colors.grey.shade200,
          width: 0.5,          
        ),                      
        image: DecorationImage(
          image: AssetImage(imgr),
        )
      ),                   
    );
  }


  @override
  Widget build(BuildContext context) {        
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
      backgroundColor: Theme.of(context).primaryColorLight,      
      body: Row(
        // fit: StackFit.loose,        
        children: [          
          Expanded(          
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    index==0 ? SizedBox(
                      height: 10,
                    ) : SizedBox(width: 0,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPageIndex = index;
                          print(index);
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 5,                                                        
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                              color: index==_selectedPageIndex ? Colors.white : Theme.of(context).primaryColorLight,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            // color: Theme.of(context).primaryColor, 
                            margin: EdgeInsets.symmetric(vertical: 2.5), 
                            padding: EdgeInsets.only(right: 15, left: 8, top: 5, bottom: 5),          
                            width: 80,                            
                            height: 70,
                            child: _buildIcon(_iconlist[index]['icon'], index==_selectedPageIndex)
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              // separatorBuilder: (context, index) {
              //   // return SizedBox(
              //   //   height: 10,
              //   // );
              // },
              itemCount: _iconlist.length
            ),
          ),
          ClipRRect(            
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
            child: Container(              
              color: Colors.white70,              
              padding: EdgeInsets.all(20),
              width: width-95,
              child: _pages[_selectedPageIndex]['page']              
            ),            
          ),          
          
          // Positioned(
          //   left: width-160,
          //   // top: 50;
          // Container(width: width, child: TimelineUpdate())
          // )
        
        ],
      ),      
    );
  }
}