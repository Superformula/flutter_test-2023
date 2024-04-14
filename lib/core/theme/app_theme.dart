import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantour/core/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  // * Colors default app
  static const Color primaryColor = Color(0xFF000000);
  static const Color secondary = Color(0xFF606060);

  // * Custom colors
  static const Color statusBarColor = Colors.white;
  static const Color backgroundColor = Color(0xffFAFAFA);
  static const Color greenColor = Color(0xFF5CD313);
  static const Color redColor = Color(0xFFEA5E5E);
  static const Color yellowColor = Color(0xFFFFB800);

  static ThemeData get defaultTheme => ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Lora',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: statusBarColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black54,
          color: Colors.white,
          elevation: 3,
          centerTitle: true,
          titleTextStyle: AppTextStyle.black18w700,
        ),
        tabBarTheme: const TabBarTheme(
          labelStyle: AppTextStyle.black14w600OpenSans,
          unselectedLabelStyle: AppTextStyle.black14w600OpenSans,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          tabAlignment: TabAlignment.center,
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        scaffoldBackgroundColor: backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          secondary: secondary,
          primary: primaryColor,
          background: backgroundColor,
          surfaceTint: backgroundColor,
        ),
        dividerTheme: const DividerThemeData(color: Color(0xFFEEEEEE), thickness: 1),
        useMaterial3: true,
      );
}
