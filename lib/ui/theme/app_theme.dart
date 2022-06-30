import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/ui/ui.dart';

abstract class AppTheme {
  /// ThemeData used for light mode theme
  static ThemeData lightThemeData({String? fontFamily}) => ThemeData(
        appBarTheme: AppBarTheme(
          color: AppColor.surface,
          titleTextStyle: _textTheme.headline6,
          iconTheme: const IconThemeData(color: AppColor.defaultText),
        ),
        primaryColor: AppColor.primaryFill,
        dividerColor: AppColor.dividerLine,
        scaffoldBackgroundColor: AppColor.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        splashFactory: NoSplash.splashFactory,
        snackBarTheme: _snackBarTheme,
        tabBarTheme: _tabBarTheme,
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
        ),
        textTheme: _textTheme,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.primaryFill,
          surface: AppColor.surface,
        ),
      );

  // Common values
  static TabBarTheme get _tabBarTheme => TabBarTheme(
        labelColor: AppColor.defaultText,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: const EdgeInsets.only(right: PaddingValues.xl),
        labelStyle: _textTheme.button,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: AppColor.primaryFill),
          insets: EdgeInsets.only(
            right: PaddingValues.big,
            left: -PaddingValues.big,
          ),
        ),
      );

  static const _snackBarTheme = SnackBarThemeData(
    contentTextStyle: TextStyle(color: Colors.white),
    backgroundColor: AppColor.closed,
  );

  static final _textTheme = TextTheme(
    headline4: GoogleFonts.lora(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColor.defaultText,
    ),
    headline6: GoogleFonts.lora(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.defaultText,
    ),
    subtitle1: GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: AppColor.defaultText,
    ),
    bodyText1: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
      height: 1.4,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
    ),
    button: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColor.defaultText,
    ),
    caption: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
    ),
    overline: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: AppColor.defaultText,
      letterSpacing: -0.5,
    ),
  );
}
