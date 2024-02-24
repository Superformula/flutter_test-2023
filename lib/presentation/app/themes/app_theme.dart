import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/presentation/app/constants/constants.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';

ThemeData lightAppThemeData() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      extensions: [
        RestauranTourTheme(
          typography: _appTypography(
            fontColor: LightThemeColors.lightColors.black ?? Colors.black,
          ),
          colors: LightThemeColors.lightColors,
        ),
      ],
    );

AppTypography _appTypography({required Color fontColor}) {
  return AppTypography(
    headingH6: GoogleFonts.lora(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: fontColor,
    ),
    button: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: fontColor,
    ),
    subtitle1: GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: fontColor,
    ),
    subtitle2: GoogleFonts.lora(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: fontColor,
    ),
    caption1: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: fontColor,
    ),
    caption2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: fontColor,
    ),
    overline: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: fontColor,
    ),
    body1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: fontColor,
    ),
  );
}
