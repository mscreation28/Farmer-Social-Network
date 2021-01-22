import 'package:KrishiMitr/Screen/timline_comment_page.dart';

import './page/edit_crop_timeline.dart';
import './page/edit_profile.dart';
import './page/edit_timeline_event.dart';
import './page/new_timeline_event.dart';
import './Screen/tab_page.dart';
import './Screen/timeline_activity.dart';
import './page/new_crop_timeline.dart';
import './Screen/profile_page.dart';
import './Screen/signup_page.dart';
import './Screen/login_page.dart';
import './Screen/welcome_page.dart';
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
  static const appName = "Krish Mitr";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: appName,
      theme: ThemeData(        
        primaryColor: Color(0xff61b15a),
        primaryColorLight: Color(0xffadce74),        
        accentColor: Color(0xfff6f578),
        primaryColorDark: Colors.brown.shade700,                
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      home: WelcomePage(),
      routes: {
        LoginPage.routeName : (ctx) => LoginPage(),
        SignupPage.routeName : (ctx) => SignupPage(),
        ProfilePage.routeName : (ctx) => ProfilePage(),
        TabScreen.routeName : (ctx) => TabScreen(),
        TimelineActivity.routeName : (ctx) => TimelineActivity(),
        NewCropTimeline.routeName : (ctx) => NewCropTimeline(),
        NewTimelineEvent.routeName : (ctx) => NewTimelineEvent(),
        EditCropTimeline.routeName : (ctx) => EditCropTimeline(),
        EditTimelineEvent.routeName : (ctx) => EditTimelineEvent(),
        EditProfile.routeName : (ctx) => EditProfile(),
        TimelineCommentPage.routeName : (ctx) => TimelineCommentPage(),
      },
    );
  }
}