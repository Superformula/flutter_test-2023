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
      headline4: GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w700, color: AppColor.defaultText),
      headline6: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.defaultText),
      subtitle1: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.defaultText),
      bodyText1: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.defaultText),
      bodyText2: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.defaultText),
      button: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.defaultText),
      caption: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.defaultText),
      overline: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: AppColor.defaultText),
    ),
    appBarTheme: AppBarTheme(
        color: AppColor.surface,
        iconTheme: IconThemeData(
          color: AppColor.primaryFill,
        )
    ),
    tabBarTheme: TabBarTheme(
      labelPadding: EdgeInsets.zero,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColor.primaryFill)),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    backgroundColor: AppColor.background,
    primaryColor: AppColor.primaryFill,
  );

  static get restaurantRowDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(0.0, 0.5),
        blurRadius: 1.2,
      ),
    ],
  );

  static get gradientLoadingDecoration => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [
          0.2,
          0.4,
          0.6,
          1.0,
        ],
        colors: [
          AppColor.gradientBG,
          AppColor.placeHolder,
          AppColor.placeHolder,
          AppColor.gradientBG,
        ],
      )
  );
}
