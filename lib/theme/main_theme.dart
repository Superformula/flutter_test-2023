import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Basic color theme
class MainTheme {
  static ThemeData get mainTheme {
    const Color primaryColor = Color(0xFFFB8C00);
    const Color secondaryColor = Color(0xFF4CAF50);
    const Color errorColor = Colors.red;
    const Color primaryTextColor = Colors.black;

    return ThemeData.from(
      colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        background: Colors.white,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: primaryTextColor,
        onBackground: primaryTextColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    ).copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        titleTextStyle: GoogleFonts.lora(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryTextColor,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
