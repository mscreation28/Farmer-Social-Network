import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: width*0.2,
          ),
          Container(
            width: width*0.8,
          ),          
        ],
      ),
    );
  }
}