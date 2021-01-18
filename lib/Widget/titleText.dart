import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final double fontsize;
  final Color color1, color2;
  TitleText({this.fontsize, this.color1, this.color2});

  @override
  Widget build(BuildContext context,) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'K',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: fontsize,
          fontWeight: FontWeight.w700,
          color: color1
        ),
        children: [
          TextSpan(
            text: 'rishi',
            style: TextStyle(color: color2, fontSize: fontsize),
          ),
          TextSpan(
            text: 'Mitr',
            style: TextStyle(color: color1, fontSize: fontsize),
          ),
          TextSpan(
            text: 'a',
            style: TextStyle(color: color2, fontSize: fontsize),
          ),
        ]
      ),
    );
  }
}