import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/theme/app_color.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      headline4: GoogleFonts.lora(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryFill,
      ),
      headline6: GoogleFonts.lora(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryFill,
      ),
      subtitle1: GoogleFonts.lora(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryFill,
      ),
      bodyText1: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryFill,
      ),
      bodyText2: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryFill,
      ),
      button: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryFill,
      ),
      caption: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryFill,
      ),
      overline: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.primaryFill,
      ),
    ),
    appBarTheme: AppBarTheme(
        color: AppColors.surface,
        iconTheme: IconThemeData(
          color: AppColors.primaryFill,
        )),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primaryFill,
      unselectedLabelColor: AppColors.secondaryText,
      labelPadding: EdgeInsets.zero,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primaryFill),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    backgroundColor: AppColors.background,
    primaryColor: AppColors.primaryFill,
  );
}
