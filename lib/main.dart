import './Widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 06623b
// 649d66
// f6d743
// f6f578
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const appName = "KrishMitr";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: appName,
      theme: ThemeData(        
        primaryColor: Color(0xff61b15a),
        primaryColorLight: Color(0xffadce74),        
        accentColor: Color(0xfff6f578),                
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      home: WelcomePage(),
    );
  }
}