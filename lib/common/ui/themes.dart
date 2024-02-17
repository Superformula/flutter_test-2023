import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/common/ui/app_colors.dart';

abstract class Themes {
  static ColorScheme colorTheme = const ColorScheme(
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: Colors.white,
    primary: Colors.white,
    onPrimary: AppColors.kFarquaadGray,
    primaryContainer: Colors.black,
    onPrimaryContainer: Colors.white,
    secondary: Colors.white,
    secondaryContainer: Colors.white,
    onSecondary: Colors.white,
    tertiary: Colors.white,
    onTertiary: Colors.white,
    tertiaryContainer: Colors.white,
    onTertiaryContainer: Colors.white,
    background: AppColors.kOfficialGrayfruitSheenGray,
    onBackground: Colors.white,
    error: Colors.white,
    onError: Colors.white,
  );

  static TextTheme textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: GoogleFonts.lora().fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: colorTheme.primaryContainer,
    ),
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.lora().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: colorTheme.primaryContainer,
    ),
    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.lora().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: colorTheme.primaryContainer,
    ),
    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: colorTheme.primaryContainer,
    ),
    bodyMedium: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colorTheme.primaryContainer,
    ),
    bodySmall: TextStyle(
      fontFamily: GoogleFonts.openSans().fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: colorTheme.primaryContainer,
    ),
  );

  static IconThemeData iconTheme = const IconThemeData(color: Colors.black);
}
