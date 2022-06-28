import 'package:flutter/material.dart';
import 'package:restaurantour/ui/theme/app_color.dart';

abstract class AppTheme {
  /// ThemeData used for light mode theme
  static ThemeData lightThemeData({String? fontFamily}) => ThemeData(
        appBarTheme: AppBarTheme(
          color: AppColor.surface,
          titleTextStyle: _textTheme.headline6,
          iconTheme: const IconThemeData(color: AppColor.defaultText),
        ),
        primaryColor: AppColor.primaryFill,
        scaffoldBackgroundColor: AppColor.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        elevatedButtonTheme: _elevatedButtonTheme,
        splashFactory: NoSplash.splashFactory,
        snackBarTheme: _snackBarTheme,
        tabBarTheme: _tabBarTheme,
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
        ),
        textTheme: _textTheme,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.primaryFill,
        ),
      );

  // Common values
  static TabBarTheme get _tabBarTheme => const TabBarTheme(
        labelColor: AppColor.defaultText,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.only(right: 24),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: AppColor.primaryFill),
          insets: EdgeInsets.only(right: 12, left: -12),
        ),
      );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      splashFactory: NoSplash.splashFactory,
    ),
  );

  static const _snackBarTheme =
      SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white));

  static const _textTheme = TextTheme(
    headline4: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColor.defaultText,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.defaultText,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.defaultText,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
    ),
    button: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColor.defaultText,
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.defaultText,
    ),
    overline: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: AppColor.defaultText,
    ),
  );
}
