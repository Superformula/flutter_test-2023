import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => themeData(
        colorScheme: lightColorScheme,
        focusColor: Colors.black.withOpacity(0.12),
      );

  static ThemeData themeData({
    required ColorScheme colorScheme,
    required Color focusColor,
  }) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: _textTheme,
        primaryColor: colorScheme.primary,
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        tabBarTheme: TabBarTheme(labelColor: colorScheme.primary),
        dividerTheme: const DividerThemeData(
          color: Color(0xffeeeeee),
          thickness: 1.0,
          space: 0.0,
        ),
      );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xff000000),
    secondary: Color(0xFFEFF3F3),
    background: Color(0xfffafafa),
    surface: Colors.white,
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.redAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.blue,
    onSurface: Color(0xff000000),
    brightness: Brightness.light,
  );

  // TODO: Figma file referenciate deprecated theme attributes,
  // comunicate to design team
  static final TextTheme _textTheme = TextTheme(
    headline6: TextStyle(
      fontFamily: loraFontFamily,
      fontSize: 18.0,
      height: calcFontHeight(
        fontSize: 18.0,
        desiredHeightInPixels: 24.0,
      ),
      fontWeight: bold,
    ),
    subtitle1: TextStyle(
      fontFamily: loraFontFamily,
      fontSize: 16.0,
      fontWeight: medium,
      height: calcFontHeight(
        fontSize: 16.0,
        desiredHeightInPixels: 24.0,
      ),
    ),
    caption: TextStyle(
      fontFamily: openSansFontFamily,
      fontSize: 12.0,
      fontWeight: regular,
      height: calcFontHeight(
        fontSize: 12.0,
        desiredHeightInPixels: 20.0,
      ),
    ),
    overline: TextStyle(
      fontFamily: openSansFontFamily,
      fontSize: 12.0,
      fontWeight: regular,
      fontStyle: FontStyle.italic,
      height: calcFontHeight(
        fontSize: 12.0,
        desiredHeightInPixels: 12.0,
      ),
    ),
    button: TextStyle(
      fontFamily: openSansFontFamily,
      fontSize: 14.0,
      height: calcFontHeight(
        fontSize: 14.0,
        desiredHeightInPixels: 24.0,
      ),
      fontWeight: semiBold,
    ),
    bodyText1: TextStyle(
      fontFamily: openSansFontFamily,
      fontSize: 16.0,
      height: calcFontHeight(
        fontSize: 16.0,
        desiredHeightInPixels: 24.0,
      ),
      fontWeight: regular,
    ),
  );

  static double calcFontHeight({
    required double fontSize,
    required double desiredHeightInPixels,
  }) =>
      desiredHeightInPixels / fontSize;

  static const loraFontFamily = 'Lora';

  static const openSansFontFamily = 'OpenSans';

  /// FontWeight.w700
  static const bold = FontWeight.w700;

  /// FontWeight.w600
  static const semiBold = FontWeight.w600;

  /// FontWeight.w500
  static const medium = FontWeight.w500;

  /// FontWeight.w400
  static const regular = FontWeight.w400;
}
