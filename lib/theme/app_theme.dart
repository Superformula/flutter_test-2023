import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/theme/app_color.dart';

// App Style guide reference link: https://www.figma.com/file/UOQDbU02GG2yaJMfrO9q9d/Flutter-Test?node-id=54%3A1060

// Phone screen standard: iPhone X
// /* 2436x1125px at 458ppi */
// (device-width : 375px)
// (device-height : 812px)

class AppTheme{
  static ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      headline4: GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w700),
      headline6: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700),
      subtitle1: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w500),
      bodyText1: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400),
      button: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
      caption: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400),
      overline: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    ),
    backgroundColor: AppColor.background,
    primaryColor: AppColor.primaryFill,
  );
}
